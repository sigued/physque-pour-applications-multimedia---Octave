
function ballon_au_sol = touche_sol (pos)
    
  R_BALLON = 0.11;
  ballon_au_sol = pos(3) < R_BALLON;
  

endfunction
