function [But vbf tt xx yy zz]=Devoir2(xy0,Vb0,Wb0)
  
  RAYON_BALLON= 0.11 ;%en m 
  t_0 = 100;
  delta_t = 1000/t_0;
  
  [r_0, r_i, v_0, vbf, tt, limite, But ] = trajectoire (xy0,Vb0,Wb0, RAYON_BALLON, delta_t, t_0);
  
  xx = r_i(1);
  yy = r_i(2);
  zz = r_i(3);
  
endFunction

