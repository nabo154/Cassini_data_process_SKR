function [] = plot_skr_flux_cir_polar(year,doy,hour,hd)
up_frequency_index = 48;

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
% Emitted_LH  = str2double(matrix(time_begin_index:time_end_index,10));
% Emitted_RH  = str2double(matrix(time_begin_index:time_end_index,8));

% figure;
% plot(time,Received_LH);
% hold on;
% plot(time,Received_RH);
% legend("Received RH integrated power in 10-1000 kHz",...
%     "Received LH integrated power in 10-1000 kHz");
% xticks([480 510 540]);
% xticklabels({'08:00','08:30','09:00'});
% plot(time,Emitted_LH);
% plot(time,Emitted_RH);

LH_flux = str2double(matrix(time_begin_index:time_end_index,107:154));
RH_flux = str2double(matrix(time_begin_index:time_end_index,11:58));

% LH_circular = matrix(:,155:202);

LH_circular_polar = str2double(matrix(time_begin_index:time_end_index,155:202));
RH_circular_polar = str2double(matrix(time_begin_index:time_end_index,59:106));

frequency_sample = frequency_sample_center(1:up_frequency_index);

height = 0.2;
width  = 0.8;
crack  = 0.04;

panel_1 = [0.1,crack,width,height];
panel_2 = [0.1,crack * 2 + height * 1,width,height];
panel_3 = [0.1,crack * 3 + height * 2,width,height];
panel_4 = [0.1,crack * 4 + height * 3,width,height];

axes('Position',panel_1);
RH_circular_polar = RH_circular_polar(:,1:up_frequency_index);
pcolor(time,frequency_sample,RH_circular_polar');
shading interp;
caxis(gca,[-1,1]);
title('Circular polarization degree of RH SKR');
colorbar;

xticks([360 420 480 540 600]);
xticklabels({'06:00','07:00','08:00','09:00','10:00'});

xticks([780 810 840 900 930 960]);
xticklabels({'13:00','13:30','14:00','15:00','15:30','16:00'});

xticks([480 510 540]);
xticklabels({'08:00','08:30','09:00'});

axes('Position',panel_2);
RH_flux = RH_flux(:,1:up_frequency_index);
pcolor(time,frequency_sample,RH_flux');
shading interp;
% caxis(gca,[1e-24,1e-18]);
% colorbar limit
set(gca,'xtick',[]);
title('RH SKR flux density');
colorbar;

axes('Position',panel_3);
LH_circular_polar = LH_circular_polar(:,1:up_frequency_index);
pcolor(time,frequency_sample,LH_circular_polar');
shading interp;
caxis(gca,[-1,1]);
set(gca,'xtick',[]);
title('Circular polarization degree of LH SKR');
colorbar;

axes('Position',panel_4);
LH_flux = LH_flux(:,1:up_frequency_index);
pcolor(time,frequency_sample,LH_flux');
shading interp;
% caxis(gca,[1e-24,1e-18]);
set(gca,'xtick',[]);
title('LH SKR flux density');
colorbar;

end