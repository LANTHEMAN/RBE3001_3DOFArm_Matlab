%calculating jacobian
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ JP] = jacob0( P1,P2,P3 )

JointP0 = cross([0;0;1],(P3(1:3,4)-[0;0;0]));
JointP1 = cross(P1(1:3,3),(P3(1:3,4)-P1(1:3,4)));
JointP2 = cross(P2(1:3,3),(P3(1:3,4)-P2(1:3,4)));


JointR0 = [0;0;1];
JointR1 = P1(1:3,3);
JointR2 = P2(1:3,3);


JP = [JointP0,JointP1,JointP2];
JR = [JointR0,JointR1,JointR2];

J = vertcat(JP,JR);
end

