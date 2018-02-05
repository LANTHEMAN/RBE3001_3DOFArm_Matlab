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
    
    TrajX1 = LinearTraj(175,146.1462);
    TrajX2 = LinearTraj(146.1462,154.7008);
    TrajX3 = LinearTraj(154.7008,175);
    TrajY1 = LinearTraj(210,-164.3);
    TrajY2 = LinearTraj(-164.3,119.39);
    TrajY3 = LinearTraj(119.39,210);
    TrajZ1 = LinearTraj(110,-20.72);
    TrajZ2 = LinearTraj(-20.72,300);
    TrajZ3 = LinearTraj(300,110);
    qX = [175,      TrajX1,   TrajX2,  TrajX3]; 
    qY = [210,      TrajY1,   TrajY2,  TrajY3];
    qZ = [110,      TrajZ1,   TrajZ2,  TrajZ3];
    disp(qX);
    disp(qY);
    disp(qZ);
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

OutputTIPV = diff(OutputTIP);
figure(4)
disp(timeline(:,2:end));
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




