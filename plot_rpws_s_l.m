
function [] = plot_rpws_s_l(year,doy,hour,hd,freq1,freq2)
[tvec,fvec,~,qm,um,~,~,~,~,~,~] = get_n2_n3d(year,doy,hour,hd);

beg = find(abs(fvec - freq1) == min(abs(fvec - freq1)));
fin = find(abs(fvec - freq2) == min(abs(fvec - freq2)));

len = length(tvec);
xx = linspace(hour,hour + hd,len);
yy = linspace(freq1,freq2,length(fvec(beg:fin)));

imagesc(xx,yy,sqrt(qm(beg:fin,:).^2 + um(beg:fin,:).^2));
ylim([freq1,freq2]);
set(gca,'YScale','log');

set(gca,'clim',[0,1]);
ylabel(['sqrt(u^2 + v^2) ','linear polarization']);
xlabel(strcat('Day ',{32},num2str(year),'-',num2str(doy)));
colormap(gca,'gray');
set(gca,'YDir','normal');
colorbar;
hold on;
[month,day] = doy2date(year,doy);
DataPath1 = 'D:\data\kronos_raw_data\Cassini_1_min_mag';
file_name = strcat(num2str(year),'_FGM_KRTP_1M.mat');
datafile = fullfile(DataPath1,file_name);
load(datafile,'Btotal','time');

[begin_time] = date_to_t97(year,month,day,hour,0,0);
[end_time]   = date_to_t97(year,month,day,hour + hd,0,0);

begin_index = find(abs(time - begin_time) == min(abs(time - begin_time)));
end_index   = find(abs(time - end_time) == min(abs(time - end_time)));

if length(begin_index) ~= 1
    begin_index = begin_index(1);
end

if length(end_index) ~= 1
    end_index = end_index(1);
end

x = linspace(hour,hour + hd, end_index - begin_index + 1);
% electron unit C coulomb
e = 1.602176634 * power(10,-19);
% electron mass Kg
m = 9.10956 * power(10,-31);
% magnetic field nT 1nT = 10e-9 T

fce = e .* Btotal(begin_index:end_index) * power(10,-9) / (2 * pi * m);
% fpe = sqrt(N * power(e,2) / (4 * power(pi,2) * m * epison_0));
plot(x,fce./1000,'r');
end
