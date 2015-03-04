%generate an n-vertex polygon 
function[points]=generate_polygon(sides,radius)
    %figure out angles for vertices
    step_size = (2*pi)/sides;
    angles = zeros(sides);
    for i = 1:sides
        angles(i) = step_size*i;
    end
    %convert angles to coordinates
    points = zeros(sides,2);
    for i = 1:sides
        points(i,1)=cos(angles(i))*radius;
        points(i,2)=sin(angles(i))*radius;
    end    
    plot(points(:,1),points(:,2),'o','MarkerSize',10);
end