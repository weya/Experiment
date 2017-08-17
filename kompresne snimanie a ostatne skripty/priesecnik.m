function [x, y, d] = priesecnik(f1, f2)

% Hladanie prisecniku dvoch funkcii.
% Funkcie su zadane ako dvojrozmerne polia bodov, 
% musia mat aspon 1001 bodov

% Hladanie priesecniku x11 a x21
min = 1000;
mini = 1000;
minj = 1000;
for i = 1:1001
    m = 1000;
    for j=1:1001
        % vzdialenost bodov i a j
        d = (f1(1,i) - f2(1,j))^2 + (f1(2,i) - f2(2,j))^2;
        if d < m
            m = d;
            mi = i;
            mj = j;
        end
    end
    if m < min
        min = m;
        mini = mi;
        minj = mj;
    end
end

x = (f1(1,mini) + f2(1,minj))/2;
y = (f1(2,mini) + f2(2,minj))/2;
d = min;
