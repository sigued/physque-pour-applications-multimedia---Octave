function collision = verifier_b2b_collision (ra, rb, Ra, Rb)  
    
  distance = calculer_distance(ra, rb);
  
  collision = distance < (Ra+Rb);
  
endfunction
