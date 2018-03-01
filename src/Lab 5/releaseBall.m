%open gripper
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ packet,returnPacket ] = releaseBall( SERV_ID,pp,packet )
packet(10) = 0;
returnPacket = pp.command(SERV_ID, packet);
pause(1);
end