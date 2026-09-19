function SignalData = calculatePSD(SignalData)
config = projectConfig();
%==========================================
% Read Signal
%==========================================

signal = SignalData.signal;

Fs = SignalData.Fs;

%==========================================
% Calculate Power Spectral Density
%==========================================

[PSD,f] = pwelch(signal,[],[],[],Fs);

%==========================================
% Store Results
%==========================================

SignalData.PSD = PSD;
SignalData.PSDFrequency = f;

%==========================================
% Plot
%==========================================


if config.trainingMode == 0

figure;

plot(f,10*log10(PSD),'LineWidth',1.5);

grid on;

title('Power Spectral Density');

xlabel('Frequency (Hz)');

ylabel('Power/Frequency (dB/Hz)');

end