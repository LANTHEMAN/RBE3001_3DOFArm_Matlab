function [ pr1,pr2 , pr3,P1,P2,P3,ACTUALX,ACTUALY,ACTUALZ,TIP ] = Forkin(returnPacket,L1,L2,L3 )
    pr1 = TictoRadian(returnPacket(1));
    pr2 = TictoRadian(returnPacket(4));
    pr3 = TictoRadian(returnPacket(7))-pi/2;
    P1 = Transform(pr1,pi/2,0,L1);
    P2 = P1*Transform(pr2,0,L2,0);
    P3 = P2*Transform(pr3,0,L3,0);
 
    ACTUALX = [0,P1(1,4),P2(1,4),P3(1,4)];
    ACTUALY = [0,P1(2,4),P2(2,4),P3(2,4)];
    ACTUALZ = [0,P1(3,4),P2(3,4),P3(3,4)];
    TIP = [P3(1,4),P3(2,4),P3(3,4)];
end

