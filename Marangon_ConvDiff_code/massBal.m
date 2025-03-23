function []=massBal(nnodes,ndir,coord,triang,dirNod,stiffStabMat,u_num,vel)

% DIFFUSIVE FLUX
qdiffpos=0;
qdiffneg=0;
countpos=0;
countneg=0;
prod= - stiffStabMat*u_num;

for iloc=1:ndir
    iglob=dirNod(iloc);
    contrib=prod(iglob);
    %fprintf('f=%e, n=%d \n', contrib,iglob);
    if (contrib >0)
    qdiffpos= qdiffpos+ contrib;
    countpos = countpos +1;
    else
    qdiffneg= qdiffneg+ contrib;
    countneg = countneg +1;
    end
end
qdiff=qdiffpos + qdiffneg;

%{
%---------PLOT DIFFUSIVE FLUX-------------------
fluxdiff=zeros(nnodes,1);
for iloc=1:ndir
    iglob=dirNod(iloc);
    fluxdiff(iglob)=prod(iglob);
end
figure (2)
trisurf(triang,coord(:,1),coord(:,2),fluxdiff);
%---------PLOT DIFFUSIVE FLUX-------------------
%}


% CONVECTIVE FLUX
qconv= -vel(1) -0.3*vel(2);


% TOTAL FLUX
qtot= qdiff + qconv;


%print fluxes
fprintf('MASS BALANCE:\n');
fprintf('   countpos = %d\n   countneg = %d \n',countpos,countneg);
fprintf('   pos diffusive flux: %e \n',qdiffpos);
fprintf('   neg diffusive flux: %e \n\n',qdiffneg);
fprintf('Diffusive flux: %e \n',qdiff);
fprintf('Convective flux: %e \n\n',qconv);
fprintf('Total flux: %e \n',qtot);




end