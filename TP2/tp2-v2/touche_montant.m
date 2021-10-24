function ballon_touche_montant = touche_montant (pos)
  
  ballon_touche_montant = false;
  
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
  
  % condition pour verifier si le ballon touche une des barres verticales
  
  if(pos(3) >  HAUTEUR_BUT + R_BALLON)
    ballon_touche_montant = false;
  else
    % ballon_touche_montant est true si touche poteaux gauche ou droit
    ballon_touche_montant = calculer_distance(pos(1), poteaux(1,1), pos(2), poteaux(2,1)) <= R_BALLON || calculer_distance(pos(1), poteaux(1,2), pos(2), poteaux(2,2)) <= R_BALLON;
  endif
  
  

  

endfunction
