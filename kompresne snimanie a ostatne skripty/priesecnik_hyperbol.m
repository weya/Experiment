%% Hladanie priesecnika dvoch vseobecnych hyperbol
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

x11 = f1* cosh(t) + f2*sinh(t);      % kladna cast
x12 = -f1* cosh(t) + f2*sinh(t) + f0(2);     % zaporna cast

x11(1,:) = x11(1,:) + f0(1);
x11(2,:) = x11(2,:) + f0(2);
x12(1,:) = x12(1,:) + f0(1);
x12(2,:) = x12(2,:) + f0(2);

plot(x11(1,:),x11(2,:),'r');   % vykreslenie aj s posunom stredu - kladna cast
plot(x12(1,:),x12(2,:),'r');   % vykreslenie aj s posunom stredu - zaporna cast

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

x21 = f1* cosh(t) + f2*sinh(t);      % kladna cast
x22 = -f1* cosh(t) + f2*sinh(t);     % zaporna cast

x21(1,:) = x21(1,:) + f0(1);
x21(2,:) = x21(2,:) + f0(2);
x22(1,:) = x22(1,:) + f0(1);
x22(2,:) = x22(2,:) + f0(2);

figure(1);
hold on
plot(x21(1,:),x21(2,:),'g');   % vykreslenie aj s posunom stredu - kladna cast
plot(x22(1,:),x22(2,:),'g');   % vykreslenie aj s posunom stredu - zaporna cast

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

x31 = f1* cosh(t) + f2*sinh(t);      % kladna cast
x32 = -f1* cosh(t) + f2*sinh(t);     % zaporna cast

x31(1,:) = x31(1,:) + f0(1);
x31(2,:) = x31(2,:) + f0(2);
x32(1,:) = x32(1,:) + f0(1);
x32(2,:) = x32(2,:) + f0(2);

figure(1);
hold on
plot(x31(1,:),x31(2,:),'b');   % vykreslenie aj s posunom stredu - kladna cast
plot(x32(1,:),x32(2,:),'b');   % vykreslenie aj s posunom stredu - zaporna cast

%% Vykreslenie pozicie reproduktorov
hold on
plot(V1(1),V1(2),'ko','MarkerSize',4,'lineWidth',2,'MarkerFaceColor','k');
plot(V2(1),V2(2),'ko','MarkerSize',4,'lineWidth',2,'MarkerFaceColor','k');
plot(V3(1),V3(2),'ko','MarkerSize',4,'lineWidth',2,'MarkerFaceColor','k');
plot(V4(1),V4(2),'ko','MarkerSize',4,'lineWidth',2,'MarkerFaceColor','k');

% vrchol paraboly 1-4
%plot(f0(1)+f1(1),f0(2)+f1(2),'b+','MarkerSize',8,'lineWidth',2);

% priesecniky prvej a druhej hyperboly
[B1x, B1y, d1] = priesecnik(x11,x21);
[B2x, B2y, d2] = priesecnik(x12,x21);
[B3x, B3y, d3] = priesecnik(x11,x22);
[B4x, B4y, d4] = priesecnik(x12,x22);

% priesecniky prvej a tretej hyperboly
[B5x, B5y, d5] = priesecnik(x11,x31);
[B6x, B6y, d6] = priesecnik(x12,x31);
[B7x, B7y, d7] = priesecnik(x11,x32);
[B8x, B8y, d8] = priesecnik(x12,x32);

% priesecniky druhej a tretej hyperboly
[B9x, B9y, d9] = priesecnik(x21,x31);
[B10x, B10y, d10] = priesecnik(x22,x31);
[B11x, B11y, d11] = priesecnik(x21,x32);
[B12x, B12y, d12] = priesecnik(x22,x32);

% podmienecne vykreslenie priesecnikov
if d1<0.01
    plot(B1x,B1y,'ko','MarkerSize',2,'lineWidth',1,'MarkerFaceColor','k');
end
if d2<0.01
    plot(B2x,B2y,'ko','MarkerSize',2,'lineWidth',1,'MarkerFaceColor','k');
end
if d3<0.01
    plot(B3x,B3y,'ko','MarkerSize',2,'lineWidth',1,'MarkerFaceColor','k');
end
if d4<0.01
    plot(B4x,B4y,'ko','MarkerSize',2,'lineWidth',1,'MarkerFaceColor','k');
end
if d5<0.01
    plot(B5x,B5y,'ko','MarkerSize',2,'lineWidth',1,'MarkerFaceColor','k');
end
if d6<0.01
    plot(B6x,B6y,'ko','MarkerSize',2,'lineWidth',1,'MarkerFaceColor','k');
end
if d7<0.01
    plot(B7x,B7y,'ko','MarkerSize',2,'lineWidth',1,'MarkerFaceColor','k');
end
if d8<0.01
    plot(B8x,B8y,'ko','MarkerSize',2,'lineWidth',1,'MarkerFaceColor','k');
end
if d9<0.01
    plot(B9x,B9y,'ko','MarkerSize',2,'lineWidth',1,'MarkerFaceColor','k');
end
if d10<0.01
    plot(B10x,B10y,'ko','MarkerSize',2,'lineWidth',1,'MarkerFaceColor','k');
end
if d11<0.01
    plot(B11x,B11y,'ko','MarkerSize',2,'lineWidth',1,'MarkerFaceColor','k');
end
if d12<0.01
    plot(B12x,B12y,'ko','MarkerSize',2,'lineWidth',1,'MarkerFaceColor','k');
end

hold off
