
function inertie = inertieCylindre (rayon, hauteur, masseVolumique)
    
  % volume = (pi*r^2)*hauteur
  volume = (3.14*(rayon^2))*hauteur;
  %masse = masseVolumique*volume
  masse = masseVolumique*volume;
  
  % Ic,zz = (masse/2)*r^2
  Izz = (masse/2)*((rayon^2));
  
  % Ic,xx = Ic,yy = ((masse/4)*(r^2)) + ((masse/12)*(hauteur^2))
  Ixx = ((masse/4)*(rayon^2)) + ((masse/12)*(hauteur^2));
  Iyy = Ixx;
  
  inertie = [Ixx,0,0; 0,Iyy,0; 0,0,Izz];

endfunction
