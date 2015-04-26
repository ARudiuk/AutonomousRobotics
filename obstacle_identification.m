%Compares the location of a scan to determine whether or not an obstacle
%has been identified yet. Returns 1 if the obstacle has been scaned
%already, and a 0 if it has not.

function [result] = obstacle_identification(map,scan,tolerance)
error = [map(:,3) - scan(1), map(:,4) - scan(2)];
[~,n] = size(error);
for i = 1:size(n)
    if abs(error(i,1)<tolerance) && abs(error(i,2)<tolerance)<tolerance
        result = 1;
    else
        result = 0;
    end
end