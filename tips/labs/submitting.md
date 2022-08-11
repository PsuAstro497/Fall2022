+++
title = "Submitting Labs"
tags = ["tips","labs","git"]
+++

# Submitting your Lab
\toc


## Commit changes before you submit
Ideally, you'd commit small changes as you go.  At a minimum, make sure that you [commit your changes to your local repository](../commit) each time you are wrapping up a coding session or about to take a break.
From the terminal tab, make sure you're in your repo's directory.
Then use the following command to commit all changes you've made to files being tracked by git in the current repository.  
```shell
git commit -a -m "Completed"    
```
Including "Completed" in the commit message lets the instructor and/or TA know that you're done with the assignment.  
<!-- Consider [testing your code](testing) on ACI (or you local computer) before submitting the final version of your code.
-->

---
## Push commits to Github
- Return to the terminal tab, make sure you're in your repo's directory.
- Run the following commands

```shell
git push
```

<!--
- If this repository is configured to apply tests via continuous integration, then navigate to your repository, click ACtions, then look for "Workflows" and choose "Test notebooks".  There will be some tests of early versions that have red x's next to them.  Hopefully, your latest submission (typically at the top of the list) will have a green checkbox next to it.  If not, then you can click on that commit string, then click "test (...)" and see the results of the continuous integration tests.
-->
