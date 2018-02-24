function [PLOTTT,Enddd] = LivePlot( )
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
    set(PLOTTT,'XDataSource','ACTUALX');
    set(PLOTTT,'YDataSource','ACTUALY');
    set(PLOTTT,'ZDataSource','ACTUALZ');
    hold on;
    Enddd = plot3(0,0,0,'-');
    set(Enddd,'XDataSource','OutputTIP(:,1)');
    set(Enddd,'YDataSource','OutputTIP(:,2)');
    set(Enddd,'ZDataSource','OutputTIP(:,3)');
end

