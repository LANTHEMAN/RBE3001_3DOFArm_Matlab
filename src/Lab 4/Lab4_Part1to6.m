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

javaaddpath('../../lib/hid4java-0.5.1.jar');

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
OutputQDot1 = zeros(0, 3, 'single');%3*0 vector
OutputQDot2 = zeros(0, 3, 'single');%3*0 vector
OutputQDot3 = zeros(0, 3, 'single');%3*0 vector
[PLOTTT,Enddd] = LivePlot();

k = 1;
tic
time = 0;
pr1vector = [];%initialize q data for each joint
pr2vector = [];
pr3vector = [];

    PPP = [0;0;0];


    qX = [];%initializing positions
    qY = [];
    qZ = [];
    
%Question 5   
[qX,qY,qZ] = QuinticPoly(qX,qY,qZ);


while (time<10)
   if k > 31
        k = 1;
    end
    [A,B,C] = ikin3001(qX(k),qY(k),qZ(k),L1,L2,L3);
    packet = GotoPosition(packet,A,B,C);
    % Send packet to the server and get the response
    returnPacket = pp.command(SERV_ID, packet);
    
    time = toc;%record time
    [ pr1,pr2,pr3,P1,P2,P3,ACTUALX,ACTUALY,ACTUALZ, TIP ] = Forkin(returnPacket,L1,L2,L3 );

    [JP,J]  = jacob0( P1,P2,P3 );
    disp(JP);
    InvJP = inv(JP);
    QDot = InvJP * [TIP(1);TIP(2);TIP(3)];

    PPP = [0;0;0];
    if time > 1
    dpr1 = diff(pr1vector);%calc Q Dot
    dpr2 = diff(pr2vector);
    dpr3 = diff(pr3vector);
    PPP = JP*[dpr1(end);dpr2(end);dpr3(end)];
    end
    OutputTIP = vertcat(OutputTIP,TIP);%concatenate returnpacket onto vactor to form a matrix
    OutputAngle = vertcat(OutputAngle,[A,B,C]);%concatenate returnpacket onto vactor to form a matrix
    OutputQDot1 = vertcat(OutputQDot1,QDot(1));%concatenate returnpacket onto vactor to form a matrix
    OutputQDot2 = vertcat(OutputQDot2,QDot(1));%concatenate returnpacket onto vactor to form a matrix
    OutputQDot3 = vertcat(OutputQDot3,QDot(1));%concatenate returnpacket onto vactor to form a matrix
    timeline = [timeline,time];
    pr1vector = [pr1vector,pr1];
    pr2vector = [pr2vector,pr2];
    pr3vector = [pr3vector,pr3];
    
    refreshdata(PLOTTT)
    %refreshdata(Enddd)
    %VelocityVector( TIP,PPP );
    pause(0.1) %timeit(returnPacket)

    toler = 30;%check error 
    if abs(TIP(1)-qX(k)) <= toler &&  abs(TIP(2)-qY(k)) <= toler &&  abs(TIP(3)-qZ(k)) <= toler
      k = k+1;
    end
end

% Clear up memory upon termination
pp.shutdown()
clear java;




