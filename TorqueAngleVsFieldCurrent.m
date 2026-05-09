%EE516 Powersystems Power System PQ Curve Analysis 
%Name: Mulualem Ayena Student 
clc; clear; close all;

% Given data
xs   = 2;        % pu
vpu  = 1;        % pu
ppu  = 0.8;      % pu
Ifnl = 1000;     % A

% From part (a): rated over-excited operation at pf = 0.8 lagging
theta = acos(0.8);                 % rad
ia    = 1;                         % pu
eaf_max = abs(vpu + 1j*xs*ia*exp(-1j*theta));
If_max  = Ifnl * eaf_max;

% Stability limit: delta = 90 deg
eaf_min = ppu*xs/vpu;
If_min  = Ifnl * eaf_min;

% Delta range from delta_min to delta_max
delta_min = asin(ppu*xs/(vpu*eaf_max));   % rad
delta_max = pi/2;                         % rad

% Create field current array
If = linspace(If_min, If_max, 400);
eaf = If / Ifnl;

% Compute delta as function of field current
delta = asin(ppu*xs ./ (vpu*eaf));   % rad
delta_deg = delta * 180/pi;          % degrees

% Plot
figure;
plot(If, delta_deg, 'b', 'LineWidth', 1.2);
grid on;
xlabel('per-unit, If');
ylabel('\delta, (degrees)');
title('part b');
