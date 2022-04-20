% Siyuan Wu Meudon Paris,2022-02-01

% input:
%% required
% data_metrix: 2D data metrix
% x: time axis in either unit input
% y: frequency axis in either unit input

% fmin: minimum frequency, unit same with y
% fmax: maximum frequency, unit same with y
% tmin: start time
% tmax: end time

%% optional
% col_map: colormap,either string, e.g. 'jet', or matrix from cmap,
% default: 'jet'

% col_lim: color limit, [clim1 clim2]
% cbar_label: colorbar label, string, ''

% x_label: x axis label, default with no label
% y_label: y axis label, default with no label

% x_tick: x axis tick, [x(1) x(2).. x(end)], default: automaticly given by
% add_ephm function, and automatically calculate the full hour/halfhour/min
% location.

% x_ticklabel: x axis tick label, {'a','b','c'}, given with x_tick. default
% with no Label

% y_tick: y axis tick, [10000 1000000 1000000], same unit with y, default
% with no ticks.

% y_ticklabel: y axis tick label, {'a','b','c'}, given with y_tick. default
% with no Label

% log_scale: y axis scale: log:1    linear:0
% YDirection: y axis direction: 'normal','reverse'


% axes_title: title of gca, string,'', default, automatically generate the
% label from [tvec(tmin) tvec(tmax)]
% pos_p: postion of gca

% empherm_data: Cassini orbital data, generated by get_emph_data3 fuction,
% input to add the orbital information in the bottom of x axis.
% require the "ifXTickLabel" to be set to 1.

% ifXTickLabel: integer num :1 add x tick label with empherm_data, 0 do
% nothing.

% PanelLabel: give the panellabel
%%
function gca_return=Plot_spdy(data_metrix,x,y,varargin)

if isempty(data_metrix)
    disp('empty data metrix')
    return
end

p=inputParser;
p.addParameter('fmin',min(y));
p.addParameter('fmax',max(y));
p.addParameter('tmin',x(1));
p.addParameter('tmax',x(end));
p.addParameter('col_map','jet');
p.addParameter('col_lim',[-1 1]);
p.addParameter('log_scale',0);
p.addParameter('YDirection','normal');
p.addParameter('cbar_label',' ');
p.addParameter('axes_title',[]);
p.addParameter('x_label',[]);
p.addParameter('x_tick',[]);
p.addParameter('x_ticklabel',{});
p.addParameter('y_label',[]);
p.addParameter('y_tick',[]);
p.addParameter('y_ticklabel',{});
p.addParameter('pos_param',[]);
p.addParameter('empherm_data',[]);
p.addParameter('ifXTickLabel',0);
p.addParameter('PaneLabel',{});
p.addParameter('Col_PaneLabel',{'white'});% string
p.addParameter('PaneLabel_Size',[16]);
p.parse(varargin{:});


%% preparing plot peters

if p.Results.fmin~=min(y)
    [~,loca_fmin]=min(abs(y-p.Results.fmin));
else loca_fmin=1;
end

if p.Results.fmax~=max(y)
    [~,loca_fmax]=min(abs(y-p.Results.fmax));
else loca_fmax=length(y);
end

if p.Results.tmin~=x(1)
    [~,loca_tmin]=min(abs(x-p.Results.tmin));
else loca_tmin=1;
end

if p.Results.tmax~=x(end)
    [~,loca_tmax]=min(abs(x-p.Results.tmax));
else loca_tmax=length(x);
end

if p.Results.log_scale==1
    y=log10(y);
end

%% Plot

if ~isempty(p.Results.pos_param)
    gca_return=axes('Position',p.Results.pos_param);
end
h1=surf(x(loca_tmin:loca_tmax),y(loca_fmin:loca_fmax),data_metrix(loca_fmin:loca_fmax,loca_tmin:loca_tmax));
shading flat
view(2)

xlim([x(loca_tmin) x(loca_tmax)]);
ylim([y(loca_fmin) y(loca_fmax)]);
xlabel(p.Results.x_label,'FontWeight','bold', 'FontSize',11);
ylabel(p.Results.y_label,'FontWeight','bold', 'FontSize',11);
colormap(gca,p.Results.col_map);
set(gca,'Clim',p.Results.col_lim,'YDir',p.Results.YDirection,'FontWeight','bold',...
    'FontSize',10,'linewidth',1.0,'layer','top',...
    'xminortick','on','yminortick','off',...
    'ticklength',[0.01 0.01],'tickdir','out','LineWidth',1.0,...
    'Ytick',p.Results.y_tick,'Yticklabel',p.Results.y_ticklabel);

if isempty(p.Results.x_tick)
    set(gca,'Xtick',add_ephm(x(loca_tmin:loca_tmax)),'Xticklabel',p.Results.x_ticklabel);
else
    set(gca,'Xtick',p.Results.x_tick,'Xticklabel',p.Results.x_ticklabel);
end


NocbarPos=get(gca,'Position');
cbar=colorbar;
cbar.Label.String=p.Results.cbar_label;
set(cbar,'ticklength',0.02,'tickdir','out','LineWidth',1.0);

if isempty(p.Results.axes_title)
    temp_min=datevec(x(loca_tmin));
    temp_max=datevec(x(loca_tmax));
    if temp_max(5)==59 & temp_min(5)==59
        title(strcat('Cassini RPWS: ',datestr(datevec(datenum('1997-01-01 00:00:00')+roundn(x(loca_tmin),-4)-1+1/1440),'yyyy-mm-dd HH:MM'),32,'through',32,...
            datestr(datevec(datenum('1997-01-01 00:00:00')+roundn(x(loca_tmax),-4)-1+1/1440),'yyyy-mm-dd HH:MM')),'FontWeight','bold', 'FontSize',12);
    elseif temp_max(5)==59 & temp_min(5)~=59
        title(strcat('Cassini RPWS: ',datestr(datevec(datenum('1997-01-01 00:00:00')+roundn(x(loca_tmin),-4)-1),'yyyy-mm-dd HH:MM'),32,'through',32,...
            datestr(datevec(datenum('1997-01-01 00:00:00')+roundn(x(loca_tmax),-4)-1+1/1440),'yyyy-mm-dd HH:MM')),'FontWeight','bold', 'FontSize',12);
    elseif temp_max(5)~=59 & temp_min(5)==59
        title(strcat('Cassini RPWS: ',datestr(datevec(datenum('1997-01-01 00:00:00')+roundn(x(loca_tmin),-4)-1+1/1440),'yyyy-mm-dd HH:MM'),32,'through',32,...
            datestr(datevec(datenum('1997-01-01 00:00:00')+roundn(x(loca_tmax),-4)-1),'yyyy-mm-dd HH:MM')),'FontWeight','bold', 'FontSize',12);
    else
        title(strcat('Cassini RPWS: ',datestr(datevec(datenum('1997-01-01 00:00:00')+roundn(x(loca_tmin),-4)-1),'yyyy-mm-dd HH:MM'),32,'through',32,...
            datestr(datevec(datenum('1997-01-01 00:00:00')+roundn(x(loca_tmax),-4)-1),'yyyy-mm-dd HH:MM')),'FontWeight','bold', 'FontSize',12);
    end
else
    title(p.Results.axes_title,'FontWeight','bold', 'FontSize',12);
end

if ~isempty(p.Results.PaneLabel)
gcaxlim=get(gca,'Xlim');
gcaylim=get(gca,'Ylim');
text(0.07*(gcaxlim(2)-gcaxlim(1))+gcaxlim(1),0.93*(gcaylim(2)-gcaylim(1))+gcaylim(1),100,strcat('\color{',p.Results.Col_PaneLabel,'}',p.Results.PaneLabel),'fontweight','Bold','fontsize',p.Results.PaneLabel_Size);
end

box on
hold on
grid off
set(gca,'Position',NocbarPos);

if p.Results.ifXTickLabel==1
    xtick_loca=add_ephm(x(loca_tmin:loca_tmax),'empherm_data',p.Results.empherm_data,'ifXTickLabel',1);
end

gca_return=get(gca);
end

