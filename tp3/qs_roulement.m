function [ qs,arret_balle ] = qs_roulement (q0, delta_t, R)
  
  u_r = 0.03;

  
  v0 = [q0(1); q0(2); q0(3)];
  w0 = [q0(7); q0(8); q0(9)];
  r0 = [q0(4); q0(5); q0(6)];
  
  d = -v0/norm(v0);
  wr = w0/norm(w0);
  acc = u_r*9.8*d;
  
  vc = v0 +acc*delta_t;
  wc = (norm(vc)/R)*wr;
  pos = next_pos(r0, v0, delta_t)+0.5*acc*delta_t.^2;
  
  qs = [wc(1); wc(2); wc(3); vc(1); vc(2); vc(3); pos(1); pos(2); pos(3)];
  
  arret_balle = dot(v0, vc) < 0;
  
endfunction
