% Yang Yifei Sustech Shenzhen 2022-03-07
function [ephemeris_matrix] = get_LT_Rs_Lat(year,doy,hour,hd)
% Output
% the first  row time  per 30 minutes
% the second row Rs    1 Rs = 60268.0 km
% the third  row LT    Local Time
% the fourth row LAT   Latitude
DataPath1 = 'D:\data\kronos_raw_data\Cassini_1_min_emphmeris';
file_name = strcat('Cassini_ephermerData_',num2str(year),'.mat');
datafile = fullfile(DataPath1,file_name);
load(datafile,'empherm_data');
index = ((doy - 1) * 24 + hour ) * 60 + 1;

intervals = 60;
% Sampling every 60 minutes
timeIndexs = hd * 60 / intervals + 1;
ephemeris_matrix = zeros(4,timeIndexs);

for i = 1 : timeIndexs
    ephemeris_matrix(1,i) = empherm_data(index,3) + empherm_data(index,4) / 60;
    ephemeris_matrix(2,i) = empherm_data(index,13);
    ephemeris_matrix(3,i) = empherm_data(index,11);
    ephemeris_matrix(4,i) = empherm_data(index,9);
    index = index + intervals;
end

end