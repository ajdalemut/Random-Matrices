% dolocimo velikost nakljucne matrike, porazdelitev za konstrukcijo in stevilo ponovitev konstrukcije

d = 'norm'; % 'uni'/'int'/'norm'/'discr'
n = 50;
st_ponovitev = 400;

%-------------------------------------------------------------------------------------
% zazenemo glavno funkcijo glede na izbrane spremenljivke
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

%% Pomozna funkcija za paramatre v odvisnosti od velikosti matrike

maxdim = 100; %maksimalna velikost matrike
x = 1:1:maxdim;
y = zeros(1,maxdim);
z = zeros(1,maxdim);
det = zeros(st_ponovitev , maxdim);
for i = x
    [stevilo_realnih_lastnih1, vse_lastne1, normvse_lastne1, vse_sledi1, vse_det1] = fanaliza(i, st_ponovitev, d);
    y(i) =  mean(stevilo_realnih_lastnih1); %povprecno stevilo realnih
    z(i) = y(i)/i ; %delez realnih
    det(:,i) = vse_det1;
end


%% --------ANALIZA GLEDE NA DISTRIBUCIJO---------------------------------------------

%-------UNI, INT, DISCR-------------------------------------------------------
if matches(d,'uni') || matches(d,'int') || matches(d,'discr') 
    
    if matches(d,'uni')
        oznaka = 'a';
    elseif  matches(d,'int')
        oznaka = 'b';
    else
        oznaka = 'd';
    end
    
    %% Graf lastnih vrednosti
    figure
    plot(real(vse_lastne), imag(vse_lastne),'.')
    axis equal
    title(sprintf('(%s) Graf vseh lastnih vrednosti v kompleksni ravnini',oznaka), 'FontSize', 15)
    
    vselastne = sprintf('vselastne_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, vselastne,'epsc')

    %% Graf pricakovane vrednosti realnih lastnih v odvisnosti od velikosti matrike
    figure
    ft = fittype('a*x^b');
    f = fit(x',y',ft,'StartPoint',[0,0]);
    plot(f);
    hold on
    
    a = f.a;
    b = f.b;
    param = sprintf('f(n) = an^b, a = %.3f, b = %.3f', a, b);
    
    plot(x, y,'.');
    title(sprintf('(%s) Graf pricakovane vrednosti stevila realnih lastnih vrednosti', oznaka) ,'FontSize', 15)
    xlabel('Velikost matrike','FontSize', 10)
    ylabel('Pricakovana vrednost','FontSize', 10)
    legend({param, 'Eksperimentalne vrednosti'}, 'Location', 'SouthEast')
    
    st_realnih = sprintf('st_realnih_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, st_realnih,'epsc')
    
    %% Graf deleza realnih lastnih vrednosti
    figure
    ft = fittype('a*x^b'); 
    f = fit(x',z',ft,'StartPoint',[0,0]);
    plot(f);
    hold on
    
    a = f.a;
    b = f.b;
    param = sprintf('f(n) = an^b, a = %.3f, b = %.3f', a, b);
    
    plot(x,z,'.');
    title(sprintf('(%s) Graf deleza realnih lastnih vrednosti', oznaka),'FontSize', 15)
    xlabel('Velikost matrike','FontSize', 10)
    ylabel('Delez realnih lastnih vrednosti','FontSize', 10)
    legend({param, 'Eksperimentalne vrednosti'})
    
    delez_realnih = sprintf('delez_realnih_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, delez_realnih,'epsc')


    %% Graf sledi 
    figure
    pd2 = fitdist(vse_sledi,'Normal');
    h = histfit(vse_sledi,20);
    h(1).FaceColor = [0.7 0.7 0.7];
    title(sprintf('(%s) Histogram vseh sledi', oznaka), 'FontSize', 15)

    hold on
    mu = pd2.mu;
    sigma = pd2.sigma;
    xline(mu, 'Color', 'r', 'LineWidth', 2);
    xline(mu - sigma, 'Color', 'r', 'LineWidth', 2, 'LineStyle', '--');
    xline(mu + sigma, 'Color', 'r', 'LineWidth', 2, 'LineStyle', '--');
    sMean = sprintf('Mean = %.3f\n  SD = %.3f', mu, sigma);
    xL=xlim;
    yL=ylim;
    text(0.99*xL(2),0.99*yL(2),sMean,'HorizontalAlignment','right','VerticalAlignment','top')
    
    sledi = sprintf('sledi_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, sledi,'epsc')

    %% Graf determinant
    figure
    histogram(vse_det,30,'FaceColor', [0.7 0.7 0.7])
    title(sprintf('(%s) Histogram vseh determinant', oznaka),'FontSize', 15)
    determinante = sprintf('determinante_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, determinante,'epsc')
    
    % Graf logaritmirane determinante
    log_det= log(abs(vse_det));
    figure
    pd2 = fitdist(log_det,'Normal');
    h = histfit(log_det,20);
    h(1).FaceColor = [0.7 0.7 0.7];
    title(sprintf('(%s) Histogram logaritmov vseh determinant', oznaka),'FontSize', 15)
    
    hold on
    mu = pd2.mu;
    sigma = pd2.sigma;
    xline(mu, 'Color', 'r', 'LineWidth', 2);
    xline(mu - sigma, 'Color', 'r', 'LineWidth', 2, 'LineStyle', '--');
    xline(mu + sigma, 'Color', 'r', 'LineWidth', 2, 'LineStyle', '--');
    sMean = sprintf('Mean = %.3f\n  SD = %.3f', mu, sigma);
    xL=xlim;
    yL=ylim;
    text(0.99*xL(2),0.99*yL(2),sMean,'HorizontalAlignment','right','VerticalAlignment','top')
    
    log_determinante = sprintf('log_determinante_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, log_determinante,'epsc')
   
%----------------NORM------------------------------
elseif matches(d,'norm')
    
    %% Graf lastnih vrednosti
    figure
    plot(real(vse_lastne), imag(vse_lastne),'.')
    axis equal
    title('(c) Graf vseh lastnih vrednosti v kompleksni ravnini','FontSize', 15)
    
    vselastne = sprintf('vselastne_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, vselastne,'epsc')


    %% Graf normaliziranih lastnih vrednosti
    figure
    plot(real(normvse_lastne), imag(normvse_lastne),'.');
    axis equal
    title('Graf vseh normaliziranih lastnih vrednosti v kompleksni ravnini','FontSize', 15)
    
    norm_vselastne = sprintf('norm_vselastne_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, norm_vselastne,'epsc')

    %% Graf porazdelitve normaliziranih realnih lastnih vrednosti
    idx = (normvse_lastne==real(normvse_lastne));
    figure
    histogram(normvse_lastne(idx),'Normalization','pdf','FaceColor', [0.7 0.7 0.7]);
    pd1 = makedist('Uniform','Lower',-1,'Upper',1);
    ylim([0 0.6])
    title('Graf normaliziranih realnih lastnih vrednosti','FontSize', 15)
    xlabel('Normalizirane lastne vrednosti','FontSize', 15)
    ylabel('Delez pojavitev','FontSize', 15)
    hold on
    a = -1:1;
    b = pdf(pd1, a);
    plot(a,b);
    
    poraz_norm_realnih = sprintf('poraz_norm_realnih_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, poraz_norm_realnih,'epsc')

    %% Graf pricakovane vrednosti realnih lastnih v odvisnosti od velikosti matrike
    figure
    ft=fittype('A*sqrt(x)');
    f = fit(x', y',ft,'StartPoint',[0]);
    plot(f);
    hold on
    
    A = f.A;
    param = sprintf('f(n) = Asqrt(n), A = %.3f', A);

    plot(x, y,'.');
    title('(c) Graf pricakovane vrednosti stevila realnih lastnih vrednosti','FontSize', 15)
    xlabel('Velikost matrike','FontSize', 10)
    ylabel('Pricakovana vrednost','FontSize', 10)
    legend({param, 'Eksperimentalne vrednosti'}, 'Location', 'SouthEast')
    
    st_realnih = sprintf('st_realnih_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, st_realnih,'epsc')

    %% Tabela teoretinih in eksperimentalnih pricakovanih vrednosti
    teoreticna_pricakovana = [ 1, 1.41421, 1.70711, 1.94454, 2.14905, 2.33124, 2.49708, 2.65027, 2.79332, 2.92799];
    tabela = table( teoreticna_pricakovana', y(1:10)','VariableNames',["Teoreticna pricakovana vrednost","Eksperimentalna pricakovana vrednost"]);
    pricakovana = sprintf('pricakovana_%s_%d_%d.txt',d,n,st_ponovitev);
    writetable(tabela, pricakovana);
    
    %% Graf deleza realnih lastnih vrednosti
    figure
    ft = fittype('a*x^b'); 
    f = fit(x',z',ft,'StartPoint',[0,0]);
    plot(f);
    hold on
    
    a = f.a;
    b = f.b;
    param = sprintf('f(n) = an^b, a = %.3f, b = %.3f', a, b);
    
    plot(x,z,'.');
    title('(c) Graf deleza realnih lastnih vrednosti','FontSize', 15)
    xlabel('Velikost matrike','FontSize', 10)
    ylabel('Delez realnih lastnih vrednosti','FontSize', 10)
    legend({param, 'Eksperimentalne vrednosti'})
    
    delez_realnih = sprintf('delez_realnih_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, delez_realnih,'epsc')


    %% Graf sledi 
    figure
    pd2 = fitdist(vse_sledi,'Normal');
    h = histfit(vse_sledi,20);
    h(1).FaceColor = [0.7 0.7 0.7];
    title('(c) Histogram vseh sledi','FontSize', 15)

    hold on
    mu = pd2.mu;
    sigma = pd2.sigma;
    xline(mu, 'Color', 'r', 'LineWidth', 2);
    xline(mu - sigma, 'Color', 'r', 'LineWidth', 2, 'LineStyle', '--');
    xline(mu + sigma, 'Color', 'r', 'LineWidth', 2, 'LineStyle', '--');
    sMean = sprintf('Mean = %.3f\n  SD = %.3f', mu, sigma);
    xL=xlim;
    yL=ylim;
    text(0.99*xL(2),0.99*yL(2),sMean,'HorizontalAlignment','right','VerticalAlignment','top')
    
    sledi = sprintf('sledi_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, sledi,'epsc')


    %% Graf determinant
    figure
    histogram(vse_det,30,'FaceColor', [0.7 0.7 0.7])
    title('(c) Histogram vseh determinant','FontSize', 15)
    
    determinante = sprintf('determinante_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, determinante,'epsc')
    
    % Graf logaritmirane determinante
    log_det= log(abs(vse_det));
    figure
    pd2 = fitdist(log_det,'Normal');
    h = histfit(log_det,20);
    h(1).FaceColor = [0.7 0.7 0.7];
    title('(c) Histogram logaritmov vseh determinant','FontSize', 15)
    
    hold on
    mu = pd2.mu;
    sigma = pd2.sigma;
    xline(mu, 'Color', 'r', 'LineWidth', 2);
    xline(mu - sigma, 'Color', 'r', 'LineWidth', 2, 'LineStyle', '--');
    xline(mu + sigma, 'Color', 'r', 'LineWidth', 2, 'LineStyle', '--');
    sMean = sprintf('Mean = %.3f\n  SD = %.3f', mu, sigma);
    xL=xlim;
    yL=ylim;
    text(0.99*xL(2),0.99*yL(2),sMean,'HorizontalAlignment','right','VerticalAlignment','top')
    
    log_determinante = sprintf('log_determinante_%s_%d_%d.eps',d,n,st_ponovitev);
    saveas(gcf, log_determinante,'epsc')

else
    error('Unidentified distribution')
end






