addpath(genpath(pwd));
clc;
clear;
close all;

%==========================================
% Load Project Configuration
%==========================================

config = projectConfig();

disp('===========================================');
disp(config.projectName);
disp(['Version : ' config.version]);
disp(['Author  : ' config.author]);
disp('===========================================');

while true

    disp(' ');
    disp('1. Generate Communication Signal');
    disp('2.Multi-Channel Simulation');
    disp('2. Exit');

    choice = input('Select Option : ');

    disp(choice)
    class(choice)

    switch choice

        case 1

            disp(' ');
            disp('Choose Signal');
            disp('-------------------------');
            disp('1. BPSK');
            disp('2. QPSK');
            disp('3. AM');
            disp('4. FM');
            disp('5. 16-QAM');
            disp('6. OFDM');
            disp('7. Bluetooth');
            disp('8. LTE');
            disp('9. 5G');
            disp('-------------------------');

            signalChoice = input('Enter Choice : ');

            disp(' ');
          switch signalChoice

    case 1
        disp(' ');
        disp('Generating BPSK Signal...');
        SignalData = generateBPSK();

    case 2
        disp(' ');
        disp('Generating QPSK Signal...');
        SignalData = generateQPSK();

    case 3
        disp(' ');
        disp('Generating AM Signal...');
        SignalData = generateAM();

    case 4
        disp(' ');
        disp('Generating FM Signal...');
        SignalData = generateFM();

    case 5
        disp(' ');
        disp('Generating 16-QAM Signal...');
        SignalData = generateQAM16();

    case 6
        disp(' ');
        disp('Generating OFDM Signal...');
        SignalData = generateOFDM();

    case 7
        disp(' ');
        disp('Generating Bluetooth Signal...');
        SignalData = generateBluetooth();

  case 8 
       disp(' '); 
       disp('Generating LTE Signal...'); 
       SignalData = generateLTE(); 
   case 9 
       disp(' '); 
       disp('Generating 5G Signal...');
       SignalData = generate5G();


    otherwise
        disp('Invalid Choice');

          end
    case 2

        disp(' ');
        disp('========== MULTI CHANNEL ==========');

        Channels = createChannels();
        Channels = scanSpectrum(Channels);
        Channels = processChannels(Channels);
        Channels = detectChannels(Channels);

        disp('Multi-Channel Simulation Completed.');

     case 3

            disp(' ');
            disp('Closing AI Cognitive Radio Platform...');
            break;

        otherwise

            disp(' ');
            disp('Invalid Choice');

    end

end