+++
title = "Pluto Notebooks on Roar"
+++

# Start Roar Session with Pluto Server

If this is your first time to run Pluto on Roar, then first make sure you have an account on ACI and have completed the [initial setup](../tips/roar/) steps.
Then, each time you want to start a Jupyter notebook session on Roar, you'll follow the instructions below:
1. Browse to [portal2.aci.ics.psu.edu](https://portal2.aci.ics.psu.edu).
Using "guest" or "incognito" mode is recommended.
Login and authenticat (as necessary).

1. Under _Interactive Apps_, choose _BYOE Jupyter Server__
1. Select:
   - Jupyter Interface: JupyterLab
   - Use custom environment: checked/selected
   - Environment Setup: `source /gpfs/group/RISE/sw7/anaconda/envs-2022.05/julia/setup`
   - Ignore then box under Select a conda environment.
   - Allocation: `ebf11_i_g_lc_default`
   - Number of hours: 2 hours  (can choose longer if you plan to continue after class or outside of class)
   - Number of cores: 4
   - Memory per core: 4 GB
   - Node type: `ACI-b Legacy Core`
1. Click _Launch_
   (Wait while your job starts.)
1. Once the _Connect to JupyterLab Server_ button appears, click it.
   + The top row of tiles (labeled "Notebook") should include a tile labeled "Pluto.jl".  Click it.  
   + A new browser tab should open with a Pluto session.
   + The first time you open Pluto it will take a few minutes and is likely to time out.  Just wait a few minutes and try again.  (Behind the scenes, it's installing a lot of packages.)
   + For a blank notebook, click "new notebook", or enter the path to a notebook you'd like to open in the text box under "Open from file" and click the "Open" button.
   + Do your work, remembering to save your notebook before you quit.
1. See [Starting & Submitting Assignments](/tips/labs/) for more information on accessing and submitting assignments.
1. When you're done, close notebook tabs and click logout in upper right (of the Jupyter server session).
1. Go back to the "My Interactive Sessions" tab in the ACI Portal, click "Delete" for this Sessions and confirm.
