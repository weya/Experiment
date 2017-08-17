%% Spracovanie vysledkov simulacie
% vstup - RMS.mat
% vystup - 3D graf

clc;

load RMS.mat;

% pocet vyberanych vzoriek
kk = [50 100 150 200];
KP = [88 44 29 22];
% amplituda sumu
sigma = [0.001 0.01 0.05 0.5];
SNR=[-0.0244  -10.0244  -17.0141  -27.0141];

% vypocet priemerov
rms = zeros(length(kk),length(sigma));
for i=1:length(kk)
    for j=1:length(sigma)
        rms(i,j)=mean(RMS_rec(i,j,:));
    end
end

figure;
% h = surf(KP,SNR,rms);
h = surf(kk,SNR,rms);
shading interp;                 % hladke prechody farieb
set(h, 'edgecolor','black');    % zobrazenie siete
xlabel('Kompresný pomer');
%xlabel('Poèet vybratých vzoriek');
ylabel('SNR');
zlabel('MSE');
colormap(hsv);
