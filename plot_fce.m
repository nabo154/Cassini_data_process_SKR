% Yang Yifei Sustech Shenzhen 2022-03-04
function [] = plot_fce(year,doy,hour,hd)
[month,day] = doy2date(year,doy);
DataPath1 = 'D:\data\kronos_raw_data\Cassini_1_min_mag';
file_name = strcat(num2str(year),'_FGM_KRTP_1M.mat');
datafile = fullfile(DataPath1,file_name);
load(datafile,'Btotal','time');

[begin_time] = date_to_t97(year,month,day,hour,0,0);
[end_time]   = date_to_t97(year,month,day,hour + hd,0,0);

begin_index = find(abs(time - begin_time) == min(abs(time - begin_time)));
end_index   = find(abs(time - end_time) == min(abs(time - end_time)));

xx = linspace(hour,hour + hd, end_index - begin_index + 1);

% electron unit C coulomb
e = 1.602176634 * power(10,-19);
% electron mass Kg
m = 9.10956 * power(10,-31);
% magnetic field nT 1nT = 10e-9 T

fce = e .* Btotal(begin_index:end_index) * power(10,-9) / (2 * pi * m);
% fpe = sqrt(N * power(e,2) / (4 * power(pi,2) * m * epison_0));
plot(xx,fce./1000);
set(gca,'YScale','log');
ylim([10,1000]);
% set(gca,'xtick',[]);
% set(gca,'ytick',[]);
ylabel('electron cyclotron frequency kHz');
xlabel(strcat('Day ',{32},num2str(year),'-',num2str(month),'-',num2str(day)));
title('electron cyclotron frequency');
end