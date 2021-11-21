function res = g (q0, t0)
  
  m=0.21;
  r=0.031;
    
  vi = q(1:3);
  ri = q(4:6);
  wi = q(7:9);
  ai = q(10:12);
  aai = q(13:15);
  
  Fg = gravite(m);
  Ff = fGlissement(vi);
  F = Fg+Ff;
  
  a = F/m;
  aaf = aai;
  vf = vi+a*t0;
  rf = ri+vi*t0;
  wf = wi+aai*t0;
  
  res = [rf-ri, vf-vi, wf-wi, a-ai, aaf-aai];

endfunction
