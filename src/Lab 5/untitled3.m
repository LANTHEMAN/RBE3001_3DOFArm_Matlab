javaaddpath('../../lib/hid4java-0.5.1.jar');
import org.hid4java.*;
import org.hid4java.event.*;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.lang.*;

% Create a PacketProcessor object to send data to the nucleo firmware
pp = PacketProcessor(7); 
SERV_ID = 37;            % we will be talking to server ID 37 on
                         % the Nucleo
DEBUG   = true;          % enables/disables debug prints


tic

[BlueCenter,YellowCenter,GreenCenter] = imageprocess( );
if isempty(BlueCenter) == 0  
    [BpositionX,BpositionY,BpositionZ] = GeneratePositions( BlueCenter );
    Bthereisball = 1;
else
    Bthereisball = 1;
end
if isempty(GreenCenter) == 0  
    [GpositionX,GpositionY,GpositionZ] = GeneratePositions( GreenCenter );
    Gthereisball = 1;
else
    Gthereisball = 1;
end
if isempty(YellowCenter) == 0  
    [YpositionX,YpositionY,YpositionZ] = GeneratePositions( YellowCenter );
    Ythereisball = 1;
else
    Ythereisball = 1;
end



GrabBall(SERV_ID,pp,BpositionX,BpositionY,BpositionZ,Bthereisball);
GrabBall(SERV_ID,pp,GpositionX,GpositionY,GpositionZ,Gthereisball);
GrabBall(SERV_ID,pp,YpositionX,YpositionY,YpositionZ,Ythereisball);


disp(TIP);
time = toc;
pause(0.5);

% Clear up memory upon termination
pp.shutdown()
clear java; 




