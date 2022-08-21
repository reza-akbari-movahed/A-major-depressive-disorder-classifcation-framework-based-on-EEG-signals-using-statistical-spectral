function [C0] = C0_Cal(x)
N = length(x);
X = (1/N).*fft(x);
G = (abs(X)).^2 ;
M = (1/N).*(sum(G));
X_ind = G<=M;
k = find(X_ind);
Y = X ;
for i=1:size(k,2)
    Y(1,k(i)) = 0 ;
end
y = N .* ifft(Y);
A1_F = (abs(x-y)).^2 ;
A0_F = (abs(x)).^2 ;
A1 = sum(A1_F);
A0 = sum(A0_F);
C0 = A1/A0;
end

