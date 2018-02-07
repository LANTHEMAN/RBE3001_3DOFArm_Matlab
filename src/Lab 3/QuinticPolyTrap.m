function [ Xtrajectory, Ytrajectory, Ztrajectory] = QuinticPolyTrap( qX,qY,qZ )

    for i = 4:4:16
    QuinticMatrix = [1 (i-4) (i-4)^2 (i-4)^3 (i-4)^4 (i-4)^5;
                   0 1 2*(i-4) 3*(i-4)^2 4*(i-4)^3 5*(i-4)^4;
                   0 0 2 6*(i-4) 12*(i-4)^2 20*(i-4)^3;
                   1 i i^2 i^3 i^4 i^5;
                   0 1 2*i 3*i^2 4*i^3 5*i^4;
                   0 0 2 6*i 12*i^2 20*i^3];

    QuinticInv = inv(QuinticMatrix);

    Xtrajectory = [250,250,146,146;     0,0,0,0;    0,0,0,0;    250,146,146,250;       0,0,0,0;    0,0,0,0;];
    Ytrajectory = [210,-164,-164,210;   0,0,0,0;    0,0,0,0;    -164,-164,210,210;   0,0,0,0;    0,0,0,0;];
    Ztrajectory = [110,-20,-20,110;   0,0,0,0;    0,0,0,0;    -20,-20,110,110;  0,0,0,0;    0,0,0,1;];

    AvalsX = (QuinticInv)*Xtrajectory(:,(i/4));
    AvalsY = (QuinticInv)*Ytrajectory(:,(i/4));
    AvalsZ = (QuinticInv)*Ztrajectory(:,(i/4));
    
    for j= (i-4):0.4:i
       qX = [qX,AvalsX(1)+AvalsX(2)*j+AvalsX(3)*(j^2)+AvalsX(4)*(j^3)+AvalsX(5)*(j^4)+AvalsX(6)*(j^5)];
       qY = [qY,AvalsY(1)+AvalsY(2)*j+AvalsY(3)*(j^2)+AvalsY(4)*(j^3)+AvalsY(5)*(j^4)+AvalsY(6)*(j^5)];
       qZ = [qZ,AvalsZ(1)+AvalsZ(2)*j+AvalsZ(3)*(j^2)+AvalsZ(4)*(j^3)+AvalsZ(5)*(j^4)+AvalsZ(6)*(j^5)];
    end
    end
    
end

