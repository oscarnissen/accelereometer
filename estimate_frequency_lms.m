function center_freq = estimate_frequency_lms(signal, fs, freq_range)
    nfft = length(signal);
    [psd, f] = pwelch(signal, [], [], nfft, fs);
    idx = (f >= freq_range(1)) & (f <= freq_range(2));
    psd = psd(idx);
    f = f(idx);

    % Weighted frequency estimation
    weighted_freq = sum(f .* psd) / sum(psd);

    % Calculate the center frequency
    center_freq = weighted_freq;
end