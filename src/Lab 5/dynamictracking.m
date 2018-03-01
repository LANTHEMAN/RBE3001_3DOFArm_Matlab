%track the ball dynamically
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

% Instantiate a packet - the following instruction allocates 64
% bytes for this purpose. Recall that the HID interface supports
% packet sizes up to 64 bytes.
packet = zeros(15, 1, 'single');
% timeline = [];

if ~exist('cam', 'var') % connect to webcam iff not connected
    cam = webcam();
    pause(1); % give the camera time to adjust to lighting
end
%arm length 
L1 = 135;
L2 = 175;
L3 = 169.28;

%main execution loop 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while(1)

tic 
img = snapshot(cam);%snap image
toc

%process image and calcualte center point
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[bimg1,BlueImage] = createBlueMask(img); %create blue binary mask
% bimg1 = medfilt2(BlueMask); %eliminate salt & pepper
bimg2 = imfill(bimg1,'holes'); %fill in any holes in balls
bimg3 = bwareaopen(bimg2, 80); %eliminate big noise under 20 pixels
BlueCenter = regionprops(bimg3,'centroid'); %find center
Bcentroids = cat(1, BlueCenter.Centroid); %plot center

[A] = mn2xy(Bcentroids(1),Bcentroids(2)); %convert camera coordinate to robot coordinate

%move robot to that point
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[A1,B1,C1]  = ikin3001 (A(1),A(2),42,L1,L2,L3); %solve inverse kinematics
packet(1) = A1;
packet(4) = B1;
packet(7) = C1;
returnPacket = pp.command(SERV_ID, packet);
pause(0.6);


end
