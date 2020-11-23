% takes input x as a column vector with N number of discreet values and perforrms
% dft
function [y] = dft_1d(x)

s = size(x);

if s(2)>1
    x = x';
end

N = length(x);
k = 0:1:N-1;
n = k;
%n = 0:1:N-1;% vectors to be used to generate matrix
M = exp(1i*2*pi*k'*n/N);

y = M*x;

end


