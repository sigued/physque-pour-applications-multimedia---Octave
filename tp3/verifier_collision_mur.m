function [collision, pos] = verifier_collision_mur (r, R)
  x = r(1);
  y = r(2);
  pos = 0;
  
  MUR_GAUCHE = 0 + R;
  MUR_DROIT = 2.8-R;
  MUR_HAUT = 1.53-R;
  MUR_BAS = 0+R;
  
  
  if x <= MUR_GAUCHE
    pos = 0;    
  endif
  
  if x >= MUR_DROIT
    pos = 1;    
  endif
  
  if y <= MUR_BAS
    pos = 2;    
  endif
  
  if y >= MUR_HAUT
    pos = 3;    
  endif
  
  collision = (x <= MUR_GAUCHE || x >= MUR_DROIT || y <= MUR_BAS || y >= MUR_HAUT);
  
endfunction
