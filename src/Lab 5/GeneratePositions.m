function [ positionsX,positionsY,positionsZ] = GeneratePositions( ColorCenter )
L1 = 135;
L2 = 175;
L3 = 169.28;
[A] = mn2xy(ColorCenter(1),ColorCenter(2));
A1 = 0;
B1 = 500;
C1 = 0;
[A2,B2,C2]  = ikin3001 (A(1),A(2),22,L1,L2,L3);
[A3,B3,C3]  = ikin3001 (A(1),A(2),-18,L1,L2,L3);
A4 = 0;
B4 = 1024;
C4 = 0;
A5 = 900;
B5 = 0;
C5 = 0;
A6 = -900;
B6 = 0;
C6 = 0;
positionsX = [A1,A2,A3,A4,A5,A6];
positionsY = [B1,B2,B3,B4,B5,B6];
positionsZ = [C1,C2,C3,C4,C5,C6];

end

