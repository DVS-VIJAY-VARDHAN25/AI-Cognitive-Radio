function SignalData = calculateFFT(SignalData)
config = projectConfig();

signal = SignalData.signal;

N = length(signal);

fftSignal = fft(signal);

fftMagnitude = abs(fftSignal)/N;

frequencyAxis = (-N/2:N/2-1)*(SignalData.Fs/N);

SignalData.frequencyAxis = frequencyAxis;
SignalData.fftMagnitude = fftMagnitude;

%plot FFT

if config.trainingMode == 0

figure;

plot(frequencyAxis,fftMagnitude,'LineWidth',1.5);

title('Frequency Spectrum');

xlabel('Frequency (Hz)');

ylabel('Magnitude');

grid on;

end