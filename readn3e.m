function [data,status] = readn3e(year,doy,hour)
% n3e data are DF/Polarization results from Direct Inversion (DI) 
% method applied to 2 antenna measurements, with U = Q = 0
DataPath1 = 'D:\data\kronos_raw_data\rpws_n3e\lesia.obspm.fr\kronos';

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

DataPath2 = strcat(DataPath1, filesep ,yearstr,'_',dirstr,filesep,'n3e');
filename = strcat('N3e_dsq',yearstr,doystr,'.',hourstr);
datafile = fullfile(DataPath2,filename);

check = exist(datafile,'file');
if check == 0
    disp(['File ',datafile,' does not exist.']);
    data = [];
    status = 0;
    return
end
disp([filename,' exist']);

fid = fopen(datafile,'r','l');

ydh = fread(fid,inf,'int32',36);

fseek(fid,4,'bof');
num = fread(fid,inf,'int32',36);

fseek(fid,8,'bof');
S = fread(fid,inf,'float32',36);

fseek(fid,12,'bof');
q=fread(fid,inf,'float32',36);

fseek(fid,16,'bof');
u = fread(fid,inf,'float32',36);

fseek(fid,20,'bof');
v = fread(fid,inf,'float32',36);

fseek(fid,24,'bof');
th = fread(fid,inf,'float32',36);

fseek(fid,28,'bof');
ph = fread(fid,inf,'float32',36);

fseek(fid,32,'bof');
SNx = fread(fid,inf,'float32',36);

fseek(fid,36,'bof');
SNz = fread(fid,inf,'float32',36);

fclose(fid);

data = struct('ydh',ydh,'num',num,'S',S,'q',q,'u',u,'v',v,'th',th,'ph',...
    ph,'SNx',SNx,'SNz',SNz);

status = 1;
end
