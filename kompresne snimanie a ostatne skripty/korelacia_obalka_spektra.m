%% Hladanie zaciatku pulzov pomocou korelacie

clear all;
%clc;

file_rec = './nahravky/03_scenar_C/V0005_ext2.wav';   % nahravka
file_orig1 = '1000Hz.wav';      % original (vysielany signal)
file_orig2 = '300Hz.wav';      % original (vysielany signal)
file_orig3 = '500Hz.wav';      % original (vysielany signal)
file_orig4 = '700Hz.wav';      % original (vysielany signal)

% pocet vzoriek medzi burstami
posun = 13230;

% load_start = 82800; %pre V0005_2mer.wav
load_start = 106722; %pre V0005_ext2.wav
% load_start = 96579; %pre V0005_ext1.wav
% load_start = 84760;
% priblizny zaciatok burstu
%dlzka = 8820;           % dlzka analyzy - 200 ms
dlzka = 5292;           % dlzka analyzy - 120 ms - kvoli odstraneniu odrazov
                        % dlzka by mala byt aspon taka ako dlzka burstu
                        % plus maximalny cas sirenia zvuku

%% Prvy signal
% nacitanie signalu
[signal1,Fs] = audioread(file_rec, [load_start,load_start+dlzka-1]);
signal1 = signal1';

% original
orig1 = audioread(file_orig1);
orig1 = orig1';

% krizova korelacia
r1 = xcorr(signal1, orig1);

% hladanie maxima
[m k] = max(abs(r1));
[zhora,zdola] = envelope(r1); %vytovrenie obalky spektra
[kolko,kde]=findpeaks(zhora, 'MinPeakProminence',2); %hladanie lokalnych maxim a treshold
k=kde(1);

% posun nahravky voci originalu
offset(1) = k-length(signal1);

%% Druhy signal
% nacitanie signalu
[signal2,Fs] = audioread(file_rec, [load_start+posun,load_start+posun+dlzka-1]);
signal2 = signal2';

% original
orig2 = audioread(file_orig2);
orig2 = orig2';

% krizova korelacia
r2 = xcorr(signal2, orig2);

% hladanie maxima
[m k] = max(abs(r2));
[zhora,zdola] = envelope(r2);
[kolko,kde]=findpeaks(zhora, 'MinPeakProminence',2);
k=kde(1);


% posun nahravky voci originalu
offset(2) = k-length(signal2);

%% Treti signal
% nacitanie signalu
[signal3,Fs] = audioread(file_rec, [load_start+2*posun,load_start+2*posun+dlzka-1]);
signal3 = signal3';

% original
orig3 = audioread(file_orig3);
orig3 = orig3';

% krizova korelacia
r3 = xcorr(signal3, orig3);

% hladanie maxima
[m k] = max(abs(r3));
[zhora,zdola] = envelope(r3);
[kolko,kde]=findpeaks(zhora, 'MinPeakProminence',2);
% k=4900;
k=kde(1);

% posun nahravky voci originalu
offset(3) = k-length(signal3);

%% Stvrty signal
% nacitanie signalu
[signal4,Fs] = audioread(file_rec, [load_start+3*posun,load_start+3*posun+dlzka-1]);
signal4 = signal4';

% original
orig4 = audioread(file_orig4);
orig4 = orig4';

% krizova korelacia
r4 = xcorr(signal4, orig4);

% hladanie maxima
[m k] = max(abs(r4));
[zhora,zdola] = envelope(r4);
[kolko,kde]=findpeaks(zhora, 'MinPeakProminence',2);
k=kde(1);

% posun nahravky voci originalu
offset(4) = k-length(signal4);

% vypis offsetov
(offset-offset(1))/44100
offset
