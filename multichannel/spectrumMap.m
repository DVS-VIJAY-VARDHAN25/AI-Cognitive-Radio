function spectrumMap(Channels)
config = projectConfig();

disp(' ');
disp('====================================');
disp('SPECTRUM OCCUPANCY MAP');
disp('====================================');


if config.trainingMode == 0
figure;
hold on;
grid on;

for i = 1:length(Channels)

    if Channels(i).Occupied

        bar(i,1,'r');

    else

        bar(i,1,'g');

    end

end

xlabel('Channel Number');

ylabel('Status');

title('Spectrum Occupancy Map');

xticks(1:length(Channels));

yticks([0 1]);

yticklabels({'Free','Occupied'});

hold off;

disp('Spectrum Map Generated');

end