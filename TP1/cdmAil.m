function [A1 A2 A3 A4] = cdmAil (epaisseur, hauteur, largeur, rayonCylindre)
  
  A1 = [0, rayonCylindre+largeur/2, hauteur/2];
  A2 = [rayonCylindre+largeur/2, 0, hauteur/2];
  A3 = [0, -rayonCylindre-largeur/2, hauteur/2];
  A4 = [-rayonCylindre-largeur/2, 0, hauteur/2];

endfunction
