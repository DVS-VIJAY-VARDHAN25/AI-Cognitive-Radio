function SignalData = generate5G()
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
% Load Project Configuration
%==========================================

config = projectConfig();
%==========================================
% Create Empty Signal Structure
%==========================================

SignalData = createSignalData();

%==========================================
% 5G Parameters
%==========================================

N = 256;                 % Number of Subcarriers

cpLength = 64;           % Cyclic Prefix Length

numSymbols = 20;         % Number of OFDM Symbols

%==========================================
% Generate Random Binary Data
%==========================================

bits = randi([0 1],N*2,numSymbols);

disp('Generated 5G Bits');
disp(bits);

SignalData.bits = bits;

%==========================================
% QPSK Symbol Mapping
%==========================================

symbols = (2*bits(1:2:end,:)-1) + ...
          1j*(2*bits(2:2:end,:)-1);

SignalData.symbols = symbols;

%==========================================
% Generate 5G OFDM Signal
%==========================================

fiveGSignal = [];

for k = 1:numSymbols

    X = symbols(:,k);

    x = ifft(X);

    cp = x(end-cpLength+1:end);

    tx = [cp; x];

    fiveGSignal = [fiveGSignal; tx];

end

fiveGSignal = real(fiveGSignal(:));

%==========================================
% Store Signal
%==========================================

SignalData.signal = fiveGSignal;

SignalData.signalName = '5G';

SignalData.modulation = '5G New Radio (OFDM)';

SignalData.centerFrequency = config.FiveGCarrier;

SignalData.time = (0:length(fiveGSignal)-1)/config.Fs;

SignalData.Fs = config.Fs;

%==========================================
% Plot Time Domain Signal
%==========================================
if config.trainingMode == 0
figure;

plot(SignalData.time,fiveGSignal,'LineWidth',1.2);

grid on;

title('Generated 5G Signal');

xlabel('Time (s)');

ylabel('Amplitude');
end
%==========================================
% Plot Constellation
%==========================================
if config.trainingMode == 0
figure;

scatter(real(symbols(:)),imag(symbols(:)),40,'filled');

grid on;

axis equal;

title('5G QPSK Constellation');

xlabel('In-Phase');

ylabel('Quadrature');
end
%==========================================
% Display Information
%==========================================

disp(' ');

disp('Length of 5G Signal:');
disp(length(fiveGSignal));

disp('Carrier Frequency (Hz):');
disp(config.FiveGCarrier);

%==========================================
% Process Complete Signal
%==========================================

disp(' ');
disp('Processing 5G Signal...');

SignalData = processSignal(SignalData);

disp('Processing Completed Successfully');

disp('5G Signal Generated Successfully');

end