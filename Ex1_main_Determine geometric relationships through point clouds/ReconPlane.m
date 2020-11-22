function [homogeneousPlane, covMatrix] = ReconPlane( listOfPoints )
% Reconstruct the plane and its covariance matrix from the sampled points
% listOfPoints: Matrix containing a 3D point in each column
% homogeneousPlane: Plane in homogenous representation
% covMatrix: Covariance matrix corresponding to the plane

%--------------------------------------------
A = size(listOfPoints);
N = A(2);% the number of the 3D points

x_center = mean(listOfPoints(1,:));
y_center = mean(listOfPoints(2,:));
z_center = mean(listOfPoints(3,:));

X_center = [x_center;y_center;z_center]; % the center of the plan
M = 0;
for i=1:N
    B = listOfPoints(:,i) - X_center;
    M = M + B * B'; % The matirx of the secord central moment M
end
[Eigen_vektor,Eigen_wert] = eig(M);
Lambada = max(Eigen_wert);
[Lambada_1,index_1] = max(Lambada);
[Lambada_3,index_3] = min(Lambada);
Lambada_2 = median(Lambada);
index_2 = 6-index_1 - index_3;

U_1 = Eigen_vektor(:,index_1);
U_2 = Eigen_vektor(:,index_2);
U_3 = Eigen_vektor(:,index_3);
Omega_H = U_3;
Omega_O = -Omega_H'* X_center;

R = [U_1,U_2,U_3];
H = [R',-R'* X_center;0,0,0,1];
Matrix_Sigma_omega = [1/Lambada_1,0,0,0;0,1/Lambada_2,0,0;0,0,0,0;0,0,0,1/N];
Sigma_Omega_process = Lambada_3/(N-3)*Matrix_Sigma_omega;
covMatrix = H'* Sigma_Omega_process * H;
homogeneousPlane = [Omega_H;Omega_O];
%--------------------------------------------
end
