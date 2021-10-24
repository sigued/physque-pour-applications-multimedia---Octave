function [Fg, Ff_VISQUEUX, Ff_MAGNUS] = calculer_forces (v, w)
  
  RAYON_BALLON = 0.11;
  MASSE_BALLON= 0.45;
  g = 9.8;
  VISCOSITE_AIR= 1.8e-5;
  AIR_BALLON = pi*RAYON_BALLON^2; % en m2
  MASSE_VOLUMIQUE_AIR = 1.2754;  % en kg/m^3
    
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %CALCULS POUR FORCE_FROTTEMENT_VISQUEUX %
  
  %1: Calcul du coefficient de trainee visqueuese
  COEFFICIENT_TRAINEE = 0;
  NORME_VITESSE = norm(v);
  NOMBRE_DE_REYNOLDS = (NORME_VITESSE*MASSE_VOLUMIQUE_AIR*RAYON_BALLON)/VISCOSITE_AIR;
    
  %Definition des cas possibles pour le coefficient
   
  if(NOMBRE_DE_REYNOLDS<100000)
   COEFFICIENT_TRAINEE = NORME_VITESSE*0.235;
  elseif(NOMBRE_DE_REYNOLDS<135000)
   COEFFICIENT_TRAINEE = (NORME_VITESSE*0.235) - (NORME_VITESSE*0.125*((NOMBRE_DE_REYNOLDS-100000)/35000));
  else
   COEFFICIENT_TRAINEE = NORME_VITESSE*0.110;
  endif
    
  %Obtention de la valeur de FORCE_FROTTEMENT_VISQUEUX
     
  Ff_VISQUEUX = -AIR_BALLON*MASSE_VOLUMIQUE_AIR*COEFFICIENT_TRAINEE*v; 
   
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
  %CALCUL POUR FORCE_MAGNUS%
    
  %1 Calcul du coefficient de magnus%
    
  COEFFICIENT_MAGNUS = 0.1925 * ((norm(w)*RAYON_BALLON)/NORME_VITESSE).^(1/4);
     
  %Calcul de la valeur de la force
     
  PRODUIT_VECTEURS = cross(w, v);
     
  NORME_PRODUIT_VECTEURS= norm(PRODUIT_VECTEURS);
     
  Ff_MAGNUS = MASSE_VOLUMIQUE_AIR* COEFFICIENT_MAGNUS* AIR_BALLON* NORME_VITESSE^2 * (PRODUIT_VECTEURS/NORME_PRODUIT_VECTEURS);
    
 
    
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
  % FORCE GRAVITATIONNELLE
    
  Fg = [0;0;-g*MASSE_BALLON];

endfunction
