function [vse_lastne, normvse_lastne, spacing, mean_spacing] = GUE_fanaliza(n, st_ponovitev)

    vse_lastne = zeros(n, st_ponovitev); % matrix of all eigenvalues
    normvse_lastne = zeros(n, st_ponovitev); % lamda/sqrt(n)
    spacing = zeros(n-1,st_ponovitev); % normalized spacings
    mean_spacing = zeros(1, st_ponovitev);
    
    for k = 1 : st_ponovitev
        
        %% generating of a random GUE matrix
        A = randn(n) + 1i*randn(n);
        A = (A + A')/ 2;
% 
%         A = sqrt(1/2)*(randn(n) + 1i*randn(n));
%         A = (A + A') / 2;

        %% calculation of eigenvalues
        lastne = sort(eig(A));
        for l = 1 : n
            vse_lastne(l,k) = lastne(l);
            normvse_lastne(l,k) = lastne(l)/sqrt(n);
        end
        
    end
    
%% calculation of spacing i.e. (lamda(n+1)-lambda(n))
    for j = 1:st_ponovitev
       for i = 1:n-1
           spacing(i,j) = vse_lastne(i+1,j)-vse_lastne(i,j);
       end
         mean_spacing(j) = mean(spacing(:,j));
         spacing(:,j) = spacing(:,j)./mean_spacing(j) ;
    end
end