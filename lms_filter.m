function [output_signal, error_signal] = lms_filter(input_signal, desired_signal, mu, filter_length)
    % Initialize filter coefficients
    w = zeros(filter_length, 1);

    % Initialize output and error signals
    output_signal = zeros(size(input_signal));
    error_signal = zeros(size(input_signal));

    % LMS adaptive filter loop
    for n = filter_length:length(input_signal)
        % Extract input signal segment
        input_segment = input_signal(n:-1:n-filter_length+1);

        % Calculate output and error
        output_signal(n) = w' * input_segment;
        error_signal(n) = desired_signal(n) - output_signal(n);

        % Update filter coefficients
        w = w + mu * error_signal(n) * input_segment;
    end
end