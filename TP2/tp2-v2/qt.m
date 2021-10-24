
function q = qt (v, w, delta_t)
  
  k1 = calculer_acc(v, w);
  k2 = calculer_acc((v + (k1*(delta_t/2))), w);
  k3 = calculer_acc((v + (k2*(delta_t/2))), w);
  k4 = calculer_acc((v + (k3*delta_t)), w);
  
  q = v + (delta_t*(k1+2*k2+2*k3+k4)/6);

endfunction
