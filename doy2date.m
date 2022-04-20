function [month,day] = doy2date(year,doy)
    days = [31,28,31,30,31,30,31,31,30,31,30,31];
    if mod(year,4) == 0
        days(2) = 29;
    end
    
    count_days = 0;
    for month = 1 : 12
        pre_days = count_days;
        count_days = count_days + days(month);
        if(count_days >=  doy)
            break;   
        end
    end
    day = doy - pre_days;
end