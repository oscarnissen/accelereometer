function [preprocessed_data, interpolated_data, time] = preprocess_data(data, time)
    % Ensure data and time are column vectors
    data = data(:);
    time = time(:);

    % Remove NaN and infinite values from data
    invalid_data_indices = isnan(data) | isinf(data);
    data(invalid_data_indices) = [];
    time(invalid_data_indices) = [];

    % Detrend the data
    detrended_data = detrend(data);

    % Denoise the data using a median filter
    window_size = 5;
    denoised_data = medfilt1(detrended_data, window_size);

    % Identify missing data points
    missing_data_indices = isnan(denoised_data);

    % Interpolate missing data points
    non_missing_indices = ~missing_data_indices;
    interpolated_data = interp1(time(non_missing_indices), denoised_data(non_missing_indices), time, 'pchip');

    % Return the preprocessed data (without interpolation)
    preprocessed_data = denoised_data;
end