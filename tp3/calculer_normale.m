function n = calculer_normale (r_a, r_b)
  r = r_a-r_b;
  n = r/(sqrt(r(1).^2+r(2).^2));
endfunction
