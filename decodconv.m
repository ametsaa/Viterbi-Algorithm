function [m, W, S] = decodconv(y, g)
    
    [~, M, T] = paramconv(g);
    
    n=length(g);
    lenTrellisX = floor(length(y)/n) +1;
    lenTrellisY = 2^M;
    S=zeros(lenTrellisY, lenTrellisX);
    W=ones(lenTrellisY, lenTrellisX)*inf;
    W(1,1) = 0;
    
    for t=1:lenTrellisX-1
        for i=1:lenTrellisY
            % We don't complete the begining of the trellis
            % where inf is set because we don't know if we will use this way
            if W(i,t) ~= inf
               for j=1:length(T(1,:))
                    if(T(i,j)~=-1)
                      
                      % We compute the branch metric thanks to the
                      % difference between the signature (T(i,j)) 
                      % and the corresponding  received sequence.
                        BM = sum(xor(dec2bin(T(i,j), n) -'0', y(n*(t-1)+1:n*t)));
                  
                      % We compute the new path metric thanks to 
                      % the old one and the branch metric
                        PM = W(i,t) + BM;
                        
                      % The column j of  matrix T correspond to the new placement
                      %  of the future path metric a time t+1.
                      % If we come though here for the first time W(j,t+1) will
                      %  be set because its old value is inf wich is
                      %  greater than PM.
                      %If anything goes through the condition a second time,it means there 
                      %  is a better path where cumulated weight of the path is lower.
                        
                        if PM < W(j,t+1)
                            W(j,t+1) = PM;
                  
                          % We save in S the way that has been used to reach t.
                          % We come from line i
                            S(j,t+1) = i;
                        end

                    end
                end
            end
        end
    end
    
    
    % Decoding the message
    
    m=zeros(1,(lenTrellisX-M-1)) -1;
    % the right way begin at S(1,lenTrellisX)
    path = 1;
    % M last instants correspond to the return at zero for the registers.
    % They won't be useful for decoding the message but we have to know about the whole path.
    for j=lenTrellisX:-1:lenTrellisX-M+1
        path = S(path, j);
    end
    % from now on we can decode the message
    for i=(lenTrellisX-M):-1:2
        % We go up or we stay on the top
        if (path < S(path,i)) || (path == 1 && path == S(path,i))
            m(i-1) = 0;
        % We go down or we stay on the bottom
        elseif  (path > S(path,i)) || (path == lenTrellisY && path == S(path,i))
            m(i-1) = 1;
        end
      % next index we have to look at
        path = S(path,i);

    end
         
    
end