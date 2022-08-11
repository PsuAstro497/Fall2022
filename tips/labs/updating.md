+++
title = "Updating lab"
tags = ["tips","labs"]
+++

### Updating files from a lab
- In case the instructor makes changes to the template after you've cloned the template, it would be useful to be able to merge in those changes easily.  To prepare for that, you can set a remote upstream repository.  Here I assume that your REPO_URL was https://github.com/GITHUBID/example-GITHUBID.git.  Notice that we're replacing the first GITHUB id by the organization name "PsuAstro497" and remove the "-GITHUBID" at the end.
```shell
git remote add upstream git@github.com:PsuAstro497/example.git
```

If you haven't started or have only made a few minor changes to existing cells, then you can attempt to have git merge changes from the starting repository by running either
```shell
git pull upstream main
```
or if you have a newer version of git
```shell
git pull upstream main --allow-unrelated-histories
```

Unfortunately, Pluto notebooks can be a bit finicky, particularly if you start adding and removing cells.  So if you've already made lots of changes, then it may make more sense to:
- make a backup copy of the notebook that you've been working in,  
- download the replacement notebook from the starter repository,
- overwrite your notebook, and
- copy and paste in any important additions/changes you've made to the notebook.  
Hopefully, you won't need to do that often!
