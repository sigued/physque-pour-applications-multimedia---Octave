

function pcdm = init (hauteurCyl,hauteurCone,rayonCone,rayonCylindre,epaisseurAil,hauteurAil,largeurAil)
  mv = 4000;
  masseAil = 2000;
   
  cylindre = cdmCylindre(rayonCylindre, hauteurCyl);
  cone = cdmCone(rayonCone, hauteurCone);
  [cdmA1 cdmA2 cdmA3 cdmA4] = cdmAil(epaisseurAil,hauteurAil,largeurAil,rayonCylindre);
  
  masseCone =  mv*((3.14*(rayonCone^2)*hauteurCone)/3);
  masseCylindre = mv*(3.14*(rayonCylindre^2)*hauteurCyl);
  
  objets = [cylindre; cone; cdmA1; cdmA2; cdmA3; cdmA4];
  masseObjets = [masseCylindre; masseCone; masseAil; masseAil; masseAil; masseAil];
  
  pcdm = cdm(objets, masseObjets);
  
 
endfunction
