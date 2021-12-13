
function [u_t] = vecteur_transmis (n_p, n_i, n_t, u_i)
  
  u_t = [0;0;0];
  
  for i=1:columns(u_i)
    
    j = cross(u_i(1:3, i), n_p(1:3, i))./norm(cross(u_i(1:3, i), n_p(1:3, i)));
    k = cross(n_p(1:3, i), j);
    s_2 = (n_i/n_t)*dot(u_i(1:3, i), k);
    u_t(:, end+1 ) = -1*(n_p(1:3, i))*sqrt(1-(s_2.^2))+(k*s_2);
    
  endfor
  
  %j = cross(u_i, n_p)./norm(cross(u_i, n_p));
  %k = cross(n_p, j);
  %s_2 = (n_i/n_t)*dot(u_i, k);
  %u_t = -1*n_p*sqrt(1-(s_2.^2))+(k*s_2);

endfunction
