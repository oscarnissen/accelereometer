function [wave_heights, time_intervals] = compute_wave_heights_by_interval_zc(displacement, time, interval_minutes, dt, overlap_ratio)
    % Check for valid overlap_ratio input
    if overlap_ratio < 0 || overlap_ratio > 1
        error('Overlap ratio must be between 0 and 1.');
    end
    
    interval_samples = round((interval_minutes * 60) / dt);
    overlap_samples = round(interval_samples * overlap_ratio);
    step_samples = interval_samples - overlap_samples;
    num_intervals = ceil((length(time) - overlap_samples) / step_samples);
    wave_heights = zeros(1, num_intervals);
    time_intervals = NaT(1, num_intervals);

    for i = 1:num_intervals
        start_index = (i - 1) * step_samples + 1;
        end_index = start_index + interval_samples - 1;
        if end_index > length(time)
            break;
        end

        % Set the time interval as the starting time of the current segment
        time_intervals(i) = time(start_index);

        % Extract the displacement data for the current segment
        segment_displacement = displacement(start_index:end_index);

        % Zero-crossing method
        zero_crossings = find(diff(sign(segment_displacement)) ~= 0);
        wave_periods = diff(time(zero_crossings));
        wave_heights_temp = zeros(1, numel(zero_crossings) - 1);

        for j = 1:(numel(zero_crossings) - 1)
            wave_heights_temp(j) = max(segment_displacement(zero_crossings(j):zero_crossings(j+1))) - min(segment_displacement(zero_crossings(j):zero_crossings(j+1)));
        end

        % Compute significant wave height (Hs) as the average of the highest one-third of the individual wave heights
        top_third_wave_heights = sort(wave_heights_temp, 'descend');
        wave_heights(i) = mean(top_third_wave_heights(1:ceil(length(wave_heights_temp)/3)));



    end
end
