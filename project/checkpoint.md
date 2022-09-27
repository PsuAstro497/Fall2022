+++
title = "Class Project Checkpoints"
tags = ["project", "checkpoints", "logistics"]
+++

### Class Project Checkpoints

Each group will submit two progress reports by {{project_checkpoint2_due}} and {{project_checkpoint3_due}}.  
Each progress report should include a link to the current prototype version of your dashboard, along with any instructions needed to use it.  
Each progress report should also include your assessment of how well the current prototype dashboard meets the expectations for the checkpoint (and mention if it already meets (or nearly meets) some of the expectations for the next checkpoint).  
Each progress report should include a comparison of where the project is to the most recently submitted project schedule.  
If your team needs to make adjustments to the schedule, then identify what caused the changes, state if you'll be making any changes to prevent similar delays in the future, and present a revised project schedule that is agreeable to all team members.

For students working in a team, the team should generally submit a single progress report.  
If the team has questions (e.g., one team member thinks the prototype is adequately meeting expectations, but another team member is concerned that it might not), then they can include those in the progress report.
Team members should only should submit separate progress reports, if they are unable to reach an agreement.


#### Checkpoint 1 ({{project_checkpoint2_due}})
By the first checkpoint, it's expected that you'll have a prototype dashboard that:
- Ingests the data for analysis.  E.g.,
  - Downloads the needed data and reads the files into memory
  - Sends a query to a database and parses the data returned
- Allows user to select the dataset to be analyzes (typically an object or date range)
- Checks if dataset selected is problematic (e.g., missing, too small for intended analysis)
- Performs data wrangling necessary to get data ready for analysis.  E.g.,
  - Flag datapoints that are problematic (e.g., missing, NaN) or suspect (e.g., have data quality issue, unphysical values)
  - If combining data from multiple sources/tables, performs joins to create a combined DataFrame for analysis

In some cases, each of these will go relatively smoothly and you can begin to make significant progress towards meeting some of the expectations for the final checkpoint and include that in their first progress report.  
In other cases, you may realize that some of the above tasks are more challenging than originally anticipated.
For example, you may find that you can read in the data of 90% of the objects just fine, but the data for 10% of the objects presents additional complications.  
Rather than spending most of your time on addressing data quality issues for the problematic 10%, it's recommended that you first get your dashboard prototype working for the 90% of objects that go relatively smoothly.
If that applies to you, then your progress report should describe the issues that you've identified and one or two plans to deal with them.  
For example, you might say:
   "Some stars have RV observations from three observatories and should be modeled with three RV offsets.  If we have time, then we'll generalize the code to fit three RV offsets (instead of the current one or two).  If we do not have time, then we'll check the number of data sources for the selected target and ask the user to pick two for including in the analysis."
This will allow your team to get feedback on your plans early in the project, while there's still plenty of time to make adjustments.  


#### Checkpoint 2 ({{project_checkpoint3_due}})
By the second checkpoint, it's expected that you'll have a prototype dashboard that:
- Meets all expectations for Checkpoint 1
- Visualizes the user-selected data with relatively little processing or analysis
- Visualizes the user-selected data after any potentially significant data processing
- Robustly fits a simple model to the selected dataset
- Fits at least one more sophisticated model to the data (recognizing that further work may be necessary to make this fitting robustly perform well)
- Visualizes the predictions of at least one of the models and the deviations of the predictions from observations
- Assesses the quality of results from each model (or a short description of your plans for performing model assessment)
- Provides any additional visualizations or messages necessary to clearly communicate the results of the analysis.  

While your project schedule should aim to have accomplished the above, it will be ok if not all of the expectations have been met as of the final checkpoint.  
It's common for some tasks to take longer than expected.     
That said, this is an opportunity for your team to get feedback on your visualizations and model fitting, while there's still time for you to make improvements prior to submitting your final dashboard.  
The more complete your dashboard is at this checkpoint, the more likely is that you'll receive constructive feedback.  
