%image processing and trajectory generation for avaiable colors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [BpositionX,BpositionY,BpositionZ,Bthereisball,GpositionX,GpositionY,GpositionZ,Gthereisball,YpositionX,YpositionY,YpositionZ,Ythereisball] = GeneratePosition(BlueCenter,YellowCenter,GreenCenter)
if isempty(BlueCenter) == 0 %check id there is ball 
    [BpositionX,BpositionY,BpositionZ] = SetWayPoint( BlueCenter ); 
    % enerate trajectory for that color
    Bthereisball = 1; %there is a ball marker = 1
else
    Bthereisball = 0; %there is a ball marker = 0
end
if isempty(GreenCenter) == 0  
    [GpositionX,GpositionY,GpositionZ] = SetWayPoint( GreenCenter );
    Gthereisball = 1;
else
    Gthereisball = 0;
end
if isempty(YellowCenter) == 0  
    [YpositionX,YpositionY,YpositionZ] = SetWayPoint( YellowCenter );
    Ythereisball = 1;
else
    Ythereisball = 0;
end
end

