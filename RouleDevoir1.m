clear
%
% Procedure servant à rouler le devoir 1
%
% Cas 1
AngRotCas1=0.0;
vangulaireCas1=[0;0;0];
forceCas1=[5e6;0;0];
posCas1=[0;0;0];
[pcmCas1 ICas1 alphaCas1]=Devoir1(posCas1,AngRotCas1,vangulaireCas1,forceCas1);
fprintf('\nResultats missile verticale \n');
fprintf('  Centre de masse = ( %10.5f  %10.5f  %10.5f )\n',pcmCas1(1),pcmCas1(2),pcmCas1(3));
fprintf('  Moment inertie  =\n   %14.0f & %14.0f & %14.0f \\\\ \n   %14.0f & %14.0f & %14.0f \\\\ \n   %14.0f & %14.0f & %14.0f \\\\ \n',...
     ICas1(1,1),ICas1(1,2),ICas1(1,3),ICas1(2,1),ICas1(2,2),ICas1(2,3),ICas1(3,1),ICas1(3,2),ICas1(3,3));
fprintf('  acc angulaire   = ( %10.5f  %10.5f  %10.5f )\n',alphaCas1(1),alphaCas1(2),alphaCas1(3));
%
% Cas 2
