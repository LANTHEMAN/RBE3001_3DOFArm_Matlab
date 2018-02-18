function [ Torque,TorqueArrayA,TorqueArrayB,TorqueArrayC ] = TorqueRead(returnPacket,time,K,TorqueArrayA,TorqueArrayB,TorqueArrayC)
TorqueArrayA(K) = returnPacket(3);
TorqueArrayB(K) = returnPacket(6);
TorqueArrayC(K) = returnPacket(9);
if time < 1
    Torque = [0;0;0];
else

    TorqueAvgA = (mean(TorqueArrayA)-0.5635)/178.5;
    TorqueAvgB = (mean(TorqueArrayB)-0.5071)/178.5;
    TorqueAvgC = (mean(TorqueArrayC)-0.4828)/178.5;
    Torque = [TorqueAvgA;TorqueAvgB;TorqueAvgC];

end 


end

