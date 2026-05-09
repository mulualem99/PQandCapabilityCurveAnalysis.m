%EE516 Powersystems Power System PQ Curve Analysis 
%Name: Mulualem Ayena 
clc; clear; close all;

% Given data
xs    = 2;              % pu
vpu   = 1;              % pu
ppu   = 0;              % pu
Ifnl  = 1000;           % A
Sbase = 1000e6;         % VA
Vbase = 24e3;           % V line-to-line RMS

% Base current
Ibase = Sbase / (sqrt(3)*Vbase);

% From part (a), use same maximum field current range
theta = acos(0.8);
eaf_max = abs(vpu + 1j*xs*exp(-1j*theta));
If_max  = Ifnl * eaf_max;

% eaf range from 0 to eaf_max
eaf = linspace(0, eaf_max, 400);

% For zero real power: delta = 0
delta = 0;

% Reactive power
qpu = (vpu/xs) .* (eaf*cos(delta) - vpu);

% Armature current magnitude in pu
ia_pu = abs(qpu);

% Convert to RMS amperes
Ia = Ibase * ia_pu;

% Field current
If = Ifnl * eaf;

% Plot
figure;
plot(If, Ia, 'b', 'LineWidth', 1.2);
grid on;
xlabel('Field Current, A');
ylabel('Armature Current Magnitude, A RMS');
title('part d');

