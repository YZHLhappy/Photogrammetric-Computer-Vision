clear all; close all; dbstop error;
% Main file for the second exercise.
% This script will call the other functions and should be run.

%-------------------------------------------------------------
%------ The Fundamental Matrix and the Essential Matrix ------
%-------------------------------------------------------------

% Import Data
[pointsLeft, pointsRight, K, imageLeft, imageRight] = ImportData();


% Estimate fundamentalMatrix
F = EightPointAlgo(pointsLeft, pointsRight);

% Estimate essential matrix
E = EstimateE(pointsLeft, pointsRight, K);

% Estimate essential matrix robustly
[robustE,score_max]  = EstimateEwithRANSAC(pointsLeft, pointsRight, K);

matrix = robustE;
isFundamental = 0;

VisualiseEpipolarLines(matrix, isFundamental)

VisualisePointCorrespondences()