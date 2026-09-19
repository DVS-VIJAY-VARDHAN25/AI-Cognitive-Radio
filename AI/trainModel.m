function trainModel()

clc;
clear;
close all;

projectRoot = fileparts(fileparts(mfilename('fullpath')));
addpath(genpath(projectRoot));

disp('======================================');
disp(' AI Cognitive Radio Model Training');
disp('======================================');

% ==========================================
% LOAD DATASET
% ==========================================

load TrainingDataset.mat

disp('Dataset Loaded Successfully');
disp(['Total Samples : ' num2str(height(Dataset))]);

% ==========================================
% PREPARE FEATURES AND LABELS
% ==========================================

X = table2array(Dataset(:,1:end-1));
Y = categorical(Dataset.Label);

disp('Original Feature Size:');
disp(size(X));

% ==========================================
% TRAIN / TEST SPLIT
% ==========================================

cv = cvpartition(Y,'HoldOut',0.2);

XTrain = X(training(cv),:);
YTrain = Y(training(cv));

XTest = X(test(cv),:);
YTest = Y(test(cv));

disp(['Training Samples : ' num2str(size(XTrain,1))]);
disp(['Testing Samples  : ' num2str(size(XTest,1))]);

% ==========================================
% NORMALIZATION
% ==========================================
% IMPORTANT:
% Calculate min/max ONLY from training data

featureMin = min(XTrain,[],1);
featureMax = max(XTrain,[],1);

featureRange = featureMax - featureMin;

% Avoid division by zero
featureRange(featureRange == 0) = 1;

% Normalize training data
XTrainNormalized = ...
    (XTrain - featureMin) ./ featureRange;

% Normalize testing data using
% THE SAME training min/max
XTestNormalized = ...
    (XTest - featureMin) ./ featureRange;

disp(' ');
disp('------ NORMALIZATION ------');

disp('First 5 normalized training samples:');

disp(XTrainNormalized(1:min(5,size(XTrainNormalized,1)),:));

% ==========================================
% TRAIN DECISION TREE
% ==========================================

disp(' ');
disp('Training Decision Tree...');

Model = fitctree(XTrainNormalized,YTrain);

disp('Training Completed');

% ==========================================
% TEST MODEL
% ==========================================

YPred = predict(Model,XTestNormalized);

accuracy = mean(YPred == YTest) * 100;

disp(' ');
disp('=========== MODEL PERFORMANCE ===========');

disp(['Accuracy = ' num2str(accuracy,'%.2f') ' %']);

disp(['Training Samples : ' ...
    num2str(size(XTrainNormalized,1))]);

disp(['Testing Samples  : ' ...
    num2str(size(XTestNormalized,1))]);

% ==========================================
% CONFUSION MATRIX
% ==========================================

figure;

confusionchart(YTest,YPred);

title('Decision Tree Confusion Matrix');

% ==========================================
% SAVE MODEL
% ==========================================

save('SavedModel.mat',...
    'Model',...
    'accuracy',...
    'featureMin',...
    'featureMax');

disp(' ');
disp('Model Saved Successfully');

disp('Saved normalization parameters:');

disp('featureMin =');
disp(featureMin);

disp('featureMax =');
disp(featureMax);

end