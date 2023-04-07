function [rmse] = verifyFilterPerformance(estimatedDisplacement, timeEst, referenceDisplacement, timeRef)

    % Interpolate the estimated displacement to match the reference displacement timepoints
    estimatedDisplacementInterp = interp1(timeEst, estimatedDisplacement, timeRef, 'linear', 'extrap');
    
    % Calculate the root-mean-square error (RMSE) between the reference and interpolated estimated displacements
    rmse = sqrt(mean((estimatedDisplacementInterp - referenceDisplacement).^2));

end