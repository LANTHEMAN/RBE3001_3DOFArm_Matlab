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

L1 = 135;%link 1 
L2 = 175;%Link 2
L3 = 169.28;%link 3

% Create a PacketProcessor object to send data to the nucleo firmware
pp = PacketProcessor(7); 
SERV_ID = 37;            % we will be talking to server ID 37 on
                         % the Nucleo

DEBUG   = true;          % enables/disables debug prints

% Instantiate a packet - the following instruction allocates 64
% bytes for this purpose. Recall that the HID interface supports
% packet sizes up to 64 bytes.
packet = zeros(15, 1, 'single');%15*0 vector
Output = zeros(15, 0, 'single');%15*0 vector
APts = [0, 0, 0];%theta 1 
BPts = [0, 1024, 0];%theta 2
CPts = [0, 1024, 1024];%theta 3

    pr1 = 0;%initialize transform
    pr2 = 0;
    pr3 = 0;

    P1 = Transform(pr1,pi/2,0,L1);%initialize transform
    P2 = P1*Transform(pr2,0,L2,0);
    P3 = P2*Transform(pr3,0,L3,0);
    ACTUALX = [0,P1(1,4),P2(1,4),P3(1,4)];%coordinates for each joint
    ACTUALY = [0,P1(2,4),P2(2,4),P3(2,4)];
    ACTUALZ = [0,P1(3,4),P2(3,4),P3(3,4)];
    PLOTTT = plot3(ACTUALX,ACTUALY,ACTUALZ,'-o');%plot stick figure
    grid('on')
    xlim([-300 400])%set figure parameters
    ylim([-300 400])
    zlim([-300 600])
    xlabel('x')
    ylabel('y')
    zlabel('z')
    set(PLOTTT,'XDataSource','ACTUALX');
    set(PLOTTT,'YDataSource','ACTUALY');
    set(PLOTTT,'ZDataSource','ACTUALZ');
    Output = zeros(0, 3, 'single');%3*0 vector
    Outputangle = zeros(0, 4, 'single');%4*0 vector
    qX = []%create empty configuration vector
    qY = []
    qZ = []
    
    for i = 2:2:4%draw 2 trajectories 
    CubicMatrix = [1 (i-2) (i-2)^2 (i-2)^3;
                   0 1 2*(i-2) 3*(i-2)^2;
                   1 i i^2 i^3;
                   0 1 2*i 3*i^2];%cubic matrix 

    CubicInv = inv(CubicMatrix);%cubic inverse


    Xtrajectory = [0,0;        0,0;    0,0;     0,0];%set points and velocity for trajectory [Q0,V0,Qf,Vf]
    Ytrajectory = [0,-94;    0,0;    -94,490;   0,0];
    Ztrajectory = [0,346;   0,0;    346,-131;  0,0];

    AvalsX = (CubicInv)*Xtrajectory(:,(i/2));%find set of coefficient a
    AvalsY = (CubicInv)*Ytrajectory(:,(i/2));
    AvalsZ = (CubicInv)*Ztrajectory(:,(i/2));
    
    for j= (i-2):0.2:i%looping through each set interval, find each sub-configuration and put in vectors.
       qX = [qX,AvalsX(1)+AvalsX(2)*j+AvalsX(3)*(j^2)+AvalsX(4)*(j^3)];
       qY = [qY,AvalsY(1)+AvalsY(2)*j+AvalsY(3)*(j^2)+AvalsY(4)*(j^3)];
       qZ = [qZ,AvalsZ(1)+AvalsZ(2)*j+AvalsZ(3)*(j^2)+AvalsZ(4)*(j^3)];
    end
    
 

    end

    disp('q values');
    disp(qX);
    disp(qY);
    disp(qZ);
    
    
    
    
tic
% Iterate through a sine wave for joint values
for k = 1:22
  
    packet(1) = qX(k);%write set points to robot

    packet(4) = qY(k);

    packet(7) = qZ(k);

    
    
    % Send packet to the server and get the response
    returnPacket = pp.command(SERV_ID, packet);
    %Output = horzcat(Output,returnPacket);%concatenate returnpacket onto vactor to form a matrix
    time = toc
    
    if DEBUG
        disp('Sent Packet:');
        disp(packet);
        disp('Received Packet:');
        disp(returnPacket);
    end
   
    pr1 = rev1(returnPacket(1));%return encoder reading in radians
    pr2 = rev1(returnPacket(4));
    pr3 = rev2(returnPacket(7));
    angle1 = rev3(returnPacket(1));%return encoder reading in degrees
    angle2 = rev3(returnPacket(4));
    angle3 = rev3(returnPacket(7));
    anglevector = [angle1, angle2, angle3,time];
    Outputangle = vertcat(Outputangle,anglevector);%concatenate returnpacket onto vector to form a matrix
   
    disp(angle1)
    disp(angle2)
    disp(angle3)
    
    P1 = Transform(pr1,pi/2,0,L1);%calculate transformation matrix 
    P2 = P1*Transform(pr2,0,L2,0);
    P3 = P2*Transform(pr3,0,L3,0);
 
    ACTUALX = [0,P1(1,4),P2(1,4),P3(1,4)];%coordinate of x,y,z
    ACTUALY = [0,P1(2,4),P2(2,4),P3(2,4)];
    ACTUALZ = [0,P1(3,4),P2(3,4),P3(3,4)];
    TIP = [P3(1,4),P3(2,4),P3(3,4)];%end factor coordinate
    Output = vertcat(Output,TIP);%concatenate returnpacket onto vactor to form a matrix
    refreshdata(PLOTTT)%refresh plot data



    pause(0.1) %timeit(returnPacket) 
end
V1 = diff(Outputangle(:,1))%angle velocity
V2 = diff(Outputangle(:,2))
V3 = diff(Outputangle(:,3))
%angle vs time plot
plot(Outputangle(:,4),Outputangle(:,1),Outputangle(:,4),Outputangle(:,2),Outputangle(:,4),Outputangle(:,3));
legend('Joint 1 angle','Joint 2 angle','Joint 3 angle')
xlabel('Time (s)')
ylabel('Joint Angles (degree)')

%angle velocity vs time plot
plot(Outputangle(2:end,4),V1,Outputangle(2:end,4),V2,Outputangle(2:end,4),V3);
legend('Joint 1 Velocity','Joint 2 Velocity','Joint 3 Velocity')
xlabel('Time (s)')
ylabel('Joint Velocity (degree/s)')
csvwrite('Lab2_Part5.csv',Output);%write to csv
% Clear up memory upon termination
pp.shutdown()



clear java;

toc


%transformation matrix
function [T] = Transform (theta, alpha, a, d) 
T = [cos(theta) -sin(theta)*cos(alpha) sin(theta)*sin(alpha) a*cos(theta); 
      sin(theta) -cos(theta)*cos(alpha) -cos(theta)*sin(alpha) a*sin(theta);
      0 sin(alpha) cos(alpha) d;
      0 0 0 1];
end

%theta 1&2 tics to radians 
function [r] = rev1 (t)
r= t/4096*2*pi;
end

%theta 3 tics to radians
function [r] = rev2 (t)
r= -(t/(4096))*pi*2 +pi/2;
end

%tics to degrees
function [r] = rev3 (t)
r= (t/(4096))*360;
end

%{
q values
     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0

  Columns 1 through 13

         0   -2.6320   -9.7760  -20.3040  -33.0880  -47.0000  -60.9120  -73.6960  -84.2240  -91.3680  -94.0000  -94.0000  -77.6480

  Columns 14 through 22

  -33.2640   32.1440  111.5680  198.0000  284.4320  363.8560  429.2640  473.6480  490.0000

  Columns 1 through 13

         0    9.6880   35.9840   74.7360  121.7920  173.0000  224.2080  271.2640  310.0160  336.3120  346.0000  346.0000  332.6440

  Columns 14 through 22

  296.3920  242.9680  178.0960  107.5000   36.9040  -27.9680  -81.3920 -117.6440 -131.0000

%}

  

      
