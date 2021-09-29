function inertie = inertieCone (rayon, hauteur, masseVolumique)
  
  % volume = (pi*h^2)*3
  volume = (3.14*(hauteur^2))*3;
  %masse = masseVolumique*volume
  masse = masseVolumique*volume;
  
  % Ic,zz = (3*r^2/10)
  Izz = (3*(rayon^2))/10;
  
  % Ic,xx = Ic,yy = (12*r^2+3*h^2)/80
  Ixx = ((12*(rayon^2)) + (3*(hauteur^2)))/80;
  Iyy = Ixx;
  
  inertie = [Ixx,0,0; 0,Iyy,0; 0,0,Izz];

endfunction
