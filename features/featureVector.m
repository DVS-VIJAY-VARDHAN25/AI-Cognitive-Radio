function SignalData = featureVector(SignalData)

disp(' ');
disp('------ FEATURE VECTOR ------');

SignalData.featureVector = [

SignalData.energy

SignalData.averagePower

SignalData.peakPower

SignalData.peakToPeak

SignalData.peakFrequency

SignalData.bandwidth

SignalData.noiseFloor

SignalData.SNR

];

disp('Feature Vector');

disp(SignalData.featureVector);

end