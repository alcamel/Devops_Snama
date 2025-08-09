# Task ??

> Task 1 

- Try .env file is in git histroy and you need add gitignore but still git tracked this file , That How Take Make This In Good Way ??? 

```bash
$ git rm --cached .env 
# this is will remove .env from tracking by local repo 
$ git status 
# Will Find the file is Delete Don't Worry Still In Working Tree 
$ echo *.env >> .gitignore 
$ git add .
$ git status 
# Will Find the All Changed Files and Need To commited 
$ git commit -m "remove .env for tracking"
$ git push origin main 
```
