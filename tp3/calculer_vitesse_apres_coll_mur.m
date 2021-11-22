function [vaf,waf]  = calculer_vitesse_apres_coll_mur (ra, p, n, va, wa, epsilon)
  
  m = 0.21;
  ri = [0; 0; 0];
  epsilon = 
  
  ra_p = p - ra;
  ra_p = [ra_p(1); ra_p(2); 0];

  n = [n(1); n(2); 0];
  
  I_a = calculer_momentInertie (m, ri, ra);

  
  G_a = dot(n, cross(inv(I_a)*cross(ra_p, n), ra_p));

  aa = 1 / (1/m + G_a);
  
  v_ai = [va(1); va(2); 0.0];
  w_ai = [0.0; 0.0; wa(3)];

      
  v_ap = v_ai + cross(w_ai, ra_p);

  v_r_min = dot(n, v_ap);
      
  j = -aa * (1 + epsilon) * v_r_min;
  J = n * j;
      
  vaf = v_ai + J / m;
  waf = w_ai + inv(I_a) * cross(r_ap, J);

endfunction
