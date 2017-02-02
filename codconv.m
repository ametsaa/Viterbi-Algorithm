function [ c ] = codconv( m, g )
    n=length(g);
    [G,~,~] = paramconv(g);
    
    for i=1:n
       ct(i,:)=conv(G(i,:),m);    
    end
    
    %Convert the result in binary
    ct=rem(ct,2);
    c=[];
    m=length(ct(1,:));
    
    for i=1:m
        c=[c ct(:,i)'];
    end
end

