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
Output = zeros(15, 0, 'single');%15*0 vector
APts = [0, 0, 0];
BPts = [0, 1024, 0];
CPts = [0, 1024, 1024];

tic
% Iterate through a sine wave for joint values
for k = 1:3
    packet(1) = APts(k);
    packet(4) = BPts(k);
    packet(7) = CPts(k);
    
    % Send packet to the server and get the response
    returnPacket = pp.command(SERV_ID, packet);
    %Output = horzcat(Output,returnPacket);%concatenate returnpacket onto vactor to form a matrix
    toc
    
    if DEBUG
        disp('Sent Packet:');
        disp(packet);
        disp('Received Packet:');
        disp(returnPacket);
    end
   
    pr1 = rev1(returnPacket(1));
    pr2 = rev2(returnPacket(4));
    pr3 = rev3(returnPacket(7));

    P1 = Transform(pr1,pi/2,0,L1);
    P2 = P1*Transform(pr2,0,L2,0);
    P3 = P2*Transform(pr3,0,L3,0);

    plot3([0,P1(1,4),P2(1,4),P3(1,4)],[0,P1(2,4),P2(2,4),P3(2,4)],[0,P1(3,4),P2(3,4),P3(3,4)],'-o');

    grid('on')
    xlim([-300 400])
    ylim([-300 400])
    zlim([-300 400])
    xlabel('x')
    ylabel('y')
    zlabel('z')

    pause(1) %timeit(returnPacket) 
end

pr1 = rev1(returnPacket(1));
    pr2 = rev2(returnPacket(4));
    pr3 = rev3(returnPacket(7));

    P1 = Transform(pr1,pi/2,0,L1);
    P2 = P1*Transform(pr2,0,L2,0);
    P3 = P2*Transform(pr3,0,L3,0);

    plot3([0,P1(1,4),P2(1,4),P3(1,4)],[0,P1(2,4),P2(2,4),P3(2,4)],[0,P1(3,4),P2(3,4),P3(3,4)],'-o');

    grid('on')
    xlim([-300 400])
    ylim([-300 400])
    zlim([-300 400])
    xlabel('x')
    ylabel('y')
    zlabel('z')

% Clear up memory upon termination
pp.shutdown()
clear java;

toc




function [T] = Transform (theta, alpha, a, d) 
T = [cos(theta) -sin(theta)*cos(alpha) sin(theta)*sin(alpha) a*cos(theta); 
      sin(theta) -cos(theta)*cos(alpha) -cos(theta)*sin(alpha) a*sin(theta);
      0 sin(alpha) cos(alpha) d;
      0 0 0 1];
end

function [r] = rev1 (t)
r= t/4096*2*pi;
end

function [r] = rev2 (t)
r= (t/(4096))*pi*2;
end

function [r] = rev3 (t)
r= -(t/(4096))*pi*2 +pi/2;
end





  

      
