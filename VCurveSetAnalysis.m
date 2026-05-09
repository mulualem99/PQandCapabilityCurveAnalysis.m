%EE516 Powersystems Power System PQ Curve Analysis 
%Name: Mulualem Ayena 
clc; clear; close all;

% Given data
xs    = 2;                   % pu
vpu   = 1;                   % pu
Ifnl  = 1000;                % A
Sbase = 1000e6;              % VA
Vbase = 24e3;                % V line-to-line RMS

% Base current
Ibase = Sbase / (sqrt(3)*Vbase);

% Maximum field current from part (a), rated VA and pf = 0.8 lagging
theta = acos(0.8);
eaf_max = abs(vpu + 1j*xs*exp(-1j*theta));
If_max  = Ifnl * eaf_max;

% Real power values
ppu_values = [0.01 0.2 0.4 0.6 0.8];

figure;
hold on;
grid on;

for k = 1:length(ppu_values)
    
    ppu = ppu_values(k);
    
    % delta min and max
    delta_min = asin(ppu*xs/(vpu*eaf_max));
    delta_max = pi/2;
    
    % delta array
    delta = linspace(delta_min, delta_max, 400);
    
    % eaf from constant power equation
    eaf = (ppu*xs) ./ (vpu*sin(delta));
    
    % reactive power
    qpu = (vpu/xs) .* (eaf.*cos(delta) - vpu);
    
    % armature current in pu
    ia_pu = sqrt(ppu.^2 + qpu.^2);
    
    % convert to amperes
    Ia = Ibase * ia_pu;
    
    % field current
    If = Ifnl * eaf;
    
    % plot each curve
    plot(If, Ia, 'LineWidth', 1.2);
end

xlabel('Field Current, A');
ylabel('Armature Current Magnitude, A RMS');
title('part e');
legend('p = 0.01 pu','p = 0.2 pu','p = 0.4 pu','p = 0.6 pu','p = 0.8 pu', ...
       'Location','northwest');
