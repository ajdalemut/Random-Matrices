
n = 5;
st_ponovitev = 300;

[stevilo_realnih_lastnih, vse_lastne, vse_sledi, vse_det] = fanaliza(n, st_ponovitev);

povprecje_st_realnih = mean(stevilo_realnih_lastnih);
       

% Graf lastnih vrednosti
figure
plot(real(vse_lastne), imag(vse_lastne),'.')
title('Graf vseh lastnih vrednosti v kompleksni ravnini')
% savefig('vselastne_uni')
% savefig('vselastne_norm')
savefig('vselastne_r')

% Graf deleža realnih lastnih vrednosti
maxdim=100;
x = 1:1:maxdim;
y = zeros(1,maxdim);
for i = x
    [stevilo_realnih_lastnih, vse_lastne, vse_sledi, vse_det] = fanaliza(i, st_ponovitev);
    povprecje_st_realnih = mean(stevilo_realnih_lastnih);
    y(i) =  povprecje_st_realnih/i; %delež realnih
end
figure
plot(x,y,'.')
title('Graf deleza realnih lastnih vrednosti v odvisnosti od velikosti matrike')
xlabel('Velikost matrike')
ylabel('Delez realnih lastnih vrednosti')
% savefig('delez_uni')
% savefig('delez_norm')
savefig('delez_r')

% Graf sledi 
figure
histogram(vse_sledi)
title('Graf vseh sledi v kompleksni ravnini')
% savefig('sledi_uni')
% savefig('sledi_norm')
savefig('sledi_r')

% Graf determinant
figure
histogram(vse_det)
title('Graf vseh determinant v kompleksni ravnini')
% savefig('det_uni')
% savefig('det_norm')
savefig('det_r')


