%EE516 Powersystems Power System PQ Curve Analysis 
%Name: Mulualem Ayena 
clc; clear; close all;

% Data
xs = 2; v = 1; ia = 1; pf = 0.8; Ifnl = 1000;
th = acos(pf);                  % power factor angle

% Phasors
V  = v;
Ia = ia*exp(-1j*th);            % lagging current
E  = V + 1j*xs*Ia;              % internal emf

% Results
eaf = abs(E);
delta = angle(E)*180/pi;
If = Ifnl*eaf;
psi = angle(E) - angle(Ia);     % lagging angle between Ia and E
psi_deg = psi*180/pi;

fprintf('eaf = %.4f pu\n', eaf);
fprintf('delta = %.4f deg\n', delta);
fprintf('If = %.4f A\n', If);
fprintf('psi = %.4f deg\n', psi_deg);

% Plot phasor diagram
figure; hold on; grid on; axis equal;
quiver(0,0,real(V),imag(V),0,'g','LineWidth',2);                  % V
quiver(0,0,real(Ia),imag(Ia),0,'b','LineWidth',2);                % Ia
quiver(real(V),imag(V),real(1j*xs*Ia),imag(1j*xs*Ia),0,'r','LineWidth',2); % jXsIa
quiver(0,0,real(E),imag(E),0,'c','LineWidth',2);                  % E

% angle marks
t1 = linspace(-th,0,50);
plot(0.25*cos(t1),0.25*sin(t1),'b');                              % theta

t2 = linspace(0,angle(E),50);
plot(0.4*cos(t2),0.4*sin(t2),'c');                                % delta

t3 = linspace(angle(Ia),angle(E),50);
plot(0.55*cos(t3),0.55*sin(t3),'m');                              % psi

% labels
text(real(V)/2,-0.06,'V');
text(real(Ia)/2,imag(Ia)/2-0.06,'I_a');
text(real(V)+real(1j*xs*Ia)/2,imag(1j*xs*Ia)/2,'jX_sI_a');
text(real(E)/2,imag(E)/2+0.06,'E_{af}');
text(0.18*cos(-th/2),0.18*sin(-th/2)-0.05,'\theta');
text(0.32*cos(angle(E)/2),0.32*sin(angle(E)/2)+0.03,'\delta');
text(0.58*cos((angle(Ia)+angle(E))/2),0.58*sin((angle(Ia)+angle(E))/2),'\psi');

xlabel('Real Axis'); ylabel('Imaginary Axis');
title('Part (a): Overexcited Phasor Diagram');
legend('V','I_a','jX_sI_a','E_{af}','Location','best');

xlim([0 3]);
ylim([-0.8 2]);
hold off