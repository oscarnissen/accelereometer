function [time,acceleration] = import_accelerometer_data(filename, sensor_name)
    data = importdata(filename);
    data = rmmissing(data(:,["DateTimeFormat", sensor_name]));
    data = renamevars(data, sensor_name, "Acceleration");
    time = data.DateTimeFormat;
    acceleration = data.Acceleration * 9.81; % Convert from g to m/s²
end