function I_c = calculer_momentInertie (m, r)
  
  I_xx = I_yy = I_zz = (2*m/5)*(r.^2);
  I_c = [I_xx 0 0; 0 I_yy 0; 0  0 I_zz];
  % translation des axes
  

endfunction
