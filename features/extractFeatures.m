function SignalData = extractFeatures(SignalData)

disp(' ');
disp('------ FEATURE EXTRACTION ------');

SignalData.features.energy = SignalData.energy;

SignalData.features.averagePower = SignalData.averagePower;

SignalData.features.peakPower = SignalData.peakPower;

SignalData.features.peakToPeak = SignalData.peakToPeak;

SignalData.features.peakFrequency = SignalData.peakFrequency;

SignalData.features.bandwidth = SignalData.bandwidth;

SignalData.features.noiseFloor = SignalData.noiseFloor;

SignalData.features.SNR = SignalData.SNR;

disp('Features Extracted Successfully');

end