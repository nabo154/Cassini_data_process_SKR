% Yang Yifei Sustech Shenzhen,2022-03-03
% convert readn2 data t97 decimal days convert to year doy hour and minute
function [year,month,day,hour,minute,second] = t97_to_date(time)
    days = 0;
    for index = 1997 : 2017
        pre_days = days;
        if mod(index,4) == 0
            days = days + 366;
        else
            days = days + 365;
        end
        
        if days >= time
            break;
        end
    end
    
    year = index;
    
    time = time - pre_days;
    
    doy = floor(time);
    
    [month,day] = doy2date(year,doy);
    
    time = time - doy;
    
    hour = floor(time * 24);
    
    minute = (time - hour / 24) * 24 * 60;
    
    minute = floor(minute);
    
    second = 0;
end