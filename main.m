clear all;
close all; 
clc;

%% Part 2

% Testing paramconv on the previous exemple
g1 = [5 7];
[G, M, T] = paramconv(g1);

m=[0 1 0 1 1 0 1];
c=codconv(m,g1);
%% Part3 Vitterbi Algorithm

g2 = [1 5 7];
y2=[1 1 0 1 1 0 1 1 1 0 1 0 0 1 0];
[m2, W, S]=decodconv(y2, g2);

%% Part 4 
y1=[0 0 1 1 0 1 0 0 1 0 1 0 0 0 0 1 1 1];
ys= bsc(y1,1);

p = 0:0.025:0.5;
% The case p = 0 is not set because there wouldn't be any error
p(1) = 0.001;
m=zeros(1,10^5);

% First Generator encoders
g=[3];
BER1 = TEB(m,g,p);

%Second Generator encoders
g=[5, 7];
BER2 =TEB(m,g,p);


%Third Generator encoders
g=[15,17];
BER3 = TEB(m,g,p);

% Uncoded
BER_Uncoded = zeros(1,length(p));
for i=1:length(p)
        m_out=bsc(m,p(i));
        nb_error = sum(m ~= m_out);
        BER_Uncoded(i) = nb_error/length(m);
end
%% Result diplay

figure,
semilogy(p,BER1,'r');
hold on
semilogy(p,BER2,'b');
semilogy(p,BER3,'m');
semilogy(p,BER_Uncoded,'k');

xlabel('p')
ylabel('Error probability')
legend('g = [3]','g = [5,7]', 'g = [15 17]', 'Uncoded')
hold off