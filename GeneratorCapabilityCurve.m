%EE516 Powersystems Power System PQ Curve Analysis 
%Name: Mulualem Ayena 
clc; clear; close all; 

% Given data
xs = 2;
v  = 1;
i  = 1;
p_r = 0.8;
q_r = 0.6;

% Rated point from the pu formulas
eaf = sqrt((2*q_r + 1)^2 + (2*p_r)^2);
delta_r = atan2(2*p_r, 2*q_r + 1);   % about 36.0 deg

% FIELD CURRENT LIMIT
delta = linspace(0, delta_r, 800);
Pf = (v*eaf/xs).*sin(delta);
Qf = (v/xs).*(eaf*cos(delta) - v);

% ARMATURE CURRENT LIMIT 
theta_min = -asin(v*i/xs);
theta = linspace(delta_r, theta_min, 800);
Pa = v*i*cos(theta);
Qa = v*i*sin(theta);

%FORCE AT RATED POINT
Pf(end) = p_r;
Qf(end) = q_r;
Pa(1)   = p_r;
Qa(1)   = q_r;

% Stability limit endpoint from lower end of armature-current limit
P_stab_end = Pa(end);
Q_stab = Qa(end);

figure('Color','k');
hold on;
axis equal;
axis off;

% Left vertical axis
plot([0 0],[Q_stab-0.15, max(Qf)+0.15],'g','LineWidth',2);

% Middle horizontal line
plot([0 1],[0 0],'g','LineWidth',2);

% Stability limit 
plot([0 P_stab_end],[Q_stab Q_stab],'g','LineWidth',2);

% Diagonal line to rated point
plot([0 p_r],[Q_stab q_r],'g','LineWidth',2);

% Arrowhead at rated point
Lh = 0.045;
ang = atan2(q_r - Q_stab, p_r);
phi = pi/7;

xA = p_r - Lh*cos(ang - phi);
yA = q_r - Lh*sin(ang - phi);
xB = p_r - Lh*cos(ang + phi);
yB = q_r - Lh*sin(ang + phi);

plot([xA p_r],[yA q_r],'g','LineWidth',2);
plot([xB p_r],[yB q_r],'g','LineWidth',2);

% 1000 MVA double arrow
y_arrow = Q_stab - 0.28;
plot([0 1],[y_arrow y_arrow],'g','LineWidth',1.5);
plot([0 0.03],[y_arrow y_arrow+0.015],'g','LineWidth',1.5);
plot([0 0.03],[y_arrow y_arrow-0.015],'g','LineWidth',1.5);
plot([1 0.97],[y_arrow y_arrow+0.015],'g','LineWidth',1.5);
plot([1 0.97],[y_arrow y_arrow-0.015],'g','LineWidth',1.5);

% Curves
plot(Pf,Qf,'g','LineWidth',2);   % Field current limit
plot(Pa,Qa,'g','LineWidth',2);   % Armature current limit

% Labels
text(0.20, max(Qf)+0.05, 'Field Current Limit', 'Color', 'b', 'FontSize', 12);
text(0.95, 0.25, 'Armature Current Limit', 'Color', 'b', 'FontSize', 12);
text(0.52, Q_stab-0.10, 'Stability Limit', 'Color', 'b', 'FontSize', 12);
text(0.32, y_arrow-0.06, '1000 MVA', 'Color', 'b', 'FontSize', 12);

xlim([-0.05 1.25]);
ylim([Q_stab-0.35, max(Qf)+0.18]);

hold off;