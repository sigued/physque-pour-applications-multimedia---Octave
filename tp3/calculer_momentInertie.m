function mi = calculer_momentInertie (m, r, d)
    I_xx = I_yy = I_zz = (2*m/5)*(r.^2);
  I_c = [I_xx, 0, 0; 0, I_yy, 0; 0 , 0, I_zz];
  R = [cos(obj.Angle), -sin(obj.Angle), 0; sin(obj.Angle), cos(obj.Angle), 0; 0, 0, 1];
  % translation des axes
  
  d_c = d-r;
  d_cx = d_c(1);
  d_cy = d_c(2);
  d_cz = d_c(3);
  
  T = [ (d_cy.^2 + d_cz.^2) (-d_cx*d_cy) (-d_cx*d_cz); (-d_cy*d_cx) (d_cx.^2 + d_cz.^2) (-d_cy*d_cz); (-d_cz*d_cx) (-d_cz*d_cy) (d_cx.^2 + d_cy.^2) ];
   
  mi = I_c+m*T;
  

endfunction
