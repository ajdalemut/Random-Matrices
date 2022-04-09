% dolocimo velikost nakljucne matrike, porazdelitev za konstrukcijo in stevilo ponovitev konstrukcije

d = 'uni'; % 'uni'/'int'/'norm'/'discr'
n = 20;
st_ponovitev = 100;

%-------------------------------------------------------------------------------------
%zaženemo glavno funkcijo glede na izbrane spremenljivke
[stevilo_realnih_lastnih, vse_lastne, normvse_lastne, vse_sledi, vse_det] = fanaliza(n, st_ponovitev, d);


%% ------------ANALIZA-----------------------------------------------------------
%% Verjetnosti

st_vsajenarealna = 0;
st_vserealne = 0;
for st = 1:length(stevilo_realnih_lastnih)
    if stevilo_realnih_lastnih(st) == n
        st_vsajenarealna = st_vsajenarealna + 1;
        st_vserealne = st_vserealne + 1;
    elseif stevilo_realnih_lastnih(st) > 0 
        st_vsajenarealna = st_vsajenarealna + 1;
    else
        continue
    end
end

verjetnost_vsajenarealna = st_vsajenarealna/st_ponovitev;
fprintf('Verjetnost, da je vsaj ena lastna vrednost realna: %.3f \n', verjetnost_vsajenarealna);
verjetnost_vserealne = st_vserealne/st_ponovitev;
fprintf('Verjetnost, da so vse lastne vrednosti realne: %.3f \n', verjetnost_vserealne);
povprecje_st_realnih = mean(stevilo_realnih_lastnih);
fprintf('Povprecje stevila realnih: %.3f \n' , povprecje_st_realnih);

%% Pomožna funkcija za paramatre v odvisnosti od velikosti matrike

maxdim = 100; %maksimalna velikost matrike
x = 1:1:maxdim;
y = zeros(1,maxdim);
z = zeros(1,maxdim);
for i = x
    [stevilo_realnih_lastnih1, vse_lastne1, normvse_lastne1, vse_sledi1, vse_det1] = fanaliza(i, st_ponovitev, d);
    y(i) =  mean(stevilo_realnih_lastnih1); %povprecno stevilo realnih
    z(i) = y(i)/i ; %delež realnih
end


%% --------ANALIZA GLEDE NA DISTRIBUCIJO---------------------------------------------
%------------------------------------------------------------------------------------

%-------UNI-------------------------------------------------------
if matches(d,'uni')
    
    %% Graf lastnih vrednosti
    figure
    plot(real(vse_lastne), imag(vse_lastne),'.')
    title('(a) Graf vseh lastnih vrednosti v kompleksni ravnini', 'FontSize', 15)
    vselastne = sprintf('vselastne_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, vselastne)

    %% Graf pricakovane vrednosti realnih lastnih v odvisnosti od velikosti matrike
    figure
    ft=fittype('A*sqrt(x)');
    A=sqrt(2/pi);
    f = fit(x',y',ft);
    plot(f);
    hold on;
    plot(x, y,'.');
    title('(a) Graf pricakovane vrednosti stevila realnih lastnih vrednosti','FontSize', 15)
    xlabel('Velikost matrike','FontSize', 15)
    st_realnih = sprintf('st_realnih_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, st_realnih)
    
    %% Graf deleža realnih lastnih vrednosti
    figure
    ft=fittype('a*x^b'); %Zakaj ??
    a = 1.2; 
    b = -0.5; % -> korenska funkcija
    f = fit(x',z',ft);
    plot(f);
    hold on;
    plot(x,z,'.');
    title('(a) Graf deleza realnih lastnih vrednosti v odvisnosti od velikosti matrike','FontSize', 15)
    xlabel('Velikost matrike','FontSize', 15)
    ylabel('Delez realnih lastnih vrednosti','FontSize', 15)
    delez_realnih = sprintf('delez_realnih_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, delez_realnih)


    %% Graf sledi 
    figure
    pd2 = fitdist(vse_sledi,'Normal');
    histfit(vse_sledi,20)
    title('(a) Histogram vseh sledi','FontSize', 15)
    sledi = sprintf('sledi_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, sledi)

    fprintf('Pricakovana vrednost sledi: %f \n' , pd2.mu);
    fprintf('Varianca sledi: %f \n' , pd2.sigma);

    %% Graf determinant
    figure
    histogram(vse_det,30)
    title('(a) Histogram vseh determinant','FontSize', 15)
    determinante = sprintf('determinante_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, determinante)
    
%----------------INT-------------------------------
elseif matches(d,'int')
    
    %% Graf lastnih vrednosti
    figure
    plot(real(vse_lastne), imag(vse_lastne),'.')
    axis equal
    title('(b) Graf vseh lastnih vrednosti v kompleksni ravnini','FontSize', 15)
    vselastne = sprintf('vselastne_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, vselastne)

    %% Graf pricakovane vrednosti realnih lastnih v odvisnosti od velikosti matrike
    figure
    ft=fittype('A*sqrt(x)');
    A=sqrt(2/pi);
    f = fit(x',y',ft);
    plot(f);
    hold on;
    plot(x, y,'.');
    title('(b) Graf pricakovane vrednosti stevila realnih lastnih vrednosti','FontSize', 15)
    xlabel('Velikost matrike','FontSize', 15)
    st_realnih = sprintf('st_realnih_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, st_realnih)
    
    %% Graf deleža realnih lastnih vrednosti
    figure
    ft=fittype('a*x^b'); %Zakaj ??
    a = 1.2; 
    b = -0.5; % -> korenska funkcija
    f = fit(x',z',ft);
    plot(f);
    hold on;
    plot(x,z,'.');
    title('(b) Graf deleza realnih lastnih vrednosti v odvisnosti od velikosti matrike','FontSize', 15)
    xlabel('Velikost matrike','FontSize', 15)
    ylabel('Delez realnih lastnih vrednosti','FontSize', 15)
    delez_realnih = sprintf('delez_realnih_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, delez_realnih)


    %% Graf sledi 
    figure
    pd2 = fitdist(vse_sledi,'Normal');
    histfit(vse_sledi,20)
    title('(b) Histogram vseh sledi','FontSize', 15)
    sledi = sprintf('sledi_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, sledi)

    fprintf('Pricakovana vrednost sledi: %f \n' , pd2.mu);
    fprintf('Varianca sledi: %f \n' , pd2.sigma);

    %% Graf determinant
    figure
    histogram(vse_det,30)
    title('(b) Histogram vseh determinant','FontSize', 15)
    determinante = sprintf('determinante_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, determinante)
    
%----------------NORM------------------------------
elseif matches(d,'norm')
    
    %% Graf lastnih vrednosti
    figure
    plot(real(vse_lastne), imag(vse_lastne),'.')
    axis equal
    title('(c) Graf vseh lastnih vrednosti v kompleksni ravnini','FontSize', 15)
    vselastne = sprintf('vselastne_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, vselastne)


    %% Graf normaliziranih lastnih vrednosti
    figure
    plot(real(normvse_lastne), imag(normvse_lastne),'.');
    axis equal
    title('Graf vseh normaliziranih lastnih vrednosti v kompleksni ravnini','FontSize', 15)
    norm_vselastne = sprintf('norm_vselastne_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, norm_vselastne)

    %% Graf porazdelitve normaliziranih realnih lastnih vrednosti
    idx = (normvse_lastne==real(normvse_lastne));
    figure
    histogram(normvse_lastne(idx),'Normalization','pdf');
    pd1 = makedist('Uniform','Lower',-1,'Upper',1);
    % histfit(normvse_lastne(idx), 20, 'Beta');
    title('Graf normaliziranih realnih lastnih vrednosti','FontSize', 15)
    xlabel('Normalizirane lastne vrednosti','FontSize', 15)
    ylabel('Delez pojavitev','FontSize', 15)
    hold on
    a = -1:1;
    b = pdf(pd1, a);
    plot(a,b);
    poraz_norm_realnih = sprintf('poraz_norm_realnih_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, poraz_norm_realnih )


 
    %% Graf pricakovane vrednosti realnih lastnih v odvisnosti od velikosti matrike
    figure
    ft=fittype('A*sqrt(x)');
    A=sqrt(2/pi); %teoreticno znana konstanta How Many Eigenvalues of a Random Matrix are Real? Alan Edelman; Eric Kostlan; Michael Shub
    f = fit(x', y',ft);
    plot(f);
    hold on
    plot(x, y,'.');
    title('(c) Graf pricakovane vrednosti stevila realnih lastnih vrednosti','FontSize', 15)
    xlabel('Velikost matrike','FontSize', 15)
    st_realnih = sprintf('st_realnih_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, st_realnih)

    %% Tabela teoretinih in eksperimentalnih pricakovanih vrednosti
    teoreticna_pricakovana = [ 1, 1.41421, 1.70711, 1.94454, 2.14905, 2.33124, 2.49708, 2.65027, 2.79332, 2.92799];
    tabela = table( teoreticna_pricakovana', y(1:10)','VariableNames',["Teoreticna pricakovana vrednost","Eksperimentalna pricakovana vrednost"]);
    pricakovana = sprintf('pricakovana_%s_%d_%d.txt',d,n,st_ponovitev);
    writetable(tabela, pricakovana);
    
    %% Graf deleža realnih lastnih vrednosti
    figure
    ft = fittype('a*x^b'); %Zakaj ??
    a = 1.2;
    b = -0.5; % -> korenska funkcija
    f = fit(x',z',ft);
    plot(f);
    hold on;
    plot(x,z,'.');
    title('(c) Graf deleza realnih lastnih vrednosti v odvisnosti od velikosti matrike','FontSize', 15)
    xlabel('Velikost matrike','FontSize', 15)
    ylabel('Delez realnih lastnih vrednosti','FontSize', 15)
    delez_realnih = sprintf('delez_realnih_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, delez_realnih)


    %% Graf sledi 
    figure
    %histogram(vse_sledi,20)
    pd2 = fitdist(vse_sledi,'Normal');
    histfit(vse_sledi,20)
    title('(c) Histogram vseh sledi','FontSize', 15)
    sledi = sprintf('sledi_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, sledi)
    
    fprintf('Pricakovana vrednost sledi: %f \n' , pd2.mu);
    fprintf('Varianca sledi: %f \n' , pd2.sigma);


    %% Graf determinant
    figure
    histogram(vse_det,30)
    title('(c) Histogram vseh determinant','FontSize', 15)
    determinante = sprintf('determinante_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, determinante)
    
%----------DISCR----------    
elseif matches(d,'discr')
    %% Graf lastnih vrednosti
    figure
    axis equal
    plot(real(vse_lastne), imag(vse_lastne),'.')
    title('(d) Graf vseh lastnih vrednosti v kompleksni ravnini','FontSize', 15)
    vselastne = sprintf('vselastne_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, vselastne)

    %% Graf pricakovane vrednosti realnih lastnih v odvisnosti od velikosti matrike
    figure
    ft=fittype('A*sqrt(x)');
    A=sqrt(2/pi);
    f = fit(x',y',ft);
    plot(f);
    hold on;
    plot(x, y,'.');
    title('(d) Graf pricakovane vrednosti stevila realnih lastnih vrednosti','FontSize', 15)
    xlabel('Velikost matrike','FontSize', 15)
    ylabel('Pricakovana vrednost stevila realnih lastnih vrednosti','FontSize', 15)
    st_realnih = sprintf('st_realnih_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, st_realnih)
    
    %% Graf deleža realnih lastnih vrednosti
    figure
    ft=fittype('a*x^b'); %Zakaj ??
    a = 1.2; 
    b = -0.5; % -> korenska funkcija
    f = fit(x',z',ft);
    plot(f);
    hold on;
    plot(x,z,'.');
    title('(d) Graf deleza realnih lastnih vrednosti v odvisnosti od velikosti matrike','FontSize', 15)
    xlabel('Velikost matrike','FontSize', 15)
    ylabel('Delez realnih lastnih vrednosti','FontSize', 15)
    delez_realnih = sprintf('delez_realnih_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, delez_realnih)


    %% Graf sledi 
    figure
    pd2 = fitdist(vse_sledi,'Normal');
    histfit(vse_sledi,20)
    title('(d) Histogram vseh sledi','FontSize', 15)
    sledi = sprintf('sledi_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, sledi)

    fprintf('Pricakovana vrednost sledi: %f \n' , pd2.mu);
    fprintf('Varianca sledi: %f \n' , pd2.sigma);

    %% Graf determinant
    figure
    histogram(vse_det,30)
    title('(d) Histogram vseh determinant','FontSize', 15)
    determinante = sprintf('determinante_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, determinante)
    
else
    error('Unidentified distribution')
end






