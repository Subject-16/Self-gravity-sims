% takes previous momentum,position and potential as input

function [X,P] = vectoreuler(x,p,phi,dt)

N = length(x);% number of particles initiated

%create the vector phi for updating momentum
gradphi = gradient(phi);

% implementing central difference scheme
for ii=length(phi)
    

phivec = zeros(N,1);
for ii=1:N
    phivec(ii) = gradphi(round(x(ii)+1,0));
end

% update momentum and position
P = p - dt*phivec;
X = x + dt*P; % taking mass as unity

end



% takes input as density funciton and outputs potential
function [phi] = poisson_1d(rho,dx)

% taking fourier tfo of source
rho_ft = dft_1d(rho);
N      = length(rho);  
% finding out potential in fourier space
m         = 0:1:N-1;
m         = m';
denom     = (sin(m*pi/N)).^2;
phi_ft    = -0.25*1*dx^2*(rho_ft./denom);
phi_ft(1) = phi_ft(end);% periodic BC
phi       = real(ift_1d(phi_ft));

end



% takes input x as a vector with N number of discreet values and performs ift

function [y] = ift_1d(x)

N = length(x);
k = 0:1:N-1;
n = 0:1:N-1;% vectors to be used to generate matrix
M = exp(i*2*pi*k'*n/N);

y = 1/N*M*x;

end


