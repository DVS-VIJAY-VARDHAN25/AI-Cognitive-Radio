function SignalData = calculateEnergy(SignalData)

signal = SignalData.signal;

energy = sum(abs(signal).^2);

SignalData.energy = energy;

disp(' ');
disp('------------ SIGNAL ENERGY ------------');
disp(['Signal Energy : ' num2str(energy)]);

end