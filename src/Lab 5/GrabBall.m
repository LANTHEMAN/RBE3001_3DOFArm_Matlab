function [ returnPacket ] = GrabBall(SERV_ID,pp,positionX,positionY,positionZ,thereisball,returnPacket,PLOTTT,ACTUALX,ACTUALY,ACTUALZ,secure)
L1 = 135;
L2 = 175;
L3 = 169.28;
K = 0;
END = 0;
TorqueOffSet = 0;
TorqueArrayA = zeros(5, 1, 'single');
TorqueArrayB = zeros(5, 1, 'single');
TorqueArrayC = zeros(5, 1, 'single');


% Instantiate a packet
tic
packet = zeros(15, 1, 'single');


    i = 1;
    while i <= 6 && END == 0
        time = toc;
        K = K+1;
        if K > 5
            K = 1;
        end
        packet = GotoPosition(packet,positionX(i),positionY(i),positionZ(i),pp,SERV_ID,returnPacket,i);
        returnPacket = pp.command(SERV_ID, packet);
%         disp('hereeeeeeeeeeee')
%         disp(packet);
        [ Torque,TorqueArrayA,TorqueArrayB,TorqueArrayC ] = TorqueRead(returnPacket,time,K,TorqueArrayA,TorqueArrayB,TorqueArrayC);
        [pr1,pr2,pr3,P1,P2,P3,ACTUALX,ACTUALY,ACTUALZ,TIP] = Forkin(returnPacket,L1,L2,L3);
        refreshdata(PLOTTT);
        error = norm([returnPacket(1),returnPacket(4),returnPacket(7)] -[positionX(i),positionY(i),positionZ(i)]);
        %disp(error);
        if error < 40
            i = i+1;
            positionReady = 1;
            pause(0.5);
        end
        if i == 4 && positionReady == 1
            %TorqueOffSet = Torque;
            [ packet,returnPacket ] = gripBall( SERV_ID,pp,packet );
            positionReady = 0;
        end
        if i == 5 && positionReady == 1
            pause(2);
            returnPacket = pp.command(SERV_ID, packet);
            [TForce,ACTUALX,ACTUALY,ACTUALZ,TIP] = TIPForce(returnPacket,(Torque),L1,L2,L3);
            disp('T')
            disp(Torque)
            if secure == 1
                i = i+1;
            end
            positionReady = 0;
        end
        if i == 6 && positionReady == 1
            [ packet,returnPacket ] = releaseBall( SERV_ID,pp,packet );
            positionReady = 0;
            END = 1;
        end
        if i == 7 && positionReady == 1
            [ packet,returnPacket ] = releaseBall( SERV_ID,pp,packet );
            positionReady = 0;
            END = 1;
        end
    end
    
    


