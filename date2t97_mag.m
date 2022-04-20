% Yang Yifei Sustech Shenzhen,2022-03-03
function [decimal_days] = date2t97_mag(year,month,day,hour,minute,second)
    decimal_days = datenum(year,month,day,hour,minute,second)...
        - datenum(1997,1,1,0,0,0);
end