%% Rekonstrukcia signalu - algoritmus s linearnymi podmienkami
% vypocet RMS pre rozne hodnoty poctu vzoriek a rozny sum
% statisticke vyhodnotenie vysledkov - opakovanie pokusu m - krat
% vsetky vypocty sa tykaju toho isteho signalu (burstu)

clear all;
clc;

path(path, './Optimization');

global A;

disp('Zaciname');

% nahravka
file_rec = '..\merania\03_scenar_C\V0002_ext2.wav';           
load_start = 155408;        % priblizny zaciatok burstu
dlzka = 4410;               % dlzka signalu (100 ms pre Fs = 44 100 Hz)

% nacitanie signalu
[signal,Fs] = audioread(file_rec, [load_start,load_start+dlzka-1]);
signal = signal';

n = length(signal);

% pocet opakovani
m = 1;
% pocet vyberanych vzoriek
kk = [50 100 150 200];
% amplituda sumu
%sigma = [0.005 0.01 0.02 0.05 0.1 0.2 0.5];
sigma = [0.001 0.01 0.05 0.1];

disp('Priprava bazy');
% Bazou je inverzna DFT (n x n)
DFTbasis = conj(dftmtx(n))/n;

% vektor casov
t = 1/Fs:1/Fs:n/Fs;

% Pomocne funkcie pre rekonstrukciu
% vypocet Ax a A'x
Afun = @(x) func(1,x);
Atfun = @(x) func(2,x);

% vektor pre ulozenie RMS po rekonstrukcii
RMS_rec = zeros(length(sigma),length(kk),m);

% dlzka vypoctu
casy = zeros(length(sigma),length(kk),m);

%% Hlavny cyklus - pre kazde sigma
for o=1:length(sigma)
    % pre kazde k
    for l=1:length(kk)
        % simulacia - opakovana m-krat
        A = zeros(kk(l),n);
        for j = 1:m
            disp([o l j]);
            disp('Vyber vzoriek');
            % Nahodne vzorkovanie (nahrada randsample, ktory vyzaduje statistics toolbook)
            ii = zeros(1,kk(l));
            for i=1:kk(l)
                while 1
                    pom = floor(1+n*rand);      % generovanie cisla
                    if (~ismember(pom, ii))     % cisla sa nesmu opakovat
                        ii(i) = pom;
                        break
                    end
                end
            end

            I = sort(ii);       % usporiadanie indexov vzoriek

            % Vyber riadkov matice prisluchajucich nahodnemu vzorkovaniu (k x n)
            for i=1:kk(l)
                A(i,:) = DFTbasis(I(i),:);
            end

            % l1 minimalizacia
            % pridanie sumu
            e = sigma(o)*randn(1,kk(l));

            % Vyber nahodnych vzoriek zo signalu (observations)
            yy = signal(I) + e;

            % prvotny odhad riesenia = min energy
            x0 = Atfun(yy);

            % riesenie LP
            tic;
            xp = l1eq_pd(x0, Afun, Atfun, yy(:), 1e-3, 30, 1e-8, 200);
            casy(o,l,j) = toc;

            disp(casy(o,l,j));

            %prerobenie realneho vektora na komplexny
            N = length(xp);
            re = xp(1:N/2);
            im = xp(N/2+1:N);
            z = re + sqrt(-1)*im;
    
            % rekonstruovany signal
            signal_rec = real(ifft(z));
    
            % vypocet RMS
            RMS_rec(o,l,j) = norm(signal-signal_rec')/sqrt(length(signal));
        end
    end
end

save RMS.mat RMS_rec;
save RMS_casy.mat casy;
