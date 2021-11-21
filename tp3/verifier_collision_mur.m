function collision = verifier_collision_mur (r, R)
  x = r(1);
  y = r(2);
  
  MUR_GAUCHE = 0 + R;
  MUR_DROIT = 2.8-R;
  MUR_HAUT = 1.53-R;
  MUR_BAS = 0+R;
  
  collision = (x <= MUR_GAUCHE || x >= MUR_DROIT || y <= MUR_BAS || y >= MUR_HAUT);
endfunction
