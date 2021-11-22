function [vaf vbf waf wbf] = calculer_vitesse_apres_coll (ra, rb, p, n, va, vb, wa, wb, epsilon)
 
 
  m = 0.21;
  ri = [0; 0; 0];
  
  ra_p = p - ra;
  ra_p = [ra_p(1); ra_p(2); 0];
  rb_p = p - rb;
  rb_p = [rb_p(1); rb_p(2); 0];
  n = [n(1); n(2); 0];
  
  I_a = calculer_momentInertie (m, ri, ra);
  I_b = calculer_momentInertie (m, ri, rb);
  
  G_a = dot(n, cross(inv(I_a)*cross(ra_p, n), ra_p));
  G_b = dot(n, cross(inv(I_b)*cross(rb_p, n), rb_p));
  aa = 1 / (1/m + 1/m + G_a + G_b);
  
  v_ai = [va(1); va(2); 0.0];
  v_bi = [vb(1); vb(2); 0.0];
  w_ai = [0.0; 0.0; wa(3)];
  w_bi = [0.0; 0.0; wb(3)];
      
  v_ap = v_ai + cross(w_ai, ra_p);
  v_bp = v_bi + cross(w_bi, rb_p);
      
  v_r_min = dot(n, v_ap - v_bp);
      
  j = -aa * (1 + epsilon) * v_r_min;
  J = n * j;
      
  vaf = v_ai + J / m;
  vbf = v_bi - J / m; 
  waf = w_ai + inv(I_a) * cross(r_ap, J);
  wbf = w_bi - inv(I_b) * cross(r_bp, J);
  
endfunction
