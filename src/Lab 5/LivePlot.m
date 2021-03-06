%intialize live plot, end factor trajectory plot and force vector plot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [PLOTTT,TF] = LivePlot( )
    figure(1);
    PLOTTT = plot3(0,0,0,'-o');
    grid('on')
    xlim([-300 400])
    ylim([-300 400])
    zlim([-300 600])
    xlabel('x')
    ylabel('y')
    zlabel('z')
    title('Robot Live Plot')
     hold on;
    TF = quiver3(0,0,0,0,0,0);
    set(PLOTTT,'XDataSource','ACTUALX');
    set(PLOTTT,'YDataSource','ACTUALY');
    set(PLOTTT,'ZDataSource','ACTUALZ');
   
    Enddd = plot3(0,0,0,'-');
    set(TF,'XDataSource','TIP(1)');
    set(TF,'YDataSource','TIP(2)');
    set(TF,'ZDataSource','TIP(3)');
    set(TF,'UDataSource','TForce(1)');
    set(TF,'VDataSource','TForce(2)');
    set(TF,'WDataSource','TForce(3)');
    hold off;
    set(Enddd,'XDataSource','OutputTIP(:,1)');
    set(Enddd,'YDataSource','OutputTIP(:,2)');
    set(Enddd,'ZDataSource','OutputTIP(:,3)');
    
end

