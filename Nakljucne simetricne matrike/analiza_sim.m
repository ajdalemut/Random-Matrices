% dolocimo velikost nakljucne matrike, porazdelitev za konstrukcijo in stevilo ponovitev konstrukcije

d = 'discr'; % 'uni'/'int'/'norm'/'discr'
n = 50;
st_ponovitev = 400;

%------------------------------------------------------------------------------------------
% zaženemo glavno funkcijo glede na izbrane spremenljivke
[vse_lastne, vse_sledi, vse_det] = fanaliza_sim(n, st_ponovitev, d);

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

%% Graf lastnih vrednosti
figure
plot(real(vse_lastne), imag(vse_lastne),'.')
title(sprintf('(%s) Graf vseh lastnih vrednosti v kompleksni ravnini', oznaka), 'FontSize', 15)
vselastne = sprintf('vselastne_sim_%s_%d_%d.eps',d,n,st_ponovitev);
saveas(gcf, vselastne,'epsc')
    
%% Graf sledi 
figure
pd2 = fitdist(vse_sledi,'Normal');
h = histfit(vse_sledi,20);
h(1).FaceColor = [0.7 0.7 0.7];
title(sprintf('(%s) Histogram vseh sledi', oznaka), 'FontSize', 15)

hold on;
mu = pd2.mu;
sigma = pd2.sigma;
xline(mu, 'Color', 'r', 'LineWidth', 2);
xline(mu - sigma, 'Color', 'r', 'LineWidth', 2, 'LineStyle', '--'); 
xline(mu + sigma, 'Color', 'r', 'LineWidth', 2, 'LineStyle', '--');
sMean = sprintf('Mean = %.3f\n  SD = %.3f', mu, sigma);
xL=xlim;
yL=ylim;
text(0.99*xL(2),0.99*yL(2),sMean,'HorizontalAlignment','right','VerticalAlignment','top')

sledi = sprintf('sledi_sim_%s_%d_%d.eps',d,n,st_ponovitev);
saveas(gcf, sledi,'epsc')

%% Graf determinant
figure
histogram(vse_det,30,'FaceColor', [0.7 0.7 0.7])
title(sprintf('(%s) Histogram vseh determinant', oznaka), 'FontSize', 15)
determinante = sprintf('determinante_sim_%s_%d_%d.eps',d,n,st_ponovitev);
saveas(gcf, determinante,'epsc')

% Graf logaritmirane determinante
log_det= log(abs(vse_det));
figure
pd2 = fitdist(log_det,'Normal');
h = histfit(log_det,20);
h(1).FaceColor = [0.7 0.7 0.7];
title(sprintf('(%s) Histogram logaritmov vseh determinant', oznaka), 'FontSize', 15)
    
hold on;
mu = pd2.mu;
sigma = pd2.sigma;
xline(mu, 'Color', 'r', 'LineWidth', 2);
xline(mu - sigma, 'Color', 'r', 'LineWidth', 2, 'LineStyle', '--');
xline(mu + sigma, 'Color', 'r', 'LineWidth', 2, 'LineStyle', '--');
sMean = sprintf('Mean = %.3f\n  SD = %.3f', mu, sigma);
xL=xlim;
yL=ylim;
text(0.99*xL(2),0.99*yL(2),sMean,'HorizontalAlignment','right','VerticalAlignment','top')
    
log_determinante = sprintf('log_determinante_sim_%s_%d_%d.eps',d,n,st_ponovitev);
saveas(gcf, log_determinante,'epsc')
    








