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


% Create a PacketProcessor object to send data to the nucleo firmware
pp = PacketProcessor(7); 
SERV_ID = 44;            % we will be talking to server ID 37 on
                         % the Nucleo

DEBUG   = true;          % enables/disables debug prints

% Instantiate a packet - the following instruction allocates 64
% bytes for this purpose. Recall that the HID interface supports
% packet sizes up to 64 bytes.
packet = zeros(15, 1, 'single');
Output = zeros(15, 0, 'single');%15*0 vector


tic
% Iterate through a sine wave for joint values
for k = 0:4
    packet(1) = k;
    
    % Send packet to the server and get the response
    returnPacket = pp.command(SERV_ID, packet);
    Output = horzcat(Output,returnPacket);%concatenate returnpacket onto vactor to form a matrix
    toc
    
    if DEBUG
        disp('Sent Packet:');
        disp(packet);
        disp('Received Packet:');
        disp(returnPacket);
    end
   
    pause(1) %timeit(returnPacket) 
end
disp(Output);
csvwrite('Lab1_Part8.csv',Output);%csv output
% Clear up memory upon termination
pp.shutdown()
clear java;

toc
