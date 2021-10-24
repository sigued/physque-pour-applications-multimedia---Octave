function [coup vf t x y z] = Devoir2 (xy0, vb0, wb0)
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
%%%%Constantes
  coup = 4;
  
  R_BALLON = 0.11;
  X_MIN = 0;
  X_MAX = 120;
  Y_MIN = 0;
  Y_MAX = 90;
  LARGEUR_BUT = 7.32;
  HAUTEUR_BUT = 2.44;
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  t_0 = 100;
  delta_t = 1000/t_0;
  err_max = 0.0095;
  q0 = [vb0(1); vb0(2); vb0(3); xy0(1); xy0(2); R_BALLON];
  qi = q0(1:6);
  delta_t = 1000/100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
do
  
  fprintf('DeltaT = %12.8f \n', delta_t);
  
  q_t =  q0(1:6);
  vf = [q_t(1); q_t(2); q_t(3)];
  x = [q_t(4)];
  y = [q_t(5)];
  z = [q_t(6)];
  t0 = 100;
  t = [t0];
  
  do
    q_t = qt(vf, wb0, delta_t);
    vf = [q_t(1); q_t(2); q_t(3)];
    x(end+1,:) = q_t(4) = next_pos(x(end), q_t(1), delta_t);
    y(end+1,:) = q_t(5) = next_pos(y(end), q_t(2), delta_t);
    z(end+1,:) = q_t(6) = next_pos(z(end), q_t(3), delta_t);
    t(end+1,:) = [t0];
    t0 = t0 + delta_t;
    pos = [x(end); y(end); z(end)];
        
  until hors_terrain(pos) || touche_montant(pos) || entre_dans_but(pos) || touche_sol(pos) || touche_montant_horz(pos) || t0>=1000
  
  erreur = sqrt((q_t(4) - qi(4))^2 + (q_t(5) - qi(5))^2 + (q_t(6) - qi(6))^2);
  qi = q_t(1:6);
  
  delta_t = delta_t / 2;
  fprintf('erreur = %12.8f \n', erreur);
until erreur <= err_max

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pos = [x(end); y(end); z(end)];


if touche_sol(pos)
  coup = 1;
elseif entre_dans_but(pos)
  coup = 0;
elseif touche_montant(pos) || touche_montant_horz(pos)
  coup =3;
elseif hors_terrain(pos)
  coup = 2;
endif  



endfunction
