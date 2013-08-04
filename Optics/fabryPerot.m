function [t,r] = fabryPerot(nu,n1,n2,theta1,d,TEorTM)
% FABRYPEROT return the complex amplitude transmittance and reflectance of
% a FP etalon.
% [t,r] = FABRYPEROT(nu,n1,n2,theta1,d,TEorTM) returns the complex
% amplitude transmittance (T) and reflectance (R) of a slab fabry perot
% etalon where n1 is the index of the surrounding medium, n2 is the index
% of the slab, d is the spacing, theta1 is the angle of the incedent light,
% nu is a vector frequencies, and TEorTM is a boolean that specifes the
% polarization of the incident light.  A value of true will use TE, false
% TM.

    c = 3e8;
    theta2 = asin(n1/n2*sin(theta1)); % angle that the rays travel at in the sample
    if (imag(theta2) ~= 0)
       exception = MException('VerifyInputs:ImaginaryAngle', ...
       'theta2 is imaginary for the given inputs');
        throw(exception); 
    end
    
    phi2 = n2*2*pi*nu/c*d*cos(theta2);
    if (TEorTM == 0) % TM
        n1s = n1*sec(theta1);
        n2s = n2*sec(theta2);
    else % TE
        n1s = n1*cos(theta1);
        n2s = n2*cos(theta2);
    end
    
    % from eqn 7.1-27 of Fundamentals of Photonics, 2e by Saleh and Teich
    % and neglecting exp(j*phi1)
    t = 4*n1s*n2s*exp(-1j*phi2)./((n1s+n2s)^2 - (n1s-n2s)^2*exp(-2j*phi2));   
    % from eqn 7.1-23 and 7.1-24 with substitutions and neglecting
    % exp(j*phi1)
    r = -2*(n1s^2-n2s^2)*sin(phi2)./...
        ((n1s+n2s)^2 - (n1s-n2s)^2*exp(-2j*phi2));
end