
function [decimal_days] = date2t97(year,month,day,hour,minute,second)
    decimal_days = datenum(year,month,day,hour,minute,second)...
        - datenum(1996,12,31,0,0,0);
end
