function filtered_acceleration = design_optimal_bandpass_filter_lms(acceleration, fs, freq_range)
    % Determine the center frequency and bandwidth based on the input data
    center_freq = estimate_frequency_lms(acceleration, fs, freq_range);

    % Create a reference signal with the desired center frequency
    n = 0:length(acceleration)-1;
    reference_signal = cos(2 * pi * center_freq * n / fs);

    % Create an LMS adaptive filter object
    filter_order = 32; % You may need to tune this parameter
    step_size = 0.01;  % You may need to tune this parameter
    lms_filter = dsp.LMSFilter('Length', filter_order, 'StepSize', step_size, 'Method', 'Normalized LMS');

    % Apply the LMS adaptive filter
    [~, filtered_acceleration] = lms_filter(reference_signal, acceleration);
    filtered_acceleration = filtered_acceleration.';
end