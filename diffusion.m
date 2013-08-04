% The Diffusion Equation over (-Inf,Inf) with u(x,0) = f(x)

% TIME PARAMETERS
dt = 0.1;
nt = 400; % number of time pts (including 0)
k = 4; % diffusivity

% SPATIAL PARAMETERS
nx = 201; % number of mesh points
dx = 1;
xextent = (nx-1)/2;
x = dx*linspace(-xextent,xextent,nx)';
xmid = (nx-1)/2 + 1;

% Initial CONDITIONS (the negative exponential ensures the boundary conditions
% aren't violated too much)
% ut0 = zeros(nx,1); ut0(xmid) = 1; % delta function
ut0 = zeros(nx,1); ut0(1) = 1;
% ut0 = exp(-4*abs(x)/(dx*nx)).*rand(nx,1); % concentration distribution at t = 0

% create the second differenece matrix (-1 2 -1)
% note that this form assumes 0 boundary conditions on both sides
Dxx = -toeplitz([2 -1 zeros(1,nx-2)])/dx^2;
Dxx(1,1) = 0; Dxx(1,2) = 0; % Change left boundary condition to fixed at 1

%% RUN THE SIMULATION
% use Newton's method and the diffusion equation:
%
% d^2U/dx^2 = (1/k)dU/dt --> dU/dt = k*Dxx*U
% U(t) ~ U(t-1) + (k*Dxx*U(t-1))*dt
%
% There are serious stability constraints on dt and the diffusivity, k
%
U = [ut0 zeros(nx,nt)]; % allocate space for the solution
for t = 2:nt
    U(:,t) = U(:,t-1) + k*(Dxx*U(:,t-1))*dt;
end

%% GENERATE A MOVIE
plot(x,U(:,1));
axis tight
set(gca,'nextplot','replacechildren');
F(1) = getframe;
% Record the movie
mm = 2;
for t = 2:nt
 plot(x,U(:,t));
 legend(['Diffusion Simulation: t = ' num2str(floor(t*dt)) ...
     ' [s] and k = ' num2str(k) ' [m/s^2]']);
 F(mm) = getframe; mm = mm + 1;
end

%% CONVERT TO STANDALONE FORMAT
% movie2avi(F,'difMovie.avi','compression','none','fps',5);
% mpgwrite(F,colormap,'difMovie.mpg');