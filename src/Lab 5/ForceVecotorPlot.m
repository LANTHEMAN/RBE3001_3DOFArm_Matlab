
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

TorqueArrayA = zeros(3, 1, 'single');
TorqueArrayB = zeros(4, 1, 'single');
TorqueArrayC = zeros(4, 1, 'single');
 [PLOTTT,TF] = LivePlot();
% [Xd,Zd] = ginput;
K = 0;

 tic
 time = 0;
% 
%     Ai=0;
%     Bi=0;
%     Ci=0;

while (1)
    %send to initial positions
    packet(1) = -600;
    packet(4) = 340;
    packet(7) = 600;
    %update data marker
    K = K+1;
    if K > 4
        K = 1;
    end
    returnPacket = pp.command(SERV_ID, packet);
    %record time
    time = toc;
    %calculate tip force 
    [ Torque,TorqueArrayA,TorqueArrayB,TorqueArrayC ] = TorqueRead(returnPacket,time,K,TorqueArrayA,TorqueArrayB,TorqueArrayC);
    [TForce,ACTUALX,ACTUALY,ACTUALZ,TIP] = TIPForce(returnPacket,Torque,L1,L2,L3);
    %magnify for easy plotting
    TForce = TForce * 10;
    %refresh plots
    refreshdata(PLOTTT);
    refreshdata(TF);
 
    pause(0.1) 
end



% Clear up memory upon termination
pp.shutdown()
clear java; 




