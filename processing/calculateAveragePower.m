function SignalData = calculateAveragePower(SignalData)

signal = SignalData.signal;

averagePower = mean(signal.^2);

SignalData.averagePower = averagePower;

disp(['Average Power : ' num2str(averagePower)]);

end