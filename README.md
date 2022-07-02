# How to contribute to this Project?

### Clone this Repository
click on the code button and then click the copy to clipboard icon.  <br/>
Open a terminal and run the following git command: <br/>

  ```
    git clone "url you just copied"   
  ```  
where "url you just copied" (without the quotation marks) is the url to this repository (your fork of this project). See the previous steps to obtain the url.  <br/>

copy URL to clipboard. <br/>
For example:  <br/>

  ```
    git clone https://github.com/angellee177/MC2_Mindfull
   ```  
![image](https://user-images.githubusercontent.com/40418196/177019117-fab748fd-37f0-4cd0-9aa4-0bf151761784.png) <br/>

### Create new Branch
check the current branch by running this command: <br/>
  ```
    git branch --show-current
  ``` 
![image](https://user-images.githubusercontent.com/40418196/177019198-f22ba5aa-c3e0-44f5-93c6-d527179acef8.png)<br/>

if you were still in branch `main` , then create a new branch by running the following git command: <br/>
  ```
    git checkout -b "branch name"
  ``` 
For example: <br/>
  ```
    git checkout -b feat/dashboard
  ``` 
  
### Commit and Push Changes.
Finally!! after you make some changes needed, its time to commit your changes and push it to remote. <br/>
1. Before you push your changes, please make sure there is no changes have not commit in the current branch by running the following git command: <br/>
  ```
    git status
  ``` 
![image](https://user-images.githubusercontent.com/40418196/177019327-6196e58d-5b2b-4b42-b747-0dd560723f0d.png) <br/><br/>

2. As you can see above the picture, all changes already commit. So, now we can update the current `branch` to make sure is up to date with `main branch` by running the following git command: <br/>

![image](https://user-images.githubusercontent.com/40418196/177019241-4aba4f70-0e31-4856-af69-d88374ef2a33.png) <br/>


