
function acc = calculer_acc (v, w)
  
  MASSE_BALLON = 0.45;
 
  [Fg, Ff, Fm] = calculer_forces(v,w);
  
  f_totale = Fg + Ff + Fm;
  acc = f_totale / MASSE_BALLON;

endfunction
