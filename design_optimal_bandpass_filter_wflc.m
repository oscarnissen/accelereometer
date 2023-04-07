function filtered_acceleration = design_optimal_bandpass_filter_wflc(acceleration, fs, freq_range,alpha)
    [center_freq, bandwidth] = estimate_frequency_wflc(acceleration, fs, freq_range, alpha);
    filter_order = 4;
    nyquist_freq = 0.5 * fs;
    wn = [center_freq - bandwidth / 2, center_freq + bandwidth / 2] / nyquist_freq;
    [b, a] = butter(filter_order, wn, 'bandpass');
    filtered_acceleration = filtfilt(b, a, acceleration);
end