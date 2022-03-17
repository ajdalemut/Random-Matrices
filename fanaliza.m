
function [stevilo_realnih_lastnih, vse_lastne, normvse_lastne, vse_sledi, vse_det] = fanaliza(n, st_ponovitev, d)

    stevilo_realnih_lastnih = zeros(st_ponovitev, 1); % vector of numbers of real eigenvalues
    vse_lastne = zeros(n, st_ponovitev); % matrix of all eigenvalues
    normvse_lastne = zeros(n, st_ponovitev); % lamda/sqrt(n)
    vse_sledi = zeros(st_ponovitev,1); % vector of all traces
    vse_det = zeros(st_ponovitev,1); % vector of all determinants

    for k = 1 : st_ponovitev
        
        
    %% generating of a random matrix
        if matches(d,'uni')
            % uniformly distributed random numbers in the interval (0,1)
            A = rand(n);
        elseif matches(d,'int')
            % uniformly distributed random integers in the range defined by r
            A = randi([-5,5],n);
        elseif matches(d,'norm')
            % normally distributed random numbers
            A = randn(n);
        elseif matches(d,'discr')
            %descrete with elements a and b, both with the same probability
            a = 0;
            b = 1;
            A = a + (b-a) * randi([0, 1], n);
        else
            error('Unidentified distribution')
        end

        %% calculation of eigenvalues
        lastne = eig(A);
        for l = 1 : n
            vse_lastne(l,k) = lastne(l);
            normvse_lastne(l,k) = lastne(l)/sqrt(n);
        end

        %% number of real eigenvalues
        st_realnih_lastnih = 0;
        for i = 1 : n
            if isreal(lastne(i))
                st_realnih_lastnih = st_realnih_lastnih + 1;
            else
                continue
            end

        end

        stevilo_realnih_lastnih(k)= st_realnih_lastnih;

        %% calculation of trace
        vse_sledi(k) = trace(A);

        %% calculation of determinant
        vse_det(k) = det(A);

    end
end


