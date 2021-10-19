function inertie = inertieAile (epaisseur, largeur, hauteur, masse)
  
  % Ic,xx = (masse/12)*(largeur^2+hauteur^2)
  Ixx = (masse/12)*(largeur^2+hauteur^2);
  
  % Ic,yy = (masse/12)*(epaisseur^2+hauteur^2)
  Iyy = (masse/12)*(epaisseur^2+hauteur^2);
  
  % Ic,zz = (masse/12)*(epaisseur^2+largeur^2)
  Izz = (masse/12)*(epaisseur^2+largeur^2);
  
  inertie = [Ixx,0,0; 0,Iyy,0; 0,0,Izz];

endfunction
