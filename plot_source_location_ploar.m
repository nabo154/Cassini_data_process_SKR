lt = linspace(0.38,1.18,5);
rs = linspace(4.7,5.0,5);
lt = pi .* lt / 12;
polarplot(lt,rs,'o');
rlim([0,6]);
set(gca,'ThetaTick',[0 30 60 90 120 150 180 210 240 270 300 330],'ThetaTickLabel',{'00:00','02:00','04:00','06:00','08:00','10:00','12:00','14:00','16:00','18:00','20:00','22:00'});
lt = pi .* linspace(8.2,9.4,5) / 12;
rs = linspace(4.3,4.9,5);
legend('2008-291');
hold on;
polarplot(lt,rs,'x');
legend('2016-339');
legend('2016-339');
legend('2008-291','2016-339');
lt = pi .* linspace(9.0,10.2,5) / 12;
rs = linspace(3.9,4.46,5);
polarplot(lt,rs,'*');
lt = pi .* linspace(10.2,11.2,5) / 12;
rs = linspace(3.2,3.7,5);
polarplot(lt,rs,'+');
legend('2008-291','2016-339','2016-346','2017-066');
title('SKR source location LT - Rs');