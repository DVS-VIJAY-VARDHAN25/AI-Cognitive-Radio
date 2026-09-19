function prepareDataset()

clc;
clear;


addpath(genpath(pwd));
disp('======================================');
disp(' AI Cognitive Radio Dataset Generator ');
disp('======================================');

samplesPerSignal = 100;

FeatureMatrix = [];
Labels = {};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BPSK
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('Generating BPSK Dataset...');

for i = 1:samplesPerSignal

    SignalData = generateBPSK();

    FeatureMatrix = [FeatureMatrix;
                     SignalData.featureVector'];

    Labels = [Labels;"BPSK"];

end
disp(['After BPSK : ' num2str(size(FeatureMatrix,1))]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% QPSK
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('Generating QPSK Dataset...');

for i = 1:samplesPerSignal

    SignalData = generateQPSK();

    FeatureMatrix = [FeatureMatrix;
                     SignalData.featureVector'];

    Labels = [Labels;"QPSK"];

end
disp(['After QPSK : ' num2str(size(FeatureMatrix,1))]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('Generating AM Dataset...');

for i = 1:samplesPerSignal

    SignalData = generateAM();

    FeatureMatrix = [FeatureMatrix;
                     SignalData.featureVector'];

    Labels = [Labels;"AM"];

end
disp(['After AM : ' num2str(size(FeatureMatrix,1))]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('Generating FM Dataset...');

for i = 1:samplesPerSignal

    SignalData = generateFM();

    FeatureMatrix = [FeatureMatrix;
                     SignalData.featureVector'];

    Labels = [Labels;"FM"];

end
disp(['After FM : ' num2str(size(FeatureMatrix,1))]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 16-QAM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('Generating QAM16 Dataset...');

for i = 1:samplesPerSignal

    SignalData = generateQAM16();

    FeatureMatrix = [FeatureMatrix;
                     SignalData.featureVector'];

    Labels = [Labels;"QAM16"];

end
disp(['After QAM16 : ' num2str(size(FeatureMatrix,1))]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OFDM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('Generating OFDM Dataset...');

for i = 1:samplesPerSignal

    SignalData = generateOFDM();

    FeatureMatrix = [FeatureMatrix;
                     SignalData.featureVector'];

    Labels = [Labels;"OFDM"];

end
disp(['After OFDM : ' num2str(size(FeatureMatrix,1))]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bluetooth
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('Generating Bluetooth Dataset...');

for i = 1:samplesPerSignal

    SignalData = generateBluetooth();

    FeatureMatrix = [FeatureMatrix;
                     SignalData.featureVector'];

    Labels = [Labels;"Bluetooth"];

end
disp(['After Bluetooth : ' num2str(size(FeatureMatrix,1))]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LTE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('Generating LTE Dataset...');

for i = 1:samplesPerSignal

    SignalData = generateLTE();

    FeatureMatrix = [FeatureMatrix;
                     SignalData.featureVector'];

    Labels = [Labels;"LTE"];

end
disp(['After LTE : ' num2str(size(FeatureMatrix,1))]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5G
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('Generating 5G Dataset...');

for i = 1:samplesPerSignal

    SignalData = generate5G();

    FeatureMatrix = [FeatureMatrix;
                     SignalData.featureVector'];

    Labels = [Labels;"5G"];

end
disp(['After 5G : ' num2str(size(FeatureMatrix,1))]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create Dataset Table
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp(size(FeatureMatrix));
disp(length(Labels));

Dataset = array2table(FeatureMatrix);
fprintf('\nFeatureMatrix rows = %d\n', size(FeatureMatrix,1));
fprintf('Labels = %d\n', length(Labels));

Dataset.Properties.VariableNames = {

'Energy'
'AveragePower'
'PeakPower'
'PeakToPeak'
'PeakFrequency'
'Bandwidth'
'NoiseFloor'
'SNR'

};

%Dataset.Label = Labels;

fprintf('Dataset rows = %d\n', height(Dataset));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Save Dataset
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save('TrainingDataset.mat','Dataset');

writetable(Dataset,'TrainingDataset.csv');

disp(' ');
disp('======================================');
disp(' Dataset Created Successfully ');
disp('======================================');

disp(['Total Samples : ' num2str(height(Dataset))]);

disp(' ');
disp('First 10 Samples');

disp(Dataset(1:10,:));

end