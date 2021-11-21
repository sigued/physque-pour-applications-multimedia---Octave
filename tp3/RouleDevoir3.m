%
% Devoir 3
% Billard français
% 
%
xtable=[0 2.8 2.8   0   0];
ytable=[0   0  1.53  1.53   0];
for Simulation=1:4
  if Simulation == 1
    disp('Simulation 1');
    xyb=[0.5;0.3];
    xyr=[1.5;1.1];
    xyj=[1.45;1.31];
    Vb0=[1.7;0.5];
  elseif Simulation == 2
    disp('Simulation 2');
    xyb=[0.5;0.3];
    xyr=[1.5;1.1];
    xyj=[1.45;1.31];
    Vb0=[1.5074;1.3145];
  elseif Simulation == 3
    disp('Simulation 3');
    xyb=[0.5;0.3];
    xyr=[1.5;1.1];
    xyj=[1.45;1.31];
    Vb0=[0.4;0.3];
  elseif Simulation == 4
    disp('Simulation 4');
    xyb=[0.5;0.3];
    xyr=[1.5;1.1];
    xyj=[1.45;1.31];
    Vb0=[2;2];
  end
  clf;
  hold;
  xlabel('x(m)')
  ylabel('y(m)')
  axis equal
  fill(xtable,ytable,'b');
 [coll tr tt xb yb xr yr xj yj]=Devoir3(xyb, xyr, xyj, Vb0);
 fprintf('Instant de transaction roulement avec-sans glissement \n');
  disp(tr)
  sz=size(tt,2);
%  plot(xb(1:sz),yb(1:sz),'w',xr(1:sz),yr(1:sz),'r',xj(1:sz),yj(1:sz),'y')
  plot(xyb(1),xyb(2),'w')
  plot(xyr(1),xyr(2),'r')
  plot(xyj(1),xyj(2),'y')
  plot(xb(1:sz),yb(1:sz),'w')
  plot(xr(1:sz),yr(1:sz),'r')
  plot(xj(1:sz),yj(1:sz),'y')
  if coll == 0
    fprintf('Aucune bille touchée \n');
  elseif coll == 1
    fprintf('Une seule bille touchée \n');
  elseif coll == 2
    fprintf('Les deux billes sont touchées \n');
    fprintf('Le point est marqué\n');
  end
  hold;
  pause;
  clearvars xyb xyr xyj Vb0 coll tr tt xb yb xr yr xj yj
end;
