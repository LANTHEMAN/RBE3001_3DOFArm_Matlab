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
[BpositionX,BpositionY,BpositionZ,Bthereisball,GpositionX,GpositionY,GpositionZ,Gthereisball,YpositionX,YpositionY,YpositionZ,Ythereisball] = GeneratePosition(BlueCenter,YellowCenter,GreenCenter);

%set the robot starting position
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[returnPacket,pr1,pr2,pr3,P1,P2,P3,ACTUALX,ACTUALY,ACTUALZ,TIP] = GotoInitialPosition(SERV_ID,pp);
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

% Clear up memory upon termination
pp.shutdown()
clear java; 




