% Lecture: Photogrammetric Computer Vision
% Exercise 3: Background subtraction
% Author: M.Sc. Jakob Unger (unger@ipi.uni-hannover.de)
% Lecturer: Dipl.-Ing. Tobias Klinger (klinger@ipi.uni-hannover.de)
% Lecturer: M.Sc. Lin Chen (chen@ipi.uni-hannover.de)
% Group: <group number>
% Authors: <zhonglong Yang, meng Zhang>

close all
clear all

%  Read image sequence
path2sequence = 'sequence';
search_string = fullfile(path2sequence, '*.jpeg');
file_list = dir(search_string);

% Sequencial estimation of the gaussians parameters

%TODO: Learning rate
alpha = 1/50;

% Initial values
im_RGB = imread(fullfile(path2sequence, file_list(1).name));
[m,n] = size(rgb2gray(im_RGB));

mu = single(rgb2gray(im_RGB)); 
sigma_square = ones(m,n)*100;

% Structure element for morphological operation
se = strel('square',3);

h1 = figure(1);
colormap(gray);

% Iterate over the sequence
for i = 2:length(file_list)
    im_RGB = imread(fullfile(path2sequence, file_list(i).name));
    im = single(rgb2gray(im_RGB)); %im is the g(x)-th  
    
%   % TODO: Thresholding for background subtraction
    delta_g = abs(im - mu);
    mask_back = delta_g;
    mask_back(delta_g > 2.5 * sqrt(sigma_square)) = 0; %foreground pixels are set to 0,background pixels are 1
    mask_back = logical(mask_back); %convert to type "logical"
      
    % Eliminate noise
    % TODO: Closing using structure element "se"
    im_closing = imclose(mask_back,se);
    
    % Update Gaussian parameters 
    % TODO: Mean
    mu = alpha * im +(1 - alpha)* mu;
    
    % TODO: Variance
    sigma_square = alpha * (mu - im).^2 + (1 - alpha) * sigma_square;

    % Output
    subplot(231); 
    imagesc(im, [0 255]); % TODO: Show input image
    title('input image');
    subplot(232); 
    imagesc(mu, [0 255]); % TODO: Show mean values
    title('mean values');
    subplot(233);  
    imagesc(sigma_square, [0 255]); % TODO: Show variances
    title('variances');
    subplot(234);  
    imagesc(delta_g, [0 255]); % TODO: Show difference between current image and mean values
    title('difference');
    subplot(235);  
    imagesc(mask_back, [0 1]); % TODO: Show background mask (unfiltered)
    title('mask');
    subplot(236);  
    imagesc(im_closing, [0 1]); % TODO: Show background mask after eliminating noise
    title('eliminating noise');
    drawnow; 
end
