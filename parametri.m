% dolocimo velikost nakljucne matrike in stevilo ponovitev konstrukcije
d = 'norm'; % 'uni'/'int'/'norm'/'discr'
st_ponovitev = 400;

%% Pomozna funkcija za paramatre v odvisnosti od velikosti matrike
maxdim = 100; %maksimalna velikost matrike
n = 1:1:maxdim;
sigma_tr = zeros(1, maxdim);
mu_det = zeros(1, maxdim);
sigma_det = zeros(1, maxdim);
for i = n
    [stevilo_realnih_lastnih1, vse_lastne1, normvse_lastne1, vse_sledi1, vse_det1] = fanaliza(i, st_ponovitev, d);
    log_det = log(abs(vse_det1));
    sigma_tr(i) = sqrt(var(vse_sledi1));
    mu_det(i) = mean(log_det);
    sigma_det(i) = sqrt(var(log_det));
end

% Oznake za naslove-----------------------------
if matches(d,'uni')
    oznaka = 'a';
elseif  matches(d,'int')
    oznaka = 'b';
elseif matches(d,'norm')
    oznaka = 'c';
elseif matches(d,'discr')
    oznaka = 'd';
else
    error('Unidentified distribution')
end
%-----------------------------------------------

% varianca sledi
    figure
    ft = fittype('a*x^b');
    f = fit(n',sigma_tr',ft,'StartPoint',[0,0]);
    plot(f);
    hold on
    
    a = f.a;
    b = f.b;
    param = sprintf('f(n) = an^b, a = %.3f, b = %.3f', a, b);
    
    plot(n, sigma_tr,'.');
    xlabel('Velikost matrike','FontSize', 10)
    ylabel('Varianca','FontSize', 10)
    title(sprintf('(%s) Varianca sledi ', oznaka),'FontSize', 15)
    legend({param, 'Eksperimentalne vrednosti'},'Location', 'SouthEast')
    
    tr = sprintf('parametri_tr_mu_%s_%d.eps',d,st_ponovitev);
    saveas(gcf, tr,'epsc')
    
    
%% ------------UNI-------------------------------------------------------
if matches(d,'uni')
    
    % pricakovana vrednost logaritma determinante 
    figure
    ft1 = fittype('p1*x^4 + p2*x^3 + p3*x^2 + p4*x + p5');
    f1 = fit(n',mu_det', ft1,'StartPoint',[0,0,0,0,0]); 
    plot(f1);
    hold on
    
    p1 = f1.p1;
    p2 = f1.p2;
    p3 = f1.p3;
    p4 = f1.p4;
    p5 = f1.p5;
    param = sprintf(['f(n) = p_1n^4 + p_2n^3 + p_3n^2 + p_4n + p_5'  newline 'p_1 = %.3f, p_2 = %.3f, p_3 = %.3f, p_4 = %.3f, p_5 = %.3f'], p1, p2, p3, p4, p5);
    
    plot(n, mu_det,'.');
    xlabel('Velikost matrike','FontSize', 10)
    ylabel('Pricakovana vrednost','FontSize', 10)
    title(sprintf('(%s) Pricakovana vrednost logaritma determinante', oznaka),'FontSize', 15)
    legend({param, 'Eksperimentalne vrednosti'},'Location', 'NorthWest');
    
    det = sprintf('parametri_det_mu_%s_%d.eps',d,st_ponovitev);
    saveas(gcf, det,'epsc')

    % variance logaritma determinante 
    figure
    ft2 = fittype('a*x^b');
    f2 = fit(n',sigma_det',ft2,'StartPoint',[0,0]);
    plot(f2);
    hold on
    
    a = f2.a;
    b = f2.b;
    param = sprintf('f(n) = an^b, a = %.3f, b = %.3f', a, b);
    
    plot(n, sigma_det,'.');
    xlabel('Velikost matrike','FontSize', 10)
    ylabel('Varianca','FontSize', 10)
    title(sprintf('(%s) Varianca logaritma determinante', oznaka),'FontSize', 15);
    legend({param, 'Eksperimentalne vrednosti'},'Location', 'SouthEast');
    
    det = sprintf('parametri_det_sigma_%s_%d.eps',d,st_ponovitev);
    saveas(gcf, det,'epsc')
    
%% ------------INT--------------------------------------------------------
elseif  matches(d,'int')

    idx1 = isfinite(mu_det);
    idx2 = isfinite(sigma_det);
    
    % pricakovana vrednost logaritma determinante 
    figure
    ft1 = fittype('a*x^b');
    f1 = fit(n(idx1)',mu_det(idx1)',ft1,'StartPoint',[0,0]);
    plot(f1);
    hold on
    
    a1 = f1.a;
    b1 = f1.b;
    param = sprintf('f(n) = an^b, a = %.3f, b = %.3f', a1, b1);
    
    plot(n, mu_det,'.');
    xlabel('Velikost matrike','FontSize', 10)
    ylabel('Pricakovana vrednost','FontSize', 10)
    title(sprintf('(%s) Pricakovana vrednost logaritma determinante', oznaka),'FontSize', 15)
    legend({param, 'Eksperimentalne vrednosti'},'Location', 'NorthWest');
    
    det = sprintf('parametri_det_mu_%s_%d.eps',d,st_ponovitev);
    saveas(gcf, det,'epsc')

    % variance logaritma determinante 
    figure
    ft2 = fittype('a*x^b');
    f2 = fit(n(idx2)',sigma_det(idx2)',ft2,'StartPoint',[0,0]);
    plot(f2);
    hold on
    
    a2 = f2.a;
    b2 = f2.b;
    param = sprintf('f(n) = an^b, a = %.3f, b = %.3f', a2, b2);
    
    plot(n, sigma_det,'.');
    xlabel('Velikost matrike','FontSize', 10)
    ylabel('Varianca','FontSize', 10)
    title(sprintf('(%s) Varianca logaritma determinante',oznaka),'FontSize', 15)
    legend({param, 'Eksperimentalne vrednosti'},'Location', 'SouthEast');
    
    det = sprintf('parametri_det_sigma_%s_%d.eps',d,st_ponovitev);
    saveas(gcf, det,'epsc')

%% -----------DISCR------------------------------------------------------
elseif matches(d,'discr') 
    
    idx1 = isfinite(mu_det);
    idx2 = isfinite(sigma_det);
    
    % pricakovana vrednost logaritma determinante 
    figure
    ft1 = fittype(' a*x^2 + b*x + c');
    f1 = fit(n(idx1)',mu_det(idx1)',ft1,'StartPoint',[0,0,0]);
    plot(f1);
    hold on
    
    a1 = f1.a;
    b1 = f1.b;
    c1 = f1.c;
    param = sprintf('f(n) = an^2 + bn + c, a = %.3f, b = %.3f, c = %.3f', a1, b1, c1);
    
    plot(n, mu_det,'.');
    xlabel('Velikost matrike','FontSize', 10)
    ylabel('Pricakovana vrednost','FontSize', 10)
    title( sprintf('(%s) Pricakovana vrednost logaritma determinante', oznaka),'FontSize', 15)
    legend({param, 'Eksperimentalne vrednosti'},'Location', 'NorthWest');
    
    det = sprintf('parametri_det_mu_%s_%d.eps',d,st_ponovitev);
    saveas(gcf, det,'epsc')

    % variance logaritma determinante 
    figure
    plot(n, sigma_det,'.');
    xlabel('Velikost matrike','FontSize', 10)
    ylabel('Varianca','FontSize', 10)
    title(sprintf('(%s) Varianca logaritma determinante', oznaka),'FontSize', 15)
    legend({'Eksperimentalne vrednosti'},'Location', 'NorthEast');
    
    det = sprintf('parametri_det_sigma_%s_%d.eps',d,st_ponovitev);
    saveas(gcf, det,'epsc')


%% -----------NORM--------------------------------------------------
elseif matches(d,'norm')
    
    % pricakovana vrednost logaritma determinante 
    figure
    y = (1/2) * log(factorial(n-1)); %funkcija iz literature
    plot(n,y,'r-')
    hold on
    plot(n, mu_det,'.');
    xlabel('Velikost matrike','FontSize', 10)
    ylabel('Pricakovana vrednost','FontSize', 10)
    title(sprintf('(%s) Pricakovana vrednost logaritma determinante', oznaka),'FontSize', 15)
    legend({'f(n) = (1/2) * log((n-1)!)', 'Eksperimentalne vrednosti'},'Location', 'NorthWest')
    
    det = sprintf('parametri_det_mu_%s_%d.eps',d,st_ponovitev);
    saveas(gcf, det,'epsc')

    % variance logaritma determinante 
    figure
    ft1 = fittype('sqrt((1/2).*log(x)) + a');
    f1 = fit(n',sigma_det', ft1,'StartPoint',[0]); 
    plot(f1);
    hold on
    
    a = f1.a;
    param = sprintf('f(n) = sqrt((1/2)*log(n)) + a, a = %.3f', a);
    
    plot(n, sigma_det,'.');
    xlabel('Velikost matrike','FontSize', 10)
    ylabel('Varianca','FontSize', 10)
    title(sprintf('(%s) Variance logaritma determinante', oznaka),'FontSize', 15)
    legend({param, 'Eksperimentalne vrednosti'},'Location', 'SouthEast')
    
    det = sprintf('parametri_det_sigma_%s_%d.eps',d,st_ponovitev);
    saveas(gcf, det,'epsc')

else
    error('Unidentified distribution')
end

