function u_i = vecteur_incident_ui (r_p, r_i)
  u_i = (r_p-r_i)./abs(r_p - r_i);
  num = (r_p-r_i);
  
  if num(3) ==0
    u_i(3) = 0;  
  endif
  
  if num(2) ==0
    u_i(2) = 0;  
  endif
  
  if num(1) ==0
    u_i(1) = 0;  
  endif
  

endfunction
