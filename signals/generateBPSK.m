function SignalData = generateBPSK()

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
% Generate Random Binary Data
%==========================================

numberOfBits = 100;

bits = randi([0 1],1,numberOfBits);

disp('Generated Binary Data');
disp(bits);
%==========================================
% Convert Bits to BPSK Symbols
%==========================================

symbols = 2*bits - 1;

disp(' ');
disp('BPSK Symbols');
disp(symbols);
% Save Data into SignalData Structure
SignalData.bits = bits;
SignalData.symbols = symbols;
%==========================================
% Generate Time Vector
%==========================================

t = 0:1/config.Fs:config.signalDuration-1/config.Fs;

% Save Time

SignalData.time = t;

SignalData.Fs = config.Fs;
%==========================================
% Generate Carrier Wave
%==========================================

carrier = cos(2*pi*config.BPSKCarrier*t);
SignalData.carrier = carrier;

%==========================================
% Generate BPSK Signal
%==========================================

samplesPerBit = floor(length(t)/numberOfBits);

bpskSignal = [];

for k = 1:numberOfBits

    bitWave = symbols(k) * ones(1,samplesPerBit);

    carrierSegment = carrier((k-1)*samplesPerBit+1:k*samplesPerBit);

    bpskSignal = [bpskSignal bitWave .* carrierSegment];

end

%==========================================
% Add Random Noise (for AI training)
%==========================================

snrValue = randi([10 35]);      % Random SNR between 10 and 35 dB

bpskSignal = awgn(bpskSignal, snrValue, 'measured');

%==========================================
% Store BPSK Signal
%==========================================

SignalData.signal = bpskSignal;

SignalData.signalName = 'BPSK';

SignalData.modulation = 'Binary Phase Shift Keying';

SignalData.centerFrequency = config.BPSKCarrier;

%==========================================
% Plot BPSK Signal
%==========================================

disp('Length of Time Vector:');
disp(length(t));

disp('Length of Carrier:');
disp(length(carrier));

disp('Samples Per Bit:');
disp(samplesPerBit);

disp('Length of BPSK Signal:');
disp(length(bpskSignal));

if config.trainingMode == 0
figure;
plot(t(1:length(bpskSignal)), bpskSignal,'LineWidth',1.2);
grid on;

title('Generated BPSK Signal');

xlabel('Time (s)');

ylabel('Amplitude');
end
%%=========================================
% Process Complete Signal
%==========================================

disp(' ');
disp('Processing Signal...');

SignalData = processSignal(SignalData);
disp(isfield(SignalData,'featureVector'))
disp(size(SignalData.featureVector))

disp('Processing Completed Successfully');
