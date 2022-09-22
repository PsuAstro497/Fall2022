+++
title = "Class Project"
tags = ["project", "logistics", "overview"]
+++

## Class Project

### Overview
Students will synthesize lessons learned in the class by building an exoplanet “dashboard” that ingests data related to detecting and/or characterizing exoplanets, performs basic data manipulations, fits a model to the data, assesses the quality of the model for the given observations, and effectively visualizes the results.  

### Purpose
The first step is figuring out what the purpose of your dashboard will be.  
That will affect many aspects of your project (e.g., the data it presents, the models it fits, the visualizations that it shows).  Below are some example ideas that you can choose from or use to help you think of something that's particularly interesting to you.

- Transits
  - Analyze transit light curves to vet planet candidates from potential astrophysical false positives
  - Analyze transit light curves to inform planning of follow-up observations
- Transit Timing Variations
  - Analyze TTV observations to assess whether TTVs are likely due to known transiting planets or additional unknown  planets
  - Analyze TTV observations to assess whether TTVs are more likely due to dynamical effects or stellar variability.
  - Analyze TTV observations to identify candidates for RV follow-up observations
- Radial Velocity Observations
  - Analyze radial velocity observations to assess whether a planet candidate's orbit is well characterized and ready for publication
  - Analyze radial velocity observations of stars with planet candidates to inform planning of future RV measurements
  - Analyze NEID standard star observations to identify any measurements which are not robust (e.g., comparing RVs derived from each order of the spectra)
  - Analyze NEID solar observations to fit a differential extinction model specific to each day and to assess whether it is adequate to use for subsequent analysis
- Microlensing
   - Analyze microlensing light curves to assess whether a microlensing event shows evidence for a planet or binary star
   - Analyze microlensing light curves to inform planning of follow-up observations
- Other ideas
   - Synthesize observations of host stars being targeted by exoplanet surveys
   - Analyze pyrheliometer data and exposure meter data accompanying NEID solar observations to determine which days observations were likely contaminated by poor atmospheric conditions

### Elements
Once you have decided on the purpose of your dashboard, then you can begin planning each of the core elements.

#### Ingest data
A key feature of a dashboard is that it should be robust and provide useful results for new data (e.g., another day/month/year of data from the same instrument, observations of a different target using the same method).  
This is in contrast to performing a (likely more detailed) analysis for one or a few specific datasets that are of particular interest.  
Therefore, each dashboard should include the ability to select one of many potential datasets to analyze.  
It will likely not be practical to explicitly look at the results of your dashboard for every one of those datasets.
You should test that it works well on enough of those datasets that you are confident that it will also work well on the datasets that others select (e.g., the instructor and TA when grading).  


#### Data Wrangling
It's very likely that you'll need to do some manipulating of data to get it into a form you can use.  
Some example of common issues that you may need to incorporate:
- Flagging datapoints that are problematic (e.g., missing, NaN) or suspect (e.g., have data quality issue, unphysical values)
- Standardizing target identifiers (e.g., if observing logs don't use the same name consistently, if you're joining data from multiple sources)
- Checking that the dataset has the minimum number of observations to support your analysis
- Checking that the data needed for your analysis is present (particularly if you're joining data from two sources)
- Converting units to enable comparisons
- Performing variable transformations (e.g., sqrt, log) to support helpful useful visualizations

While it may not be practical to identify all the manipulations that you'll need to do, it's good to start identifying those issues that you will need to deal with (or at least check if you need to deal with).  

#### Model Fitting
Identify at least two models that your dashboard will fit to each dataset.  
Typically, there will be one model that prioritizes being robust and efficient.
Often this first model is highly simplified or approximate (e.g., linear model for transit times, circular model for RV perturbations from a single planet).  
Even if it's not complex enough for all datasets, it can serve as a useful reference point for comparison.
Typically, a second model will model additional complications (e.g., linear + sinusoidal model for transit times, Keplerian model for RV perturbations).
In some cases, it may make sense to have more than two models (e.g., allow for the possibility of additional planets or a more detailed model for transit times, such as TTVFaster).
Each dashboard should present the results of each model fit in a way that supports the purpose of that dashboard.

If all the modeling calculations are very fast, then it may make sense for the dashboard to perform all the calculations for a given system as soon as the user selects a dataset.  
If some of the modeling is more computationally demanding, then it would likely make sense for the user to have the option to perform the time consuming steps.
For example, your dashboard might automatically compute the maximum a posterior estimate of the parameters, but have a checkbox that the user must check before it starts performing Markov chain Monte Carlo simulations to compute a posterior sample.


#### Model Assessment
As demonstrated in the labs, blindly use the results of model fitting is dangerous.  
In some cases, a well-intentioned, but poorly-designed dashboard can make it scarily easy for users to jump to false conclusions/decisions.   
We want to avoid that!
Therefore, it's important that your dashboard include some mechanism to assess the quality of the results from each model it fits.  
For each model that your dashboard fits, your dashboard should perform tests that the results are reasonable and prominently warn users if there is any reason for concern.
Whenever an iterative algorithm is used, the dashboard should either report that the algorithm met the intended convergence criteria or highlight if there are convergence concerns.
For stochastic algorithms or algorithms that depend on an initial guess, either perform analyses from automatically (e.g., using different initial guesses and/or multiple sets of random numbers) or include an easy way for user to trigger an additional calculation.

In the context of a dashboard, users are expected to analyze new datasets, and it's often not practical that it perfectly fit its most detailed model to every dataset.    
For example, some datasets may provide only loose constraints on model parameters leading to convergence issues.  
For other datasets, obtaining a good model may require a more complex model than is implemented in the dashboard.  
That's completely understandable.  
Hopefully, your dashboard will have a first model that is robust enough to return useful results for any reasonable dataset.  
Then your dashboard can compare the results from the different models to support its goal.  
Again, it is very important that the dashboard make it easy for the user to recognize if there are any reasons for concern (e.g., failure to converge, converging to unphysical or limiting values, poor quality fit to data, results are sensitive to modeling choices), so users don't misuse the outputs.  

#### Visualization
Trying to make sense of a table of numbers or even a long computational notebook is often difficult and time consuming.
Effective visualizations can make it easier to digest the information.  
Your dashboard should include several plots:
1. *Visualize the data to be analyzed with relatively little processing or analysis:*  The purpose of this visualization is to give users an opportunity to recognize any data quality issues that may affect all subsequent analyses.  This might be an observed lightcurve, a raw spectrum, reported RV measurements, or the residuals of the transit times from a linear model).
1. *Visualize the data after potentially significant data processing:*  The purpose here is to give users an opportunity to recognize if any of the "automatic" processing had unintended consequences.  This might be a lightcurve after removing long-term trends, a spectrum after performing continuum normalization, RV measurements plotted versus orbital phase for a putative orbital period, or transit times plotted versus phase of a putative TTV periodicity.  
1. *Visualize the predictions of each of the models fit to the data and the deviations of the predictions from observations.*  One purpose of these visualizations is to allow the user to assess the quality of the model.  If the deviations from the model are small compared to the total extent of variations, then it may be useful to have a separate panel plotting the residuals.  If there's a modest number of data points, then you'll generally want to show the measurement uncertainty for each observation.  If there's hundreds of data points, then it may be more useful to leave out the residuals from plots of a model's predictions, but to add a histogram of the residuals to each model.   
1. *Clearly communicate the results of the analysis.*   This will depend on the purpose of your dashboard.  For example, if the purpose is to assess whether a planet candidate's orbit is well characterized and ready for publication, then the dashboard could show contour plots of the posterior probability for pairs of model parameters.   If the purpose of the dashboard is to assess whether TTVs are more likely due to dynamical effects or stellar variability, then your dashboard might plot the expected distribution of the log likelihood and indicate the maximum values of the log likelihood under the two models for TTVs.  
While the choices for the above figures will be relatively straight forward, designing this figure is likely to require some experimentation with multiple possible visualizations to find what is effective.  

In some cases, one visualization may serve multiple purposes.  For example, if the purpose of your dashboard is to inform the scheduling of future observations, then the figure showing the predictions of a model (using multiple sets of parameter values consistent with the current data) for a few months into the future, so users can see which observations times would be useful for collecting additional observations.  In some cases, that might just be one wide figure.  In other cases, it might be useful to split it into two figures, one focusing on existing data and one focusing on prediction during some window of time in the future.

In some cases, the most important result to convey may be that something went wrong and the user should do additional analysis or at least be extra cautious in interpreting the results on the dashboard.  
In those cases, the dashboard should include a prominent warning (and telling the user what triggered the warning message).




### Timeline
This is a substantive project and students should spread their effort over several weeks of the semester.  To encourage making steady progress, students will earn credit for submitting a plan and demonstrating significant progress for two additional checkpoints.  

1. [{{project_checkpoint1_title}}](plan) (due {{project_checkpoint1_due}})
1. [{{project_checkpoint2_title}}](checkpoint) (due {{project_checkpoint2_due}})
1. [{{project_checkpoint3_title}}](checkpoint) (due {{project_checkpoint3_due}})
1. [{{project_final_title}}](dashboard) (due {{project_final_due}})
1. [{{project_presentation_title}}](presentation) (due {{project_presentation_due}})
1. [{{project_report_title}}](report) (due {{project_report_due}})

### Teamwork
Students are encouraged (but not required) to work in small teams of two to three, so that they can build a high-quality dashboard, while practicing technical communications and collaboration skills.  
Groups will submit a single dashboard and present their dashboard to the full class during the final weeks of class as a group.  
Each student will individually submit a final statement describing their contributions to the dashboard project, describing the contributions of their teammates, and reflecting on what they learned from the experience.  
Remember that both you and other group members will have other assignments, exams, and projects.  
Therefore, it is very important to develop a mutually agreeable schedule and to follow through on your contributions in a timely fashion.   

## Resources
- [Exoplanet Archive](https://exoplanetarchive.ipac.caltech.edu/docs/data.html)
- [California Legacy Survey RVs](https://github.com/leerosenthalj/CLSI) (see csv files in legacy_tables directory)
- [California-Kepler Survey (spectra & RVs)](https://california-planet-search.github.io/cks-website/)
- [Kepler light curves](https://archive.stsci.edu/kepler/publiclightcurves.html)
- [Lightkurve package for downloading Kepler, K2 & TESS data](https://docs.lightkurve.org/tutorials/1-getting-started/searching-for-data-products.html)
- [Kepler Simulated data products](https://exoplanetarchive.ipac.caltech.edu/docs/KeplerSimulated.html)
- [Transit Timing Variations observed by Kepler (Holczer et al. 2016)](https://cdsarc.cds.unistra.fr/viz-bin/cat/J/ApJS/225/9#/browse)
- [IAC community database for exoplanet atmospheric observations](http://research.iac.es/proyecto/exoatmospheres/table.php)
