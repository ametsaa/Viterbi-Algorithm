function [ y ] = bsc( c, p )
% Simulation of the transmission of c in an Asymetric Binary Canal
 n=length(c);
 y=zeros(1,n);
 
 for i=1:n
     e=rand;
     if e<p
         y(i) = not (c(i));
     else
         y(i) = c(i);
     end
 end



end

