function [wave_heights, time_intervals] = compute_wave_heights_by_interval(displacement, time, interval_minutes, dt, overlap_ratio)
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

    snr_values = zeros(1, num_intervals);
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

        % Spectral Analysis
        [Hs_spectral, snr] = perform_spectral_analysis(segment_displacement, dt);

        snr_values(i) = snr;
        wave_heights(i) = Hs_spectral;
    end
    mean_snr = mean(snr_values);
    disp("Mean SNR: " + num2str(mean_snr));
end