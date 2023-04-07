# Ocean Wave Height Estimation from Accelerometer Data

This MATLAB-based method estimates ocean wave heights using accelerometer data by analyzing the power spectral density (PSD) of the displacement signal derived from the accelerometer measurements. The method consists of several steps, including data import, preprocessing, filtering, displacement calculation, and wave height estimation.


## Function Overview

The main function `estimate_wave_heights_from_file` takes the following input parameters:

-   `filename`: The name of the file containing the accelerometer data.
-   `interval_minutes`: The length of the time intervals (in minutes) used for segmenting the displacement data.
-   `sensor_name`: The name of the sensor column in the input file.
-   `freq_range`: A two-element vector specifying the frequency range of interest for the bandpass filter (e.g., `[0.05, 0.5]`).
-   `alpha`: A parameter used to determine the bandwidth of the bandpass filter.
-   `overlap_ratio`: A value between 0 and 1 specifying the overlap ratio between consecutive segments of the displacement data.
-   `dt`: The time step (in seconds) between consecutive accelerometer measurements.

The function returns the following output:

-   `wave_heights`: A vector containing the estimated significant wave heights for each time interval.
-   `time_intervals`: A vector containing the corresponding time intervals for the estimated wave heights.

## Usage

To use the method, call the `estimate_wave_heights_from_file` function with the appropriate input parameters:

    filename ='example_accelerometer_data.csv';
    interval_minutes = 30;
    sensor_name = 'Sensor1';
    freq_range = [0.05, 0.5];
    alpha = 1.6;
    overlap_ratio = 0.5;
    dt = 0.125;
    [wave_heights, time_intervals] = estimate_wave_heights_from_file(filename, interval_minutes, sensor_name, freq_range, alpha, overlap_ratio, dt);
    

## Methodology

The method involves the following steps:

1.  **Import accelerometer data**: The `import_accelerometer_data` function reads accelerometer data from a file and converts the acceleration values from g to m/s².
    
2.  **Preprocess and filter acceleration data**: The `preprocess_and_filter_acceleration` function preprocesses the raw acceleration data by removing NaNs, detrending, and denoising it with a median filter. The preprocessed acceleration data is then filtered using a bandpass filter designed by the `design_optimal_bandpass_filter_wflc` function.
    
3.  **Compute displacement from acceleration**: The `compute_displacement_from_acceleration` function calculates the displacement from the filtered acceleration data by integrating the acceleration twice using the trapezoidal rule. The velocity and displacement are detrended to remove any linear trends.
    
4.  **Estimate wave heights by time intervals**: The `compute_wave_heights_by_interval` function divides the displacement data into overlapping segments based on the specified `interval_minutes` and `overlap_ratio`. For each segment, it performs spectral analysis using the `perform_spectral_analysis` function, which computes the PSD using the Welch method, calculates the zeroth-order moment (m0) of the PSD, and estimates the significant wave height (Hs) as 4 times the square root of m0.


## Limitations and Assumptions

The method relies on several assumptions, such as the choice of the filter design, the method used for spectral analysis, and the overlap ratio for segmenting the data. These assumptions may affect the results and impose some limitations on the method:

1.  **Filter design**: The choice of the bandpass filter and its parameters (e.g., filter order, center frequency, and bandwidth) can impact the quality of the filtered acceleration data. The method uses the weighted frequency locked loop (WFLC) to estimate the center frequency and bandwidth, but other filter designs or parameter estimation methods could be used as well.
    
2.  **Spectral analysis**: The method uses the Welch method for spectral analysis, which is based on averaging periodograms. This approach provides a trade-off between frequency resolution and variance reduction but may not be optimal for all cases. Other spectral estimation techniques, such as the Lomb-Scargle periodogram or multitaper methods, could be considered as alternatives.
    
3.  **Overlap ratio**: The choice of the overlap ratio can impact the wave height estimation results, particularly in cases where the wave conditions change rapidly. A higher overlap ratio can provide better temporal resolution but may increase computation time.
    
4.  **Assumptions about wave characteristics**: The method assumes that the wave heights follow a Gaussian distribution and that the significant wave height can be estimated from the zeroth-order moment of the power spectral density. This assumption may not hold for all types of ocean waves or sea states.
   
It is important to consider these limitations and assumptions when using the method and to perform sensitivity analyses to understand how changes in the input parameters affect the estimated wave heights. By doing so, users can make informed decisions when choosing appropriate parameter values for their specific application.


