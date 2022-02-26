
function [stevilo_realnih_lastnih, vse_lastne, vse_sledi, vse_det] = fanaliza(n, st_ponovitev)

    stevilo_realnih_lastnih = zeros(st_ponovitev, 1); %vector of numbers of real eigenvalues
    vse_lastne = zeros(n, st_ponovitev); % matrix of all eigenvalues
    vse_sledi = zeros(st_ponovitev,1); %vector of all traces
    vse_det = zeros(st_ponovitev,1); %vector of all determinants

    for k = 1 : st_ponovitev

        % naklju?na matrika (uni/normal/symmetric)
        A = rand(n,n);
        % A = randn(n,n); 
        % A = tril(A) + triu(A',1);

        %izra?un lastnih vrednosti
        lastne = eig(A);
        for l = 1 : n
            vse_lastne(l,k)= lastne(l);
        end

        %izracun st lastnih vrednosti
        st_realnih_lastnih= 0;
        for i = 1:length(lastne)
            if isreal(lastne(i))
                st_realnih_lastnih = st_realnih_lastnih + 1  ;
            else
                continue
            end

        end

        stevilo_realnih_lastnih(k)= st_realnih_lastnih;

        %izracun sledi nakljucne matrike
        vse_sledi(k) = trace(A);

        %izracun determinante nakljucne matrike
        vse_det(k) = det(A);

    end
end


