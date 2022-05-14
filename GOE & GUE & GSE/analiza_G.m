% dolocimo velikost nakljucne matrike, porazdelitev za konstrukcijo in stevilo ponovitev konstrukcije

d = 'GSE'; % 'GOE'/'GUE'/'GSE'
n = 50;
st_ponovitev = 50000;

[vse_lastne, normvse_lastne, spacing, mean_spacing, vse_sledi, vse_det] = fanaliza_G(n, st_ponovitev, d);


%% Graf sledi 
figure
pd2 = fitdist(vse_sledi,'Normal');
h = histfit(vse_sledi,20);
h(1).FaceColor = [0.7 0.7 0.7];
title(sprintf('(%s) Histogram vseh sledi', d), 'FontSize', 15)

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

sledi = sprintf('sledi_G_%s_%d_%d.eps',d,n,st_ponovitev);
saveas(gcf, sledi,'epsc')

%% Graf determinant
    
figure
plot(real(vse_det), imag(vse_det),'.')
axis equal
title(sprintf('(%s) Graf vseh determinant v kompleksni ravnini',d), 'FontSize', 15)
determinante1 = sprintf('realnedeterminante_G_%s_%d_%d.eps',d,n,st_ponovitev);
saveas(gcf, determinante1,'epsc')
    
figure
histogram(real(vse_det),30,'FaceColor', [0.7 0.7 0.7])
title(sprintf('(%s) Histogram vseh determinant', d),'FontSize', 15)
determinante2 = sprintf('determinante_G_%s_%d_%d.eps',d,n,st_ponovitev);
saveas(gcf, determinante2,'epsc')

% Graf logaritmirane determinante
log_det= log(abs(vse_det));
figure
pd2 = fitdist(log_det,'Normal');
h = histfit(log_det,20);
h(1).FaceColor = [0.7 0.7 0.7];
title(sprintf('(%s) Histogram logaritmov vseh determinant', d),'FontSize', 15)

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

log_determinante = sprintf('log_determinante_G_%s_%d_%d.eps',d,n,st_ponovitev);
saveas(gcf, log_determinante,'epsc')

   