##clf;
##pkg load io;
##
##bronbestand = "Twentsche_Winterwedstrijd_Gladiatoren.xlsx";
##[An, Tn, ~, ~] = xlsread (bronbestand, 'Pluto 2019', 'n735:r1237');
##[Ap, Tp, ~, ~] = xlsread (bronbestand, 'Optio 2018', 'n220:r771');

load Twentsche_Winterwedstrijd

tijd2019 = An(:,1);
snelheid2019 = An(:,2);
slagtempo2019 = An(:,3);
afstand2019 = An(:,4);
meters_per_haal2019 = An(:,5);

tijd2018 = Ap(:,1);
snelheid2018 = Ap(:,2);
slagtempo2018 = Ap(:,3);
afstand2018 = Ap(:,4);
meters_per_haal2018 = Ap(:,5);

## Breaks interpolated from data
pp1 = splinefit (tijd2019, snelheid2019, 24, "robust", true);  % 21 breaks, 20 pieces
pp11 = splinefit (tijd2019, slagtempo2019, 10, "robust", true);  % 21 breaks, 20 pieces
pp10 = splinefit (tijd2018, snelheid2018, 19, "robust", true);
pp110 = splinefit (tijd2018, slagtempo2018, 10, "robust", true);

pq1 = splinefit (afstand2019(1:488), meters_per_haal2019(1:488), 10, "robust", true);
pq11 = splinefit (afstand2019(1:488), slagtempo2019(1:488), 10, "robust", true);
pq10 = splinefit (afstand2018, meters_per_haal2018, 10, "robust", true);
pq110 = splinefit (afstand2018, slagtempo2018, 10, "robust", true);

## Plot
xx = linspace (tijd2019(1), tijd2019(end), 400);
y1 = ppval (pp1, xx);
y11 = ppval (pp11, xx);
xx0 = linspace (tijd2018(1), tijd2018(end), 400);
y10 = ppval (pp10, xx0);
y110 = ppval (pp110, xx0);

xq = linspace (afstand2019(1), afstand2019(488), 400);
yq1 = ppval (pq1, xq);
yq11 = ppval (pq11, xq);
xq0 = linspace (afstand2018(1), afstand2018(end), 400);
yq10 = ppval (pq10, xq0);
yq110 = ppval (pq110, xq0);

##h = figure;
##n1 = plot(xx, y1, 'k');
##hold on;
##plot(tijd2019, snelheid2019, 'b.', "markersize", 10);
##plot(tijd2018, snelheid2018, 'k.', "markersize", 10);
##n2 = plot(xx0, y10, 'r');
##hold off;
##set (gca, "ytick", [0.0013889:0.00011574:0.0017362]);
####datetick('x', 15, 'keepticks');
##datetick('y', 'MM:SS', 'keepticks');
##datetick('x', 15);
####ylim([0.0013889 0.0020835]);
##
##FS = findall(h,'-property','FontSize');
##set(FS,'FontSize',16);
##title('Bootsnelheid Gladiatores Mix4* Twentsche Winterwedstrijd','FontSize',20);
##xlabel('tijdstip (u)','FontSize',16);
##ylabel('snelheid (min/500m)','FontSize',16);
##legend([n1 n2],["17:46,8min, 4086m (Pluto)\n"...
##      "10 februari 2019"],["18:45,4min, 4093m (Optio)\n"...
##      "11 februari 2018"],"location",'southeast');
##grid on;
##
##q = figure;
##r1 = plot(xx, y11, 'k');
##hold on;
##plot(tijd2019, slagtempo2019, 'b.', "markersize", 10);
##plot(tijd2018, slagtempo2018, 'k.', "markersize", 10);
##r2 = plot(xx0, y110, 'r');
##hold off;
####set (gca, "ytick", [0.0013889:0.00011574:0.0017362]);
####datetick('x', 15, 'keepticks');
##datetick('x', 15);
##ylim([20 30]);
##
##GS = findall(q,'-property','FontSize');
##set(GS,'FontSize',16);
##title('Slagtempo Gladiatores Mix4* Twentsche Winterwedstrijd','FontSize',20);
##xlabel('tijdstip (u)','FontSize',16);
##ylabel('tempo (1/min)','FontSize',16);
##legend([r1 r2],["17:46,8min, 4086m (Pluto)\n"...
##      "10 februari 2019"],["18:45,4min, 4093m (Optio)\n"...
##      "11 februari 2018"],"location",'southeast');
##grid on;

##qqp = figure;
hold on;
[hax12,line1,hline2] = plotyy(xq, yq11, xq, yq1);
##set(hax12,'NextPlot','add');
lcolor = get (gca, "ColorOrder")(1,:);
rcolor = get (gca, "ColorOrder")(2,:);
[hax34,line3,hline4] = plotyy(afstand2019(1:488), slagtempo2019(1:488),...
 afstand2019(1:488), meters_per_haal2019(1:488));
##plot(hax12(2), afstand2019(1:488), meters_per_haal2019(1:488));
##hold off;
set ([line1, line3], "color", lcolor);
xlabel("positie (m)");
ylabel(hax12(1),"tempo (1/min)");
ylabel(hax12(2),"haallengte (m)");
##xlim([0 4100]);
##ylim([0 10]);
title("Slagtempo Gladiatores Mix4* Twentsche Winterwedstrijd",'FontSize',20);
legend(hax12(2),["17:46,8min, 4086m (Pluto)\n10 februari 2019"]);
grid on;
GZ = findall(gca,'-property','FontSize');
set(GZ,'FontSize',16);
