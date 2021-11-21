function v_r = calculer_vRoulement (t, r_pc, v)
  
  m = 0.21;
  f_r = fRoulement(v);
  
  acc = f_r/m;
  aa = acc; % acc angulaire est egale a l'acc du CM
  
  v_r = cross((aa*t), r_pc) %vitesse de roulement = alpha*t x r_pc
endfunction
