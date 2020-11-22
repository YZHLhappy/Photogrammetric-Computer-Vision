function [] = PlotErrorEllipse( point, covMatrix )
% Plots an error allipse based on the input point and the corresponding
% covariance matrix.
% point: A 2D point
% covMatrix: Covariance matrix corresponding to the point

% Calculate length of ellipse axes
eigenvalues = eig(covMatrix);
eigenvalues = sort(eigenvalues, 'descend');
axesLength = sqrt(eigenvalues);
aspectRatio = axesLength(2) / axesLength(1);
angle = 0.5 * atan((1 / aspectRatio)*((covMatrix(1,2) + covMatrix(2,1)) / (covMatrix(1,1) - covMatrix(2,2))));
rotationMatrix = [cos(angle) -sin(angle); sin(angle) cos(angle)];

P1 = [(axesLength(1) / 2); 0];
P2 = [-(axesLength(1) / 2); 0];
P1 = (rotationMatrix * P1) + point;
P2 = (rotationMatrix * P2) + point;

% Determine start and end point of major axis
x1 = P1(1);
y1 = P1(2);
x2 = P2(1);
y2 = P2(2);
e = 1 - aspectRatio;

% Draw ellipse
a = 1/2*sqrt((x2-x1)^2+(y2-y1)^2);
b = a*sqrt(1-e^2);
t = linspace(0,2*pi);
X = a*cos(t);
Y = b*sin(t);
w = atan2(y2-y1,x2-x1);
x = (x1+x2)/2 + X*cos(w) - Y*sin(w);
y = (y1+y2)/2 + X*sin(w) + Y*cos(w);
plot(x,y,'b-')
axis equal;

end
