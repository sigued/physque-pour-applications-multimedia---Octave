function f = calculer_FMagnus (v, w)
  
  R_BALLON = 0.11;
  A = pi*R_BALLON^2; % en m2
  M_BALLON= 0.45;
  
  rho = 1.2754;  % en kg/m^3
  C_M = 0.1925 * ((norm(w)*R_BALLON)/norm(v)).^(1/4);
  cross_wv = cross(w,v);
  
  f = rho*C_M*A*((norm(v))^2)*(cross_wv/(norm(cross_wv)));
  

endfunction
