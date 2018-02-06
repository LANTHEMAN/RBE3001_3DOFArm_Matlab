function [ AvalsX, AvalsY, AvalsZ ] = QuintPoly( )

    for i = 2:2:4
    QuinticMatrix = [1 (i-2) (i-2)^2 (i-2)^3 (i-2)^4 (i-2)^5;
                   0 1 2*(i-2) 3*(i-2)^2 4*(i-2)^3 5*(i-2)^4;
                   0 0 2 6*(i-2) 12*(i-2)^2 20*(i-2)^3;
                   1 i i^2 i^3 i^4 i^5;
                   0 1 2*i 3*i^2 4*i^3 5*i^4;
                   0 0 2 6*i 12*i^2 20*i^3];

    QuinticInv = inv(QuinticMatrix);


    Xtrajectory = [0,0;     0,0;    0,0;    0,0;       0,0;    0,0;];
    Ytrajectory = [0,-94;   0,0;    0,0;    -94,490;   0,0;    0,0;];
    Ztrajectory = [0,346;   0,0;    0,0;    346,-131;  0,0;    0,0;];

    AvalsX = (QuinticInv)*Xtrajectory(:,(i/2));
    AvalsY = (QuinticInv)*Ytrajectory(:,(i/2));
    AvalsZ = (QuinticInv)*Ztrajectory(:,(i/2));

end

