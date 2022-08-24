+++
title = "SSH keys on ACI"
+++

For students using Roar for the first time,
- Open [portal2.aci.ics.psu.edu](https://portal2.aci.ics.psu.edu/) in your browser's guest or incognito mode.
- Log in with your Penn State credentials (and authenticate if necessary).
- Select Clusters._ACI Shell Access (You'll likely have to complete 2 factor authentication again.)
- Run the following script
```shell
/gpfs/group/RISE/classroom/astro_497/scripts/updateKeys.sh
```
once at the beginning of the semester.  

This will:

1) Properly setting up keys for password-less ssh to compute nodes which is sometimes required by some distributed computing models,
2) Generate keys for github,
3) Modify ssh config file, and
4) Set proper permissions on all ssh files/directories.

I recommend that you do NOT enter a password for your ssh key. 


Once you run the `updateKeys.sh` script, then you'll need to [add the new ssh key to the list of authorized keys for your github account](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/#platform-linux) in order to push code from ACI to github.
- Follow the link to your github repository for Lab 1 (the one like https://github.com/PsuAstro497/lab1-yourgithubid),
- Look for the green "Code" button near the top.  There will be a message about not having SSH keys setup.  Click "add a new public key".  
- In the Title box enter "ACI key" (or your preferred identifier).  
- In the "Key" box paste the contents of the file ~/.ssh/id_rsa.pub from the ACI system.  You can get your ssh public key by running 'cat  ~/.ssh/id_rsa.pub' from the command line while logged into Roar (or download it from the ACI portal by going to Files.Home Directory, clicking "Show Dotfiles" (at the top of the page), double clicking .ssh, clicking id_rsa.pub and then download.  Then copy from your favorite text editor.)  


The next step is to [configure git on Roar](../git/)
