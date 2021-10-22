function [r_0, r_i, v_0, v_i, t, limite, coup ] = trajectoire (xy0,Vb0,Wb0, rayon_ballon, delta_t, t_0)
  % initialisation des valeurs de retour
  r_0 = r_i = vertcat(xy0, rayon_ballon);
  v_0 = v_i = Vb0;
  t = t_0;
  
  [limite, coup] = verifier_limites(v_i);
  
  while(limite)
    r_0 = r_i;
    v_0 = v_i;
    v_i = qt(v_0, Wb0, delta_t);
    r_i = r_0 + v_i*delta_t;
    t = t + delta_t;
  endwhile
  

endfunction
