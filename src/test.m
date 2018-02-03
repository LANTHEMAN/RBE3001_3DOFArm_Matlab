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
PLOTTT = LivePlot();
%EndPlottt = EndPlot();
OutputTIP = zeros(0, 3, 'single');%3*0 vector

    qX = [175, 146.1462,154.7008,175];
    qY = [0,  -164.3877,  119.3989,0];
    qZ = [-34.28,  -20.7257,  300,-34.28];   
    

% Iterate through a sine wave for joint values
k = 1;
tic
while  k<5

    [A,B,C] = ikin3001(qX(k),qY(k),qZ(k),L1,L2,L3);
    packet = GotoPosition(packet,A,B,C);
    % Send packet to the server and get the response
    returnPacket = pp.command(SERV_ID, packet);

    time = toc;
    
    [ACTUALX,ACTUALY,ACTUALZ,TIP] = Forkin(returnPacket,L1,L2,L3);
    OutputTIP = vertcat(OutputTIP,TIP);%concatenate returnpacket onto vactor to form a matrix
    timeline = [timeline,time];
    refreshdata(PLOTTT)
    pause(0.1) %timeit(returnPacket)

    toler = 30;
    if abs(TIP(1)-qX(k)) <= toler &&  abs(TIP(2)-qY(k)) <= toler &&  abs(TIP(3)-qZ(k)) <= toler
      k = k+1;
    end
    disp(time)
    disp(TIP)
    disp('true')
  
end
disp(timeline)
disp(OutputTIP)
%plot(timeline,OutputTIP);
% Clear up memory upon termination
pp.shutdown()
clear java;




