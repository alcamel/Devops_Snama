# Git Docs

## Git History 

### Intorduction To Git 

> What Git ? 

- Git : Version Control System 

> Why Git ? 
    
- Need A Tracking System 
- Version Control System or Source Control Manger 

> History of Git ? 

- Linux -: Was The Project  
- Git   -: Wat The Version Control System 

### Get Started 
- Types of Version Control : 
    - local 
        - in your device  
    - Centeral 
        - Work live on server 
        - Need online access 
    - Distributed 
        - clone copy from server 
            - can fetch only diff files and apply them 
            - can push  dif files to server 
            - Relationship between Remote Repo and Local Repo 
            - can make more than one remote Repo and you can update on them. 

> Sometimes you need to look to any tool why? and the answer is How? and What? 

### Logic Behined Version Control 
    - incremental : 
        - source + diff1 + diff2 .... 
    - snapshots   : 
        - source 
        - Source + diff1
        - source + diff1 + diff2 

## Git Arch 

### What Do You Need ? **Requirments** 

    - functional Features 
        - application do this  
    - non-functional Features 
        - application has this properity 
        
```plaintext
                You        Git
              -------   --------
Working tree ( a.txt ) ( ------ )
Working tree ( a.txt ) ( adiff1 )
```

> Functional Features :
    
    - Track Everything 
        - Must Tracking label not something you track it . 
    - Os Independent 
    - Unique ID < objects[iD] >   
        - Git Objects : item git track it 
            - blob  : binary large object (content,metadata)
            - tree  : (folder, content, metadata) 
            - commit:   
            - tagged annotation: 
        - Git Hash Function: 
            - x =f(x)=> f(x)
            - sha-1 <160>(40 bit), sha-256 <160> (40 bit)
    - Track History 
    - No Content Change < content, metadata ...> 
    
    - What is  Git Add ?? 
        - Type , Size , null 

```bash
$  echo "Hello, Git" | git hash-object --stdin
#  b7aec520dec0a7516c18eb4c68b64ae1eb9b5a5e
$  echo "Hello, Git" | shasum
#  c9d5d04925b93d2fb99c73ab2b5869bde7405ca4
$  echo -e "blob 11\0Hello, Git" | shasum
```


> Tree Arch 

- Before Git ??
    - 2 Tree Arch 
        - WT 
        - Repo 
    - 3 Tree Arch 
        - WT   
        - Staging Area <Index> **file** git add 
            - Workflow ??
            - Take a chances ?? 
            - Only Buffer file ?? 
            - Batach ??  
            - Look to difference ?? 
        - Repo <<Commit>> Add To Local Repo 


> Batach : Change Related to one Object or Area.

```plaintext
    wt                  staging             repo 
    --                  -------             ----    
    file(untracked)     file(tracked)      file(snapshot) 

    ----------------------------------------------
    git add file    # Write sha-1 to file <create a blob to file><Tracking only> 
    git commit file # Add file <Tracking><snapshots> 
```

> File Status 

-  untracked 
-  tracked 
    - Modified      (M)
    - Unmodified     
--- 

## Git Hands on 

- git config ??

```bash
$ git config --global user.name "UserName" # User(global) -> ~/.gitconfig
$ git config --system user.name "UserName" # System -> /etc/gitconfig 
$ git config user.name "UserName"          # local -> .git/config 
```

- git entrypoint 

```
$ git init # Create .git dir 
$ ls 
# branches config description HEAD hooks info objects refs 
$ git ls-files # ls files at stagging area 
# file.txt 
$ find ./git/objects/ -type f 
# ... blob files 
$ git add fileName 
# add file to stagging area 
$ git ls-file -s             # Show tracked files but no snapshot yet
# blob == (type, size, content)
# metadata : which also contains "/path/to/file"
$ git mv # to rename file 
```

- track History ?? 
    - Rollback 
    - Rollforward 
    
- Batach : 
    - Some Blobs Created But There are one Batach : 
        - There are Some Diff Files on The same area 

- Commit Object : 
    - That Will All Trees(folders) . 
    - This is wrapper To Groups Some Blobs .
    - That When Some Blobbs Change At Some Time . 
    - Any Commit At least Create 3 Object 
        - blob -> file 
            - tree -> folder 
                - commit -> EnteyPoint 
                - Comit  => Object Will Pointer To it . 

> Commit Object : The Head of any changes in some blobs . 

- git logging 

```bash
$ git log -p -2 
$ git log -p --stat 
$ git log -p --pretty=oneline
$ git log --pretty=format:"%h - %an, %ar : %s" 
$ git log --pretty=format:"%h %s" --graph
```
--- 

## Undoing Things 

```bash
# === Restore === # 
$ git restore              # only Modified
$ git restore --staged     # Modified and Staged 
$ git commit  --amend      # Modify the message for last commit 
# === Reset === # 
$ git diff                 # between stage and working tree 
$ git reset HEAD           # to staging area 
$ git reset HEAD --hard    # to working area 
$ git reset HEAD --hard~1  # return one commit Back
$ git reset --hard HEAD@{1}# go commit forward 
$ git reflog               # to show the logs on commits 
# === Revert === # 
$ git revert <commitrefs>  # return on this command chagnes 
```

## Tags 

> You need to `mark` commit as version 

```bash 
# 2 types of tags <Annotated tag> and <lightweight tag> 
$ git tag -a <version> -m "<msg>" 
$ git show <version>
```

## Working With Remote Repo 

```bash
# Clone Don't remove the connection between remote repo and local repo
$ git clone <paht_to_remote_repo>  <local_repo>
# === Remote Branches === # 
$ git branch -r 
```

> Can use More than one remote 

```bash 
$ git remote add <remote_name> <remote_path>
$ git fetch # Don't Make Merge With your Local repo ? 
# 1. Fetch update 
# 2. Merge Update 
$ git pull # fetch + merge 
$ git status # compare local branch with tracked remote in remote repo 
$ git push --set-upstream origin feature  # first time to tracked this in remote 
$ git push -u             origin feature 
``` 

> Default Work To Make A Branch to your Changes ... 

## Intorduction To Github 

- `Github` : is Romote Location To Store your Repos 
    - Readme.md : Readme is which show under repo  
    - .gitignore: don't tracking this files.   
    - licencse  : this which show polices to can updates . 

- `Github Settings` : 
    - There some Feature Don't Exists like 
        - Create a `Protected Branch`
        - Create a `Pull Request` 
        - Create a `Merge Police` 

- `https` -> here your account  
- `ssh`   -> here all  accounts 
--- 
