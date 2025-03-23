function []=plotSol(nnodes,coord,triang,u1_ex,u2_ex,p_ex,u1_num,u2_num,p_num)

    %{
    figure(1)
    hold on 
    %sgtitle('Exact solution')
    
    u1Vec=func2vect(nnodes,coord,u1_ex);
    u2Vec=func2vect(nnodes,coord,u2_ex);
    pVec=func2vect(nnodes,coord,p_ex);
    
        subplot(1,3,1)
        trisurf(triang,coord(:,1),coord(:,2),u1Vec);
        xlabel('x');
        ylabel('y');
        %title('u1_{ex}');
    
        subplot(1,3,2)
        trisurf(triang,coord(:,1),coord(:,2),u2Vec);
        xlabel('x');
        ylabel('y');
        %title('u2_{ex}');
    
        subplot(1,3,3)
        trisurf(triang,coord(:,1),coord(:,2),pVec);
        xlabel('x');
        ylabel('y');
        %title('p_{ex}');
    
    hold off
    figure(2)
    hold on
    %sgtitle('Bubble - Manufactured')
    %}
    
        figure(1)
        trisurf(triang,coord(:,1),coord(:,2),u1_num);
        xlabel('x');
        ylabel('y');
        %title('u1_{num}');

        figure(2)   
        trisurf(triang,coord(:,1),coord(:,2),u2_num);
        xlabel('x');
        ylabel('y');
        %title('u2_{num}');

        figure(3)
        trisurf(triang,coord(:,1),coord(:,2),p_num);
        xlabel('x');
        ylabel('y');
        %title('p_{num}');
     
    hold off

end