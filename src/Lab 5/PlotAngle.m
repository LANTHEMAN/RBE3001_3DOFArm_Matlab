function [  ] = PlotAngle( timeline,OutputAngle )
figure(3)
plot(timeline,OutputAngle);
xlabel('Time(s)')
ylabel('Angles(tic)')
legend('Axis1','Axis2','Axis3')
title('Robot Joint Angle Vs Time')
end

