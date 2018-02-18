function [ qX,qY,qZ ] = Trajectory( x0,y0,z0,x1,y1,z1,x2,y2,z2 )
    qX = [];
    qY = [];
    qZ = [];
    for i = 2:2:4
    CubicMatrix = [1 (i-2) (i-2)^2 (i-2)^3;
                   0 1 2*(i-2) 3*(i-2)^2;
                   1 i i^2 i^3;
                   0 1 2*i 3*i^2];

    CubicInv = inv(CubicMatrix);


    Xtrajectory = [x0,x1;        0,0;    x1,x2;     0,0];
    Ytrajectory = [y0,y1;    0,0;    y1,y2;   0,0];
    Ztrajectory = [z0,z1;   0,0;    z1,z2;  0,0];

    AvalsX = (CubicInv)*Xtrajectory(:,(i/2));
    AvalsY = (CubicInv)*Ytrajectory(:,(i/2));
    AvalsZ = (CubicInv)*Ztrajectory(:,(i/2));
    
    for j= (i-2):0.2:i
       qX = [qX,AvalsX(1)+AvalsX(2)*j+AvalsX(3)*(j^2)+AvalsX(4)*(j^3)];
       qY = [qY,AvalsY(1)+AvalsY(2)*j+AvalsY(3)*(j^2)+AvalsY(4)*(j^3)];
       qZ = [qZ,AvalsZ(1)+AvalsZ(2)*j+AvalsZ(3)*(j^2)+AvalsZ(4)*(j^3)];
    end
    
 

    end

end

