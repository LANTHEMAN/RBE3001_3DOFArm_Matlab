function [ V1 ] = PlotAngleAngleV( Outputangle )
V1 = diff(Outputangle(:,1));
V2 = diff(Outputangle(:,2));
V3 = diff(Outputangle(:,3));
plot(Outputangle(:,4),Outputangle(:,1),Outputangle(:,4),Outputangle(:,2),Outputangle(:,4),Outputangle(:,3));
legend('Joint 1 angle','Joint 2 angle','Joint 3 angle')
xlabel('Time (s)')
ylabel('Joint Angles (degree)')

plot(Outputangle(2:end,4),V1,Outputangle(2:end,4),V2,Outputangle(2:end,4),V3);
legend('Joint 1 Velocity','Joint 2 Velocity','Joint 3 Velocity')
xlabel('Time (s)')
ylabel('Joint Velocity (degree/s)')

end

