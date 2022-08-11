+++
title = "Committing changes"
tags = ["tips","labs","git"]
+++

## Commit changes in your Pluto notebook to your local repository

- Make sure you've saved all your changes in the Pluto notebook (Ctrl+S).
- If you want to commit changes to a single file named `ex1.jl`, then run
```shell
git add ex1.jl
git commit -m "note describing this change"
```

- If you want commit your work on all files beginning with `ex`, then you could run:
```shell
git add ex*
git commit -m "note describing these changes"
```

- Note that this commits the changes to the repository on the computer you're using, but does *not* [push those changes to GitHub](../labs/submitting/).  
