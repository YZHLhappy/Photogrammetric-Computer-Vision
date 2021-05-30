function [T] = ConditionTrafo(points)
% Get the conditioning transformation based on the specified points.
% points: Matrix containing homogeneous points. (One point per column!)
% T: Transformation matrix.

cOG = mean(points,2);

avgDist = 0;
for i=1:size(points,2)
    avgDist = avgDist + norm(points(1:2,i) - cOG(1:2));
end
avgDist = avgDist / size(points,2);
scale = sqrt(2)/avgDist;

T = [scale 0 -scale*cOG(1); 0 scale -scale*cOG(2); 0 0 1];

end