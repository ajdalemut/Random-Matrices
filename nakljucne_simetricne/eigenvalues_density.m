n = 50;
st_ponovitev = 50000;

%zaženemo glavno funkcijo glede na izbrane spremenljivke
[vse_lastne_uni, vse_sledi_uni, vse_det_uni] = fanaliza_sim(n, st_ponovitev, 'uni');
[vse_lastne_int, vse_sledi_int, vse_det_int] = fanaliza_sim(n, st_ponovitev, 'int');
[vse_lastne_norm, vse_sledi_norm, vse_det_norm] = fanaliza_sim(n, st_ponovitev, 'norm');
[vse_lastne_discr, vse_sledi_discr, vse_det_discr] = fanaliza_sim(n, st_ponovitev, 'discr');

figure
[values1, edges1] = histcounts(vse_lastne_uni, 40,'Normalization', 'pdf');
centers1 = (edges1(1:end-1)+edges1(2:end))/2;

[values2, edges2] = histcounts(vse_lastne_int, 40,'Normalization', 'pdf');
centers2 = (edges2(1:end-1)+edges2(2:end))/2;

[values3, edges3] = histcounts(vse_lastne_norm, 40,'Normalization', 'pdf');
centers3 = (edges3(1:end-1)+edges3(2:end))/2;

[values4, edges4] = histcounts(vse_lastne_discr, 40,'Normalization', 'pdf');
centers4 = (edges4(1:end-1)+edges4(2:end))/2;


plot(centers1, values1, '-', centers2, values2, '-', centers3, values3, '-', centers4, values4, '-')

legend('UNI','INT', 'NORM', 'DISCR')

lastne_density = sprintf('lastne_density_%d_%d.eps',n,st_ponovitev);
saveas(gcf,lastne_density,'epsc')
