
function [pcm I alpha] = Devoir1 (pos,AngRot,vangulaire,force)
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
  %donnees du missile : hauteurs
  h_cyl = 10;
  h_cone = 3;
  h_p = 1.5;
  
  %rayons 
  r_cyl = r_cone = 1.5;
  
  % plaque : largeur, epaisseur et masse
  l_p = 2.5;
  masse_p = 2000;
  e_p = 0.15;
  
  % masse (mv) volumique cone et cylindre
  mv_cyl = mv_cone = 4000;
  
  % calcul de la masse du cylindre
  
  % volume = (pi*r^2)*hauteur
  volume_cyl = (3.14*(r_cyl^2))*h_cyl;
  %masse = masseVolumique*volume
  masse_cyl = mv_cyl*volume_cyl;
  
  % calcul de la masse du cone
  
  % volume = (pi*h*r^2)/3
  volume_cone = (3.14*(r_cone^2)*h_cone)/3;
  %masse = masseVolumique*volume
  masse_cone = mv_cone*volume_cone;
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

  % calcul du centre de masse de chaque composant du missile (donnee utile pour le calcul
  % de l'inertie par rapport aux coordonnees du systeme global
  pcdm_cylindre = cdmCylindre (h_cyl); 
  pcdm_cone = cdmCone (h_cone, h_cyl);
  [pcdm_plaque1 pcdm_plaque2 pcdm_plaque3 pcdm_plaque4] = cdmAil (e_p, h_p, l_p, r_cyl);
  

  
  % calcul pour la position du centre de masse global
  %#########################################################
  %                                                        % 
  pcm = init(h_cyl, h_cone, r_cone, r_cyl, e_p, h_p, l_p); %
  %                                                        %
  %#########################################################
  
  %inertieAile (epaisseur, largeur, hauteur, masse)
  
  % calcul de l'inertie de chaque composant du missile
  I_cylindre = inertieCylindre (r_cyl, h_cyl, mv_cyl);
  I_cone = inertieCone (r_cone, h_cone, mv_cone);
  I_plaque1 = inertieAile (e_p, l_p, h_p, masse_p);
  I_plaque2 = inertieAile (l_p, e_p, h_p, masse_p);
  I_plaque3 = inertieAile (e_p, l_p, h_p, masse_p);
  I_plaque4 = inertieAile (l_p, e_p, h_p, masse_p);
  
  #{
  % calcul de l'inertie de chaque composant du missile
  M =  mRotation(AngRot);
  I_cylindre = M*I_cylindre*M';
  I_cone = M*I_cone*M';
  I_plaque1 = M*I_plaque1*M';
  I_plaque2 = M*I_plaque2*M';
  I_plaque3 = M*I_plaque3*M';
  I_plaque4 = M*I_plaque4*M';
  #}
  
  % translation de l'inertie par rapport au cdm glogal Ig_composant (inertie dans coord globale du composant x)
  Ig_cylindre = inertieComposee(I_cylindre, pcdm_cylindre, pcm, masse_cyl);
  Ig_cone = inertieComposee (I_cone, pcdm_cone, pcm, masse_cone);
  Ig_plaque1 = inertieComposee (I_plaque1, pcdm_plaque1, pcm, masse_p);
  Ig_plaque2 = inertieComposee (I_plaque2, pcdm_plaque2, pcm, masse_p);
  Ig_plaque3 = inertieComposee (I_plaque3, pcdm_plaque3, pcm, masse_p);
  Ig_plaque4 = inertieComposee (I_plaque4, pcdm_plaque4, pcm, masse_p);
  
  % calcul de l' inertie apres rotation selon l'axe OX
  M =  mRotation(AngRot);
  Ig_cylindre_Rot = M*Ig_cylindre*M';
  Ig_cone_Rot = M*Ig_cone*M';
  Ig_plaque1_Rot = M*Ig_plaque1*M';
  Ig_plaque2_Rot = M*Ig_plaque2*M';
  Ig_plaque3_Rot = M*Ig_plaque3*M';
  Ig_plaque4_Rot = M*Ig_plaque4*M';
  
  Ig = Ig_cylindre_Rot + Ig_cone_Rot + Ig_plaque1_Rot + Ig_plaque2_Rot + Ig_plaque3_Rot +Ig_plaque4_Rot;
  
  %#########################################################
  %                                                        % 
  I = Ig;                      %
  %                                                        %
  %#########################################################
  
  alpha = calculerAcceleration ([pcm(1); pcm(2); pcm(3)], AngRot, force, Ig, vangulaire);

endfunction
