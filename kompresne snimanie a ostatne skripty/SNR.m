%% Vypocet SNR v dB pre dany signal a rozptyl sumu (sigma)

clear all;
%clc;

file = '..\merania\03_scenar_C\V0002_ext2.wav';  % signal
% rozsah signalu
start = 155408;
koniec = 159818;

%rozptyl sumu
sigma = [0.001 0.01 0.05 0.5];

% nacitanie signalu
[signalSNR,Fs] = audioread(file,[start koniec]);
signalSNR = signalSNR';

% Vypocet SNR
for i=1:length(sigma)
    snr(i) = 10*log10(var(signalSNR)/sigma(i));
end

% vypis
snr