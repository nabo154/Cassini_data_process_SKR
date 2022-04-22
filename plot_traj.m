function [] = plot_traj(year)
if(mod(year,4) == 0) 
    days = 366; 
else
    days = 365;
end 
 
if year == 2017 
    days = 257;
end 
 
latitude = zeros(1,24 * days);
radius = zeros(1,24 * days);
local_time = zeros(1,24 * days);

for doy = 1 : days 
    ephemeris_matrix = get_LT_Rs_Lat(year,doy,0,23); 
    radius(1,(doy - 1) * 24 + 1 : doy * 24) = ephemeris_matrix(2,:); 
    local_time(1,(doy - 1) * 24 + 1 : doy * 24) = ephemeris_matrix(3,:); 
    latitude(1,(doy - 1) * 24 + 1 : doy * 24) = ephemeris_matrix(4,:); 
end 
[x,y,z] = sph2cart(local_time * pi / 12 ,latitude / 180 * pi,radius);
plot3(x,y,z);

hold on;
azimuth = 0 :2 * pi / 359 :2 * pi;
r = ones(1,360);
elevation = zeros(1,360);
[x,y,z] = sph2cart(azimuth,elevation,r);
plot3(x,y,z);
hold on;

azimuth = zeros(1,360);
r = ones(1,360);
elevation = - pi / 2 : pi / 359 : pi / 2;
[x,y,z] = sph2cart(azimuth,elevation,r);
plot3(x,y,z);

% hold on;
% azimuth = zeros(1,360);
% azimuth(:) = pi;
% r = ones(1,360);
% elevation = - pi / 2 : pi / 359 : pi / 2;
% [x,y,z] = sph2cart(azimuth,elevation,r);
% plot3(x,y,z);

title(strcat('DOY-',num2str(year)));
end