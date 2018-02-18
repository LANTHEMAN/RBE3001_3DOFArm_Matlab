function [  ] = VelocityVector( TIP,PPP )
    q = quiver3(TIP(1),TIP(2),TIP(3),PPP(1),PPP(2),PPP(3));
    w = q.LineWidth;
    q.LineWidth = 1.0;
    a = q.ShowArrowHead;
    q.ShowArrowHead = 'on';
    s = q.MaxHeadSize;
    q.MaxHeadSize = 1;
end

