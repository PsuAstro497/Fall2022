+++
title = "Class Project Plan"
tags = ["project", "plan", "logistics"]
+++


### Class Project Plan

Each group will submit a short description of their plan their class project  by {{project_checkpoint1_due}}.  

The plan should address each of the following:

- What will be the purpose of the dashboard?  (see [ideas](../project/#Purpose))
- What data set(s) will your dashboard use for its analysis?
  - What observatories and instruments could provide the data to be analyzed?    
  - How many different objects (or time periods) are publicly available?
  - Where will you/your dashboard download the data from?   
  - Is the data small enough that we will download the entire dataset once?  Or is the dataset large enough that the dashboard will query a database to retrieve the data for each object (or time period) separate?  
  - What format will the data be in?  
- What data wrangling tasks do you anticipate needing to perform?
  - Will the data for each object (or time period) arrive in a single table?  Or will you need to perform joins across multiple tables?
- What models will your dashboard fit to the data?
  - What will serve as the robust baseline model?
  - What will serve as the more sophisticated model?
  - What will the models predict?
- Describe the plots that will be displayed on your dashboard.  For each plot,
  - What data will be shown?  
  - Will it be plotted with a curve, points, contours, histogram, etc.?
  - What will be the axes?
  - Is there additional information that could be conveyed through other attributes like size or color of points?   
  - Would it be helpful to include multiple panels (e.g., to show data on different x or y scales, or to show predictions of different models)?
  - Will the figures that you have already described be sufficient for the dashboard to achieve its purpose?  Or do you anticipate needing additional experimentation to convey the results of the analysis effectively?  If you have some early ideas, then  provide enough information that you can get constructive feedback on them.
- Project schedule
  - What tasks do you (or each member of your team) plan to accomplish each week?  Make sure to account for scheduling constraints such as exams or big assignments in other classes, holidays, and travel.   Be sure to allow some contingency in the schedule for tasks that take longer than expected or other unexpected delays.  
  - If you're working as part of a team, then make a plan for how your team will work.  Will you work together on each task simultaneously?  Will each person be responsible for writing code to do specific tasks separately?  It's particularly important to make a plan that doesn't create problematic dependencies (e.g., one person needs to wait for working code from someone else and the team can only meet the deadline if everything goes perfectly).  
  - If you or your team have any hard scheduling constraints that would prevent them from presenting during class on Dec 2, 5, 7 or 9.  You may also indicate any additional scheduling preferences.

### Potential Data Sources
- Transit light curves:  
  - Kepler/K2
  - TESS
- Transit Timing Variations:  
  - Table of transit times from Holczer et al. (2016)
- Radial Velocities:
   - California Legacy Survey RVs
   - NEID standard star observations
   - NEID solar observations
- Host star properties
   - California Legacy Survey spectra
   - NEID standard star spectra
