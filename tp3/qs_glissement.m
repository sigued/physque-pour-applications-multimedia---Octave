
function glisse = qs_glissement (q0, qs)
  
  v0 = [q0(1); q0(2); q0(3)];
  r0 = [q0(4); q0(5); q0(6)];
  w0 = [q0(7); q0(8); q0(9)];
  
  
  vi = [qs(1); qs(2); qs(3)];
  ri = [qs(4); qs(5); qs(6)];
  wi = [qs(7); qs(8); qs(9)];
  
  
  rp = [qs(4); qs(5); 0];
  r_pc = ri-rp;
  
  rp_0 = [q0(4); q0(5); 0];
  r_pc_0 = r0-rp_0;
  
  vr_0 = cross(-w0, r_pc_0);
  vr = cross(-wi, r_pc);
  d = (vi-vr)/norm(vi-vr);
  d0 = (v0-vr_0)/norm(v0-vr_0);
  
  b0 = dot(v0, vi);
  b = dot(d, d0)/abs(dot(d, d0));
  
  if b0 > 0 && b < 0
    glisse = false;
  else
    glisse = true;
  endif
  
endfunction
