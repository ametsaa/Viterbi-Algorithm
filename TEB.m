function [BER] = TEB(m_in, g, p)
    
    % Init
    BER = zeros(1,length(p));
   
    % Coding the message
    c=codconv(m_in,g);

    % We compute the number of error due to the transmission (bsc)
    % for each error probability p
    for i=1:length(p)
        
        y=bsc(c,p(i));
        m_out= decodconv(y,g);
        nb_error = sum(m_in ~= m_out);
        BER(i) = nb_error/length(m_in);
    end
end  