function [ TForce,ACTUALX,ACTUALY,ACTUALZ,TIP ] = TIPForce( returnPacket,Torque,L1,L2,L3)
        [pr1,pr2,pr3,P1,P2,P3,ACTUALX,ACTUALY,ACTUALZ,TIP] = Forkin(returnPacket,L1,L2,L3);
        [JP] = jacob0(P1,P2,P3);
        tranJP = transpose(JP);
        InvJP = pinv(tranJP);
        TForce = InvJP * Torque*1000;
        
end

