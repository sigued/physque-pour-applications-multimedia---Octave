function [pos_initiale, pos_finale, vi, vf, temps, limite ] = trajectoire (xy0,Vb0,Wb0, rayon_ballon, detlta_t, temps_inital)
  % initialisation des valeurs de retour
  pos_initiale = pos_finale = vertcat(xy0, rayon_ballon);
  vi = vf = Vb0;
  
  while(true)
  

endfunction
