function [coll tr tt xb yb xr yr xj yj]=Devoir3(xyb, xyr, xyj, Vb0)
 
  R = 3.1/100;
  epsilon_b2b = 0.9;
  epsilon_b2mur = 0.8;
  t0 = 100; 
  delta_t = 100/1000;
  
  glisse_b = true;
  glisse_r = false;
  glisse_j = false;
  
  b2r_collision = false;
  b2j_collision = false;
  r2j_collision = false;
  
  mur2b_collision = false;
  mur2r_collision = false;
  mur2j_collision = false;
  
  coll = 0;
  q0 = [Vb0(1); Vb0(2); 0; xyb(1); xyb(2); 0; 0; 0; 0];
  xb = [q0(4)];
  xb = [q0(5)];
  
  qr0 = [0; 0; 0; xyr(1); xyr(2); 0; 0; 0; 0];
  xr = [qr0(4)];
  xr = [qr0(5)];
  
  qj0 = [0; 0; 0; xyj(1); xyj(2); 0; 0; 0; 0];
  xj = [qj0(4)];
  xj = [qj0(5)];
  
  vi_r = [qr0(1); qr0(2); 0];
  ri_r = [qr0(4); qr0(5); 0];
  wi_r = [qr0(7); qr0(8); qr0(9)];
  
  vi_j = [qj0(1); qj0(2); 0];
  ri_j = [qj0(4); qj0(5); 0];
  wi_j = [qj0(7); qj0(8); qj0(9)];
  
  tt = [t0];
  g = 'g';
  
  arret_balle_b = false;
  vitesses_balle_blanche = [vi];
 
  do
    
    
    if glisse_b
      
      qs = SEDRK4t0 (q0, t0, delta_t, g);
      vi = [qs(1); qs(2); 0];
      ri = [qs(4); qs(5); 0];
      wi = [qs(7); qs(8); qs(9)];
            
      glisse_b = qs_glissement (q0, qs);
      
      q0 = [vi(1); vi(2); vi(3); ri(1); ri(2); ri(3); wi(7); wi(8); wi(9)];
      xb(end+1,:) = next_pos(xb(end), qs(1), delta_t);
      yb(end+1,:) = next_pos(yb(end), qs(2), delta_t);
      tt(end+1,:) = [t0];
      t0 = t0 + delta_t;
      vitesses_balle_blanche(end+1,:) = [vi];
    
    else
      
      [qs,arret_balle_b] = qs_roulement (q0, delta_t, R);
      q0 = qs;
      xb(end+1,:) = next_pos(xb(end), qs(1), delta_t);
      yb(end+1,:) = next_pos(yb(end), qs(2), delta_t);
      tt(end+1,:) = [t0];
      t0 = t0 + delta_t;
      vitesses_balle_blanche(end+1,:) = [vi];

    endif
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% BOULE ROUGE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if glisse_r
      
      qs_r = SEDRK4t0 (qr0, t0, delta_t, g);
      vi_r = [qs_r(1); qs_r(2); 0];
      ri_r = [qs_r(4); qs_r(5); 0];
      wi_r = [qs_r(7); qs_r(8); qs_r(9)];
            
      glisse_r = qs_glissement (qr0, qs_r);
      
      qr0 = [vi_r(1); vi_r(2); vi_r(3); ri_r(1); ri_r(2); ri_r(3); wi_r(7); wi_r(8); wi_r(9)];
      xr(end+1,:) = next_pos(xr(end), qs_r(1), delta_t);
      yr(end+1,:) = next_pos(yr(end), qs_r(2), delta_t);

    
    else
      
      [qs_r,arret_balle_r] = qs_roulement (qr0, delta_t, R);
      qr0 = qs_r;
      xr(end+1,:) = next_pos(xr(end), qs_r(1), delta_t);
      yr(end+1,:) = next_pos(yr(end), qs_r(2), delta_t);

    endif
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% BOULE JAUNE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if glisse_j
      
      qs_j = SEDRK4t0 (qj0, t0, delta_t, g);
      vi_j = [qs_j(1); qs_j(2); 0];
      ri_j = [qs_j(4); qs_j(5); 0];
      wi_j = [qs_j(7); qs_j(8); qs_j(9)];
            
      glisse_j = qs_glissement (qj0, qs_j);
      
      qj0 = [vi_j(1); vi_j(2); vi_j(3); ri_j(1); ri_j(2); ri_j(3); wi_j(7); wi_j(8); wi_j(9)];
      xj(end+1,:) = next_pos(xj(end), qs_j(1), delta_t);
      yj(end+1,:) = next_pos(yj(end), qs_j(2), delta_t);

    
    else
      
      [qs_j,arret_balle_j] = qs_roulement (qj0, delta_t, R);
      qj0 = qs_j;
      xj(end+1,:) = next_pos(xj(end), qs_j(1), delta_t);
      yj(end+1,:) = next_pos(yj(end), qs_j(2), delta_t);

    endif    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%  VERIFICATION COLLISIONS   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
    b2r_collision = verifier_b2b_collision(ri, ri_r, R, R);
    b2j_collision = verifier_b2b_collision(ri, ri_j, R, R);
    b_mur_collision = verifier_collision_mur (ri, R)
    
    if b2r_collision
      n = calculer_normale(ri, ri_r);
      p = ri + n*R;
      [vbf vrf wbf wrf] = calculer_vitesse_apres_coll (ri, ri_r, p, n, vi, vi_r, wi, wi_r, epsilon_b2b);
      
      vi = [vbf(1); vbf(2); 0];
      wi = [wbf(1); wbf(2); wbf(3)];
      
      xb(end+1,:) = next_pos(xb(end), vi(1), delta_t);
      yb(end+1,:) = next_pos(yb(end), vi(2), delta_t);
      ri = [xb(end); yb(end); 0];
      q0 = [vi(1); vi(2); vi(3); ri(1); ri(2); ri(3); wi(7); wi(8); wi(9)];
      
      vi_r = [vrf(1); vrf(2); 0];   
      wi_r = [wrf(1); wrf(2); wrf(3)];
1      
      xr(end+1,:) = next_pos(xr(end), vi_r(1), delta_t);
      yr(end+1,:) = next_pos(yr(end), vi_r(2), delta_t);
      ri_r = [xr(end); yr(end); 0];
      qr0 = [vi_r(1); vi_r(2); vi_r(3); ri_r(1); ri_r(2); ri_r(3); wi_r(7); wi_r(8); wi_r(9)];
      
      tt(end+1,:) = [t0];
      t0 = t0 + delta_t;
      
      if coll == 1;
        coll = 2;
      else
        coll = 1;
      endif 
      vitesses_balle_blanche(end+1,:) = [vi];
    endif  
    
    if b2j_collision
      n = calculer_normale(ri, ri_j);
      p = ri + n*R;
      [vbf vjf wbf wjf] = calculer_vitesse_apres_coll (ri, ri_j, p, n, vi, vi_j, wi, wi_j, epsilon_b2b);
      
      vi = [vbf(1); vbf(2); 0];
      wi = [wbf(1); wbf(2); wbf(3)];
      
      xb(end+1,:) = next_pos(xb(end), vi(1), delta_t);
      yb(end+1,:) = next_pos(yb(end), vi(2), delta_t);
      ri = [xb(end); yb(end); 0];
      q0 = [vi(1); vi(2); vi(3); ri(1); ri(2); ri(3); wi(7); wi(8); wi(9)];
      
      vi_j = [vjf(1); vjf(2); 0];   
      wi_j = [wjf(1); wjf(2); wjf(3)];
1      
      xj(end+1,:) = next_pos(xj(end), vi_j(1), delta_t);
      yj(end+1,:) = next_pos(yj(end), vi_j(2), delta_t);
      ri_j = [xj(end); yj(end); 0];
      qr0 = [vi_j(1); vi_j(2); vi_j(3); ri_j(1); ri_j(2); ri_j(3); wi_j(7); wi_j(8); wi_j(9)];
      
      tt(end+1,:) = [t0];
      t0 = t0 + delta_t;
      
      if coll == 1;
        coll = 2;
      else
        coll = 1;
      endif 
      vitesses_balle_blanche(end+1,:) = [vi];
    endif
    
    if b_mur_collision
      n = calculer_normale(ri, ri_j);
      p = ri + n*R;
      [vbf, wbf]  = calculer_vitesse_apres_coll_mur (ri, p, n, vi, wi, epsilon_b2mur);
      
      vi = [vbf(1); vbf(2); 0];
      wi = [wbf(1); wbf(2); wbf(3)];
      
      xb(end+1,:) = next_pos(xb(end), vi(1), delta_t);
      yb(end+1,:) = next_pos(yb(end), vi(2), delta_t);
      ri = [xb(end); yb(end); 0];
      q0 = [vi(1); vi(2); vi(3); ri(1); ri(2); ri(3); wi(7); wi(8); wi(9)];
      vitesses_balle_blanche(end+1,:) = [vi];
      
      tt(end+1,:) = [t0];
      t0 = t0 + delta_t;

  endif
  
    arret_balle_b = dot(vitesses_balle_blanche(end-1,:), vi) < 0;
    delta_t = delta_t / 2;
    
  until arret_balle_b
  
  
  

endfunction



