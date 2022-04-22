function [] = plot_skr_LH_RH_integrated(year,doy,hour,hd)
load frequency_sample_center.mat;
DataPath1 = 'D:\data\kronos_raw_data\Saturn_Kilometric_Radiation';
yearstr = num2str(year);
formatSpec = '%03d';
doystr = num2str(doy,formatSpec);
DataPath = strcat(DataPath1,filesep,yearstr);
filename = strcat(yearstr,doystr,'.','skr');
DataPath2 = fullfile(DataPath,filename);

data = importdata(DataPath2);
data = data(2:end);
matrix = split(data);

time = matrix(:,2);
time = split(time,{':'});
time = str2double(time);
time = time(:,1) * 60 + time(:,2);

time_begin_index = hour * 20 + 1;
time_end_index   = (hour + hd) * 20;
time = time(time_begin_index:time_end_index);

% Received_RH = str2double(matrix(time_begin_index:time_end_index,7));
% Received_LH = str2double(matrix(time_begin_index:time_end_index,9));

Emitted_LH  = str2double(matrix(time_begin_index:time_end_index,10));
Emitted_RH  = str2double(matrix(time_begin_index:time_end_index,8));

% Received_RH_N = str2double(matrix(time_begin_index:time_end_index,3));
% Received_LH_N = str2double(matrix(time_begin_index:time_end_index,5));

figure;
plot(time,Emitted_LH);
hold on;
plot(time,Emitted_RH);
legend("Emitted RH integrated power in 10-1000 kHz",...
    "Emitted LH integrated power in 10-1000 kHz");

% figure;
% plot(time,Received_LH);
% hold on;
% plot(time,Received_RH);
% legend("Received RH integrated power in 10-1000 kHz",...
%     "Received LH integrated power in 10-1000 kHz");
% 
% figure;
% plot(time,Received_LH_N);
% hold on;
% plot(time,Received_RH_N);
% legend("Received RH integrated power in 100-400 kHz",...
%     "Received LH integrated power in 100-400 kHz");
%
% xticks([480 510 540]);
% xticklabels({'08:00','08:30','09:00'});
%
% xticks([780 810 840]);
% xticklabels({'13:00','13:30','14:00'});
% 
% xticks([900 930 960]);
% xticklabels({'15:00','15:30','16:00'});

title(strcat(num2str(year),'-',num2str(doy),'-',num2str(hour)));
end
