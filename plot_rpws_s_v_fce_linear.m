
function [] = plot_rpws_s_v_fce_linear(year,doy,hour,hd,freq1,freq2)
    [month,day] = doy2date(year,doy);
    [tvec,fvec,~,~,~,vm,~,~,~,Pxm,~] = get_n2_n3d(year,doy,hour,hd);
    height = 0.3;
    width = 0.8;
    panel_1 = [0.1,0.6,width,height];
    panel_2 = [0.1,0.2,width,height];
    
    beg = find(abs(fvec - freq1) == min(abs(fvec - freq1)));
    fin = find(abs(fvec - freq2) == min(abs(fvec - freq2)));
    
    Axes_S = axes('Position',panel_1); 
    pcolor(tvec,fvec(beg:fin),log10(Pxm(beg:fin,:)/(10^-17)));
    shading interp;
    % set(Axes_S,'yscale','log');
    % set(gca,'ytick',[10 100 1000]);
    colormap('jet');
    title(strcat('CASSINI-RPWS-MAG:',num2str(hour),':00-',num2str(hour + hd),':00' ) );
    
    DataPath1 = 'D:\data\kronos_raw_data\Cassini_1_min_mag';
    file_name = strcat(num2str(year),'_FGM_KRTP_1M.mat');
    datafile = fullfile(DataPath1,file_name);
    load(datafile,'Btotal','time');
    
    begin_time = date2t97_mag(year,month,day,hour ,    0,0);
    end_time   = date2t97_mag(year,month,day,hour + hd,0,0);
    begin_index = find(abs(time - begin_time) == min(abs(time - begin_time)));
    end_index   = find(abs(time - end_time  ) == min(abs(time - end_time  )));
    hold on;
    
    e = 1.602176634 * power(10,-19);
    m = 9.10956 * power(10,-31);
    fce = e .* Btotal(begin_index:end_index) * power(10,-9) / (2 * pi * m);
    xx = linspace(tvec(1),tvec(end),length(fce));
    plot(xx,fce / 1000,'w');
    xlabel(strcat('Day ',{32},num2str(year),'-',num2str(doy)));
    ylabel('Frequency [kHz]');
    colorbar;
    c1 = colorbar;
    c1.Label.String = 'V^2Hz^-1/10^-17';
    
    Axes_V = axes('Position',panel_2);
    pcolor(tvec,fvec(beg:fin),vm(beg:fin,:));
    shading interp;
    set(Axes_V,'clim',[-1,1]);
    ylabel(['V ','Circular polarization']);
    xlabel(strcat('Day ',{32},num2str(year),'-',num2str(doy)));
    colormap(Axes_V,'gray');
    set(gca,'YDir','normal');
    % set(gca,'yscale','log');
    colorbar;
    hold on;
    plot(xx,fce / 1000,'b');
end