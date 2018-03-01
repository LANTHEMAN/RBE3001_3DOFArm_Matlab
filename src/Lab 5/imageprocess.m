%process camera image, output object centers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ Bcentroids,Ycentroids,Gcentroids ] = imageprocess(  )
%% Instantiate hardware (turn on camera)
if ~exist('cam', 'var') % connect to webcam iff not connected
    cam = webcam();
    pause(1); % give the camera time to adjust to lighting
end
tic 
img = snapshot(cam); %snap a picture
toc

tic
[bimg1,BlueImage] = createBlueMask(img); %create blue binary mask
% bimg1 = medfilt2(BlueMask); %eliminate salt & pepper
bimg2 = imfill(bimg1,'holes'); %fill in any holes in balls
bimg3 = bwareaopen(bimg2, 80); %eliminate big noise under 20 pixels
BlueCenter = regionprops(bimg3,'centroid'); %find center
Bcentroids = cat(1, BlueCenter.Centroid); %plot center
% disp('lala');
% disp(BlueCenter);
% disp(Bcentroids);
% figure(1);
% imshow(bimg3);
% hold on
% plot(Bcentroids(:,1), Bcentroids(:,2), 'b*')
% hold off

[yimg1,YellowImage] = createYellowMask(img); %create yellow binary mask
%yimg1 = medfilt2(YellowMask); %eliminate salt & pepper
yimg2 = imfill(yimg1,'holes'); %fill in any holes in balls
yimg3 = bwareaopen(yimg2, 80); %eliminate big noise under 20 pixels
YellowCenter = regionprops(yimg3,'centroid'); %find center
Ycentroids = cat(1, YellowCenter.Centroid); %plot center
% figure(2);
% imshow(yimg3);
% figure(3);
% imshow(img);
% figure(4);
% imshow(YellowImage);
% hold on
% plot(Ycentroids(:,1), Ycentroids(:,2), 'b*')
% hold off
% disp(Ycentroids);

[gimg1,GreenImage] = createGreenMask(img); %create green binary mask
%gimg1 = medfilt2(GreenMask); %eliminate salt & pepper
gimg2 = imfill(gimg1,'holes'); %fill in any holes in balls
gimg3 = bwareaopen(gimg2, 120); %eliminate big noise under 20 pixels
GreenCenter = regionprops(gimg3,'centroid'); %find center
Gcentroids = cat(1, GreenCenter.Centroid); %plot center
toc
%  figure(3)
%  imshow(GreenImage);
%  hold on
%  plot(Gcentroids(:,1), Gcentroids(:,2), 'b*')
%  hold off

% figure(4);
% imshow(img);
end