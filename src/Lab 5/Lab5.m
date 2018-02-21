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
% timeline = [];

TorqueArrayA = zeros(10, 1, 'single');
TorqueArrayB = zeros(10, 1, 'single');
TorqueArrayC = zeros(10, 1, 'single');
 [PLOTTT,END] = LivePlot();
% [Xd,Zd] = ginput;
K = 0;

 tic
 time = 0;
% 
%     Ai=0;
%     Bi=0;
%     Ci=0;

while (1)
    packet(4) = 1024;
    K = K+1;
    if K > 10
        K = 1;
    end
    returnPacket = pp.command(SERV_ID, packet);
    %record time
    time = toc;
    [ Torque,TorqueArrayA,TorqueArrayB,TorqueArrayC ] = TorqueRead(returnPacket,time,K,TorqueArrayA,TorqueArrayB,TorqueArrayC);
    
    [TForce,ACTUALX,ACTUALY,ACTUALZ,TIP] = TIPForce(returnPacket,Torque,L1,L2,L3);
    disp(returnPacket);
    refreshdata(PLOTTT);
    
    
    
    
    
    
    
    
    
    
    
%         [pr1,pr2,pr3,P1,P2,P3,ACTUALX,ACTUALY,ACTUALZ,TIP] = ForkinR(Ai,Bi,Ci,L1,L2,L3);
%         [JP,J] = jacob0(P1,P2,P3);
%         InvJP = pinv(JP);
%         deltaQ = 0.1*InvJP*([Xd;0;Zd]-[TIP(1);TIP(2);TIP(3)]);
% 
%         Ai = Ai + deltaQ(1);
%         Bi = Bi + deltaQ(2);
%         Ci = Ci + deltaQ(3);


%     refreshdata(PLOTTT)
    pause(0.02) 
%     error = norm([TIP(1);TIP(2);TIP(3)] - [Xd;0;Zd]);
%     disp(error);
%     if error < 0.1
%     break;
%     end
end
% packet = [(Ai/(2*pi)*4096),0,0,(Bi/(2*pi)*4096),0,0,(Ci/(2*pi)*4096),0,0,0,0,0,0,0,0];
% disp(packet);


% Clear up memory upon termination
pp.shutdown()
clear java; 




