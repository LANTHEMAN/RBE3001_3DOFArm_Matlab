function [  ] = PlotTip( timeline,OutputTIP )
figure(2)
plot(timeline,OutputTIP);
xlabel('Time(s)')
ylabel('Position(mm)')
legend('X','Y','Z')
title('Robot Tip Position Vs Time')


end

