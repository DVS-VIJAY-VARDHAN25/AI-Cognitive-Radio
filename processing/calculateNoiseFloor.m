function SignalData = estimateNoiseFloor(SignalData)

PSD = SignalData.PSD;

noiseFloor = mean(PSD);

SignalData.noiseFloor = noiseFloor;

disp(['Noise Floor : ' num2str(noiseFloor)]);

end