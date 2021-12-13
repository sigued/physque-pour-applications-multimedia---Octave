function p = intersect_paille (u_t, xyp, R_p)
  u_x = u_t(1);
  u_y = u_t(2);
  x = xyp(1);
  y = xyp(2);
  
  delta = ((2*u_x*x+2*u_y*y).^2)- 4*(u_x.^2+u_y.^2)*(x.^2+y.^2-R_p.^2);
  
  
  s_max = (2*u_x*x+2*u_y*y + sqrt(delta))/(2*(u_x.^2+u_y.^2));
  s_min = (2*u_x*x+2*u_y*y - sqrt(delta))/(2*(u_x.^2+u_y.^2));
  
  s = s_max;
  
  if s_min > 0
    s = s_min;
  endif
  
  p = -1*s*[u_t(1); u_t(2)];


endfunction
