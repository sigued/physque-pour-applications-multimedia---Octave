function q = qt (v, w, t)
  k1 = calculer_acc(v, w);
  k2 = calculer_acc((v + (k1*(t/2))), w);
  k3 = calculer_acc((v + (k2*(t/2))), w);
  k2 = calculer_acc((v + (k3*t)), w);
  
  q = v + (t/6)*(k1+2*k2+2*k3+k4);
  
endfunction
