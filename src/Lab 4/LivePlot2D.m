function [PLOTTT] = LivePlot2D( )
    PLOTTT = plot(0,0,'-o');
    grid('on')
    xlim([-300 400])
    ylim([-300 400])
    xlabel('x')
    ylabel('z')
    title('Robot Live Plot')
    set(PLOTTT,'XDataSource','ACTUALX');
    set(PLOTTT,'YDataSource','ACTUALZ');
    hold on;
end

