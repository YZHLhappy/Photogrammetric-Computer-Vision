function [fundamentalMatrix] = EightPointAlgo(pointsImg1, pointsImg2)
% Implementation of the 8 point algorithm, which computes the Fundamental
% matrix based on 8 or more point correspondences.
% pointsImg1: Matrix containing homogeneous points from the first
% image. (One point per column!)
% pointsImg2: Matrix containing homogeneous points from the second
% image. (One point per column!) 
% fundamentalMatrix: Fundamental matrix

%--------------------------------------------
%------- Task 1a: Add your code here --------
[~,n] = size(pointsImg2);
T_2D_1 = ConditionTrafo(pointsImg1);  
T_2D_2 = ConditionTrafo(pointsImg2);  
x_k_1 = T_2D_1 * pointsImg1;
x_k_2 = T_2D_2 * pointsImg2;
for i=1:n
    A(i,:) = kron(x_k_1(:,i),x_k_2(:,i));
    %A_n9 = [A_n9; A];
end
[~,~,V] = svd(A);
[~,b] = size(V);
f = V(:,b);
F_k = reshape(f,3,3); %[f(1),f(2),f(3);f(4),f(5),f(6);f(7),f(8),f(9)];
[U_1,S_1,V_1] = svd(F_k);
[max_S_1,~]=max(S_1,[],2);
[~,index_S_1]=min(max_S_1,[],1);
S_1(index_S_1,index_S_1) = 0;
F_k = U_1*S_1*V_1';
fundamentalMatrix = T_2D_2'* F_k * T_2D_1;
%--------------------------------------------
end
% X_c_1 = [sum(pointsImg1(1,:))/n;sum(pointsImg1(2,:))/n;sum(pointsImg1(3,:))/n];
% X_c_2 = [sum(pointsImg2(1,:))/n;sum(pointsImg2(2,:))/n;sum(pointsImg2(3,:))/n];
% s_1_sum = 0;
% s_2_sum = 0;
% for i=1:n
%     s_1 = norm([pointsImg1(1,i);pointsImg1(2,i);pointsImg1(3,i)] - X_c_1);
%     s_2 = norm([pointsImg2(1,i);pointsImg2(2,i);pointsImg2(3,i)] - X_c_2);
%     
%     
%     s_1_sum = s_1_sum+s_1;
%     s_2_sum = s_2_sum+s_2;
% end 
% S_mean_img1 = s_1_sum/n;
% S_mean_img2 = s_2_sum/n;
% 
% S_2D_1 = sqrt(2)/S_mean_img1;
% S_2D_2 = sqrt(2)/S_mean_img2;
% 
% T_2D_1 = [S_2D_1, 0, -S_2D_1*X_c_1(1);
%           0, S_2D_1, -S_2D_1*X_c_1(2);
%           0, 0, 1];
% T_2D_2 = [S_2D_2, 0, -S_2D_2*X_c_2(1);
%           0, S_2D_2, -S_2D_2*X_c_2(2);
%           0, 0, 1]; 
