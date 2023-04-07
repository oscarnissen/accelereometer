function [center_freq, bandwidth] = estimate_frequency_wflc(signal, fs, freq_range,alpha)
    nfft = length(signal);
    [psd, f] = pwelch(signal, [], [], nfft, fs);
    idx = (f >= freq_range(1)) & (f <= freq_range(2));
    psd = psd(idx);
    f = f(idx);

    % Weighted frequency estimation
    weighted_freq = sum(f .* psd) / sum(psd);

    % Determine the optimal bandwidth
    bandwidth = alpha * weighted_freq;

    % Calculate the center frequency
    center_freq = weighted_freq;
end