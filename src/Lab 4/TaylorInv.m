function [] = TaylorInv(L1,L2,L3,packet)


[PLOTTT] = LivePlot2D();
[Xd,Zd] = ginput;

    Ai=0;
    Bi=0;
    Ci=0;

while (1)
        [pr1,pr2,pr3,P1,P2,P3,ACTUALX,ACTUALY,ACTUALZ,TIP] = ForkinR(Ai,Bi,Ci,L1,L2,L3);
        JP = jacob0(P1,P2,P3);
        InvJP = pinv(JP);
        deltaQ = 0.1*InvJP*([Xd;0;Zd]-[TIP(1);TIP(2);TIP(3)]);

        Ai = Ai + deltaQ(1);
        Bi = Bi + deltaQ(2);
        Ci = Ci + deltaQ(3);
       
    %record time
    refreshdata(PLOTTT)
    pause(0.1) 
    error = norm([TIP(1);TIP(2);TIP(3)] - [Xd;0;Zd]);
    if error < 0.1
    break;
    end
end
packet = [(Ai/(2*pi)*4096),0,0,(Bi/(2*pi)*4096),0,0,(Ci/(2*pi)*4096),0,0,0,0,0,0,0,0];



end

