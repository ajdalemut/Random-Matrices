n = 50;
st_ponovitev = 50000;

[vse_lastne_GOE, normvse_lastne_GOE, spacing_GOE, mean_spacing_GOE] = GOE_fanaliza(n, st_ponovitev);
[vse_lastne_GUE, normvse_lastne_GUE, spacing_GUE, mean_spacing_GUE] = GUE_fanaliza(n, st_ponovitev);
[vse_lastne_GSE, normvse_lastne_GSE, spacing_GSE, mean_spacing_GSE] = GSE_fanaliza(n, st_ponovitev);

% density of eigenvalues-----------------------------------
figure
[values1, edges1] = histcounts(vse_lastne_GOE, 40,'Normalization', 'pdf');
centers1 = (edges1(1:end-1)+edges1(2:end))/2;

[values2, edges2] = histcounts(vse_lastne_GUE, 40,'Normalization', 'pdf');
centers2 = (edges2(1:end-1)+edges2(2:end))/2;

[values3, edges3] = histcounts(vse_lastne_GSE, 40,'Normalization', 'pdf');
centers3 = (edges3(1:end-1)+edges3(2:end))/2;

plot(centers1, values1, '-', centers2, values2, '-', centers3, values3, '-')

legend('GOE','GUE', 'GSE')

lastne = sprintf('lastne_%d_%d.eps',n,st_ponovitev);
saveas(gcf, lastne)

%---------level spacing---------------------------------------------


figure

[values1, edges1] = histcounts(spacing_GOE,40,'Normalization', 'pdf');
centers1 = (edges1(1:end-1)+edges1(2:end))/2;

[values2, edges2] = histcounts(spacing_GUE,40,'Normalization', 'pdf');
centers2 = (edges2(1:end-1)+edges2(2:end))/2;

[values3, edges3] = histcounts(spacing_GSE, 40,'Normalization', 'pdf');
centers3 = (edges3(1:end-1)+edges3(2:end))/2;

plot(centers1, values1, '-', centers2, values2, '-', centers3, values3, '-')

% analitic distributions of level spacings
x = linspace(0,10,1000);
y1=(pi/2).*x.*exp(-(pi/4).*(x.^2));
y2=(32/(pi^2)).*(x.^2).*exp(-(4/pi).*(x.^2));
y3=((2^18)/(3^6 * pi^3)).*(x.^4).*exp(-(64/(9*pi)).*(x.^2));
hold on
plot(x,y1,'-',x,y2,'-',x,y3,'-')

legend('GOE','GUE','GSE')

level_spacing = sprintf('level_spacing_%d_%d.eps',n,st_ponovitev);
saveas(gcf, level_spacing)

%----------------------------------------------------------------------
figure

[values1, edges1] = histcounts(vse_lastne_GOE./mean_spacing_GOE,40,'Normalization', 'pdf');
centers1 = (edges1(1:end-1)+edges1(2:end))/2;

[values2, edges2] = histcounts(vse_lastne_GUE./mean_spacing_GUE,40,'Normalization', 'pdf');
centers2 = (edges2(1:end-1)+edges2(2:end))/2;

[values3, edges3] = histcounts(vse_lastne_GUE./mean_spacing_GSE,40,'Normalization', 'pdf');
centers3 = (edges3(1:end-1)+edges3(2:end))/2;

plot(centers1, values1, '-', centers2, values2, '-', centers3, values3, '-')

legend('GOE','GUE','GSE')

normalizirane_lastne = sprintf('normalizirane_lastne_%d_%d.eps',n,st_ponovitev);
saveas(gcf, normalizirane_lastne)



