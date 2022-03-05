
% dolocimo velikost nakljucne matrike, porazdelitev za konstrukcijo in stevilo ponovitev konstrukcije
d = 'norm'; % 'uni'/'int'/'norm'
n = 50;
st_ponovitev = 300;


%zaženemo glavno funkcijo glede na izbrane spremenljivke
[stevilo_realnih_lastnih, vse_lastne, vse_sledi, vse_det] = fanaliza(n, st_ponovitev, d);

st_vsajenarealna = 0;
st_vserealne = 0;
for st = stevilo_realnih_lastnih
    if st == n
        st_vsajenarealna = st_vsajenarealna + 1;
        st_vserealne = st_vserealne + 1;
    elseif st > 0 
        st_vsajenarealna = st_vsajenarealna + 1;
    else
        continue
    end
end

verjetnost_vsajenarealna = st_vsajenarealna/n;
fprintf('Verjetnost, da je vsaj ena lastna vrednost realna: %.3f \n', verjetnost_vsajenarealna);
verjetnost_vserealne = st_vserealne/n;
fprintf('Verjetnost, da so vse lastne vrednosti realne: %.3f \n', verjetnost_vserealne);
povprecje_st_realnih = mean(stevilo_realnih_lastnih);
fprintf('Povprecje stevila realnih: %.3f \n' , povprecje_st_realnih);



%% Graf lastnih vrednosti
figure
plot(real(vse_lastne), imag(vse_lastne),'.')
title('Graf vseh lastnih vrednosti v kompleksni ravnini')
vselastne = sprintf('vselastne_%s_%d_%d.eps',d,n,st_ponovitev);
saveas(gcf, vselastne)

% pomožna funkcija za izra?une povprecnega stevila lastnih vrednosti
maxdim=100;
x = 1:1:maxdim;
y = zeros(1,maxdim);
z = zeros(1,maxdim);
for i = x
    [stevilo_realnih_lastnih, vse_lastne, vse_sledi, vse_det] = fanaliza(i, st_ponovitev,d);
    povprecje_st_realnih = mean(stevilo_realnih_lastnih);
    y(i) =  povprecje_st_realnih; 
    z(i) = y(i)/i ; %delež realnih
end

%% Graf stevila realnih lastnih v odvisnosti od velikosti matrike
figure
ft=fittype('A*sqrt(x)');
A=sqrt(2/pi); %teoreticno znana konstanta How Many Eigenvalues of a Random Matrix are Real? Alan Edelman; Eric Kostlan; Michael Shub
f = fit(x', y',ft);
plot(f)
hold on;
plot(x, y,'.')
title('Graf pricakovane vrednosti stevila realnih lastnih vrednosti v odvisnosti od velikosti matrike')
xlabel('Velikost matrike')
ylabel('Pricakovana vrednost stevila realnih lastnih vrednosti')


%% Graf deleža realnih lastnih vrednosti
figure
ft=fittype('a*x^b'); %Zakaj ??
a=1;
b=-0.5; 
f = fit(x',z',ft);
plot(f)
hold on;
plot(x,z,'.')
title('Graf deleza realnih lastnih vrednosti v odvisnosti od velikosti matrike')
xlabel('Velikost matrike')
ylabel('Delez realnih lastnih vrednosti')
delez = sprintf('delez_%s_%d_%d.eps',d,n,st_ponovitev);
saveas(gcf, delez)

%% Graf sledi 
figure
%histogram(vse_sledi,30)
pd = fitdist(vse_sledi,'Normal');
histfit(vse_sledi,30)
title('Graf vseh sledi v kompleksni ravnini')
sledi = sprintf('sledi_%s_%d_%d.eps',d,n,st_ponovitev);
saveas(gcf, sledi)

%% Graf determinant
figure
histogram(vse_det,30)
title('Graf vseh determinant v kompleksni ravnini')
determinante = sprintf('det_%s_%d_%d.eps',d,n,st_ponovitev);
saveas(gcf, determinante)




