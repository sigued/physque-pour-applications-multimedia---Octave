function ballon_hors_terrain = hors_terrain (pos)
  
  ballon_hors_terrain = false;
  
  R_BALLON = 0.11;
  X_MIN = 0;
  X_MAX = 120;
  Y_MIN = 0;
  Y_MAX = 90;
  LARGEUR_BUT = 7.32;
  HAUTEUR_BUT = 2.44;
  
  ballon_hors_terrain = pos(2) < Y_MIN || pos(2) > Y_MAX || pos(1) <= X_MIN || pos(1) >= X_MAX;
  

endfunction
