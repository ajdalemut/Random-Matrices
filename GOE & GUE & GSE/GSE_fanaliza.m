function [vse_lastne, normvse_lastne, spacing, mean_spacing]= GSE_fanaliza(n, st_ponovitev)    

    vse_lastne = zeros(n, st_ponovitev); % matrix of all eigenvalues (size of matrix is not n anymore so we can't set the dimension)
    normvse_lastne = zeros(n, st_ponovitev); % lamda/sqrt(n)
    spacing = zeros(n-1,st_ponovitev); % normalized spacings
    mean_spacing = zeros(1, st_ponovitev);
    
    for k = 1 : st_ponovitev

        %% generating of a random GSE matrix
        A = randn(n) + 1i*randn(n);
        B = randn(n) + 1i*randn(n);
        M = [A B; -conj(B) conj(A)]; 
        M = (M + M')/2; 

        %% calculation of eigenvalues
        lastne = sort(eig(M));
        for l = 1 : n
            vse_lastne(l,k) = lastne(2*l);
            normvse_lastne(l,k) = lastne(2*l)/sqrt(n);
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
    