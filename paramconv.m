function [G,M,T] = paramconv(g)
% g : vectors with entries in octal representing the polynomial generators of a dimension 1 convolutional code. 
% G : binary matrix whose rows contains the coefficients of each polynomial generator specified in g, from lowest to highest degree. 
% M : memory of the convolutional code specified by the generator polynomials in g.


    n=length(g); % Length of the code

    for i=1:n
        gtmp(i) = base2dec(int2str(g(i)),8); % from octal to binary
    end
    G = fliplr(dec2bin(gtmp)-'0');

    M=length(G(1,:))-1; 



    % Create the m_(t-l) list 
    % Correspond to the left side of the diagram
    tab=[];
    for i=0:2^(M)-1
        tab(i+1)=i;
    end
    tab_bin=dec2bin(tab)-'0';
    
    % initialization of transition matrix 
    T=-ones(2^M);
    for i=1:2^M      
        
        % Transition downward(mt=1)
        mt=1;
        % Get messages at instant t
        tab_1=[mt tab_bin(i,:)];
        ct_down=rem(tab_1*G',2);
        %The index of column (j) correspond to mt, mt-1, ... , mt-(M-1)
        %convertion to decimal with a gap of 1 index
        j=bin2dec(num2str(tab_1(1:M)))+1;
        T(i,j)= bin2dec(num2str(ct_down));
        
        % Transition upward (mt=0)
        mt=0;
        tab_0=[mt tab_bin(i,:)];
        ct_up=rem(tab_0*G',2);
        j=bin2dec(num2str(tab_0(1:M)))+1;
        T(i,j)= bin2dec(num2str(ct_up));
      
    end
    
end

