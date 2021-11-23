function [vaf vbf waf wbf] = calculer_vitesse_apres_coll (ra, rb, p, n, q0, q0r, epsilon, balle)
 
  R = 3.1/100;
  m = 0.21;
  ri = [0; 0; 0];
  
  
  I_a = calculer_momentInertie (m, R);
  I_b = calculer_momentInertie (m, R);
  %t = cross(n, [0 0 1]);
  ra_p = -n*R;
  rb_p = n*R;
  
  
    
  v_a = [q0(4) q0(5) q0(6)];
  v_b = [q0r(4) q0r(5) q0r(6)];
  w_a = [q0(1) q0(2) q0(3)];
  w_b = [q0r(1) q0r(2) q0r(3)];
      
  v_ap = v_a + cross(w_a, ra_p);
  v_bp = v_b + cross(w_b, rb_p);
      
  v_r_min = dot(n, (v_ap - v_bp));
  a_t = (cross(cross(ra_p, n), ra_p))';
  b_t = (cross(cross(rb_p, n), rb_p))';
  
  G_a = dot(n, (inv(I_a)*a_t));
  G_b = dot(n, (inv(I_b)*b_t));

  if balle
    a = 1 / (1/m + 1/m+G_a+G_b);
    u_c = 0.1;
    u_s = 0.15;
  else
    a = 1/(1/m+G_a);
    u_c = 0.3;
    u_s = 0.4;
  endif
  
  j = -a * (1 + epsilon) * v_r_min;
  
  
  
  J = n*j;
      
  vaf = v_a + J / m;
  vbf = v_b - J / m; 
  waf = w_a + inv(I_a)*(cross(ra_p, J))';
  wbf = w_b - inv(I_b)*(cross(rb_p, J))';
  
  
endfunction
