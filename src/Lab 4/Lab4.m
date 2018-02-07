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
[PLOTTT,Enddd] = LivePlot();

k = 1;
tic
time = 0;
while time<40

    % Send packet to the server and get the response
    returnPacket = pp.command(SERV_ID, packet);

    time = toc;%record time
    [ pr1,pr2,pr3,P1,P2,P3,ACTUALX,ACTUALY,ACTUALZ, TIP ] = Forkin(returnPacket,L1,L2,L3 );
    [JP,J]  = jacob0( P1,P2,P3 );
    disp(JP);
    D = det(JP);
    disp(D);
    dpr1 = diff(pr1);
    dpr2 = diff(pr2);
    dpr3 = diff(pr3);
    disp([dpr1;dpr2;dpr3]);
    PPP = JP*[dpr1;dpr2;dpr3];
    disp(PPP);
    timeline = [timeline,time];
    
    refreshdata(PLOTTT)
    refreshdata(Enddd)
    pause(0.1) %timeit(returnPacket)


end


% Clear up memory upon termination
pp.shutdown()
clear java;



