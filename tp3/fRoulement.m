function f = fRoulement (v)
  
  mu_r = 0.4;
  m = 0.21;
  g=9.81;
  
  f = -mu_r*m*g*(v/norm(v));
   
endfunction
