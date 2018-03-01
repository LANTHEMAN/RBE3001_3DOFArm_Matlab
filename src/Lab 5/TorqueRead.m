%convert ADC to torque reading then average the last 5 readings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

    Torque = [TorqueAvgA;TorqueAvgB;TorqueAvgC];

end 


end

