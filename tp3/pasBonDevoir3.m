function [coll tr tt xb yb xr yr xj yj]=pasbonDevoir3(xyb, xyr, xyj, Vb0)
 
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
  b_mur_collision = false;
  
  coll = 0;
  q0 = [0 0 0 Vb0(1) Vb0(2) 0 xyb(1) xyb(2) R];
  xb = [q0(7)];
  yb = [q0(8)];
  
  wi = [q0(1) q0(2) q0(3)];
  vi = [q0(4) q0(5) q0(6)];
  ri = [q0(7) q0(8) q0(9)];
  
  qr0 = [0 0 0 0 0 0 xyr(1) xyr(2) R];
  xr = [qr0(7)];
  yr = [qr0(8)];
  
  qj0 = [0 0 0 0 0 0 xyj(1) xyj(2) R];
  xj = [qj0(7)];
  yj = [qj0(8)];
  
  wi_r = [qr0(1) qr0(2) qr0(3)];
  vi_r = [qr0(4) qr0(5) qr0(6)];
  ri_r = [qr0(7) qr0(8) qr0(9)];
  
  wi_j = [qj0(1) qj0(2) qj0(3)];
  vi_j = [qj0(4) qj0(5) qj0(6)];
  ri_j = [qj0(7) qj0(8) qj0(9)];
  
  tt = [t0];
  g = 'g';
  
  arret_balle_b = false;
  v = [Vb0(1) Vb0(2) 0];
  vitesses_balle_blanche = [v];
  prev_glisse_b = true;
  n=0;
  
  tr = [t0];
  vbx = [vi(1)];
  vby = [vi(2)];
 
  fprintf("vi = [ %d %d %d]\n", q0(4),q0(5),q0(6));
  do
    n = n+1;
    fprintf("---------------------------------------------------------------\n");
    fprintf("n = %d\n", n);
    
    if glisse_b
      fprintf("glisse_b\n");
      qs = SEDRK4t0 (q0, tt(end), delta_t, 'g');

      wi = [qs(1); qs(2); qs(3)];
      vi = [qs(4); qs(5); qs(6)];
      ri = [qs(7); qs(8); qs(9)];
            
      glisse_b = qs_glissement (q0, qs);
      
      %q0 = [wi(1); wi(2); wi(3); vi(1); vi(2); vi(3); xb(end); yb(end); R];
      
      xb(end+1,:) = next_pos(xb(end), vi(1), delta_t);
      yb(end+1,:) = next_pos(yb(end), vi(2), delta_t);
      vbx(end+1,:) = vi(1);
      vby(end+1,:) = vi(2);
      
      q0 = [wi(1) wi(2) wi(3) vi(1) vi(2) vi(3) xb(end) yb(end) R];
      
      tt(end+1,:) = [t0];
      t0 = t0 + delta_t;
      
    
    else
      fprintf("glisse_b faux  \n");
      
      [qs,arret_balle_b] = qs_roulement (q0, delta_t, R);
      
      q0 = qs;
      %q0(7) =xb(end);
      %q0(8) =yb(end);
      %q0(9) = R;
      xb(end+1,:) = next_pos(xb(end), qs(4), delta_t);
      yb(end+1,:) = next_pos(yb(end), qs(5), delta_t);
      
      q0(7) =xb(end);
      q0(8) =yb(end);
      q0(9) = R;
      
      tt(end+1,:) = [t0];
      t0 = t0 + delta_t;

    endif
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% BOULE ROUGE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if glisse_r
      fprintf("glisse_r\n");
      qs_r = SEDRK4t0 (qr0, tt(end), delta_t, 'g');
      wi_r = [qs_r(1) qs_r(2) qs_r(3)];
      vi_r = [qs_r(4) qs_r(5) qs_r(6)];
      ri_r = [qs_r(7) qs_r(8) qs_r(9)];
            
      glisse_r = qs_glissement (qr0, qs_r);
      
      %qr0 = [wi_r(1); wi_r(2); wi_r(3); vi_r(1); vi_r(2); vi_r(3); xr(end); yr(end); R];
      
      xr(end+1,:) = next_pos(xr(end), qs_r(4), delta_t);
      yr(end+1,:) = next_pos(yr(end), qs_r(5), delta_t);
      qr0 = [wi_r(1) wi_r(2) wi_r(3) vi_r(1) vi_r(2) vi_r(3) xr(end) yr(end) R];
    
  else
    
      fprintf("glisse_r faux \n");
      [qs_r,arret_balle_r] = qs_roulement (qr0, delta_t, R);
      qr0 = qs_r;
      %qr0(7) =xr(end);
      %qr0(8) =yr(end);
      %qr0(9) = R;
      xr(end+1,:) = next_pos(xr(end), qs_r(4), delta_t);
      yr(end+1,:) = next_pos(yr(end), qs_r(5), delta_t);
      
      qr0(7) =xr(end);
      qr0(8) =yr(end);
      qr0(9) = R;
      
    endif
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% BOULE JAUNE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if glisse_j
      fprintf("glisse_j\n");
      qs_j = SEDRK4t0 (qj0, tt(end), delta_t, 'g');
      wi_j = [qs_j(1) qs_j(2) qs_j(3)];
      vi_j = [qs_j(4) qs_j(5) qs_j(6)];
      ri_j = [qs_j(7) qs_j(8) qs_j(9)];
            
      glisse_j = qs_glissement (qj0, qs_j);
      
      %qj0 = [wi_j(1); wi_j(2); wi_j(3); vi_j(1); vi_j(2); vi_j(3); xj(end); yj(end); R];
      xj(end+1,:) = next_pos(xj(end), qs_j(4), delta_t);
      yj(end+1,:) = next_pos(yj(end), qs_j(5), delta_t);
      
      qj0 = [wi_j(1) wi_j(2) wi_j(3) vi_j(1) vi_j(2) vi_j(3) xj(end) yj(end) R];
    
    elseif (!glisse_j && b2j_collision)
      fprintf("glisse_j faux \n");
      [qs_j,arret_balle_j] = qs_roulement (qj0, delta_t, R);
      qj0 = qs_j;
      %qj0(7) =xj(end);
      %qj0(8) =yj(end);
      %qj0(9) = R;
      xj(end+1,:) = next_pos(xj(end), qs_j(4), delta_t);
      yj(end+1,:) = next_pos(yj(end), qs_j(5), delta_t);
      
      qj0(7) =xj(end);
      qj0(8) =yj(end);
      qj0(9) = R;

    endif    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%  VERIFICATION COLLISIONS   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    fprintf("VERIFICATION COLLISIONS \n");
    fprintf("ri = [ %d %d %d]\n", ri(1),ri(2),ri(3));
    fprintf("ri_r = [ %d %d %d]\n", ri_r(1),ri_r(2),ri_r(3));
    fprintf("ri_j = [ %d %d %d]\n", ri_j(1),ri_j(2),ri_j(3));
    b2r_collision = verifier_b2b_collision(ri, ri_r, R, R);
    b2j_collision = verifier_b2b_collision(ri, ri_j, R, R);
    b_mur_collision = verifier_collision_mur (ri, R);
    
    if b2r_collision
      fprintf("b2r_collision\n");
      
      n = calculer_normale(ri, ri_r);
      p = ri + n*R;
      [vbf vrf wbf wrf] = calculer_vitesse_apres_coll (ri, ri_r, p, n, vi, vi_r, wi, wi_r, epsilon_b2b);
      
      vi = [vbf(1) vbf(2) 0];
      wi = [wbf(1) wbf(2) wbf(3)];
      
      xb(end+1,:) = next_pos(xb(end), vi(1), delta_t);
      yb(end+1,:) = next_pos(yb(end), vi(2), delta_t);
      ri = [xb(end); yb(end); R];
      q0 = [wi(1) wi(2) wi(3) vi(1) vi(2) vi(3) ri(1) ri(2) ri(3)];
      
      vi_r = [vrf(1) vrf(2) 0];   
      wi_r = [wrf(1) wrf(2) wrf(3)];
1      
      xr(end+1,:) = next_pos(xr(end), vi_r(1), delta_t);
      yr(end+1,:) = next_pos(yr(end), vi_r(2), delta_t);
      ri_r = [xr(end) yr(end) R];
      qr0 = [wi_r(1) wi_r(2) wi_r(3) vi_r(1) vi_r(2) vi_r(3) ri_r(1) ri_r(2) ri_r(3)];
      
      tt(end+1,:) = [t0];
      t0 = t0 + delta_t;
      
      if coll == 1;
        coll = 2;
      else
        coll = 1;
      endif 
      vitesses_balle_blanche(end+1,:) = [vi(1) vi(2) vi(3)];
    endif  
    
    if b2j_collision
      fprintf("b2j_collision\n");
      n = calculer_normale(ri, ri_j);
      p = ri + n*R;
      [vbf vjf wbf wjf] = calculer_vitesse_apres_coll (ri, ri_j, p, n, vi, vi_j, wi, wi_j, epsilon_b2b);
      
      vi = [vbf(1) vbf(2) 0];
      wi = [wbf(1) wbf(2) wbf(3)];
      
      xb(end+1,:) = next_pos(xb(end), vi(1), delta_t);
      yb(end+1,:) = next_pos(yb(end), vi(2), delta_t);
      ri = [xb(end) yb(end) R];
      q0 = [wi(1) wi(2) wi(3) vi(1) vi(2) vi(3) ri(1) ri(2) ri(3)];
      
      vi_j = [vjf(1) vjf(2) 0];   
      wi_j = [wjf(1) wjf(2) wjf(3)];
1      
      xj(end+1,:) = next_pos(xj(end), vi_j(1), delta_t);
      yj(end+1,:) = next_pos(yj(end), vi_j(2), delta_t);
      ri_j = [xj(end) yj(end) 0];
      qr0 = [wi_j(1) wi_j(2) wi_j(3) vi_j(1) vi_j(2) vi_j(3) ri_j(1) ri_j(2) ri_j(3)];
      
      tt(end+1,:) = [t0];
      t0 = t0 + delta_t;
      
      if coll == 1;
        coll = 2;
      else
        coll = 1;
      endif 

    endif
    
    if b_mur_collision
      fprintf("b_mur_collision\n");
      n = calculer_normale(ri, ri_j);
      p = ri + n*R;
      [vbf, wbf]  = calculer_vitesse_apres_coll_mur (ri, p, n, vi, wi, epsilon_b2mur);
      
      vi = [vbf(1) vbf(2) 0];
      wi = [wbf(1) wbf(2) wbf(3)];
      
      xb(end+1,:) = next_pos(xb(end), vi(1), delta_t);
      yb(end+1,:) = next_pos(yb(end), vi(2), delta_t);
      ri = [xb(end) yb(end) 0];
      q0 = [wi(1) wi(2) wi(3) vi(1) vi(2) vi(3) ri(1) ri(2) ri(3)];
      vitesses_balle_blanche(end+1,:) = [vi(1) vi(2) vi(3)];
      
      tt(end+1,:) = [t0];
      t0 = t0 + delta_t;
    endif
  
    delta_t = delta_t / 2;
    
    if glisse_b != prev_glisse_b
      tr(end+1,:) = [t0];
    endif
    
    arret_balle = dot([q0(4) q0(5) q0(6)], [qs(4) qs(5) qs(6)]);
    
    
    prev_glisse_b = glisse_b;
    fprintf("arret_balle = %d\n", arret_balle);
    fprintf("vf = [ %d %d %d]\n", qs(4),qs(5),qs(6));
  until (sqrt(vbx(end) ^ 2 + vby(end) ^ 2) < 0.01);
  
  
endfunction



