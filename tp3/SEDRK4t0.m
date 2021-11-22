
function qs = SEDRK4t0 (q0, deltatT)
  
  k1=g(q0);
  k2=g(q0+k1*deltatT/2);
  k3=g(q0+k2*deltatT/2);
  k4=g(q0+k3*deltatT);

  qs=q0+deltatT*(k1+2*k2+2*k3+k4)/6;

endfunction
