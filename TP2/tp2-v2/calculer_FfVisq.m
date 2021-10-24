function f = calculer_FfVisq (v)
  
  R_BALLON = 0.11;
  A = pi*R_BALLON^2; % en m2
  M_BALLON= 0.45;
  
  rho = 1.2754;  % en kg/m^3
  u = 1.8e-5;
  
  Re = (rho*norm(v)*R_BALLON)/u;
  C_V = 0;
  
  if Re < 100000
    C_V = 0.235*norm(v);
  elseif Re > 100000 && Re < 135000
    C_V = 0.235*norm(v) - 0.125*norm(v)*((Re-100000)/35000);
  else
    C_V = 0.110*norm(v);
  endif
  
  f = -1*A*rho*C_V*v;
  
endfunction
