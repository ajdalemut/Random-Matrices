% dolocimo velikost nakljucne matrike, porazdelitev za konstrukcijo in stevilo ponovitev konstrukcije
d = 'int'; % 'uni'/'int'/'norm'
n = 50;
st_ponovitev = 400;

%zaženemo glavno funkcijo glede na izbrane spremenljivke
[vse_lastne, vse_sledi, vse_det] = fanaliza_sim(n, st_ponovitev, d);

%% --------ANALIZA GLEDE NA DISTRIBUCIJO---------------------------------------------

%-------UNI-------------------------------------------------------
if matches(d,'uni')
    
    %% Graf lastnih vrednosti
    figure
    plot(real(vse_lastne), imag(vse_lastne),'.')
    title('Graf vseh lastnih vrednosti v kompleksni ravnini')
    vselastne = sprintf('vselastne_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, vselastne)

    %% Graf sledi 
    figure
    pd2 = fitdist(vse_sledi,'Normal');
    histfit(vse_sledi,20)
    title('Histogram vseh sledi')
    sledi = sprintf('sledi_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, sledi)

    %% Graf determinant
    figure
    histogram(vse_det,30)
    title('Histogram vseh determinant')
    determinante = sprintf('determinante_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, determinante)
    
    

%----------------INT-------------------------------
elseif matches(d,'int')
    
    %% Graf lastnih vrednosti
    figure
    plot(real(vse_lastne), imag(vse_lastne),'.')
    title('Graf vseh lastnih vrednosti v kompleksni ravnini')
    vselastne = sprintf('vselastne_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, vselastne)

    %% Graf sledi 
    figure
    pd2 = fitdist(vse_sledi,'Normal');
    histfit(vse_sledi,20)
    title('Histogram vseh sledi')
    sledi = sprintf('sledi_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, sledi)

    %% Graf determinant
    figure
    histogram(vse_det,30)
    title('Histogram vseh determinant')
    determinante = sprintf('determinante_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, determinante)
    
%----------------NORM------------------------------
elseif matches(d,'norm')
    
    %% Graf lastnih vrednosti
    figure
    plot(real(vse_lastne), imag(vse_lastne),'.')
    axis equal
    title('Graf vseh lastnih vrednosti v kompleksni ravnini')
    vselastne = sprintf('vselastne_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, vselastne)

    %% Graf sledi 
    figure
    %histogram(vse_sledi,20)
    pd2 = fitdist(vse_sledi,'Normal');
    histfit(vse_sledi,20)
    title('Histogram vseh sledi')
    sledi = sprintf('sledi_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, sledi)

    %% Graf determinant
    figure
    histogram(vse_det,30)
    title('Histogram vseh determinant')
    determinante = sprintf('determinante_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, determinante)
    
elseif matches(d,'discr')
        
    %% Graf lastnih vrednosti
    figure
    plot(real(vse_lastne), imag(vse_lastne),'.')
    axis equal
    title('Graf vseh lastnih vrednosti v kompleksni ravnini')
    vselastne = sprintf('vselastne_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, vselastne)

    %% Graf sledi 
    figure
    %histogram(vse_sledi,20)
    pd2 = fitdist(vse_sledi,'Normal');
    histfit(vse_sledi,20)
    title('Histogram vseh sledi')
    sledi = sprintf('sledi_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, sledi)

    %% Graf determinant
    figure
    histogram(vse_det,30)
    title('Histogram vseh determinant')
    determinante = sprintf('determinante_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, determinante)
    
else
    error('Unidentified distribution')
end






