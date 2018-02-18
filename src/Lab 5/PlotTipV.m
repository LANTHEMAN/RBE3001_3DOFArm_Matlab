function [  ] = PlotTipV( timeline,OutputTIP )
OutputTIPV = diff(OutputTIP);
figure(4)
plot(timeline(:,2:end),OutputTIPV);
xlabel('Time(s)')
ylabel('PositionVelocity(mm/s)')
legend('X','Y','Z')
title('Robot Tip Velocity Vs Time')
end

