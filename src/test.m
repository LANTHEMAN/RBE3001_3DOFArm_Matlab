%%
% RBE3001 - Laboratory 1 
% 
% Instructions
% ------------
% Welcome again! This MATLAB script is your starting point for Lab
% 1 of RBE3001. The sample code below demonstrates how to establish
% communication between this script and the Nucleo firmware, send
% setpoint commands and receive sensor data.
% 
% IMPORTANT - understanding the code below requires being familiar
% with the Nucleo firmware. Read that code first.

javaaddpath('../lib/hid4java-0.5.1.jar');

import org.hid4java.*;
import org.hid4java.event.*;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.lang.*;

L1 = 135;
L2 = 175;
L3 = 169.28;

% Create a PacketProcessor object to send data to the nucleo firmware
pp = PacketProcessor(7); 
SERV_ID = 37;            % we will be talking to server ID 37 on
                         % the Nucleo

DEBUG   = true;          % enables/disables debug prints

% Instantiate a packet - the following instruction allocates 64
% bytes for this purpose. Recall that the HID interface supports
% packet sizes up to 64 bytes.
packet = zeros(15, 1, 'single');

timeline = [];


%EndPlottt = EndPlot();
OutputTIP = zeros(0, 3, 'single');%3*0 vector
OutputAngle = zeros(0, 3, 'single');%3*0 vector
[PLOTTT,Enddd] = LivePlot();

   
    TrajX = LinearTraj(1,101);
    %qX = [175,      146.1462,   154.7008]; question#3
    %qY = [0,        -164.3877,  119.3989];
    %qZ = [-34.28,   -20.7257,   300];  

    %qX = [175,      146.1462,   154.7008]; question #4
    %qY = [210,        -164.3877,  119.3989];
    %qZ = [110,   -20.7257,   300];
    
% Question 5
%     TrajX1 = LinearTraj(175,146.1462);
%     TrajX2 = LinearTraj(146.1462,154.7008);
%     TrajX3 = LinearTraj(154.7008,175);
%     TrajY1 = LinearTraj(210,-164.3);
%     TrajY2 = LinearTraj(-164.3,119.39);
%     TrajY3 = LinearTraj(119.39,210);
%     TrajZ1 = LinearTraj(110,-20.72);
%     TrajZ2 = LinearTraj(-20.72,300);
%     TrajZ3 = LinearTraj(300,110);
%     qX = [175,      TrajX1,   TrajX2,  TrajX3]; 
%     qY = [210,      TrajY1,   TrajY2,  TrajY3];
%     qZ = [110,      TrajZ1,   TrajZ2,  TrajZ3]; 

% %Question 6/7
%     qX = [];
%     qY = [];
%     qZ = [];
%     
%     for i = 3:3:9
%     QuinticMatrix = [1 (i-3) (i-3)^2 (i-3)^3 (i-3)^4 (i-3)^5;
%                    0 1 2*(i-3) 3*(i-3)^2 4*(i-3)^3 5*(i-3)^4;
%                    0 0 2 6*(i-3) 12*(i-3)^2 20*(i-3)^3;
%                    1 i i^2 i^3 i^4 i^5;
%                    0 1 2*i 3*i^2 4*i^3 5*i^4;
%                    0 0 2 6*i 12*i^2 20*i^3];
% 
%     QuinticInv = inv(QuinticMatrix);
% 
%     Xtrajectory = [175,146.1462,154.7008;     0,0,0;    0,0,0;    146.1462,154.7008,175;       0,0,0;    0,0,0;];
%     Ytrajectory = [210,-146.3,119.39;   0,0,0;    0,0,0;    -146.3,119.39,210;   0,0,0;    0,0,0;];
%     Ztrajectory = [110,-20.72,300;   0,0,0;    0,0,0;    -20.72,300,110;  0,0,0;    0,0,0;];
% 
%     AvalsX = (QuinticInv)*Xtrajectory(:,(i/3));
%     AvalsY = (QuinticInv)*Ytrajectory(:,(i/3));
%     AvalsZ = (QuinticInv)*Ztrajectory(:,(i/3));
%     
%     for j= (i-3):0.3:i
%        qX = [qX,AvalsX(1)+AvalsX(2)*j+AvalsX(3)*(j^2)+AvalsX(4)*(j^3)+AvalsX(5)*(j^4)+AvalsX(6)*(j^5)];
%        qY = [qY,AvalsY(1)+AvalsY(2)*j+AvalsY(3)*(j^2)+AvalsY(4)*(j^3)+AvalsY(5)*(j^4)+AvalsY(6)*(j^5)];
%        qZ = [qZ,AvalsZ(1)+AvalsZ(2)*j+AvalsZ(3)*(j^2)+AvalsZ(4)*(j^3)+AvalsZ(5)*(j^4)+AvalsZ(6)*(j^5)];
%     end
%     end
%        disp(qX)
%        disp(qY)
%        disp(qZ)

%Question 8

    qX = [];
    qY = [];
    qZ = [];
    
    for i = 4:4:16
    QuinticMatrix = [1 (i-4) (i-4)^2 (i-4)^3 (i-4)^4 (i-4)^5;
                   0 1 2*(i-4) 3*(i-4)^2 4*(i-4)^3 5*(i-4)^4;
                   0 0 2 6*(i-4) 12*(i-4)^2 20*(i-4)^3;
                   1 i i^2 i^3 i^4 i^5;
                   0 1 2*i 3*i^2 4*i^3 5*i^4;
                   0 0 2 6*i 12*i^2 20*i^3];

    QuinticInv = inv(QuinticMatrix);

    Xtrajectory = [250,250,146,146;     0,0,0,0;    0,0,0,0;    250,146,146,250;       0,0,0,0;    0,0,0,0;];
    Ytrajectory = [210,-164,-164,210;   0,0,0,0;    0,0,0,0;    -164,-164,210,210;   0,0,0,0;    0,0,0,0;];
    Ztrajectory = [110,-20,-20,110;   0,0,0,0;    0,0,0,0;    -20,-20,110,110;  0,0,0,0;    0,0,0,1;];

    AvalsX = (QuinticInv)*Xtrajectory(:,(i/4));
    AvalsY = (QuinticInv)*Ytrajectory(:,(i/4));
    AvalsZ = (QuinticInv)*Ztrajectory(:,(i/4));
    
    for j= (i-4):0.4:i
       qX = [qX,AvalsX(1)+AvalsX(2)*j+AvalsX(3)*(j^2)+AvalsX(4)*(j^3)+AvalsX(5)*(j^4)+AvalsX(6)*(j^5)];
       qY = [qY,AvalsY(1)+AvalsY(2)*j+AvalsY(3)*(j^2)+AvalsY(4)*(j^3)+AvalsY(5)*(j^4)+AvalsY(6)*(j^5)];
       qZ = [qZ,AvalsZ(1)+AvalsZ(2)*j+AvalsZ(3)*(j^2)+AvalsZ(4)*(j^3)+AvalsZ(5)*(j^4)+AvalsZ(6)*(j^5)];
    end
    end
    
       disp(qX)
       disp(qY)
       disp(qZ)


    
% Iterate through a sine wave for joint values
k = 1;
tic
time = 0;
while time<40
    if k > 31
        k = 1;
    end
    [A,B,C] = ikin3001(qX(k),qY(k),qZ(k),L1,L2,L3);
    packet = GotoPosition(packet,A,B,C);
    % Send packet to the server and get the response
    returnPacket = pp.command(SERV_ID, packet);

    time = toc;
    
    [ACTUALX,ACTUALY,ACTUALZ,TIP] = Forkin(returnPacket,L1,L2,L3);
    OutputTIP = vertcat(OutputTIP,TIP);%concatenate returnpacket onto vactor to form a matrix
    OutputAngle = vertcat(OutputAngle,[A,B,C]);%concatenate returnpacket onto vactor to form a matrix
    timeline = [timeline,time];
    
    refreshdata(PLOTTT)
    refreshdata(Enddd)
    pause(0.03) %timeit(returnPacket)

    toler = 30;
    if abs(TIP(1)-qX(k)) <= toler &&  abs(TIP(2)-qY(k)) <= toler &&  abs(TIP(3)-qZ(k)) <= toler
      k = k+1;
    end

end

figure(2)
plot(timeline,OutputTIP);
xlabel('Time(s)')
ylabel('Position(mm)')
legend('X','Y','Z')
title('Robot Tip Position Vs Time')

figure(3)
plot(timeline,OutputAngle);
xlabel('Time(s)')
ylabel('Angles(tic)')
legend('Axis1','Axis2','Axis3')
title('Robot Joint Angle Vs Time')
       disp(qX)
       disp(qY)
       disp(qZ)
OutputTIPV = diff(OutputTIP);
figure(4)
plot(timeline(:,2:end),OutputTIPV);
xlabel('Time(s)')
ylabel('PositionVelocity(mm/s)')
legend('X','Y','Z')
title('Robot Tip Velocity Vs Time')

OutputTIPA = diff(OutputTIPV);
figure(5)
plot(timeline(:,3:end),OutputTIPA);
xlabel('Time(s)')
ylabel('PositionAcc(mm/s^2)')
legend('X','Y','Z')
title('Robot Tip Acceleration Vs Time')

% Clear up memory upon termination
pp.shutdown()
clear java;




