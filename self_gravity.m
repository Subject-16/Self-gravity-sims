% this code generates a self gravitating system of particles under a poisson potential
clear
clc

% defining simulation parameters
S      = 100; % total space in 1d
dx     = 1;% length of each segment
N      = S/dx; % number of grid points
T      = 100; % total run time
dt     = 0.1;% time step
nsteps = T/dt;

% defining position,momenta and source function at t=0
n     = 100;% number of particles to be simulated
x     = zeros(n,nsteps);
p     = zeros(n,nsteps);
x1    = [1:T];
p1    = sin(2*pi/100*x1);
%p1=zeros(1,n);
p(:,1)= p1;
x(:,1)= x1;

% simulation loop
for ii=1:(nsteps-1)
    
    rho   = zeros(N,1);% update rho
    for jj=1:n
        rho(round(x(jj,ii)+1,0)) = 1;
    end
    
    phi = poisson_1d(rho,dx);% update phi
    
    [x(:,ii+1),p(:,ii+1)] = vectoreuler(x(:,ii),p(:,ii),phi,dt);% update position,momentum
    
    % implementing circular method
    for mm=1:n
        if(x(mm,ii+1)<0)
            x(mm,ii+1) = x(mm,ii+1) + 100;
        else
            if(x(mm,ii+1)>S)
                x(mm,ii+1) = x(mm,ii+1) - 100;
            end
        end
    end
end

x1_t = x(1,:);
p1_t = p(1,:);
x2_t = x(2,:);
p2_t = p(2,:);

%% Set up the movie. Section for Setting up movie

% writerObj = VideoWriter('sinusoidal-phase-10,000steps.avi'); % Name it.
% writerObj.FrameRate = 7; % How many frames per second.
% open(writerObj); 
%  figure
% for i=1:nsteps      
%     % We just use pause but pretend you have some really complicated thing here...
%     pause(0.0001);
%     %figure(fId); % Makes sure you use your desired frame.
%     plot(x(:,i),p(:,i),'*');
%     %plot(x1_t(1:i),p1_t(1:i),'-r');
%     %hold
%     %plot(x2_t(1:i),p2_t(1:i),'-b');
%     %hold
%     xlim([0,100])
%     ylim([-25,25])
%     xlabel('position');ylabel('momentum');title('Phase-space-plot')
%     %if mod(i,4)==0, % Uncomment to take 1 out of every 4 frames.
%         frame = getframe(gcf); % 'gcf' can handle if you zoom in to take a movie.
%         writeVideo(writerObj, frame);
%     %end
%  
% end
% hold off
% close(writerObj); % Saves the movie.

%% Section for taking snapshots



i = 1;
for i=1:100
     
   if(mod(i,5)==0)
     h = figure  
     plot(x(:,i),p(:,i),'*');
     xlim([0,100]);ylim([-25,25])
     if(i==1)
         hold
     end
     xlabel('position');ylabel('momentum');title('Phase-space-plot')
     saveas(h,sprintf('100_particles_%d.png',i))
     
   end
end

