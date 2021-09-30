function matriceRotation = mRotation (angle)
  % la rotation n'etant applique qu'autour de l'axe OX 
  matriceRotation = [1, 0, 0; 0, cos(angle), (-1*sin(angle)); 0, sin(angle), cos(angle) ];
endfunction
