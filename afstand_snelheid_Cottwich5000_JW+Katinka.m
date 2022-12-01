pkg load io;

bronbestand = "C:\\Users\\matth\\Downloads\\Gladiatores_Ertveld_experience.xlsx";
ruw = xlsread (bronbestand, 'Cottwich 5000m', 'a2:h593');

tijd = ruw(:,1);
afstand = ruw(:,4);
snelheid = ruw(:,6);

slagtempo = ruw(:,7);
slaglengte = ruw(:,8);
gevaren_tijd = (tijd(end-1)- tijd(1))/86400;

afgelegd = afstand(end-1)-afstand(1);

## Breaks interpolated from data
pp = splinefit (afstand, snelheid,22,"robust",true);  % 21 breaks, 20 pieces
qq = splinefit (afstand, slaglengte,22,"robust",true);  % 21 brea ks, 20 pieces
pq = splinefit (afstand, slagtempo,22,"robust",true);  % 21 breaks, 20 pieces
## Plot
xx = linspace (0, 5200, 400);
xy = linspace (tijd(1), tijd(end), 400);
y = ppval (pp, xx);
z = ppval (qq, xx);
zy = ppval (pq, xx);
roeihalen = 1440*quad(@(t) ppval(pq,t),tijd(1)/86400,tijd(end-1)/86400);

h = figure;
##n1 = plot(xx, y, 'k');
hold on;
n1 = plot(afstand, snelheid, 'k.', "markersize", 10);
set (gca, "xtick", [0:250:5200]);
xlim([0 5200]);
ylim([0 18]);
set (gca, "ytick", [0,5,10:2:18]);

FS = findall(h,'-property','FontSize');
set(FS,'FontSize',16);
title(["Bootsnelheid Cottwich 5000m\n15 september 2019"],...
      'FontSize',24);
xlabel('afstand (m)','FontSize',16);
ylabel('snelheid (km/u)','FontSize',16);
legend([n1],...
[sprintf("Katinka en Jan-Willem (Lago Mio) in %su",...
datestr(gevaren_tijd,13))],"location",'southwest');
grid on;
##set(gcf(), 'position', [300 200 1560 420]);
hold off;

k = figure;
n1 = plot(xx, z, 'k');
hold on;
plot(afstand, slaglengte, 'k.', "markersize", 10);
set (gca, "xtick", [0:250:5200]);
xlim([0 5200]);
ylim([0 10]);
set (gca, "ytick", [0,4,8:10]);

FS = findall(k,'-property','FontSize');
set(FS,'FontSize',16);
title(["Slaglengte Cottwich 5000m\n15 september 2019"],...
      'FontSize',24);
xlabel('afstand (m)','FontSize',16);
ylabel('slaglengte (m)','FontSize',16);
legend([n1],...
[sprintf("Katinka en Jan-Willem (Lago Mio) in %su",...
datestr(gevaren_tijd,13))],"location",'southwest');
grid on;
hold off;

kh = figure;
n1 = plot(xx, zy, 'k');
hold on;
plot(afstand, slagtempo, 'k.', "markersize", 10);
set (gca, "xtick", [0:250:5200]);
xlim([0 5200]);
ylim([20 30]);
set (gca, "ytick", [20,24:2:30]);

FS = findall(kh,'-property','FontSize');
set(FS,'FontSize',16);
title(["Slagtempo Cottwich 5000m\n15 september 2019"],...
      'FontSize',24);
xlabel('afstand (m)','FontSize',16);
ylabel('slagtempo (min^{-1})','FontSize',16);
legend([n1],...
[sprintf("Katinka en Jan-Willem (Lago Mio) in %d halen",...
round(roeihalen))],"location",'southwest');
grid on;
hold off;