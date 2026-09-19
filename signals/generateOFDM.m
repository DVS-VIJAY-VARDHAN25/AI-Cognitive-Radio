function SignalData = generateOFDM()

% Always locate the project root
thisFile = mfilename('fullpath');
signalsFolder = fileparts(thisFile);
projectRoot = fileparts(signalsFolder);

addpath(genpath(projectRoot));

disp("Current folder:");
disp(pwd)

disp("projectConfig exists?");
disp(exist('projectConfig','file'))
%==========================================
% Load Configuration
%==========================================

config = projectConfig();

SignalData = createSignalData();

%==========================================
% OFDM Parameters
%==========================================

N = 64;

cpLength = 16;

numSymbols = 20;

%==========================================
% Generate Random QPSK Symbols
%==========================================

bits = randi([0 1],N*2,numSymbols);

symbols = (2*bits(1:2:end,:)-1) + ...
          1j*(2*bits(2:2:end,:)-1);

%==========================================
% OFDM Modulation
%==========================================

ofdmSignal = [];

for k = 1:numSymbols

    X = symbols(:,k);

    x = ifft(X);

    cp = x(end-cpLength+1:end);

    tx = [cp; x];

    ofdmSignal = [ofdmSignal; tx];

end

ofdmSignal = real(ofdmSignal(:));

SignalData.signal = ofdmSignal;

SignalData.signalName = 'OFDM';

SignalData.modulation = 'Orthogonal Frequency Division Multiplexing';

SignalData.centerFrequency = config.OFDMCarrier;

SignalData.bits = bits;

SignalData.symbols = symbols;

SignalData.time = (0:length(ofdmSignal)-1)/config.Fs;

SignalData.Fs = config.Fs;

%==========================================
% Plot
%==========================================
if config.trainingMode == 0
figure;
plot(SignalData.time, ofdmSignal,'LineWidth',1.2);

grid on;
title('Generated OFDM Signal');
xlabel('Time (s)');
ylabel('Amplitude');
end
%==========================================
% Constellation
%==========================================
if config.trainingMode == 0
figure;
scatter(real(symbols(:)),imag(symbols(:)),'filled');
grid on;
axis equal;
title('OFDM QPSK Constellation');
xlabel('In-Phase');
ylabel('Quadrature');
end
disp('Length of OFDM Signal:');
disp(length(ofdmSignal));

%%=========================================
% Process Complete Signal
%==========================================

disp(' ');
disp('Processing Signal...');

SignalData = processSignal(SignalData);

disp('Processing Completed Successfully');

disp('OFDM Signal Generated Successfully');
disp('OFDM Signal Generated Successfully');

end