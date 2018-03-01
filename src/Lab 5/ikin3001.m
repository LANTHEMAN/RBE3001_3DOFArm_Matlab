%solve inverse kinematics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [A1,A2,A3]  = ikin3001 (px,py,pz,L1,L2,L3)
    L4 = ((pz - L1)^2 + px^2+py^2)^(0.5);
    T1 = atan2d(py,px); %Theta 1 equation
    T2 = atan2d(pz-L1, (px^2+py^2)^(0.5)) + acosd((L2^2+L4^2-L3^2)/(2*L2*L4)); %Theta 2 equation
    T3 = acosd((L2^2+L3^2-L4^2)/(2*L2*L3))-90;%theta 3 equation
    %add safety if statements
    A1 = T1/(360)*4096;
    A2 = T2/(360)*4096;
    A3 = T3/(360)*4096;
 
end