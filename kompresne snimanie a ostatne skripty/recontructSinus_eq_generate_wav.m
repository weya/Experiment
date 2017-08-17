%% Rekonstrukcia sinusoidy

%modifikacia oproti 'recontructSinus_eq' nacitanie 200ms useku z wav
%vyber nahodnych vzoriek, rekonstrukcia a vygenerovanie wav suboru

clear all;
%clc;

path(path, '\Optimization');
filename_rec = '..\generovanie multikanaloveho zvuku\vygenerovane subory\rec_100_300_500_700_mono.wav';
load_start = 56668; %vyber 200ms useku = 8820 vzoriek
load_end = 65487;
[sinus,Fs] = audioread(filename_rec, [load_start,load_end]);
sinus = sinus';

n = length(sinus);

%% Matica merania
% Nahodne vzorkovanie
% pocet vzoriek
k = 200;

% velkost sumu
sigma = 0;

% randsample vyzaduje statistics toolbook
%ii = sort(randsample(1:n,k));

% Nahrada randsample
ii = zeros(1,k);
for i=1:k
    while 1
        pom = floor(1+n*rand);
        if (~ismember(pom, ii))
            ii(i) = pom;
            break
        end
    end
end

I = sort(ii);

% Bazou je inverzna DFT (n x n)
DFTbasis = conj(dftmtx(n))/n;

% Vyber riadkov matice prisluchajucich nahodnemu vzorkovaniu    (k x n)
global A;
for i=1:k
    A(i,:) = DFTbasis(I(i),:);
end

%% l1 minimalizacia

% Pomocne funkcie
% vypocet Ax a A'x

Afun = @(x) func(1,x);
Atfun = @(x) func(2,x);

% sum
e = sigma*randn(1,k);

% Vyber nahodnych vzoriek zo signalu (observations)
yy = sinus(I) + e;

% initial guess = min energy
x0 = Atfun(yy);

% solve the LP
tic
xp = l1eq_pd(x0, Afun, Atfun, yy(:), 1e-3, 30, 1e-8, 200);
toc

n = length(xp);
x_os = 1:1:200;%linspace(0,400);
figure;
subplot(2,3,1); 
plot(sinus);
axis([0 n/2 -1 1]);
title('Originalny signal');

%prerobenie realneho vektora na komplexny
re = xp(1:n/2);
im = xp(n/2+1:n);
z = re + sqrt(-1)*im;
rec = real(ifft(z))';

F=fft(sinus);
pow=F.*conj(F);
total_pow1=sum(pow);

% Vykreslenie
subplot(2,3,2); 
plot(real(ifft(z)));
%plot(x_os,sinus,x_os,real(ifft(z))); 
axis([0 n/2 -1 1]);
title('Rekonstruovany signal');

%generovanie wav suboru
reconstructed_sinus = (real(ifft(z)))';
filename_gen = '..\rekonstrukcie priklady\\rekonstrukcia.wav';
audiowrite(filename_gen,reconstructed_sinus,Fs);

pow_2=z.*conj(real(z));
total_pow2=sum(pow_2);
POW=real(total_pow2)-total_pow1;

subplot(2,3,3); 
plot(sinus - rec);
% plot(sinus(:) - real(ifft(z)));
title('Rozdiel signalov');

%stredná absolútna odchýlka
err = mean(abs(sinus - rec));

subplot(2,3,4); 
pom = abs(fft(sinus)); 
plot(pom(1:n/4));
title('Originalna DFT');

subplot(2,3,5); 
plot(abs(z(1:n/4)));
title('Rekonstruovana DFT');

subplot(2,3,6); 
pom = abs(fft(sinus(:))) - abs(z);
plot(pom(1:n/4));
title('Rozdiel DFT');
