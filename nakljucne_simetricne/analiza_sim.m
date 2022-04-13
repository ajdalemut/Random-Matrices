% dolocimo velikost nakljucne matrike, porazdelitev za konstrukcijo in stevilo ponovitev konstrukcije
d = 'uni'; % 'uni'/'int'/'norm'/'discr'
n = 50;
st_ponovitev = 10000;

%zaženemo glavno funkcijo glede na izbrane spremenljivke
[vse_lastne, vse_sledi, vse_det] = fanaliza_sim(n, st_ponovitev, d);

%% Graf lastnih vrednosti
figure
plot(real(vse_lastne), imag(vse_lastne),'.')
title('(a) Graf vseh lastnih vrednosti v kompleksni ravnini', 'FontSize', 15)
vselastne = sprintf('vselastne_sim_%s_%d_%d.eps',d,n,st_ponovitev);
saveas(gcf, vselastne)


%% Graf gostote lastnih vrednosti
figure
[values, edges] = histcounts(vse_lastne, 40,'Normalization', 'pdf');
centers = (edges(1:end-1)+edges(2:end))/2;

plot(centers, values, '-')

lastne = sprintf('lastne_sim_%d_%d.eps',n,st_ponovitev);
saveas(gcf, lastne,'epsc')
    
%% Graf sledi 
figure
pd2 = fitdist(vse_sledi,'Normal');
histfit(vse_sledi,20)
title('(a) Histogram vseh sledi', 'FontSize', 15)
sledi = sprintf('sledi_sim_%s_%d_%d.eps',d,n,st_ponovitev);
saveas(gcf, sledi)

%% Graf determinant
figure
histogram(vse_det,30)
title('(a) Histogram vseh determinant', 'FontSize', 15)
determinante = sprintf('determinante_sim_%s_%d_%d.eps',d,n,st_ponovitev);
saveas(gcf, determinante)
    








