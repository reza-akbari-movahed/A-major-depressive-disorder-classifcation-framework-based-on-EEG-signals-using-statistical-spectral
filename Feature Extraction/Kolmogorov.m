% FUNCTION: kolmogorov.m
% DATE: 9th Feb 2005
% AUTHOR: Stephen Faul (stephenf@rennes.ucc.ie)
%
% Function for estimating the Kolmogorov Complexity as per:
% "Easily Calculable Measure for the Complexity of Spatiotemporal Patterns"
% by F Kaspar and HG Schuster, Physical Review A, vol 36, num 2 pg 842
%
% Input is a digital string, so conversion from signal to a digital stream
% must be carried out a priori

function complexity=Kolmogorov(s);
n=length(s);
c=1;
l=1;

i=0;
k=1;
k_max=1;
stop=0;

while stop==0
	if s(i+k)~=s(l+k)
        if k>k_max
            k_max=k;
        end
        i=i+1;
        
        if i==l
            c=c+1;
            l=l+k_max;
            if l+1>n
                stop=1;
            else
                i=0;
                k=1;
                k_max=1;
            end
        else
            k=1;
        end
	else
        k=k+1;
        if l+k>n
            c=c+1;
            stop=1;
        end
	end
end

b=n/log2(n);

% a la Lempel and Ziv (IEEE trans inf theory it-22, 75 (1976), 
% h(n)=c(n)/b(n) where c(n) is the kolmogorov complexity
% and h(n) is a normalised measure of complexity.
complexity=c/b;