# pMFexp
By :      Martin SZINTE<br/>
Projet :  pRFseqTest<br/>
With :    Vanessa Morita, Anna Montagnini & Guillaume Masson<br/>
Version:  1.0<br/>

## Version description
Experiment in which we try to adapt the population receptive field method to 
an eye movement experiment including different pursuit and saccades of different
amplitudes and directions.

## Acquisition sequences
* 2.0 mm isotropic<br/> 
* TR 1.2 seconds<br/>
* Multi-band 4<br/>
* 60 slices<br/>

## MRI analysis
To define later

## Behavioral analysis
* get eye coordinates using stats/behav_analysis/extract_eyetraces.py
* get saccade parameters using stats/behav_analysis/extract_saccades.py
* plot eye traces per run using stats/behav_analysis/plot_eye_traces_run.py
* plot eye traces per sequence using stats/behav_analysis/plot_eye_traces_sequence.py
* plot eye traces per saccade trials using stats/behav_analysis/plot_eye_traces_saccade.py
* plot eye traces per pursuit trials using stats/behav_analysis/plot_eye_traces_saccade.py
* plot saccade metrics summary using stats/behav_analysis/plot_saccade_metrics.py
* plot pursuit metrics summary using stats/behav_analysis/plot_pursuit_metrics.py
