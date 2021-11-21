function F = fGlissement (vitesse)
  
  u_c = 0.3;
  m = 0.21;
  
  F = -u_c*m*9.81*(vitesse/(norm(vitesse)));

endfunction
