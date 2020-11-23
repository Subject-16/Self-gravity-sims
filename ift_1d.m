% takes input x as a vector with N number of discreet values and performs ift

function [y] = ift_1d(x)

s = size(x);

if s(2)>1
    x = x';
end

N = length(x);
k = 0:1:N-1;
n = 0:1:N-1;% vectors to be used to generate matrix
M = exp(i*2*pi*k'*n/N);

y = 1/N*M*x;

end
