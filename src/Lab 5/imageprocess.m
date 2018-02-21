%% Instantiate hardware (turn on camera)
if ~exist('cam', 'var') % connect to webcam iff not connected
    cam = webcam();
    pause(1); % give the camera time to adjust to lighting
end



%% Request two points from user to define bounding box
img = snapshot(cam);


[mask,BlueImage] = createYellowMask(img);
Image = medfilt2(mask);
i = imfill(Image,'holes');
i2 = bwareaopen(i, 20);

s = regionprops(i2,'centroid');
centroids = cat(1, s.Centroid);
imshow(i2);
hold on
plot(centroids(:,1), centroids(:,2), 'b*')
hold off