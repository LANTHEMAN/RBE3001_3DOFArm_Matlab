function [ packet,returnPacket ] = gripBall( SERV_ID,pp,packet )
packet(10) = 1;
returnPacket = pp.command(SERV_ID, packet);
pause(1);
end

