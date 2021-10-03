
function [pcdm] = cdm (pos, masse)
  
  total = [0,0,0];
  masseTotal = sum(masse);
  centre = [0,0,0];
  
  for i = 1:(size(pos)(1))
    centre = [pos(i,1), pos(i,2), pos(i,3)]*masse(i);
    total = total + centre;  
  endfor
  pcdm = total / masseTotal;

endfunction
