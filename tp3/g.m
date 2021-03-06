function res = g (q0, t0)
  
  m=0.21;
  r=0.031;
  u_c = 0.3;
    
  wi = [q0(1) q0(2) q0(3)];
  vi = [q0(4) q0(5) q0(6)];
  ri = [q0(7) q0(8) q0(9)];
  
  rp = [q0(4) q0(5) 0];
  
  vc = vi;
  vr = cross(-wi, (rp-ri));

  d = (vc-vr)/norm(vc-vr);
  
  Fg = [0 0 -9.81*m];
  Ff = fGlissement(vi);
  F = Ff;
  
  a = -1*(u_c*m*9.81*d)/m;
  aa = -1*(5/(2*m*r.^2))*(u_c*m*9.81*cross((ri-rp), d));
  
  if norm(vc) == 0 && norm(vr) == 0
    a= [0 0 0];
    aa = [0 0 0];
    
  endif
  
  res = [aa(1), aa(2), aa(3), a(1), a(2), a(3), vi(1) vi(2) 0];

endfunction