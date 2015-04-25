%Draw a map
function [] = draw(position,results,goal,map)
    clf();
    figure(1);
    hold on;
    %results are stored in terms of local coordinates
    %add position to change to global coordinates for plotting
    plot(results(:,1)+position(1),results(:,2)+position(2),'bo');
    %position is already in global coordinates so just plot
    plot(position(1),position(2),'rh','MarkerSize',15);
    %goal is aleady in global coordinates ss just plot
    plot(goal(1),goal(2),'gh','MarkerSize',15);
    %map is aleady in global coordinates so just plot
    plot(map(:,1),'ko');
end