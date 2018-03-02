%go to starting position
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [returnPacket,pr1,pr2,pr3,P1,P2,P3,ACTUALX,ACTUALY,ACTUALZ,TIP] = GotoInitialPosition(SERV_ID,pp)
packet = zeros(15, 1, 'single');
packet(1) = 900; %packets for joint angles
packet(4) = 0;
packet(7) = 0;
returnPacket = pp.command(SERV_ID, packet);
pause(2);
[pr1,pr2,pr3,P1,P2,P3,ACTUALX,ACTUALY,ACTUALZ,TIP] = Forkin(returnPacket,L1,L2,L3);
end

