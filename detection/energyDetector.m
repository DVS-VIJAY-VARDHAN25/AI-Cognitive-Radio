function SignalData = energyDetector(SignalData)

disp(' ');
disp('------ ENERGY DETECTOR ------');

if SignalData.energy > SignalData.threshold

    SignalData.signalDetected = true;

else

    SignalData.signalDetected = false;

end

disp(['Signal Detected : ' num2str(SignalData.signalDetected)]);

end