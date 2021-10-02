function accelerationAngulaire = accelerationAngulaireSysteme(ar,pcm,Force,va,inertie,rayonCylindre,rayonAil)
  
  pos_cylindre=[0;0;0]-pcm
  
  %selon vue de haut , POSITIONS A VERIFIER
  %gauche
  pos_Ail1=[0;-(rayonAil+rayonCylindre);0]-pcm
  %droite
  pos_Ail2=[0;rayonAil+rayonCylindre;0]-pcm
  %haut
  pos_Ail3=[-(rayonAil+rayonCylindre);0]-pcm
  %bas
  pos_Ail4=[rayonAil+rayonCylindre;0]-pcm
  
  %Moments de force (cross==> vector cross product)
  

  
  
  
  
  
  
  