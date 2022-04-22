% Yang Yifei, Sustech Shenzhen,2022-03-03
year = 2017;
month = 3;
day = 7;
doy = 66;
hour = 13;
hd = 4;
freq1 = 10;
freq2 = 1000;

[tvec,fvec,Sm,qm,um,vm,thm,phm,DFm,Pxm,Pwm] = get_n2_n3d(year,doy,hour,hd);
height = 0.3;
width = 0.8;
panel_1 = [0.1,0.6,width,height];
panel_2 = [0.1,0.2,width,height];

beg = find(abs(fvec - freq1) == min(abs(fvec - freq1)));
fin = find(abs(fvec - freq2) == min(abs(fvec - freq2)));

Axes_S = axes('Position',panel_1);
len = length(tvec);
xx = linspace(hour,hour + hd,len);
yy = linspace(freq1,freq2,length(fvec(beg:fin)));
imagesc(xx,yy,log10(Pxm(beg:fin,:) / (10^-17) ));
hold on;
ylim([freq1,freq2]);
% imagesc(xx,log10(fvec(beg:fin)*1000),log10(Pxm(beg:fin,:) / (10^-17) ));

set(gca,'YScale','log');
xlabel(strcat('Day ',{32},num2str(year),'-',num2str(doy)));
ylabel('Frequency [kHz]');

colormap(Axes_S,'jet');
set(gca,'YDir','normal');
colorbar;
c1 = colorbar;
c1.Label.String = 'V^2Hz^-1/10^-17';

DataPath1 = 'D:\data\kronos_raw_data\Cassini_1_min_mag';
file_name = strcat(num2str(year),'_FGM_KRTP_1M.mat');
datafile = fullfile(DataPath1,file_name);
load(datafile,'Btotal','time');

[begin_time] = date_to_t97(year,month,day,hour,0,0);
[end_time]   = date_to_t97(year,month,day,hour + hd,0,0);

begin_index = find(abs(time - begin_time) == min(abs(time - begin_time)));
end_index   = find(abs(time - end_time) == min(abs(time - end_time)));

x = linspace(hour,hour + hd, end_index - begin_index + 1);

% electron unit C coulomb
e = 1.602176634 * power(10,-19);
% electron mass Kg
m = 9.10956 * power(10,-31);
% magnetic field nT 1nT = 10e-9 T

fce = e .* Btotal(begin_index:end_index) * power(10,-9) / (2 * pi * m);
% fpe = sqrt(N * power(e,2) / (4 * power(pi,2) * m * epison_0));
plot(x,fce./1000,'w');

Axes_V = axes('Position',panel_2);
% imagesc(xx,log10(fvec(beg:fin)*1000),vm(beg:fin,:));
imagesc(xx,yy,vm(beg:fin,:));
ylim([freq1,freq2]);
set(gca,'YScale','log');

set(Axes_V,'clim',[-1,1]);
ylabel(['V ','Circular polarization']);
xlabel(strcat('Day ',{32},num2str(year),'-',num2str(doy)));
colormap(Axes_V,'gray');
set(gca,'YDir','normal');
colorbar;
hold on;
plot(x,fce./1000,'w');