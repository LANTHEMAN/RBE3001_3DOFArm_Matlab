javaaddpath('../../lib/hid4java-0.5.1.jar');
import org.hid4java.*;
import org.hid4java.event.*;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.lang.*;

%arm lengths
L1 = 135;
L2 = 175;
L3 = 169.28;
% Create a PacketProcessor object to send data to the nucleo firmware
pp = PacketProcessor(7); 
SERV_ID = 37;            % we will be talking to server ID 37 on
                         % the Nucleo
DEBUG   = true;          % enables/disables debug prints


tic
%image processing and trajectory generation for avaiable colors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[BlueCenter,YellowCenter,GreenCenter] = imageprocess( );%extract centers of objects
if isempty(BlueCenter) == 0 %check id there is ball 
    [BpositionX,BpositionY,BpositionZ] = GeneratePositions( BlueCenter ); 
    % enerate trajectory for that color
    Bthereisball = 1; %there is a ball marker = 1
else
    Bthereisball = 0; %there is a ball marker = 0
end
if isempty(GreenCenter) == 0  
    [GpositionX,GpositionY,GpositionZ] = GeneratePositions( GreenCenter );
    Gthereisball = 1;
else
    Gthereisball = 0;
end
if isempty(YellowCenter) == 0  
    [YpositionX,YpositionY,YpositionZ] = GeneratePositions( YellowCenter );
    Ythereisball = 1;
else
    Ythereisball = 0;
end

%set the robot starting position
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
packet = zeros(15, 1, 'single');
packet(1) = 900; %packets for joint angles
packet(4) = 0;
packet(7) = 0;
returnPacket = pp.command(SERV_ID, packet);
pause(2);
[pr1,pr2,pr3,P1,P2,P3,ACTUALX,ACTUALY,ACTUALZ,TIP] = Forkin(returnPacket,L1,L2,L3);
[PLOTTT,TF] = LivePlot(); %intialize live plot


%grabbing ball for each color balls
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if Bthereisball == 0
   disp('no Blue ball'); %if there is no ball, display on screen
else
    disp('GRABBING BLUEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE!!');
    %display which color ball is grabbing
    returnPacket = GrabBall(SERV_ID,pp,BpositionX,BpositionY,BpositionZ,Bthereisball,returnPacket,PLOTTT,ACTUALX,ACTUALY,ACTUALZ);
    %call grab ball function to execute the generated trajectories
end

if Ythereisball == 0
   disp('no Yellow ball');
else
    disp('GRABBING YELLOWWWWWWWWWWWWWWWWWWWWWWWWWWWWW!!');
returnPacket = GrabBall(SERV_ID,pp,YpositionX,YpositionY,YpositionZ,Ythereisball,returnPacket,PLOTTT,ACTUALX,ACTUALY,ACTUALZ);
end

if Gthereisball == 0
   disp('no Green ball');
else
    disp('GRABBING GREENNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN!!');
returnPacket = GrabBall(SERV_ID,pp,GpositionX,GpositionY,GpositionZ,Gthereisball,returnPacket,PLOTTT,ACTUALX,ACTUALY,ACTUALZ);
end
 
%end program
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%disp(TIP);
time = toc;
pause(0.5);

% Clear up memory upon termination
pp.shutdown()
clear java; 




