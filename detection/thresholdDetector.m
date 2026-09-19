function SignalData = thresholdDetector(SignalData)

disp(' ');
disp('------ THRESHOLD DETECTOR ------');

SignalData.threshold = SignalData.noiseFloor * 5;

disp(['Threshold : ' num2str(SignalData.threshold)]);

end