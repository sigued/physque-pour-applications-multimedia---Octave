function aa = calculerAcceleration (cdm, angle, force, inertie, vangulaire, pos)
       
  pointApplicationForce = [0; 0; 0];
  
  % moment de force tau = ( rj-ri ) x F ou rj -> point d'application de la force F et ri -> cdm
  forceCoordPolaire = convertirForce(force(1), force(2), force(3));
  
  tau = cross((pos - cdm), forceCoordPolaire);
  
  % momoent cinetique L = Iw
  momentCinetique = inertie*vangulaire;
  
  M = mRotation (angle);
  momentCinetiqueRotate = M*tau;
   
  % acceleration angulaire alpha = (I^-1)*(tau + (L x w))
  aa = inv(inertie) * (tau + cross(momentCinetique, vangulaire));
  
endfunction
