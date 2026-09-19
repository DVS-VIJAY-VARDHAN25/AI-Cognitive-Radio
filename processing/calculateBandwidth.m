function SignalData = calculateBandwidth(SignalData)

PSD = SignalData.PSD;

frequency = SignalData.PSDFrequency;

threshold = max(PSD)/2;

index = find(PSD >= threshold);

bandwidth = frequency(index(end)) - frequency(index(1));

SignalData.bandwidth = bandwidth;

disp(['Bandwidth : ' num2str(bandwidth) ' Hz']);

end