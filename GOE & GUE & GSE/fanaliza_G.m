function [vse_lastne, spacing, mean_spacing, vse_sledi, vse_det] = fanaliza_G(n, st_ponovitev, tip)

    vse_lastne = zeros(n, st_ponovitev); % matrix of all eigenvalues
    spacing = zeros(n-1,st_ponovitev); % normalized spacings
    mean_spacing = zeros(1, st_ponovitev);
    vse_sledi = zeros(st_ponovitev,1); % vector of all traces
    vse_det = zeros(st_ponovitev,1); % vector of all determinants
    
    for k = 1 : st_ponovitev
        
        %% generating of a random matrix
        if matches(tip,'GOE')
            A = randn(n);
            A = (A + A')/ 2;
            
        elseif matches(tip,'GUE')
            A = randn(n) + 1i*randn(n);
            A = (A + A')/ 2;
% 
        elseif matches(tip,'GSE')
            A1 = randn(n) + 1i*randn(n);
            B1 = randn(n) + 1i*randn(n);
            M = [A1 B1; -conj(B1) conj(A1)]; 
            A = (M + M')/2; 

        else
            continue
        end
        
        %% calculation of eigenvalues
        if matches(tip,'GOE') || matches(tip,'GUE')
            lastne = sort(eig(A));
            for l = 1 : n
                vse_lastne(l,k) = lastne(l);
            end
        else %if tip = 'GSE'
            lastne = sort(eig(A));
            for l = 1 : n
                vse_lastne(l,k) = lastne(2*l);
            end
        end
        
        %% calculation of trace
        vse_sledi(k) = trace(A);

        %% calculation of determinant
        vse_det(k) = det(A);
        
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


        
