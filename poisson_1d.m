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




