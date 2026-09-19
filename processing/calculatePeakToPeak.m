function SignalData = calculatePeakToPeak(SignalData)

signal = SignalData.signal;

peakToPeak = max(signal)-min(signal);

SignalData.peakToPeak = peakToPeak;

disp(['Peak To Peak : ' num2str(peakToPeak)]);

end