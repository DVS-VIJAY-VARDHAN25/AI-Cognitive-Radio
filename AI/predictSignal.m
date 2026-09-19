function predictedLabel = predictSignal(SignalData)

load SavedModel.mat

featureVector = SignalData.featureVector;

disp('Original size:')
disp(size(featureVector))

disp('Original class:')
disp(class(featureVector))

featureVector = double(featureVector(:)');

disp('Final size:')
disp(size(featureVector))

disp('Final class:')
disp(class(featureVector))

disp(featureVector)

predictedLabel = predict(Model,featureVector);

disp(predictedLabel)

end