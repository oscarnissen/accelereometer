function [Hs_spectral, snr] = perform_spectral_analysis(segment_displacement, dt)
    fs = 1 / dt;
    window = kaiser(floor(length(segment_displacement) / 10));
    noverlap = floor(length(window) / 2);
    nfft = 2 ^ nextpow2(length(segment_displacement));

    [pxx, f] = pwelch(segment_displacement, window, noverlap, nfft, fs);
    m0 = trapz(f, pxx);
    Hs_spectral = 4 * sqrt(m0);

    % Compute signal-to-noise ratio (SNR) for the current segment
    signal_power = trapz(f, pxx);
    noise_power = sum(pxx) - signal_power;
    snr = 10 * log10(signal_power / noise_power);
end