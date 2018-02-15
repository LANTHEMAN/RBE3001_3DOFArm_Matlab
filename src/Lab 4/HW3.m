theta1 = 0;
theta2 = 0;
theta3 = -pi/2;
l1 = 135;
l2 = 175;
l3=169.28;
% syms theta1
% syms theta2
% syms theta3
% syms l3
% syms l1
% syms l2

P1 = Transform(0,sym(-pi/2),l1,theta1);
P2 = P1*Transform(l2,0,0,theta2);
P3 = P2*Transform(l3,0,0,theta3+sym(pi/2));

jjj = jacob0(P1,P2,P3);
jjj = simplify(jjj);
%answer = jjj * [t1;t2;d3d];
disp(P3);
disp(jjj)
%disp(answer)
d = det(jjj);
r = rank(jjj);
disp(d);
disp(r);

function [T] = Transform (a, alpha, d, theta) 
T = [cos(theta) -sin(theta)*cos(alpha) sin(theta)*sin(alpha) a*cos(theta); 
      sin(theta) cos(theta)*cos(alpha) -cos(theta)*sin(alpha) a*sin(theta);
      0 sin(alpha) cos(alpha) d;
      0 0 0 1];
end




