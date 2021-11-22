function [ qs,arret_balle ] = qs_roulement (q0, delta_t, R)
  
  u_r = 0.03;

  
  v0 = [q0(1); q0(2); q0(3)];
  w0 = [q0(7); q0(8); q0(9)];
  r0 = [q0(4); q0(5); q0(6)];
  
  d_r = -v0/norm(v0);
  w_r = w0/norm(w0);
  acc = u_r*9.8*d_r;
  
  vi = v0 +acc*delta_t;
  wi = (norm(vi)/R)*w_r
  pos = next_pos(r0, v0, delta_t)+0.5*acc*delta_t.^2;
  
  q0 = [vi(1); vi(2); vi(3); ri(1); ri(2); ri(3); wi(7); wi(8); wi(9)];
  
  arret_balle = dot(v0, vi) < 0;
  

endfunction
