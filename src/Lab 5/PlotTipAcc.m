function [  ] = PlotTipAcc( timeline,OutputTIPV )
OutputTIPA = diff(OutputTIPV);
figure(5)
plot(timeline(:,3:end),OutputTIPA);
xlabel('Time(s)')
ylabel('PositionAcc(mm/s^2)')
legend('X','Y','Z')
title('Robot Tip Acceleration Vs Time')
end

