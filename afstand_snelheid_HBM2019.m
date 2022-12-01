##clear
pkg load io;

bronbestand = "D:\\MATTHIJS\\Mijn Garmin\\bootsnelheid_Frisia.xlsx";
ruw = xlsread (bronbestand, 'Blad11', 'c4:e2214');

tijd = ruw(:,2);
afstand = ruw(:,3);
## Breaks interpolated from data
pp = splinefit ( tijd, afstand, 100, "robust", true);  % 51 breaks, 50 pieces
v_t = ppder(pp);

## Plot
benodigde_tijd = ruw(end,1)- ruw(1,1);
x_t = linspace (0, tijd(end), 400);
afgelegd = 1e-3*linspace (0, afstand(end), 400);
snelheid = 3.6*ppval (v_t, x_t);
tijdstip = linspace ( mod(ruw(1,1),1),mod(ruw(end,1),1), 400);

h = figure(1);
n1 = plot(tijdstip, snelheid, 'r');
hold on;
##set( gca, "xtick", [0.85:0.00834:0.90]);
datetick('x', 15);
##xlim([0.85 0.89]);
ylim([0 11]);

FS = findall(h,'-property','FontSize');
set(FS,'FontSize',16);
title(["Bootsnelheid Frisia HBM 2019"],'FontSize',24);
xlabel('tijdstip (u)','FontSize',16);
ylabel('bootsnelheid (km/u)','FontSize',16);
legend([n1],[sprintf(...
"Katinka, Jan-Willem, Matthijs\n (%4.1f km)",...
1e-3*afstand(end))],"location",'southeast');
grid on;
hold off;

