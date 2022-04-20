function [data,status] = readn2(year,doy,hour)

% The function [data,status] = readn2(year,doy,hour) 
% reads level 2 binary data (n2, calibrated values) 
% by giving the year (4 digits) 
% the day of year doy (1-366), and the hour (0-23). 
% Level n2 data consists of 11 different tags, 
% which are saved as vectors in the structure named 'data'. 
% If the file exists status is set to 1, otherwise it is 0.

DataPath1 = 'D:\data\kronos_raw_data\rpws_n2';
yearstr = num2str(year);
doystr  = num2str(doy,'%03d');
hourstr = num2str(hour,'%02d');

if doy < 91
    dirstr = '001_090';
elseif doy <= 180
    dirstr = '091_180';
elseif doy <= 270
    dirstr = '181_270';
else
    dirstr = '271_366';
end

DataPath2 = strcat(DataPath1,filesep,yearstr,'_',dirstr,filesep,'n2');
filename = strcat('P',yearstr,doystr,'.',hourstr);
datafile = fullfile(DataPath2,filename);

check = exist(datafile,'file');

if check == 0
    disp(['File',datafile,'does not exist']);
    data = [];
    status = 0;
    return
end
disp(['Processing ',filename]);

fid = fopen(datafile,'r','l');

ydh = fread(fid,inf,'int32',41);

fseek(fid,4,'bof');
num = fread(fid,inf,'int32',41);

fseek(fid,8,'bof');
t97 = fread(fid,inf,'double',37);

fseek(fid,16,'bof');
f = fread(fid,inf,'float32',41);

fseek(fid,20,'bof');
dt = fread(fid,inf,'float32',41);

fseek(fid,24,'bof');
df = fread(fid,inf,'float32',41);

fseek(fid,28,'bof');
autoX = fread(fid,inf,'float32',41);

fseek(fid,32,'bof');
autoZ = fread(fid,inf,'float32',41);

fseek(fid,36,'bof');
crossR = fread(fid,inf,'float32',41);

fseek(fid,40,'bof');
crossI = fread(fid,inf,'float32',41);

fseek(fid,44,'bof');
ant = fread(fid,inf,'uchar',44);

fclose(fid);

data = struct('ydh',ydh,'num',num,'t97',t97,'f',f,'dt',dt,'df',df,...
    'autoX',autoX,'autoZ',autoZ,'crossR',crossR,'crossI',crossI,'ant',ant);
status = 1;
end
