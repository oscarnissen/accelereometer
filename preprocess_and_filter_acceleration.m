function [filtered_acceleration, time] = preprocess_and_filter_acceleration(acceleration, time, freq_range,alpha)
    [~, preprocessed_acceleration, preprocessed_time] = preprocess_data(acceleration, time);

    % Compute mean measurement frequency
    dt = mean(seconds(diff(preprocessed_time)));
    fs = 1 / dt;

    % Apply bandpass filter
    filtered_acceleration = design_optimal_bandpass_filter_wflc(preprocessed_acceleration, fs, freq_range, alpha);
%     filtered_acceleration = design_optimal_bandpass_filter_lms(preprocessed_acceleration, fs, freq_range);
end