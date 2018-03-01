%plot end plot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [End] = EndPlot( )
    End = plot(3,4);
    grid('on')
    xlabel('Time(s)')
    ylabel('Position(mm)')
    set(EndPlot,'XDataSource','time');
    set(EndPlot,'YDataSource','TIP');
end
