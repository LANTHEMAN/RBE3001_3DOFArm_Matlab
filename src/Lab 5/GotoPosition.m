function [ packet ] = GotoPosition( packet,X,Y,Z )
    packet(1) = X; %packets for joint angles
    packet(4) = Y;
    packet(7) = Z;
end

