% calcul de l'acceleration 
function acc = calculer_acc (VITESSE, VITESSE_ANGULAIRE)
  
  % CONSTANTES POUR LE BALLON %
   
  MASSE_BALLON= 0.45; %en kg
  RAYON_BALLON= 0.11 ;%en m 
  AIR_BALLON = pi*RAYON_BALLON^2; % en m2
  % CONSTANTES POUR LES BUTS %
  LARGEUR_BUT = 7.32; %en m
  HAUTEUR_BUT = 2.44; %en m
    
  % CONSTANTES POUR LES CALCULS DE FORCES %
    
  g =9.8; % en m/s^2
  Z_FORCE_GRAVITATIONNELLE = -MASSE_BALLON*g; 
  
  MASSE_VOLUMIQUE_AIR = 1.2754;  % en kg/m^3
  VISCOSITE_AIR= 1.8e-5; % en kgm-1s-1
  
  [g Ff Fm] = Calculs_Forces(MASSE_BALLON,RAYON_BALLON,AIR_BALLON,Z_FORCE_GRAVITATIONNELLE,MASSE_VOLUMIQUE_AIR,VISCOSITE_AIR,VITESSE,VITESSE_ANGULAIRE);

  force_totale = g + Ff + Fm;
  acc = force_totale / MASSE_BALLON;
  
endfunction
