%functions to execute generated trajectories
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ returnPacket ] = GrabBall(SERV_ID,pp,positionX,positionY,positionZ,thereisball,returnPacket,PLOTTT,ACTUALX,ACTUALY,ACTUALZ)

%function set up 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%arm length
L1 = 135;
L2 = 175;
L3 = 169.28;
K = 0; %intial data marker 
i = 1; %trajectory step marker
END = 0; %end of trajectory marker
%set up torque recording arrays to take average for anormaly elimination 
TorqueArrayA = zeros(5, 1, 'single');
TorqueArrayB = zeros(5, 1, 'single');
TorqueArrayC = zeros(5, 1, 'single');
%start clock
tic
%Instantiate a packet
packet = zeros(15, 1, 'single');

%main execution loop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    while i <= 6 && END == 0
        time = toc;%record time 
        %set data markers, record the last 5 torque readings 
        K = K+1;
        if K > 5
            K = 1;
        end
        %go to set position 
        packet = GotoPosition(packet,positionX(i),positionY(i),positionZ(i),pp,SERV_ID,returnPacket,i);
        returnPacket = pp.command(SERV_ID, packet);
        %convert torque from raw ADC readings
        [ Torque,TorqueArrayA,TorqueArrayB,TorqueArrayC ] = TorqueRead(returnPacket,time,K,TorqueArrayA,TorqueArrayB,TorqueArrayC);
        %forward kinematics for current position
        [pr1,pr2,pr3,P1,P2,P3,ACTUALX,ACTUALY,ACTUALZ,TIP] = Forkin(returnPacket,L1,L2,L3);
        %refresh plot
        refreshdata(PLOTTT);
        %calculate error from the distance between current position from desired position 
        error = norm([returnPacket(1),returnPacket(4),returnPacket(7)] -[positionX(i),positionY(i),positionZ(i)]);
        %if reached position, go to next position 
        if error < 40
            i = i+1;
            positionReady = 1;
            pause(0.5);
        end
        
        %at position 4, grab the ball
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        if i == 4 && positionReady == 1
            [ packet,returnPacket ] = gripBall( SERV_ID,pp,packet );
            positionReady = 0;
        end
        
        %at position 5, weigh the ball and distiguish between weights
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if i == 5 && positionReady == 1
            %wait till settling down 
            pause(2);
            returnPacket = pp.command(SERV_ID, packet);
            [TForce,ACTUALX,ACTUALY,ACTUALZ,TIP] = TIPForce(returnPacket,(Torque),L1,L2,L3);
            %weighting threshold
            if Torque(2) < 100
                %send to different location
                i = i+1;
            end
            positionReady = 0;
        end
        
        %at position 6, drop the heavy balls 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if i == 6 && positionReady == 1
            [ packet,returnPacket ] = releaseBall( SERV_ID,pp,packet );
            positionReady = 0;
            END = 1;
        end
        
        %at position 7, drop the light balls 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if i == 7 && positionReady == 1
            [ packet,returnPacket ] = releaseBall( SERV_ID,pp,packet );
            positionReady = 0;
            END = 1;
        end
    end
    
    


