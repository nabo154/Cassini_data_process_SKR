function [doy] = date2doy(year,month,day)
    days = [31,28,31,30,31,30,31,31,30,31,30,31];
    if mod(year,4) == 0
        days(2) = 29;
    end
    
    doy = day;
    for i = 1 : month - 1
        doy = doy + days(i);
    end
end