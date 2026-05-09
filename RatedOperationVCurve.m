%EE516 Powersystems Power System PQ Curve Analysis 
%Name: Mulualem Ayena 
clc; clear; close all;
% Given data
xs    = 2;              % pu
vpu   = 1;              % pu
ppu   = 0.8;            % pu
Ifnl  = 1000;           % A
Sbase = 1000e6;         % VA
Vbase = 24e3;           % V line-to-line RMS

% Base current
Ibase = Sbase / (sqrt(3)*Vbase);

% From part (a), rated over-excited operating point
theta = acos(0.8);                      % power factor angle
ia_pu = 1;                              % rated current = 1 pu
eaf_max = abs(vpu + 1j*xs*ia_pu*exp(-1j*theta));
If_max  = Ifnl * eaf_max;

% Stability limit
eaf_min = ppu*xs/vpu;                   % occurs at delta = 90 deg
If_min  = Ifnl * eaf_min;

% Create delta range from delta_min to delta_max
delta_min = asin(ppu*xs/(vpu*eaf_max));
delta_max = pi/2;

delta = linspace(delta_min, delta_max, 400);

% Compute eaf from constant power equation
eaf = (ppu*xs) ./ (vpu*sin(delta));

% Reactive power
qpu = (vpu/xs) .* (eaf.*cos(delta) - vpu);

% Armature current in pu
ia_pu = sqrt(ppu.^2 + qpu.^2);

% Convert to RMS amperes
Ia = Ibase * ia_pu;

% Field current
If = Ifnl * eaf;

% Plot
figure;
plot(If, Ia, 'b', 'LineWidth', 1.2);
grid on;
xlabel('Per-unit, If');
ylabel('I_a');
title('part c');
