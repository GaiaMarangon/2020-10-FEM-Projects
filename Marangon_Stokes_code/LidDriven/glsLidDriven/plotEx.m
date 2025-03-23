function [nfig]=plotEx(nfig,nnodes,triang,coord,u1_ex,u2_ex,p_ex)
    
    figure(nfig)
    hold on
    %sgtitle('Exact');

    u1Vec=func2vect(nnodes,coord,u1_ex);
    u2Vec=func2vect(nnodes,coord,u2_ex);
    pVec=func2vect(nnodes,coord,p_ex);
    
    subplot(1,3,1)
    trisurf(triang,coord(:,1),coord(:,2),u1Vec);
    xlabel('x');
    ylabel('y');
    %title('Exact - u_1');
    
    subplot(1,3,2)
    trisurf(triang,coord(:,1),coord(:,2),u2Vec);
    xlabel('x');
    ylabel('y');
    %title('Exact - u_2');
    
    subplot(1,3,3)
    trisurf(triang,coord(:,1),coord(:,2),pVec);
    xlabel('x');
    ylabel('y');
    %title('Exact - p');
    
    hold off
    nfig=nfig+1;

end