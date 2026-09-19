function SignalData = normalizeFeatures(SignalData)

disp(' ');
disp('------ NORMALIZATION ------');

x = SignalData.featureVector;

% Load trained model and normalization parameters

projectRoot = 'C:\Users\SAI VIJAY VARDHAN\OneDrive\ドキュメント\MATLAB\AI_Cognitive_Radio';

modelFile = fullfile(projectRoot,'AI','SavedModel.mat');

if isfile(modelFile)

    data = load(modelFile,...
        'featureMin',...
        'featureMax');

    featureMin = data.featureMin;
    featureMax = data.featureMax;

else

    error('SavedModel.mat not found at: %s', modelFile);

end

% Make sure feature vector is a row vector
x = x(:)';

% Calculate feature range
featureRange = featureMax - featureMin;

% Avoid division by zero
featureRange(featureRange == 0) = 1;

% Normalize using training parameters
SignalData.normalizedFeatures = ...
    (x - featureMin) ./ featureRange;

disp('Normalized Feature Vector:');

disp(SignalData.normalizedFeatures);

end