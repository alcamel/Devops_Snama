from contextlib import asynccontextmanager
from fastapi import FastAPI, HTTPException
import aioredis
import aiomysql
import json
import os 




REDIS_HOST = os.getenv("REDIS_HOST", "redis")
REDIS_PORT = int(os.getenv("REDIS_PORT", 6379))
CACHE_TTL  = 3600

MYSQL_HOST = os.getenv("MYSQL_HOST", "mysql")
MYSQL_PORT = int(os.getenv("MYSQL_PORT",3306))
MYSQL_USER = os.getenv("MYSQL_USER","root")
MYSQL_PASS = os.getenv("MYSQL_PASS","p@ssw0rd") 
MYSQL_DB   = os.getenv("MYSQL_DB","testdb")

@asynccontextmanager
async def lifespan(app: FastAPI):
   # connect to redis 
   app.state.redis      = await aioredis.from_url(
                     f"redis://{REDIS_HOST}:{REDIS_PORT}", 
                           decode_responses=True)
   # connect to Mysql
   app.state.mysql_pool = await aiomysql.create_pool(
                          host=MYSQL_HOST,
                          port=MYSQL_PORT,
                          user=MYSQL_USER,
                          password=MYSQL_PASS,
                          db=MYSQL_DB,
                          autocommit=True)
   # startup yield
   yield
   # shutdown 
   await app.state.redis.close()
   app.state.mysql_pool.close()
   await app.state.mysql_pool.wait_close()


app = FastAPI(lifespan=lifespan)

# === Routes === # 
@app.get("/")
async def root(): 
    return {"msg" : "Hello From V1"}

@app.get("/item/{item_id}")
async def get_item(item_id: int): 
    # try cache first 
    cached_item = await app.state.redis.get(f"item:{item_id}")
    if cached_item : 
        return {"source": "cache", "data": json.loads(cached_item)}

    # Query Mysql 
    async with app.state.mysql_pool.acquire() as conn: 
        async with conn.cursor(aiomysql.DictCursor) as cur: 
            await cur.execute("SELECT * FROM ITEMS WHERE ID=%S", (item_id,))
            row = await cur.fetchone() 
            if not row: 
                raise HTTPException(status_code=404, detail= "Item not Found") 

            #cahce it 
            await app.state.redis.setex(f"item:{item_id}", CACHE_TTL, json.dumps(row))

            return {"source", "db", "data", row} 


@app.post("/item")
async def create_item(name: str): 
    # Create a connection with database 
    async with app.state.mysql_pool.acquire() as conn: 
        async with conn.cursor() as cur: 
            await cur.execute("INSERT INTO items (name) VALUES %s", (name,))
            return {"status": "created", "name": name }
