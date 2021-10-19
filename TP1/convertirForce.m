
function force = convertirForce (force, theta, phi)
  fx = force*sin(phi)*cos(theta);
  fy = force*sin(phi)*sin(theta);
  fz = force*cos(phi);
  
  force = [fx; fy; fz];

endfunction
