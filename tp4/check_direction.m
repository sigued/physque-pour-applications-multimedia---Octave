
function retval = check_direction (poso, xyp, R_p, u_t)
  
  if poso(2)>0
    retval = u_t(2)/2 <= sin(R_p/(poso(2)-xyp(2)-R_p));
  endif
  
  if poso(1)>0
    retval = u_t(1)/2 <= sin(R_p/(poso(1)-xyp(1)-R_p));
  endif
  

endfunction
