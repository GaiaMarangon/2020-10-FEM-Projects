function [nfig]=plotNumSolStab(nfig,triang,coord,u1_num,u2_num,p_num)
%slightly modified: get single plots instead of subplots

figure(nfig)
trisurf(triang,coord(:,1),coord(:,2),u1_num);
xlabel('x');
ylabel('y');
%title('Stabilized - u_1');
nfig=nfig+1;

figure(nfig)
trisurf(triang,coord(:,1),coord(:,2),u2_num);
xlabel('x');
ylabel('y');
%title('Stabilized - u_2');
nfig=nfig+1;

figure(nfig)
trisurf(triang,coord(:,1),coord(:,2),p_num);
xlabel('x');
ylabel('y');
%title('Stabilized - p');
nfig=nfig+1;


end