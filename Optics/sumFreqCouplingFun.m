function da = sumFreqCouplingFun(z,a)
    global g dk;
    
    da = zeros(3,1);
    
    da(1) = -1j*g*a(3)*conj(a(2))*exp(-1j*dk*z);
    da(2) = -1j*g*a(3)*conj(a(1))*exp(-1j*dk*z);
    da(3) = -1j*g*a(2)*a(1)*exp(-1j*dk*z);
  
end