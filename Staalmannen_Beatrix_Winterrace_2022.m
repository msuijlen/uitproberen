pkg load io;

bronbestand = "D:\\matth\\Downloads\\Staalmannen_Markregatta_2019.xlsx";
file27nov = xlsread (bronbestand, 'Beatrix Winterrace 2022', 'd2:h520');

tijd27nov = file27nov(:,2);
snelheid27nov = file27nov(:,3);
afstand27nov = 1e-3*file27nov(:,1);
slagtempo27nov = file27nov(:,4);
slaglengte27nov = file27nov(:,5);

## Breaks interpolated from data
spline_v_t = splinefit (tijd27nov, snelheid27nov, 123,"robust",true);  % 123 breaks, 122 pieces
spline_v_x = splinefit (afstand27nov, snelheid27nov, 123,"robust",true);  % 123 breaks, 122 pieces
spline_f_x = splinefit (afstand27nov, slagtempo27nov, 123,"robust",true);  % 123 breaks, 122 pieces
spline_d_x = splinefit (afstand27nov, slaglengte27nov, 123,"robust",true);  % 123 breaks, 122 pieces

## Plot
tijdas = linspace (tijd27nov(1), tijd27nov(end), 400);
posas = linspace (afstand27nov(1), afstand27nov(end), 400);
v_x = ppval (spline_v_x, posas);
f_x = ppval (spline_f_x, posas);
afgelegd27nov = 24*ppval(ppint(spline_v_t),tijdas);
d_x = ppval (spline_d_x, posas);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gevarentijd_staal = (tijd27nov(end)- tijd27nov(1))/86400;
roeihalen_staal = 1440*quad(@(t) ppval(spline_f_x,t),tijd27nov(1)/86400,tijd27nov(end)/86400);

h=figure(1);
plot(posas, v_x, 'r');
hold on;
plot(afstand27nov, snelheid27nov, 'r.', "markersize", 10);
##set (gca, "xtick", [0.4125:0.002083:0.427083],"xgrid","on");
##datetick('x', 15, 'keepticks');
##datetick('x', 15);
##xlim([0 7]);
set (gca, "xtick", [0:0.5:10],"xgrid","on");
ylim([0 15]);
set (gca, "ytick", [0,5,10,12:15],"ygrid","on");
FS = findall(h,'-property','FontSize');
set(FS,'FontSize',20);
set(h,'position',[300 200 1920 420]);
title(['Bootsnelheid Peelse Loop C4* op Eindhovens Kanaal'],'FontSize',36);
xlabel('afstand (km)','FontSize',20);
ylabel('snelheid (km/u)','FontSize',20);
legend({sprintf('Staalmannen 27 november 2022\nin %d roeihalen en %su op Beatrix Winterrace',round(roeihalen_staal),datestr(gevarentijd_staal,13))},...
'orientation','horizontal','location','southeast');
grid on;
hold off;


k=figure(2);
plot( posas, f_x, 'r');
hold on;
plot(afstand27nov, slagtempo27nov, 'r.', "markersize", 10);
##xlim([0 7]);
set (gca, "xtick", [0:0.5:10],"xgrid","on");
ylim([16 36]);
FS = findall(k,'-property','FontSize');
set(FS,'FontSize',20);
set(k,"position",[300 200 1920 420]);
title(["Slagtempo Peelse Loop C4* op Eindhovens Kanaal"],'FontSize',36);
xlabel('afstand (km)','FontSize',20);
ylabel("slagtempo (1/min)",'FontSize',20);
legend({sprintf('Staalmannen 27 november 2022\nin %d roeihalen en %su op Beatrix Winterrace',round(roeihalen_staal),datestr(gevarentijd_staal,13))},...
'orientation','horizontal','location','southeast');
grid on;
hold off;


m=figure(4);
plot( posas, d_x, 'r');
hold on;
plot(afstand27nov, slaglengte27nov, 'r.', "markersize", 10);
##xlim([0 7]);
set (gca, "xtick", [0:0.5:10],"xgrid","on");
ylim([0 10]);
FS = findall(m,'-property','FontSize');
set(FS,'FontSize',20);
set(m,"position",[300 200 1920 420]);
title(["Slaglengte Peelse Loop C4* op Eindhovens Kanaal"],'FontSize',36);
xlabel('afstand (km)','FontSize',20);
ylabel("slaglengte (m)",'FontSize',20);
legend({sprintf('Staalmannen 27 november 2022\nin %d roeihalen en %su op Beatrix Winterrace',round(roeihalen_staal),datestr(gevarentijd_staal,13))},...
'orientation','horizontal','location','southeast');
grid on;
hold off;


print (h, "Winterrace_afstand_snelheid_27nov22.png", "-S1920,420");
print (k, "Winterrace_afstand_slagtempo_27nov22.png", "-S1920,420");
##print (l, "afstand_hartslag_27nov22.png", "-S1920,420");
print (m, "Winterrace_afstand_slaglengte_27nov22.png", "-S1920,420");