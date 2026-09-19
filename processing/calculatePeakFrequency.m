function SignalData = calculatePeakFrequency(SignalData)

fftMagnitude = SignalData.fftMagnitude;

frequencyAxis = SignalData.frequencyAxis;

[~,index] = max(fftMagnitude);

peakFrequency = frequencyAxis(index);

SignalData.peakFrequency = peakFrequency;

disp(['Peak Frequency : ' num2str(peakFrequency) ' Hz']);

end