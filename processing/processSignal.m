function SignalData = processSignal(SignalData)

%SignalProcessing
SignalData = calculateFFT(SignalData);
SignalData = calculatePSD(SignalData);
SignalData = calculateEnergy(SignalData);
SignalData = calculateAveragePower(SignalData);
SignalData = calculatePeakPower(SignalData);
SignalData = calculatePeakToPeak(SignalData);
SignalData = calculatePeakFrequency(SignalData);
SignalData = calculateBandwidth(SignalData);
SignalData = calculateNoiseFloor(SignalData);
SignalData = calculateSNR(SignalData);

%Detection
SignalData = thresholdDetector(SignalData);
SignalData = energyDetector(SignalData);
SignalData = signalPresence(SignalData);
SignalData = occupancyDecision(SignalData);
SignalData = channelRecommendation(SignalData);
SignalData = spectrumOccupancyMap(SignalData);
SignalData = decisionReport(SignalData);


%Feature Extraction
SignalData = extractFeatures(SignalData);
SignalData = featureVector(SignalData);
SignalData = normalizeFeatures(SignalData);
end