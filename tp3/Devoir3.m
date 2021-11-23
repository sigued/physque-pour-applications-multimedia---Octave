function [coll tr tt xb yb xr yr xj yj]=Devoir3(xyb, xyr, xyj, Vb0)
 
 
  R = 3.1/100;
  epsilon_b2b = 0.9;
  epsilon_b2mur = 0.8;
  t0 = 100; 
  delta_t = 100/1000;
  
  roulement_b = false;
  roulement_r = false;
  roulement_j = false;
  
  b2r_collision = false;
  b2j_collision = false;
  r2j_collision = false;
  
  mur2b_collision = false;
  mur2r_collision = false;
  mur2j_collision = false;
  b_mur_collision = false;
  r_mur_collision = false;
  j_mur_collision = false;
  
  collision_avec_rouge  =false;
  collision_avec_jaune=false;
  
  coll = 0;
  q0 = [0 0 0 Vb0(1) Vb0(2) 0 xyb(1) xyb(2) R];
  xb = [q0(7)];
  yb = [q0(8)];
  
  qr0 = [0 0 0 0 0 0 xyr(1) xyr(2) R];
  xr = [qr0(7)];
  yr = [qr0(8)];
  
  qj0 = [0 0 0 0 0 0 xyj(1) xyj(2) R];
  xj = [qj0(7)];
  yj = [qj0(8)];
  
  
  wb = [q0(1) q0(2) q0(3)];
  vb = [q0(4) q0(5) q0(6)];
  rb = [q0(7) q0(8) q0(9)];
  
  wr = [qr0(1) qr0(2) qr0(3)];
  vr = [qr0(4) qr0(5) qr0(6)];
  rr = [qr0(7) qr0(8) qr0(9)];
  
  wj = [qj0(1) qj0(2) qj0(3)];
  vj = [qj0(4) qj0(5) qj0(6)];
  rj = [qj0(7) qj0(8) qj0(9)];
  
  tt = [t0];
  g = 'g';
  
  
  m=0;
  
  tr = [t0];
  vbx = [vb(1)];
  vby = [vb(2)];
 
  fprintf("vi = [ %d %d %d]\n", q0(4),q0(5),q0(6));

  do
    m = m+1;
    
    %fprintf("n = %d\n", m);
    %fprintf("vi = [ %d %d %d]\n", q0(4),q0(5),q0(6));
    
    rb = [q0(7) q0(8) q0(9)];
    rr = [qr0(7) qr0(8) qr0(9)];
    rj = [qj0(7) qj0(8) qj0(9)];
    
    
    b2r_collision = verifier_b2b_collision(rb, rr, R, R);
    b2j_collision = verifier_b2b_collision(rb, rj, R, R);
    r2j_collision = verifier_b2b_collision(rr, rj, R, R);
    [b_mur_collision, pos_mur_b] = verifier_collision_mur (rb, R);
    [r_mur_collision, pos_mur_r] = verifier_collision_mur (rr, R);
    [j_mur_collision, pos_mur_j] = verifier_collision_mur (rj, R);
    
    if b2r_collision
      %fprintf("b2r_collision\n");
      
      n = rb-rr/norm(rb-rr);
      p = rb + n*R;
      [vbf vrf wbf wrf] = calculer_vitesse_apres_coll (rb, rr, p, n, q0, qr0, epsilon_b2b, true);
      roulement_r = false;
      roulement_b = false;
      collision_avec_rouge = true;
      q0 = [wbf(1) wbf(2) wbf(3) vbf(1) vbf(2) vbf(3) rb(1) rb(2) rb(3)];
      qr0 = [wrf(1) wrf(2) wrf(3) vrf(1) vrf(2) vrf(3) rr(1) rr(2) rr(3)];
    endif
    
    if b2j_collision
      %fprintf("b2j_collision\n");
      
      n = rb-rj/norm(rb-rj);
      p = rb + n*R;
      [vbf vjf wbf wjf] = calculer_vitesse_apres_coll (rb, rj, p, n, q0, qj0, epsilon_b2b, true);
      roulement_j = false;
      roulement_b = false;
      collision_avec_jaune = true;
      q0 = [wbf(1) wbf(2) wbf(3) vbf(1) vbf(2) vbf(3) rb(1) rb(2) rb(3)];
      qj0 = [wjf(1) wjf(2) wjf(3) vjf(1) vjf(2) vjf(3) rj(1) rj(2) rj(3)];
    endif
    
    if r2j_collision
      %fprintf("r2j_collision\n");
      
      n = rr-rj/norm(rr-rj);
      p = rr + n*R;
      [vrf vjf wrf wjf] = calculer_vitesse_apres_coll (rr, rj, p, n, qr0, qj0, epsilon_b2b, true);
      roulement_j = false;
      roulement_r = false;

      qr0 = [wrf(1) wrf(2) wrf(3) vrf(1) vrf(2) vrf(3) rr(1) rr(2) rr(3)];
      qj0 = [wjf(1) wjf(2) wjf(3) vjf(1) vjf(2) vjf(3) rj(1) rj(2) rj(3)];
    endif
    
    if b_mur_collision
      %fprintf("b_mur_collision\n");
      
      if pos_mur_b == 0
        qm = [ 0 0 0 0 0 0 qs(7)-2*R qs(8) R];
            
      elseif pos_mur_b == 1
        qm = [ 0 0 0 0 0 0 qs(7)+2*R qs(8) R];
        
      elseif pos_mur_b == 2
       qm = [ 0 0 0 0 0 0 qs(7) qs(8)-2*R R];
      elseif pos_mur_b == 3 
        qm = [ 0 0 0 0 0 0 qs(7) qs(8)+2*R R];
      endif
      
      rm = [ qm(7) qm(8) qm(9)];
      n = rb-rm/norm(rb-rm);
      p = rb + n*R;
      [vbf vmf wbf wmf] = calculer_vitesse_apres_coll (rb, rm, p, n, q0, qm, epsilon_b2mur, false);
      roulement_b = false;

      q0 = [wbf(1) wbf(2) wbf(3) vbf(1) vbf(2) vbf(3) rb(1) rb(2) rb(3)];
    endif
    
    if r_mur_collision
      %fprintf("r_mur_collision\n");
      
      if pos_mur_r == 0
        qm = [ 0 0 0 0 0 0 qsr(7)-2*R qsr(8) R];
            
      elseif pos_mur_r == 1
        qm = [ 0 0 0 0 0 0 qsr(7)+2*R qsr(8) R];
        
      elseif pos_mur_r == 2
       qm = [ 0 0 0 0 0 0 qsr(7) qsr(8)-2*R R];
      elseif pos_mur_r == 3 
        qm = [ 0 0 0 0 0 0 qsr(7) qsr(8)+2*R R];
      endif
      
      
      rm = [ qm(7) qm(8) qm(9)];
      n = rr-rm/norm(rr-rm);
      p = rr + n*R;
      [vrf vmf wrf wmf] = calculer_vitesse_apres_coll (rr, rm, p, n, qr0, qm, epsilon_b2mur, false);
      roulement_r = false;

      qr0 = [wrf(1) wrf(2) wrf(3) vrf(1) vrf(2) vrf(3) rr(1) rr(2) rr(3)];
    endif
    
    if j_mur_collision
      %fprintf("j_mur_collision\n");
      
      if pos_mur_j == 0
        qm = [ 0 0 0 0 0 0 qsj(7)-2*R qsj(8) R];
            
      elseif pos_mur_j == 1
        qm = [ 0 0 0 0 0 0 qsj(7)+2*R qsj(8) R];
        
      elseif pos_mur_j == 2
       qm = [ 0 0 0 0 0 0 qsj(7) qsj(8)-2*R R];
      elseif pos_mur_j == 3 
        qm = [ 0 0 0 0 0 0 qsj(7) qsj(8)+2*R R];
      endif
      
      rm = [ qm(7) qm(8) qm(9)];
      n = rj-rm/norm(rj-rm);
      p = rj + n*R;
      [vjf vmf wjf wmf] = calculer_vitesse_apres_coll (rj, rm, p, n, qj0, qm, epsilon_b2mur, false);
      roulement_j = false;

      qj0 = [wjf(1) wjf(2) wjf(3) vjf(1) vjf(2) vjf(3) rj(1) rj(2) rj(3)];
    endif
      
    if roulement_b == false
      roulement_temp = roulement_b;
      qs = SEDRK4t0 (q0, t0, delta_t, 'g');
            
      roulement_b = qs_glissement (q0, qs);
      
      xb(end+1,:) = next_pos(xb(end), qs(4), delta_t);
      yb(end+1,:) = next_pos(yb(end), qs(5), delta_t);
      vbx(end+1,:) = qs(4);
      vby(end+1,:) = qs(5);
      
      q0 = qs;
      
      if roulement_b != roulement_temp
        tr(end+1,:) = [t0];
      endif
      
      tt(end+1,:) = [t0];
      t0 = t0 + delta_t;
    else
      [qs,arret_balle_b] = qs_roulement (q0, delta_t, R);
      
      q0 = qs;

      xb(end+1,:) = next_pos(xb(end), qs(4), delta_t);
      yb(end+1,:) = next_pos(yb(end), qs(5), delta_t);
      
      tt(end+1,:) = [t0];
      t0 = t0 + delta_t;
      
      if arret_balle_b == true
        break;
      endif
      
    endif  
    
    if roulement_r == false

      qsr = SEDRK4t0 (qr0, t0, delta_t, 'g');
            
      roulement_r = qs_glissement (qr0, qsr);
      
      xr(end+1,:) = next_pos(xb(end), qs(4), delta_t);
      yr(end+1,:) = next_pos(yb(end), qs(5), delta_t);
      
      qr0 = qsr;

    else
      [qsr,is_roulement_r_end] = qs_roulement (qr0, delta_t, R);
      
      qr0 = qsr;

      xr(end+1,:) = next_pos(xr(end), qsr(4), delta_t);
      yr(end+1,:) = next_pos(yr(end), qsr(5), delta_t);

      if is_roulement_r_end == true
        roulement_r = false;
        qr0 = [ 0 0 0 0 0 0 qr0(7) qr0(8) qr0(9)];
      endif
      
    endif
    
    if roulement_j == false

      qsj = SEDRK4t0 (qj0, t0, delta_t, 'g');
            
      roulement_j = qs_glissement (qj0, qsj);
      
      xj(end+1,:) = next_pos(xj(end), qsj(4), delta_t);
      yj(end+1,:) = next_pos(yj(end), qsj(5), delta_t);
      
      qj0 = qsj;

    else
      [qsj,is_roulement_j_end] = qs_roulement (qj0, delta_t, R);
      
      qj0 = qsj;

      xj(end+1,:) = next_pos(xj(end), qsj(4), delta_t);
      yj(end+1,:) = next_pos(yj(end), qsj(5), delta_t);

      if is_roulement_r_end == true
        roulement_r = false;
        qr0 = [ 0 0 0 0 0 0 qj0(7) qj0(8) qj0(9)];
      endif
      
    endif
    
    if collision_avec_rouge
        coll = coll + 1;
    end
    if collision_avec_jaune
        coll = coll + 1;
    end
%{
  fprintf("vf = [ %d %d %d]\n", qs(4),qs(5),qs(6));
  fprintf("rf = [ %d %d %d]\n", qs(7),qs(8),qs(9));

  fprintf("-----------------------------------------------------------------\n");
    %}
  until m == 10000
  
endfunction