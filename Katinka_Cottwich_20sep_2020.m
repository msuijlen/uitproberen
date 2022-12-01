pkg load io;

bronbestand = "C:\\Users\\matth\\Downloads\\Gladiatores_Ertveld_experience.xlsx";
ruw2019 = xlsread (bronbestand, 'Cottwich 5000m', 'a2:h592');
ruw2020 = xlsread (bronbestand, 'Katinka_Cottwich', 'f14:k434');

tijd2019 = ruw2019(:,1);
afstand2019 = ruw2019(:,4);
snelheid2019 = ruw2019(:,6);

slagtempo2019 = ruw2019(:,7);
slaglengte2019 = ruw2019(:,8);
gevaren_tijd = (tijd2019(end)-tijd2019(1))/86400;

afgelegd = afstand2019(end)-afstand2019(1);

## Breaks interpolated from data
pp2019 = splinefit (afstand2019, snelheid2019,43,"robust",true);  % 21 breaks, 20 pieces
qq2019 = splinefit (afstand2019, slaglengte2019,43,"robust",true);  % 21 brea ks, 20 pieces
pq2019 = splinefit (afstand2019, slagtempo2019,43,"robust",true);  % 21 breaks, 20 pieces
pr2019 = splinefit (tijd2019-tijd2019(1), slagtempo2019,43,"robust",true);  % 21 breaks, 20 pieces
## Plot
xx = linspace (0, 5100, 400);
xy = linspace (0, tijd2019(end)-tijd2019(1), 400);
y = ppval (pp2019, xx);
z = ppval (qq2019, xx);
zy = ppval (pq2019, xx);
zx = ppval (pr2019, xy);
roeihalen = quad(@(t) ppval(pr2019,t),0,(tijd2019(end)-tijd2019(1))/60);

afstand2020 = ruw2020(:,1);
tijd2020 = ruw2020(:,2);
snelheid2020 = ruw2020(:,3);
hartslag2020 = ruw2020(:,4);
slagtempo2020 = ruw2020(:,5);
slaglengte2020 = ruw2020(:,6);
gevaren_tijd2020 = tijd2020(end)/86400;

## Breaks interpolated from data
pp2020 = splinefit (tijd2020, snelheid2020, 43,"robust",true);  % 21 breaks, 20 pieces
pt2020 = splinefit (afstand2020, snelheid2020, 43,"robust",true);  % 21 breaks, 20 pieces
pq2020 = splinefit (afstand2020, slagtempo2020, 43,"robust",true);  % 21 breaks, 20 pieces
pr2020 = splinefit (afstand2020, hartslag2020, 43,"robust",true);  % 21 breaks, 20 pieces
ps2020 = splinefit (afstand2020, slaglengte2020, 43,"robust",true);  % 21 breaks, 20 pieces
qq2020 = splinefit (tijd2020, slagtempo2020, 43,"robust",true);  % 21 breaks, 20 pieces
qr2020 = splinefit (tijd2020, hartslag2020, 43,"robust",true);  % 21 breaks, 20 pieces

## Plot
xx2020 = linspace (tijd2020(1), tijd2020(end), 400);
uu2020 = linspace (0, 5100, 400);
yy2020 = ppval (pt2020, uu2020);
zz2020 = ppval (pq2020, uu2020);
roeihalen2020 = quad(@(t) ppval(qq2020,t),0,tijd2020(end)/60);
ss2020 = ppval (pr2020, uu2020);
hartslagen2020 = quad(@(t) ppval(qr2020,t),0,tijd2020(end)/60);
tt2020 = ppval (ps2020, uu2020);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


h=figure(1);
n3 = plot(xx, y, 'r');
hold on;
n4 = plot(uu2020, yy2020, 'b');
plot(afstand2019, snelheid2019, 'r.', "markersize", 10);
plot(afstand2020, snelheid2020, 'b.', "markersize", 10);
##set (gca, "xtick", [0.4125:0.002083:0.427083],"xgrid","on");
##datetick('x', 15, 'keepticks');
##datetick('x', 15);
xlim([0 5100]);
set (gca, "xtick", [0:250:5100],"xgrid","on");
ylim([6 16]);
set (gca, "ytick", [6,10:2:16],"ygrid","on");
FS = findall(h,'-property','FontSize');
set(FS,'FontSize',20);
set(h,"position",[300 200 1920 420]);
title(["Bootsnelheid Katinka, Cottwich regatta Almelo"],'FontSize',36);
xlabel('afstand (m)','FontSize',20);
ylabel('snelheid (km/u)','FontSize',20);
legend([n3 n4],[sprintf("Mix2x veld, 15 sep 2019, %4.2f km in %su",...
1e-3*afgelegd,datestr(gevaren_tijd,13))],...
[sprintf("D1x veld, 20 sep 2020, %4.2f km in %su",...
1e-3*afstand2020(end),datestr(gevaren_tijd2020,13))],"location",'southeast');
grid on;
hold off;
print (h, "snelh_Cott.png", "-S1920,420")


k=figure(2);
n3 = plot( xx, zy, 'r');
hold on;
n4 = plot( uu2020, zz2020, 'b');
plot(afstand2019, slagtempo2019, 'r.', "markersize", 10);
plot(afstand2020, slagtempo2020, 'b.', "markersize", 10);
xlim([0 5100]);
set (gca, "xtick", [0:250:5100],"xgrid","on");
ylim([24 30]);
FS = findall(k,'-property','FontSize');
set(FS,'FontSize',20);
set(k,"position",[300 200 1920 420]);
title(["Slagtempo Katinka, Cottwich regatta Almelo"],'FontSize',36);
xlabel('afstand (m)','FontSize',20);
ylabel("slagtempo (1/min)",'FontSize',20);
legend([n3 n4],[sprintf("Mix2x veld, 15 sep 2019, %4.2f km in %d halen",...
1e-3*afgelegd,round(roeihalen))],...
[sprintf("D1x veld, 20 sep 2020, %4.2f km in %d halen",...
1e-3*afstand2020(end),round(roeihalen2020))],"location",'southeast');
grid on;
hold off;
print (k, "slagtempo_Cott.png", "-S1920,420")


l=figure(3);
n4 = plot( uu2020, ss2020, 'b');
hold on;
plot(afstand2020, hartslag2020, 'b.', "markersize", 10);
xlim([0 5100]);
set (gca, "xtick", [0:250:5100],"xgrid","on");
ylim([80 200]);
FS = findall(l,'-property','FontSize');
set(FS,'FontSize',20);
set(l,"position",[300 200 1920 420]);
title(["Hartslag Katinka, Cottwich regatta Almelo"],'FontSize',36);
xlabel('afstand (m)','FontSize',20);
ylabel("hartslagfrequentie (1/min)",'FontSize',20);
legend([n4],[sprintf("D1x veld, 20 sep 2020, %4.2f km in %d hartslagen",...
1e-3*afstand2020(end),round(hartslagen2020))],"location",'southeast');
grid on;
hold off;
print (l, "hart_Katinka.png", "-S1920,420")


m=figure(4);
n3 = plot( xx, z, 'r');
hold on;
n4 = plot( uu2020, tt2020, 'b');
plot(afstand2019, slaglengte2019, 'r.', "markersize", 10);
plot(afstand2020, slaglengte2020, 'b.', "markersize", 10);
xlim([0 5100]);
set (gca, "xtick", [0:250:5100],"xgrid","on");
ylim([6 10]);
FS = findall(m,'-property','FontSize');
set(FS,'FontSize',20);
set(m,"position",[300 200 1920 420]);
title(["Slaglengte Katinka, Cottwich regatta Almelo"],'FontSize',36);
xlabel('afstand (m)','FontSize',20);
ylabel("slaglengte (m)",'FontSize',20);
legend([n3 n4],[sprintf("Mix2x veld, 15 sep 2019, %4.2f km in %su",...
1e-3*afgelegd,datestr(gevaren_tijd,13))],...
[sprintf("D1x veld, 20 sep 2020, %4.2f km in %su",...
1e-3*afstand2020(end),datestr(gevaren_tijd2020,13))],"location",'southeast');
grid on;
hold off;
print (m, "slaglengte_Cott.png", "-S1920,420")