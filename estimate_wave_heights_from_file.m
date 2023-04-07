function [wave_heights, time_intervals] = estimate_wave_heights_from_file(filename, interval_minutes, sensor_name, freq_range, alpha, overlap_ratio,dt)
    % Import the data
    [time,acceleration] = import_accelerometer_data(filename, sensor_name);

    % Preprocess acceleration data
    [filtered_acceleration, time] = preprocess_and_filter_acceleration(acceleration, time, freq_range,alpha);

    % Compute mean measurement timestep
%     dt = mean(seconds(diff(time)));

    % Convert acceleration to displacement
    displacement = calculate_displacement(filtered_acceleration, dt);

    % Estimate wave heights
    [wave_heights, time_intervals] = compute_wave_heights_by_interval(displacement, time, interval_minutes, dt, overlap_ratio);
end