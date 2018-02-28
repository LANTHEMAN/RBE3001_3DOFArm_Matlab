 function [ packet ] = GotoPosition( packet,X,Y,Z,pp,SERV_ID,returnPacket,i)
%     disp('prepacket');
%     disp(packet);
if i == 4
    packet(1)=returnPacket(1);
    packet(4) =550;
    packet(7) = 0;
   returnPacket = pp.command(SERV_ID, packet);
   pause(3);
   returnPacket = pp.command(SERV_ID, packet);
end
    j = 1;
    distanceX = (X - returnPacket(1));
    distanceY = (Y - returnPacket(4));
    distanceZ = (Z - returnPacket(7));
    while j <= 10
    packet(1) = X - distanceX*(10-j)/10; %packets for joint angles
    packet(4) = Y - distanceY*(10-j)/10;
    packet(7) = Z - distanceZ*(10-j)/10;
        returnPacket = pp.command(SERV_ID, packet);
        innererror = norm([returnPacket(1),returnPacket(4),returnPacket(7)] -[packet(1),packet(4),packet(7)]);
        %disp(error);
        if innererror < 50
            j = j+1;
        end
    pause(0.05);
%     disp('postpacket');
%     disp(packet);
    end

    
    

end

