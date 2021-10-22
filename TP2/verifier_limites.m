
function [limite, coup] = verifier_limites (pos)
  R_BALLON = 0.11;
  X_MIN = 0;
  X_MAX = 120;
  Y_MIN = 0;
  Y_MAX = 90;
  LARGEUR_BUT = 7.32;
  HAUTEUR_BUT = 2.44;
  
  % limite hors but du terrain (POTEAU_BUT_GB = LIMITE POTEAU BUT GAUCHE BAS)
  POTEAU_BUT_GB = [X_MIN; (Y_MAX/2 - LARGEUR_BUT/2)];
  POTEAU_BUT_GH = [X_MIN; (Y_MAX/2 + LARGEUR_BUT/2)];
  
  POTEAU_BUT_DB = [X_MAX; (Y_MAX/2 - LARGEUR_BUT/2)];
  POTEAU_BUT_DH = [X_MAX; (Y_MAX/2 + LARGEUR_BUT/2)];
  
  poteaux = [0,0;0,0];
  
  if(pos(1) < X_MAX/2)
    poteaux = [POTEAU_BUT_GB, POTEAU_BUT_GH];
  else
    poteaux = [POTEAU_BUT_DB, POTEAU_BUT_DH];
  endif
  
  ballon_au_sol = pos(3) < R_BALLON;
  ballon_au_but = false;
  ballon_touche_montant_vertical = false;
  ballon_touche_montant_horz = false;
  ballon_hors_terrain_Y = pos(2) > Y_MAX || pos(2) < Y_MIN;
  ballon_hors_terrain_X = false;
  
  % condition pour verifier si le ballon entre dans les buts
  
  if(pos(3) >= HAUTEUR_BUT - R_BALLON || pos(2) <= poteaux(2) + R_BALLON || pos(2) >= poteaux(4) - R_BALLON)
      ballon_au_but = false;
  else
      ballon_au_but = pos(1) <= X_MIN || pos(1) >= X_MAX;
  endif
  
  % condition pour verifier si le ballon touche une des barres verticales
  
  if(pos(3) >  HAUTEUR_BUT + R_BALLON)
    ballon_touche_montant_vertical = false;
  else
    % ballon_touche_montant est true si touche poteaux gauche ou droit
    ballon_touche_montant_vertical = calcul_distance(pos(1), poteaux(1), pos(2), poteaux(2)) <= R_BALLON || calcul_distance(pos(1), poteaux(3), pos(2), poteaux(4)) <= R_BALLON;
  endif
  
  % condition pour verifier si le ballon touche la barre horizontale
  
  if(pos(2) <= poteaux(2) - R_BALLON || pos(4) >= poteaux(2) + R_BALLON)
    ballon_touche_montant_horz = false;
  else
    % ballon_touche_montant est true si touche poteaux gauche ou droit
    ballon_touche_montant_horz = calcul_distance(pos(1), poteaux(1), pos(3), R_BALLON) <= R_BALLON;
  endif
  
  % ballon sort du terrain sans marquer de but
  
  if(!ballon_au_but)
    ballon_hors_terrain_X = pos(1) > X_MAX || pos(1) < X_MIN;
  endif  
  
  % traduction des limites
  coup =0;
  
  if(ballon_au_but)
   coup = 0;
  elseif(ballon_au_sol)
    coup = 1;
  elseif(ballon_hors_terrain_X || ballon_hors_terrain_Y)
    coup = 2;
  elseif(ballon_touche_montant_vertical || ballon_touche_montant_horz)
    coup = 3;
  endif  
  
  limite = ballon_au_sol || ballon_au_but || ballon_touche_montant_vertical || ballon_touche_montant_horz || ballon_hors_terrain_Y || ballon_hors_terrain_X;

endfunction
