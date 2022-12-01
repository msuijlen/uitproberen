##clear
pkg load io;

bronbestand = "C:\\Users\\matth\\Downloads\\Staalmannen_Markregatta_2019.xlsx";
ruw = xlsread (bronbestand, 'Midwintermarathon', 'c3:e1839');

tijd = ruw(:,2);
afstand = ruw(:,3);
## Breaks interpolated from data
pp = splinefit ( tijd, afstand, 71, "robust", true);  % 51 breaks, 50 pieces
v_t = ppder(pp);

## Plot
benodigde_tijd = ruw(end,1)- ruw(1,1);
x_t = linspace (0, tijd(end), 400);
afgelegd = 1e-3*linspace (0, afstand(end), 400);
snelheid = 3.6*ppval (v_t, x_t);
tijdstip = linspace ( mod(ruw(1,1),1),mod(ruw(end,1),1), 400);

h = figure(1);
plot(tijdstip, snelheid, 'r');
hold on;
##set( gca, "xtick", [0.85:0.00834:0.90]);
datetick('x', 15);
##xlim([0.85 0.89]);
ylim([0 15]);

FS = findall(h,'-property','FontSize');
set(FS,'FontSize',16);
title(["Staalmannen RIC Midwintermarathon 2019"],'FontSize',24);
xlabel('tijdstip (u)','FontSize',16);
ylabel('bootsnelheid (km/u)','FontSize',16);
##legend([n1],[sprintf(...
##"Katinka, Jan-Willem, Matthijs\n (%4.1f km)",...
##1e-3*afstand(end))],"location",'southeast');
grid on;
hold off;

k = figure(2);
plot(afgelegd, snelheid, 'b');
hold on;
##set( gca, "xtick", [0.85:0.00834:0.90]);
##datetick('x', 15);
xlim([0 50]);
ylim([0 15]);

FS = findall(k,'-property','FontSize');
set(FS,'FontSize',16);
title(["Staalmannen RIC Midwintermarathon 2019"],'FontSize',24);
xlabel('afstand (km)','FontSize',16);
ylabel('bootsnelheid (km/u)','FontSize',16);
##legend([n1],[sprintf(...
##"Katinka, Jan-Willem, Matthijs\n (%4.1f km)",...
##1e-3*afstand(end))],"location",'southeast');
grid on;
hold off;