function config = projectConfig()

%==========================================================
% AI Cognitive Radio Configuration File
%==========================================================

% Project Information
config.projectName = 'AI Cognitive Radio';
config.version = '0.1';
config.author = 'D.V.S. Vijay Vardhan';

%==========================================================
% Signal Parameters
%==========================================================

% Sampling Frequency (1 MHz)
config.Fs = 1e6;

% Signal Duration (10 milliseconds)
config.signalDuration = 0.01;

% Number of Samples
config.numberOfSamples = config.Fs * config.signalDuration;

%==========================================================
% Carrier Frequencies
%==========================================================

config.BPSKCarrier = 100e3;
config.QPSKCarrier = 150e3;
config.QAMCarrier = 200e3;
config.OFDMCarrier = 250e3;
config.AMCarrier        = 50e3;      
config.FMCarrier        = 75e3;      
config.BluetoothCarrier = 300e3;     
config.LTECarrier       = 350e3;     
config.FiveGCarrier     = 400e3;     

%==========================================================
% Bandwidths
%==========================================================

config.WiFiBandwidth = 20e6;
config.BluetoothBandwidth = 1e6;
config.LTEBandwidth = 10e6;
config.NRBandwidth = 100e6;

%==========================================================
% Noise Parameters
%==========================================================

config.defaultSNR = 20;
config.noisePower = 0.01;

%==========================================================
% Supported Signals
%==========================================================

config.supportedSignals = {
    'AM'
    'FM'
    'BPSK'
    'QPSK'
    '16QAM'
    'OFDM'
    'Bluetooth'
    'LTE'
    '5G'
};

config.trainingMode = 1;

end