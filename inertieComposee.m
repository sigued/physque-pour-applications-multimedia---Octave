function inertie = inertieComposee (inertieComposant, pcdmComposant, pcdmGlobal, masse, pos)
  %dc = [ dc,x , dc,y , dc,z ] = pcdmComposant - pcdmGlobal
  
  dcx = (pcdmComposant(1) + pos(1) - pcdmGlobal(1));
  dcy = (pcdmComposant(2) + pos(2) - pcdmGlobal(2));
  dcz = (pcdmComposant(3) + pos(3) - pcdmGlobal(3));
 
  % initialisation de la matrice de translation (mTranslation)
  mTranslation = zeros(3,3);
  
  mTranslation(1) = dcy^2 + dcz^2;
  mTranslation(2) = -1*(dcy*dcx);
  mTranslation(3) = -1*(dcz*dcx);
  mTranslation(4) = mTranslation(2);
  mTranslation(5) = dcx^2+dcz^2;
  mTranslation(6) = -1*(dcz*dcy);
  mTranslation(7) = mTranslation(3);
  mTranslation(8) = mTranslation(6);
  mTranslation(9) = dcx^2+dcy^2;
   
  % Id = inertie = Ic + m*T(dc)
  inertie = inertieComposant + masse*mTranslation;
  
endfunction
