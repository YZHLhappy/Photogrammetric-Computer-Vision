function [essentialMatrix] = EstimateE(pointsImg1, pointsImg2, calibrationMatrix)
% Estimates the essential matrix using the eight point algorithm.
% pointsImg1: Matrix containing homogeneous points from the first
% image. (One point per column!)
% pointsImg2: Matrix containing homogeneous points from the second
% image. (One point per column!)
% calibrationMatrix: Calibration matrix
% essentialMatrix: Essential matrix

%--------------------------------------------
%------- Task 1b: Add your code here --------
% [~,n] = size(pointsImg1);
% x_n_1 = inv(calibrationMatrix) * pointsImg1;
% x_n_2 = inv(calibrationMatrix) * pointsImg2;
% for i=1:n
%     A(i,:) = kron(x_n_1(:,i),x_n_2(:,i));
%     %A_n9 = [A_n9; A];
% end
% [~,~,V] = svd(A);
% [~,b] = size(V);
% e = V(:,b);
% E_k = reshape(e,3,3);%[e(1),e(2),e(3);e(4),e(5),e(6);e(7),e(8),e(9)];
% [U_1,S_1,V_1] = svd(E_k);
% 
% S_1(3,3) = 0;
% sigma = 1/2 * (S_1(2,2)+S_1(1,1));
% S_1(1,1) = sigma;
% S_1(2,2) = sigma;
% essentialMatrix = U_1*S_1*V_1';

% % 2021.02.08 
F = EightPointAlgo(pointsImg1,pointsImg2);
E = calibrationMatrix'* F * calibrationMatrix;
[U_e,S_e,V_e] = svd(E);

sigma = 0.5 * (S_e(1,1)+S_e(2,2));
s = [sigma sigma 0];
S_e = diag(s);
essentialMatrix = U_e * S_e * V_e';
%--------------------------------------------
end