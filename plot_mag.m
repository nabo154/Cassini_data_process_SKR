
function [] = plot_mag(year,doy,hour,hd)
[month,day] = doy2date(year,doy);
DataPath1 = 'D:\data\kronos_raw_data\Cassini_1_min_mag';
file_name = strcat(num2str(year),'_FGM_KRTP_1M.mat');
% file_name = strcat(num2str(year),'_FGM_KSM_1M.mat');
datafile = fullfile(DataPath1,file_name);
load(datafile,'Bx','By','Bz','Btotal','time');

[begin_time] = date_to_t97(year,month,day,hour,0,0);
[end_time]   = date_to_t97(year,month,day,hour + hd,0,0);

begin_index = find(abs(time - begin_time) == min(abs(time - begin_time)));
end_index   = find(abs(time - end_time) == min(abs(time - end_time)));
xx = linspace(hour,hour + hd, end_index - begin_index + 1);

plot(xx,Bx(begin_index:end_index));
ylabel('Magnetic filed  nT');
hold on;
plot(xx,By(begin_index:end_index));
plot(xx,Bz(begin_index:end_index));
plot(xx,Btotal(begin_index:end_index));
xlabel(strcat('Day ',{32},num2str(year),'-',num2str(month),'-',num2str(day)));
legend('Bx','By','Bz','Btotal');
title('CASSINI MAG');
end
