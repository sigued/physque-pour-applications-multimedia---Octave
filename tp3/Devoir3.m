function [coll tr tt xb yb xr yr xj yj]=Devoir3(xyb, xyr, xyj, Vb0)
 
  R = 3.1/100;
  t0 = 100; 
  delta_t = 100/1000;
  
  b2r_collision = false;
  b2j_collision = false;
  r2j_collision = false;
  
  mur2b_collision = false;
  mur2r_collision = false;
  mur2j_collision = false;
  
  coll = 0;
  q0 = [Vb0(1) Vb0(2) 0 xyb(1) xyb(1) 0 0 0 0];
  
  qr0 = [0 0 0 xyr(1) xyr(1) 0 0 0 0];
  qj0 = [0 0 0 xyj(1) xyj(1) 0 0 0 0];
  
  vi_r = [qr0(1) qr0(2)];
  ri_r = [qr0(4) qr0(5)];
  
  vi_j = [qj0(1) qj0(2)];
  ri_j = [qj0(4) qj0(5)];
  
  
  g = 'g';
 
  do
    qs = SEDRK4t0 (q0, t0, delta_t, g)
    vi = [qs(1) qs(2)];
    ri = [qs(4) qs(5)];
    
    b2r_collision = verifier_b2b_collision(ri, ri_r, R, R);
    b2j_collision = verifier_b2b_collision(ri, ri_j, R, R);
    b_mur_collision = verifier_collision_mur (ri, R)
    
    if b2r_collision
      
      
      
    endif
    
    
    
  until

endfunction
