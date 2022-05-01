function [roots, st_realnih] = roots_of_matrix(A, p)
    tic
    n = size(A);
    
    if n(1) == n(2)
        n = n(1);
    else
        error('Not a square matrix')
    end
    
    syms x [n n]
    xsq = x^p;
    sol = solve(xsq == A, x );

    l = length(sol.x1_1);
    roots = cell(1,l);
    for k = 1:l
        roots{k} = zeros(n,n);
        for i = 1:n
            for j = 1:n
                xij = sprintf('x%d_%d',i,j);
                roots{k}(i,j) = sol.(xij)(k);
            end
        end
    end
    
    st_realnih = 0;
    for k = 1:l
        if isreal(roots{k}) 
            st_realnih = st_realnih + 1;
        end
    end
  toc
end