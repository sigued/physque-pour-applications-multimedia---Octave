
function qs = SEDRK4t0 (q0, t0, deltatT, g)
  
  k1=feval(g,q0,t0);
  k2=feval(g,q0+k1*deltatT/2,t0+deltatT/2);
  k3=feval(g,q0+k2*deltatT/2,t0+deltatT/2);
  k4=feval(g,q0+k3*deltatT,t0+deltatT);

  qs=q0+deltatT*(k1+2*k2+2*k3+k4)/6;

endfunction
