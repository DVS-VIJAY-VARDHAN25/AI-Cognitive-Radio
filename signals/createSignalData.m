function SignalData = createSignalData()

%==========================================================
% Create Empty Signal Structure
%==========================================================

SignalData = struct();

% Basic Signal Information
SignalData.signal = [];
SignalData.time = [];
SignalData.Fs = [];
% Digital Communication Data
SignalData.bits = [];
SignalData.symbols = [];
SignalData.carrier = [];

% Signal Details
SignalData.signalName = '';
SignalData.modulation = '';

% RF Parameters
SignalData.centerFrequency = [];
SignalData.bandwidth = [];

% Analysis Parameters
SignalData.signalPower = [];
SignalData.noisePower = [];
SignalData.SNR = [];
SignalData.energy = [];

% FFT Results
SignalData.frequencyAxis = [];
SignalData.fftMagnitude = [];

% PSD 
SignalData.PSD = [];
SignalData.PSDFrequency = [];
%Energy 
SignalData.energy = [];
%Avg Power 
SignalData.averagePower = [];
%PeakPower
SignalData.peakPower = [];
%Peak TO Peak
SignalData.peakToPeak = [];
%peak Frequency
SignalData.peakFrequency = [];
% Bandwidth
SignalData.bandwidth = [];
%NoiseFloor

SignalData.noiseFloor = [];
%SNR
SignalData.SNR = [];

%==========================================
% Detection
%==========================================

SignalData.threshold = [];

SignalData.signalDetected = false;

SignalData.signalPresence = "";

SignalData.isOccupied = false;

SignalData.channelStatus = "";

SignalData.recommendedChannel = "";

%==================================
% Feature Extraction
%==================================

SignalData.features = struct();

SignalData.featureVector = [];

SignalData.normalizedFeatures = [];


% Recommendation
SignalData.recommendedChannel = '';

% Metadata
SignalData.timestamp = datetime('now');

end