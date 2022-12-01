##pkg load io;
%DIT IS EEN TEST REGEL (Patrick) %2de test
bronbestand = "C:\\Users\\matth\\Downloads\\Staalmannen_Markregatta_2019.xlsx";
ruw = xlsread (bronbestand, 'Lingebokaal 2019', 'b2:h1502');
bronbestand1 = "C:\\Users\\matth\\Downloads\\Gladiatores_Ertveld_experience.xlsx";
ruw1 = xlsread (bronbestand1, 'Lingebokaal 2019', 'a2:h733');

tijd = ruw(:,1);
afstand = ruw(:,3);
snelheid = ruw(:,4);
hartslag = ruw(:,5);
slagtempo = ruw(:,6);
slaglengte = ruw(:,7);
benodigde_tijd = tijd(end)- tijd(1);

afgelegd = afstand(end)-afstand(1);

## Breaks interpolated from data
pp = splinefit (afstand, snelheid,22,"robust",true);  % 21 breaks, 20 pieces
qq = splinefit (afstand, slaglengte,22,"robust",true);  % 21 brea ks, 20 pieces
pq = splinefit (afstand, slagtempo,22,"robust",true);  % 21 breaks, 20 pieces
rr = splinefit (afstand, hartslag,22,"robust",true);  % 21 breaks, 20 pieces
## Plot
xx = linspace (0, 6000, 400);
xy = linspace (tijd(1), tijd(end), 400);
y = ppval (pp, xx);
z = ppval (qq, xx);
zy = ppval (pq, xx);
zx = ppval (rr, linspace (0, 6000, 400));
roeihalen = 1440*quad(@(t) ppval(pq,t),tijd(1),tijd(end));
hartslagen = 1440*quad(@(t) ppval(rr,t),tijd(1),tijd(end));

tijd1 = ruw1(:,1);
afstand1 = ruw1(:,4);
snelheid1 = ruw1(:,6);

slagtempo1 = ruw1(:,7);
slaglengte1 = ruw1(:,8);
gevaren_tijd = (tijd1(end)- tijd1(1))/86400;

afgelegd1 = afstand1(end)-afstand1(1);

## Breaks interpolated from data
pp1 = splinefit (afstand1, snelheid1,22,"robust",true);  % 21 breaks, 20 pieces
qq1 = splinefit (afstand1, slaglengte1,22,"robust",true);  % 21 brea ks, 20 pieces
pq1 = splinefit (afstand1, slagtempo1,22,"robust",true);  % 21 breaks, 20 pieces
## Plot
xx1 = linspace (0, 6000, 400);
xy1 = linspace (tijd1(1), tijd1(end), 400);
y1 = ppval (pp1, xx1);
z1 = ppval (qq1, xx1);
zy1 = ppval (pq1, xx1);
roeihalen1 = 1440*quad(@(t) ppval(pq1,t),tijd1(1)/86400,tijd1(end)/86400);

h = figure;
n1 = plot(xx, y, 'r');
hold on;
plot(afstand, snelheid, 'r.', "markersize", 10);
n2 = plot(xx1, y1, 'b');
plot(afstand1, snelheid1, 'b.', "markersize", 10);
set (gca, "xtick", [0:500:6000]);
xlim([0 6000]);
ylim([0 16]);
set (gca, "ytick", [0,5,10:2:16]);

FS = findall(h,'-property','FontSize');
set(FS,'FontSize',16);
title(["Bootsnelheid Lingebokaal\n9 november 2019"],...
      'FontSize',24);
xlabel('afstand (m)','FontSize',16);
ylabel('snelheid (km/u)','FontSize',16);
legend([n1,n2],[sprintf(...
"Staalmannen (Nero) in %su",...
datestr(benodigde_tijd,13))],...
[sprintf("Gladiatores (Pluto) in %su",...
datestr(gevaren_tijd,13))],"location",'southeast');
grid on;
##set(gcf(), 'position', [300 200 1560 420]);
hold off;

k = figure;
n1 = plot(xx, z, 'r');
hold on;
plot(afstand, slaglengte, 'r.', "markersize", 10);
n2 = plot(xx1, z1, 'b');
plot(afstand1, slaglengte1, 'b.', "markersize", 10);
set (gca, "xtick", [0:500:6000]);
xlim([0 6000]);
ylim([0 10]);
set (gca, "ytick", [0,4,8:10]);

FS = findall(k,'-property','FontSize');
set(FS,'FontSize',16);
title(["Slaglengte Lingebokaal\n9 november 2019"],...
      'FontSize',24);
xlabel('afstand (m)','FontSize',16);
ylabel('slaglengte (m)','FontSize',16);
legend([n1,n2],[sprintf(...
"Staalmannen (Nero) in %su",...
datestr(benodigde_tijd,13))],...
[sprintf("Gladiatores (Pluto) in %su",...
datestr(gevaren_tijd,13))],"location",'southeast');
grid on;
hold off;

kh = figure;
n1 = plot(xx, zy, 'r');
hold on;
plot(afstand, slagtempo, 'r.', "markersize", 10);
n2 = plot(xx1, zy1, 'b');
plot(afstand1, slagtempo1, 'b.', "markersize", 10);
set (gca, "xtick", [0:500:6000]);
xlim([0 6000]);
ylim([20 32]);
set (gca, "ytick", [20,24:2:32]);

FS = findall(kh,'-property','FontSize');
set(FS,'FontSize',16);
title(["Slagtempo Lingebokaal\n9 november 2019"],...
      'FontSize',24);
xlabel('afstand (m)','FontSize',16);
ylabel('slagtempo (min^{-1})','FontSize',16);
legend([n1,n2],[sprintf(...
"Staalmannen (Nero) in %d halen",...
round(roeihalen))],...
[sprintf("Gladiatores (Pluto) in %d halen",...
round(roeihalen1))],"location",'southeast');
grid on;
hold off;