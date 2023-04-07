function displacement = compute_displacement_from_acceleration(filtered_acceleration, dt)
    velocity = cumtrapz(dt, filtered_acceleration);
    velocity = detrend(velocity);
    displacement = cumtrapz(dt, velocity);
end