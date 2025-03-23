function [nfig]=plotNumSolStab(nfig,triang,coord,u1_num,u2_num,p_num)

figure(nfig)
hold on
%sgtitle('Stabilized - P1/P1');

subplot(1,3,1)
trisurf(triang,coord(:,1),coord(:,2),u1_num);
xlabel('x');
ylabel('y');
%title('Stabilized - u_1');

subplot(1,3,2)
trisurf(triang,coord(:,1),coord(:,2),u2_num);
xlabel('x');
ylabel('y');
%title('Stabilized - u_2');

subplot(1,3,3)
trisurf(triang,coord(:,1),coord(:,2),p_num);
xlabel('x');
ylabel('y');
%title('Stabilized - p');

hold off
nfig=nfig+1;

end