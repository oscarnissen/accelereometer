clear all
close all
clc


%% File Stuff
load flexaquaWaves_hs1.mat
% Accelerometer:
%%
% load buh05Feb2020.mat
% load buhJan.mat
% load buh21Feb2022.mat
% load buh19Jan2020.mat
% load buh23Jan2020.mat

% Buoy:

fileID = 'C:\Users\oscarn\Documents\Matlab filer\Akselerometer\Datafiler\Buholmen\Real Waves\Bøya\rawSeawatchExp22.txt'; 
buoy_table = importBuoyData(fileID);
% 
% startTime = datetime('23/01/2020 03:00:00.000','InputFormat','dd/MM/yyyy HH:mm:ss.SSS'); 
% endTime = datetime('23/01/2020 15:00:00.000','InputFormat','dd/MM/yyyy HH:mm:ss.SSS');

startTime = datetime('07/02/2020 00:00:00.000','InputFormat','dd/MM/yyyy HH:mm:ss.SSS'); 
endTime = datetime('23/02/2020 23:59:00.000','InputFormat','dd/MM/yyyy HH:mm:ss.SSS');

% startTime = datetime('23/01/2020 03:00:00.000','InputFormat','dd/MM/yyyy HH:mm:ss.SSS'); 
% endTime = datetime('23/01/2020 15:00:00.000','InputFormat','dd/MM/yyyy HH:mm:ss.SSS');

% startTime = datetime('19/01/2020 05:00:00.000','InputFormat','dd/MM/yyyy HH:mm:ss.SSS'); 
% endTime = datetime('19/01/2020 17:00:00.000','InputFormat','dd/MM/yyyy HH:mm:ss.SSS');


timeInterval = timerange(startTime,endTime);
TT_buoy_table = table2timetable(buoy_table);
buoy_data = timetable2table(TT_buoy_table(timeInterval,:));

%% 
%Spectral analysis
sensorName = "ch2_14755";
freq_range = [0.08 0.7];
alpha = 1.6;
overlap_ratio = 0.5;
dt = 0.125;

[wave_heights,t2] = estimate_wave_heights_from_file("buhFeb2020.mat",30,sensorName, freq_range, alpha, overlap_ratio,dt);
spectral_table = table(t2',wave_heights','VariableNames',{'Time','WaveHeights'});
TT_spectral_table = table2timetable(spectral_table);
spectral_table = timetable2table(TT_spectral_table(timeInterval,1));


%% Plot 2
[rmse] = verifyFilterPerformance(spectral_table.WaveHeights, spectral_table.Time, buoy_data.hm0, buoy_data.Time);
disp("RMSE: "+ num2str(rmse));

% Create a figure and set the size
figure_width = 800; % Width in pixels
figure_height = 400; % Height in pixels
figure('Position', [100, 100, figure_width, figure_height]);

% Define colors from the Paul Tol colorblind-friendly palette
% color1 = [102, 194, 165] / 255;
color4 = [252, 141, 98] / 255;
color1=[0, 0.4, 0.7]; % Blue color for the estimated wave height
color2=[0.8, 0.1, 0.1]; % Orange color for the real measurements
color3 = [141, 160, 203] / 255;
% Plot the estimated wave heights
plot(waveHeightFlexaqua_hs1.Time, waveHeightFlexaqua_hs1.hs, 'LineWidth', 2, 'Color', color1);
hold on;
plot(spectral_table.Time, spectral_table.WaveHeights, 'LineWidth', 2, 'Color', color4);
% Plot the first real measurement
plot(buoy_data.Time, buoy_data.hm0, 'LineWidth', 2, 'Color', color2);

% yyaxis right
% plot(buoy_data.Time, buoy_data.mdir, 'LineWidth', 2);


% plot_startTime = datetime('13/01/2021 00:00:00.000','InputFormat','dd/MM/yyyy HH:mm:ss.SSS'); 
% plot_endTime = datetime('14/01/2021 23:59:00.000','InputFormat','dd/MM/yyyy HH:mm:ss.SSS');
% plot_startTime = datetime('19/11/2020 14:00:00.000','InputFormat','dd/MM/yyyy HH:mm:ss.SSS'); 
% plot_endTime = datetime('20/11/2020 14:00:00.000','InputFormat','dd/MM/yyyy HH:mm:ss.SSS');
% plot_startTime = datetime('24/12/2020 02:00:00.000','InputFormat','dd/MM/yyyy HH:mm:ss.SSS'); 
% plot_endTime = datetime('25/12/2020 01:00:00.000','InputFormat','dd/MM/yyyy HH:mm:ss.SSS');
plot_startTime = datetime('07/02/2020 00:00:00.000','InputFormat','dd/MM/yyyy HH:mm:ss.SSS'); 
plot_endTime = datetime('23/02/2020 23:59:00.000','InputFormat','dd/MM/yyyy HH:mm:ss.SSS');

% ylim([0.4,2])
xlim([plot_startTime,plot_endTime])

% Customize the plot
% Customize the plot
title_obj =title('Accelerometer Wave Height Estimation and Real Measurements', 'FontSize', 18, 'FontWeight', 'bold');
xlabel('Date [-]', 'FontSize', 16);
ylabel('Signficant Wave Height [m]', 'FontSize', 16);

lgd = legend('V50','Accelerometer', 'Buoy', 'FontSize', 14);

grid on;
grid minor;
box on;
set(gca, 'FontSize', 14, 'LineWidth', 1, 'XMinorTick', 'on', 'YMinorTick', 'on', 'XGrid', 'on', 'YGrid', 'on', 'XMinorGrid', 'on', 'YMinorGrid', 'on');

% Adjust axis and grid appearance
ax = gca;
ax.GridAlpha = 0.3;
ax.MinorGridAlpha = 0.15;
hold off;
set(gca, 'LineWidth', 1.5);
set(gca, 'TickDir', 'out');
set(gca, 'XMinorTick', 'on', 'YMinorTick', 'on');
% xticks = linspace(min(spectral_table.Time), max(spectral_table.Time), 10);
% yticks = linspace(min_ylim, max_ylim, num_yticks);
set(gca, 'XTick', xticks, 'YTick', yticks);
ax = gca; % Get the current axes handle
ax.TitleFontSizeMultiplier = 1.1; % Increase the title font size by 10% relative to the axes font size
ax.TitleFontWeight = 'normal'; % Set the title font weight to 'normal' instead of 'bold'
title_obj = title('Wave Height Estimation and Real Measurements', 'FontSize', 18);
title_pos = get(title_obj, 'Position');
set(title_obj, 'Position', [title_pos(1), title_pos(2) + 1, title_pos(3)]);