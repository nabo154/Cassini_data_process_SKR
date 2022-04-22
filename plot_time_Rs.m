
% plot Cassini Time - Rs
function[] = plot_time_Rs(year) 
 
if(mod(year,4) == 0) 
    days = 366; 
else
    days = 365;
end 
 
if year == 2017 
    days = 257;
end 
 
eph_lat = zeros(1,24 * days);

for doy = 1 : days 
    ephemeris_matrix = get_LT_Rs_Lat(year,doy,0,23); 
    eph_lat(1,(doy - 1) * 24 + 1 : doy * 24) = ephemeris_matrix(2,:); 
end 
 
len = days * 24; 
eph_time = 1 : len; 
plot(eph_time,eph_lat); 
 
xticks([2400 4800 7200]); 
xticklabels({100 200 300}); 
 
% ylim([-90 90]); 
ylabel('Rs'); 
xlabel(strcat('DOY-',num2str(year))); 
end