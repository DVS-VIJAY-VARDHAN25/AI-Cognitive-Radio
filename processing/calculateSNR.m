function SignalData = calculateSNR(SignalData)

signalPower = mean(SignalData.signal.^2);

noisePower = SignalData.noiseFloor;

SNR = 10*log10(signalPower/noisePower);

SignalData.SNR = SNR;

disp(['SNR : ' num2str(SNR) ' dB']);

end