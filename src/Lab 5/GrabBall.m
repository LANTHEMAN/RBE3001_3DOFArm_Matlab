function [ L1 ] = GrabBall(SERV_ID,pp,positionX,positionY,positionZ,thereisball)
L1 = 135;
L2 = 175;
L3 = 169.28;
[PLOTTT,END] = LivePlot();

% Instantiate a packet 
packet = zeros(15, 1, 'single');
if thereisball == 0
   disp('no ball');
else
    i = 1;
    while i <= 6
        packet = GotoPosition(packet,positionX(i),positionY(i),positionZ(i));
        returnPacket = pp.command(SERV_ID, packet);
        
        [pr1,pr2,pr3,P1,P2,P3,ACTUALX,ACTUALY,ACTUALZ,TIP] = Forkin(returnPacket,L1,L2,L3);
        %refreshdata(PLOTTT);
        error = norm([returnPacket(1),returnPacket(4),returnPacket(7)] -[positionX(i),positionY(i),positionZ(i)]);
        disp(error);
        if error < 40
            i = i+1;
            positionReady = 1;
            pause(0.5);
        end
        if i == 4 && positionReady == 1
            %grab ball
        end
        if i == 5 && positionReady == 1
            %weightfunction; release ball 
        end
        positionReady = 0;
    end
end

