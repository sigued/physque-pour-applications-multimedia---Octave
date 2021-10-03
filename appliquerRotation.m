function inertie = appliquerRotation (composantsMissile, angle)
  %calcul de la matrice de rotation M
  M =  mRotation(angle);
  inertieTotaleApresTranslation = zeros(3,3);
  
  for i = 1:6
    inertieTotaleApresTranslation = inertieTotaleApresTranslation + composantsMissile(i);    
  endfor
  
  inertie = M*inertieTotaleApresTranslation*M';
endfunction
