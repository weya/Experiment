%% Vykreslenie troch vseobecnych hyperbol
% vypocet casov a vzdialenosti zo zaciatku impulzov

%% definicia parametrov
% ohniska hyperbol (umiestnenie reproduktorov)
% repraky vzdialene od stien
V1 = [0.6; 0];
V2 = [2.55; 0];
V3 = [0.6; 5.45];
V4 = [2.6; 5.45];

% zaciatky impulzov ziskane z analyzy nahraneho zvuku (cisla vzoriek)
t1 = 33978;
t2 = 47224;
t3 = 60015;
t4 = 73272;

% posun vo vysielani jednotlivych signalov
delta = 13230;
% frekvencia vzorkovania
FVZ = 44100

% rychlost zvuku (suchy vzduch, 25 stupnov) [m/s]
v = 346;

% vypocet rozdielov (TDOA) - v sekundach
t12 = (t2-t1-delta)/FVZ;
t13 = (t3-t1-2*delta)/FVZ;
t14 = (t4-t1-3*delta)/FVZ;

% TDOA [s] prepocitane na vzdialenost [m]
d12 = t12 * v;
d13 = t13 * v;
d14 = t14 * v;

% rozsah parametra pre vykreslenie jednotlivych hyperbol
p1 = 2.4;
p2 = 1;
p3 = 1;

%% vykreslenie hyperbol

figure(1);
hold on
% Prehodenie osi Y, aby obrazok zodpovedal skutocnosti
set(gca,'Ydir','reverse');

%% hyperbola pre V1 a V2
F1 = V1;
F2 = V2;
a = d12 / 2;    % parameter hyperboly
c = sqrt((F1(1)-F2(1))^2+(F1(2)-F2(2))^2)/2;     % polovica vzdialenosti ohnisk
b = sqrt(c*c-a*a);

f0 = (F1 + F2)/2;       % stred
f1 = (F1 - f0) * a/c;   % vrchol hyperboly
f2 = [-f1(2); f1(1)] * b/a;   % tangentovy vektor v danom bode (vo vrchole) (v nasom pripade kolmy na f1)

t = linspace(-p1,p1,1001); 

x1 = f1* cosh(t) + f2*sinh(t);      % kladna cast
x2 = -f1* cosh(t) + f2*sinh(t);     % zaporna cast

plot(x1(1,:) + f0(1),x1(2,:) + f0(2),'r');   % vykreslenie aj s posunom stredu - kladna cast
plot(x2(1,:) + f0(1),x2(2,:) + f0(2),'r');   % vykreslenie aj s posunom stredu - zaporna cast

%% hyperbola pre V1 a V3
F1 = V1;
F2 = V3;
a = d13 / 2;    % parameter hyperboly
c = sqrt((F1(1)-F2(1))^2+(F1(2)-F2(2))^2)/2;     % polovica vzdialenosti ohnisk
b = sqrt(c*c-a*a);

f0 = (F1 + F2)/2;       % stred
f1 = (F1 - f0) * a/c;   % vrchol hyperboly
f2 = [-f1(2); f1(1)] * b/a;   % tangentovy vektor v danom bode (vo vrchole) (v nasom pripade kolmy na f1)

t = linspace(-p2,p2,1001); 

x1 = f1* cosh(t) + f2*sinh(t);      % kladna cast
x2 = -f1* cosh(t) + f2*sinh(t);     % zaporna cast

figure(1);
hold on
plot(x1(1,:) + f0(1),x1(2,:) + f0(2),'g');   % vykreslenie aj s posunom stredu - kladna cast
plot(x2(1,:) + f0(1),x2(2,:) + f0(2),'g');   % vykreslenie aj s posunom stredu - zaporna cast

%% hyperbola pre V1 a V4
F1 = V1;
F2 = V4;
a = d14 / 2;    % parameter hyperboly
c = sqrt((F1(1)-F2(1))^2+(F1(2)-F2(2))^2)/2;     % polovica vzdialenosti ohnisk
b = sqrt(c*c-a*a);

f0 = (F1 + F2)/2;       % stred
f1 = (F1 - f0) * a/c;   % vrchol hyperboly
f2 = [-f1(2); f1(1)] * b/a;   % tangentovy vektor v danom bode (vo vrchole) (v nasom pripade kolmy na f1)

t = linspace(-p3,p3,1001); 

x1 = f1* cosh(t) + f2*sinh(t);      % kladna cast
x2 = -f1* cosh(t) + f2*sinh(t);     % zaporna cast

figure(1);
hold on
plot(x1(1,:) + f0(1),x1(2,:) + f0(2),'b');   % vykreslenie aj s posunom stredu - kladna cast
plot(x2(1,:) + f0(1),x2(2,:) + f0(2),'b');   % vykreslenie aj s posunom stredu - zaporna cast

%% Vykreslenie pozicie reproduktorov
hold on
plot(V1(1),V1(2),'ko','MarkerSize',4,'lineWidth',2,'MarkerFaceColor','k');
plot(V2(1),V2(2),'ko','MarkerSize',4,'lineWidth',2,'MarkerFaceColor','k');
plot(V3(1),V3(2),'ko','MarkerSize',4,'lineWidth',2,'MarkerFaceColor','k');
plot(V4(1),V4(2),'ko','MarkerSize',4,'lineWidth',2,'MarkerFaceColor','k');

% vrchol paraboly 1-4
%plot(f0(1)+f1(1),f0(2)+f1(2),'b+','MarkerSize',8,'lineWidth',2);
hold off
