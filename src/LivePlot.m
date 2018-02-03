function [PLOTTT ] = LivePlot( )
    PLOTTT = plot3(0,0,0,'-o');
    grid('on')
    xlim([-300 400])
    ylim([-300 400])
    zlim([-300 600])
    xlabel('x')
    ylabel('y')
    zlabel('z')
    set(PLOTTT,'XDataSource','ACTUALX');
    set(PLOTTT,'YDataSource','ACTUALY');
    set(PLOTTT,'ZDataSource','ACTUALZ');
end

