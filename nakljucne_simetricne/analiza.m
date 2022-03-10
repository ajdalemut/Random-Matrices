
% dolocimo velikost nakljucne matrike, porazdelitev za konstrukcijo in stevilo ponovitev konstrukcije
d = 'int'; % 'uni'/'int'/'norm'
n = 50;
st_ponovitev = 200;


%zaženemo glavno funkcijo glede na izbrane spremenljivke
[stevilo_realnih_lastnih, vse_lastne, vse_sledi, vse_det] = fanaliza(n, st_ponovitev, d);


povprecje_st_realnih = mean(stevilo_realnih_lastnih);
       

% Graf lastnih vrednosti
figure
plot(real(vse_lastne), imag(vse_lastne),'.')
title('Graf vseh lastnih vrednosti v kompleksni ravnini')
vselastne = sprintf('vselastne_%s_%d_%d.eps',d,n,st_ponovitev);
saveas(gcf, vselastne)

% Graf sledi 
figure
pd2 = fitdist(vse_sledi,'Normal');
histfit(vse_sledi,20)
title('Graf vseh sledi v kompleksni ravnini')
sledi = sprintf('sledi_%s_%d_%d.eps',d,n,st_ponovitev);
saveas(gcf, sledi)

% Graf determinant
figure
histogram(vse_det)
title('Graf vseh determinant v kompleksni ravnini')
determinante = sprintf('det_%s_%d_%d.eps',d,n,st_ponovitev);
saveas(gcf, determinante)




