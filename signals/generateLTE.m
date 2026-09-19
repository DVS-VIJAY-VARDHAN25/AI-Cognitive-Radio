function SignalData = generateLTE()

% Always locate the project root
thisFile = mfilename('fullpath');
signalsFolder = fileparts(thisFile);
projectRoot = fileparts(signalsFolder);

addpath(genpath(projectRoot));
%==========================================
% Load Project Configuration
%==========================================

config = projectConfig();

%==========================================
% Create Empty Signal Structure
%==========================================

SignalData = createSignalData();

%==========================================
% LTE Parameters
%==========================================

N = 128;                  % Number of subcarriers
cpLength = 32;            % Cyclic Prefix Length
numSymbols = 20;          % Number of OFDM Symbols

%==========================================
% Generate Random Binary Data
%==========================================

bits = randi([0 1],N*2,numSymbols);

disp('Generated LTE Bits');

SignalData.bits = bits;

%==========================================
% QPSK Mapping
%==========================================

symbols = (2*bits(1:2:end,:)-1) + ...
          1j*(2*bits(2:2:end,:)-1);

SignalData.symbols = symbols;

%==========================================
% Generate LTE OFDM Signal
%==========================================

lteSignal = [];

for k = 1:numSymbols

    X = symbols(:,k);

    x = ifft(X);

    cp = x(end-cpLength+1:end);

    tx = [cp; x];

    lteSignal = [lteSignal; tx];

end

lteSignal = real(lteSignal(:));

%==========================================
% Store Signal
%==========================================

SignalData.signal = lteSignal;

SignalData.signalName = 'LTE';

SignalData.modulation = 'LTE OFDM';

SignalData.centerFrequency = config.LTECarrier;

SignalData.time = (0:length(lteSignal)-1)/config.Fs;

SignalData.Fs = config.Fs;

%==========================================
% Plot LTE Signal
%==========================================
if config.trainingMode == 0
figure;

plot(SignalData.time,lteSignal,'LineWidth',1.2);

grid on;

title('Generated LTE Signal');

xlabel('Time (s)');

ylabel('Amplitude');
end
%==========================================
% LTE Constellation
%==========================================
if config.trainingMode == 0
figure;

scatter(real(symbols(:)),imag(symbols(:)),40,'filled');

grid on;

axis equal;

title('LTE QPSK Constellation');

xlabel('In-Phase');

ylabel('Quadrature');
end
%==========================================
% Display Information
%==========================================

disp('Length of LTE Signal:');
disp(length(lteSignal));

disp('Carrier Frequency (Hz):');
disp(config.LTECarrier);

%==========================================
% Process Signal
%==========================================

disp(' ');
disp('Processing LTE Signal...');

SignalData = processSignal(SignalData);

disp('Processing Completed Successfully');

disp('LTE Signal Generated Successfully');

end