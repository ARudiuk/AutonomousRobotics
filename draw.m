%Draw a map
function [] = draw(map)
    clf();
    figure(1);
    hold on;
    %results are stored in terms of local coordinates
    %add position to change to global coordinates for plotting
    plot(map(:,1),map(:,2),'bo');
    plot(map(:,3),map(:,4),'kx');
    plot(map(end,1),map(end,2),'gh','MarkerSize',15);
end