function [rp, u_i, v_i, u] = calculer_rp (poso, R, z, r_c)
  x=poso(1);
  y=poso(2);
  %z=poso(3); %%%%%%%%%%%%%%%%hummmmmm pas sur ????????????????????????????????
  d = sqrt((x.^2)+(y.^2));
  
  alpha = asin(R/d);
  i = alpha/10;
  alpha_i = 0;
  
  rp1 = [0; 0; 0];
  rp2 = [0; 0; 0];
  rp = [0; 0; 0];
  u_i = [0; 0; 0];
  v_i = [0; 0; 0];
  
  u = [0;0;0];
  u1 = [0;0;0];
  u2 = [0;0;0];
  
  for j = 1:11
    
    if y==0
      u_1 = [-1*cos(alpha_i); sin(alpha_i)];
      u_2 = [-1*cos(alpha_i); -1*sin(alpha_i)];
      
     
    else
      u_1 = [-1*sin(alpha_i); -1*cos(alpha_i)];
      u_2 = [sin(alpha_i); -1*cos(alpha_i)];
      
  endif
  
  s_p1 = sqrt((R.^2)/((u_1(1).^2)+(u_1(2).^2))); %%% Z???????????????????
  s_p2 = sqrt((R.^2)/((u_2(1).^2)+(u_2(2).^2))); %%% Z???????????????????
      
  r_p1 = -1*s_p1*u_1;
  r_p2 = -1*s_p2*u_2;  
  
  u_z = ((poso(3)-z/abs(poso(3)-z)));
  
  if (poso(3)-z == 0)
    u_z = 0;
  endif
  
  u1( :, end+1 ) = [u_1; u_z]; 
  u2( :, end+1 ) = [u_2; u_z]; 
  
  rp1( :, end+1 ) = [r_p1; z];
  rp2( :, end+1 ) = [r_p2; z];
  
  alpha_i = alpha_i + i;
    
  endfor
  
  rp = [rp2(1:3,3:end) rp1(1:3,2:end)];
  u = [u2(1:3,3:end) u1(1:3,2:end)];
  
  for i=1:columns(rp)
    
    u_i(:, end+1 ) = vecteur_incident_ui (rp(1:3, i), poso);
    v_i(:, end+1 ) = vecteur_incident_ui (rp(1:3, i), r_c);
    
  endfor
  
  
  
endfunction
