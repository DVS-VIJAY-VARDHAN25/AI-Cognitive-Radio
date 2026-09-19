function SignalData = calculatePeakPower(SignalData)

signal = SignalData.signal;

peakPower = max(signal.^2);

SignalData.peakPower = peakPower;

disp(['Peak Power : ' num2str(peakPower)]);

end