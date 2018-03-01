%generate linear quintic Polynomial trajectory
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ qX,qY,qZ ] = QuinticPoly( qX,qY,qZ)
   for i = 3:3:9
    QuinticMatrix = [1 (i-3) (i-3)^2 (i-3)^3 (i-3)^4 (i-3)^5;
                   0 1 2*(i-3) 3*(i-3)^2 4*(i-3)^3 5*(i-3)^4;
                   0 0 2 6*(i-3) 12*(i-3)^2 20*(i-3)^3;
                   1 i i^2 i^3 i^4 i^5;
                   0 1 2*i 3*i^2 4*i^3 5*i^4;
                   0 0 2 6*i 12*i^2 20*i^3];

    QuinticInv = inv(QuinticMatrix);

    Xtrajectory = [175,146.1462,154.7008;     0,0,0;    0,0,0;    146.1462,154.7008,175;       0,0,0;    0,0,0;];
    Ytrajectory = [210,-146.3,119.39;   0,0,0;    0,0,0;    -146.3,119.39,210;   0,0,0;    0,0,0;];
    Ztrajectory = [110,-20.72,300;   0,0,0;    0,0,0;    -20.72,300,110;  0,0,0;    0,0,0;];

    AvalsX = (QuinticInv)*Xtrajectory(:,(i/3));
    AvalsY = (QuinticInv)*Ytrajectory(:,(i/3));
    AvalsZ = (QuinticInv)*Ztrajectory(:,(i/3));
    
    for j= (i-3):0.3:i
       qX = [qX,AvalsX(1)+AvalsX(2)*j+AvalsX(3)*(j^2)+AvalsX(4)*(j^3)+AvalsX(5)*(j^4)+AvalsX(6)*(j^5)];
       qY = [qY,AvalsY(1)+AvalsY(2)*j+AvalsY(3)*(j^2)+AvalsY(4)*(j^3)+AvalsY(5)*(j^4)+AvalsY(6)*(j^5)];
       qZ = [qZ,AvalsZ(1)+AvalsZ(2)*j+AvalsZ(3)*(j^2)+AvalsZ(4)*(j^3)+AvalsZ(5)*(j^4)+AvalsZ(6)*(j^5)];
    end
   end
end

