%% Generovanie signalu - sinus

clear all;

% pocet period
pocet_period = 70;
% frekvencia vzorkovania
FVZ = 44100;
% frekvencia sinusu
frekv = 700;
%frekv2 = 30;
% nuly pred
nuly_pred =0;
nuly_za = 0;

% velkost sumu
% zadava sa amplituda sumu s normalnym rozdelenim (0,1)
Asum = 0;

dlzka = pocet_period*FVZ/frekv;
sinus4ch = zeros(1,dlzka+nuly_pred+nuly_za);

% hlavny cylkus
for i=1:dlzka
    pom = sin(2*pi*frekv*i/FVZ);
    %pom2 = sin(2*pi*frekv2*i/FVZ);
    %sum = Asum * randn;
    %sinus(nuly_pred+i)=pom+pom2+sum;
    %sinus(nuly_pred+i)=sinus+sum;
    sinus(nuly_pred+i)=pom;
end

% okno
okno = [zeros(1,nuly_pred) (chebwin(length(sinus)-nuly_pred-nuly_za)') zeros(1,nuly_za)];
sinus = sinus.*okno;

% ulozenie matice
save sinus2.mat sinus4ch FVZ frekv;

% vykreslenie
figure;
subplot(1,2,1); 
plot(sinus);
xlabel('n','FontSize',12);
ylabel('amplit�da','FontSize',12); 

subplot(1,2,2); 
plot(abs(fft(sinus)));
xlabel('n','FontSize',12);
ylabel('|DFT(y(n))|','FontSize',12); 
