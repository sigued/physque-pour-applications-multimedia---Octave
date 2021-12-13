function [xi yi zi couleur] = v3(poso,xyp,he)
%function [xi yi zi couleur pos, theta_i_ theta_f_] = Devoir4(poso,xyp,he)
  
%function [theta_i theta_f pos u_t] = Devoir4(poso,xyp,he)
  
  R_p = 5/1000;
  H_p = 25/100;
  n_v = 1;
  H_v = 20/100;
  R_v = 4/100;
  n_air = 1;
  n_eau = 1.333;
  rc_p = [xyp(1); xyp(2); H_p/2];
  r_c = [0; 0; H_v/2];
  
  theta_i = 0;
  theta_f = 0;
  cote_adj = poso(1);
  
  u_t=[0;0;0];
  
  couleur = [1];
  
  H_couleur = H_p/5;
  rouge = H_couleur;
  orange = rouge + H_couleur;
  magenta = orange + H_couleur;
  vert = magenta + H_couleur;
  bleu = vert + H_couleur;
  
  xi = [0];
  yi = [0];
  zi = [0];
  
  rpp=[0;0;0];
  
 %%%%%%%%%%%%%%%%%%%%%%%%%   ANGLE POLAIRE   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  if he == H_v
    
    if poso(1) == 0
      theta_i = -1*atan(poso(3)/poso(2));
      theta_f = atan((H_v-poso(3))/poso(2));
      cote_adj = poso(2);
    elseif poso(2) == 0 && poso(3)>0
      theta_i = -1*atan(poso(3)/poso(1));
      theta_f = atan((H_v-poso(3))/poso(1));
    else
      theta_i = atan((abs(poso(3)))/poso(1));
      theta_f = atan((H_v-poso(3))/poso(1));
    endif
    
  else   
    if poso(1) == 0
      theta_i = -1*atan(poso(3)/poso(2));
      theta_f = atan((he-poso(3))/poso(2));
      cote_adj = poso(2);
    elseif poso(2) == 0 && poso(3)>0
      theta_i = -1*atan(poso(3)/poso(1));
      theta_f = atan((he-poso(3))/poso(1));
    else
      theta_i = atan((abs(poso(3)))/poso(1));
      theta_f = atan((he-poso(3))/poso(1));
    endif    
    
  endif
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

  k = (theta_f - theta_i) / 100;
  theta = theta_i;
  pos = [cote_adj];
  
  while (theta <= (theta_f+k))
    %fprintf("%d\n", theta);
    pos(end+1,:) = poso(3)+(cote_adj*(tan(theta)));
    z = poso(3)+(cote_adj*(tan(theta)));
    
    [rp, u_i, v_i, u] = calculer_rp (poso, R_v, z, r_c);
    
    [u_t] = vecteur_transmis (v_i, n_air, n_eau, u);
    
    for i = 1:columns(rp)
      %touch = check_direction (poso, xyp, R_p, u_t(1:3, i));
      touch = true;
      
      if touch == true
        [rpp, u_ip, v_ip, up] = calculer_rp (rp(1:3, i), R_p, z, rc_p);
        pxy = intersect_paille (u_t, xyp, R_p);
        xi(end+1) = pxy(1);
        yi(end+1) = pxy(2);
        zi(end+1) = rp(3);
        
        if(rp(3) < rouge)
          couleur(end+1) = 1;
        endif
        if(rp(3) < orange && rp(3) > rouge)
          couleur(end+1) = 2;
        endif
        if(rp(3) < magenta && rp(3) > orange)
          couleur(end+1) = 3;
        endif
        if(rp(3) < vert && rp(3) > magenta)
          couleur(end+1) = 4;
        endif
        if(rp(3) < bleu && rp(3) > vert)
          couleur(end+1) = 5;
        endif
        
        for j=1:3:columns(rpp)
          xi(end+1) = rpp(j);

      endfor
      for j=2:3:columns(rpp)
         yi(end+1) = rpp(j);

      endfor
      
      endif
      
      
      
    endfor
    
    theta = theta + k;
  endwhile   
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  if he == H_v
    
    if poso(1) == 0
      theta_i_ = atan((H_v-poso(3))/poso(2));
      theta_f_ = atan((H_p-H_v)/poso(2));
      cote_adj_ = poso(2);
    elseif poso(2) == 0 && poso(3)>0
      theta_i_ = atan((H_v-poso(3))/poso(1));
      theta_f_ = atan((H_p-H_v)/poso(1));
    else
      theta_i_ = atan((abs((H_v-poso(3))))/poso(1));
      theta_f_ = atan((H_p-H_v)/poso(1));
    endif
    
  else   
    if poso(1) == 0
      theta_i_ = atan((he-poso(3))/poso(2));
      theta_f_ = atan((H_p-he)/poso(2));
      cote_adj_ = poso(2);
    elseif poso(2) == 0 && poso(3)>0
      theta_i_ = atan((he-poso(3))/poso(1));
      theta_f_ = atan((H_p-he)/poso(1));
    else
      theta_i_ = atan((abs((he-poso(3))))/poso(1));
      theta_f_ = atan((H_p-he)/poso(1));
    endif    
    
  endif


  m = (theta_f_ - theta_i_) / 100;
  theta_ = theta;
  
  while (theta_ <= (theta_f_+m))
    %fprintf("%d\n", theta);
    pos(end+1,:) = he-poso(3)+(cote_adj_*(tan(theta_)));
    z = he-poso(3)+(cote_adj_*(tan(theta_)));
    

    [rp, u_i, v_i, u] = calculer_rp ([poso(1); poso(2); z], R_v, z, r_c);
    
    [u_t] = vecteur_transmis (v_i, n_air, n_eau, u);
    
    for i = 1:columns(rp)
      %touch = check_direction (poso, xyp, R_p, u_t(1:3, i));
      touch = true;
      
      if touch == true
        [rpp, u_ip, v_ip, up] = calculer_rp (rp(1:3, i), R_p, z, rc_p);
        pxy = intersect_paille (u_t, xyp, R_p);
        %xi(end+1) = pxy(1);
        %yi(end+1) = pxy(2);
        zi(end+1) = rp(3);
        
        if(rp(3) < rouge)
          couleur(end+1) = 1;
        endif
        if(rp(3) < orange && rp(3) > rouge)
          couleur(end+1) = 2;
        endif
        if(rp(3) < magenta && rp(3) > orange)
          couleur(end+1) = 3;
        endif
        if(rp(3) < vert && rp(3) > magenta)
          couleur(end+1) = 4;
        endif
        if(rp(3) < bleu && rp(3) > vert)
          couleur(end+1) = 5;
        endif
        
      for j=1:3:columns(rpp)
        xi(end+1) = rpp(j);
      endfor
      for j=2:3:columns(rpp)
        yi(end+1) = rpp(j);
      endfor
      
      endif
      
      
      
    endfor
    
    theta_ = theta_ + m;
  endwhile    
  
  %xi = rpp(1:3:end);
  %yi = rpp(2:3:end);


endfunction
