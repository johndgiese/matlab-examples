function dx = aofun(t,x)
    global m w0 e a gamma E;
    dx = zeros(2,1);
    dx(1) = x(2);
    dx(2) = -(w0^2*x(1) + 2*gamma*x(2) + a*x(1)^2 + e/m*E(t));
end