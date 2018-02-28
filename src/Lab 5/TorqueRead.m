function [ Torque,TorqueArrayA,TorqueArrayB,TorqueArrayC ] = TorqueRead(returnPacket,time,K,TorqueArrayA,TorqueArrayB,TorqueArrayC)
TorqueArrayA(K) = returnPacket(3);
TorqueArrayB(K) = returnPacket(6);
TorqueArrayC(K) = returnPacket(9);
if time < 1
    Torque = [0;0;0];
else
    TorqueAvgA = (mean(TorqueArrayA)-0.5574)/178.5*4096*1000;
    TorqueAvgB = (mean(TorqueArrayB)-0.4993)/178.5*4096*1000;
    TorqueAvgC = (mean(TorqueArrayC)-0.4833)/178.5*4096*1000;
%     TorqueAvgA = (returnPacket(3)-0.6263)/178.5*4096*1000;
%     TorqueAvgB = (returnPacket(6)-0.5440)/178.5*4096*1000;
%     TorqueAvgC = (returnPacket(9)-0.5039)/178.5*4096*1000;
    Torque = [TorqueAvgA;TorqueAvgB;TorqueAvgC];

end 


end

