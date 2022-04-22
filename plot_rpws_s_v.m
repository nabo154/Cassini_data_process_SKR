% Yang Yifei Sustech Shenzhen 2022-03-04
function [] = plot_rpws_s_v(year,doy,hour,hd,freq1,freq2)
[tvec,fvec,~,~,~,vm,~,~,~,Pxm,~] = get_n2_n3d(year,doy,hour,hd);
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

% imagesc(xx,yy,Pxm(beg:fin,:));

% imagesc(xx,yy,log10(Pxm(beg:fin,:)));
imagesc(xx,log10(fvec(beg:fin)*1000),10.*log(Pxm(beg:fin,:)/(10^-17)));
% ylim([freq1,freq2]);
% imagesc(xx,log10(fvec(beg:fin)*1000),log10(Pxm(beg:fin,:) / (10^-17) ));

imagesc(xx,log10(yy*1000),10.*log(Pxm(beg:fin,:)/(10^-17)));

% set(gca,'YScale','log');
xlabel(strcat('Day ',{32},num2str(year),'-',num2str(doy)));
ylabel('Frequency [kHz]');

colormap(Axes_S,'jet');
set(gca,'YDir','norma');
colorbar;
c1 = colorbar;
c1.Label.String = 'V^2Hz^-1/10^-17';

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
end
