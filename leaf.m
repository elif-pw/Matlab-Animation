function leaf(x,y)
%by Elif Ozdemir
g = -9.8;
deltaTime = 1/15;
endTime = 50;

%Define pendulum
rodPivotPoint1 = [x y]; %rectangular coordinates
rodPivotPoint2 = [x+randi([-100 200],1) y+randi([-20 0],1)];
rodLength = 50;
mass = 1; 
radius = 10; 
theta = 45; 
velocity = [10 5]; 

position1 = rodPivotPoint1 - (rodLength*[-sind(theta) cosd(theta)]); %in rectangular coordinates
%position2 = rodPivotPoint2 - (rodLength*[-sind(theta) cosd(theta)]); %in rectangular coordinates

rectHandle1 = rectangle('Position',[(position1 - radius/2) 40 10],...
    'FaceColor', hsv2rgb([1 unifrnd(0.3, 1) unifrnd(0.3, 1)]) ,'EdgeColor','none', 'LineWidth', 0.5, 'Curvature', [1 1]);

%rectHandle2 = rectangle('Position',[(position2 - radius/2) 40 10],...
   % 'FaceColor', hsv2rgb([1 unifrnd(0.3, 1) unifrnd(0.3, 1)]) ,'EdgeColor','none', 'LineWidth', 0.5, 'Curvature', [1 1]);

for time = (deltaTime:deltaTime:endTime)

    drawnow; 

    totalForce = [mass*g*cosd(theta) mass*g*sind(theta)];
 
    rodForce = [-totalForce(1) 0];
 
    totalForce = totalForce + rodForce;
 
    acceleration = totalForce / mass; %F = ma
    velocity =velocity + acceleration * deltaTime;
    rodLength = rodLength + velocity(1) * deltaTime;
    theta = theta + velocity(2) * deltaTime/rodLength/pi*180;

    position1 = rodPivotPoint1 - (rodLength*[-sind(theta) cosd(theta)]);
    %position2 = rodPivotPoint2 - (rodLength*[-sind(theta) cosd(theta)]);

    %Update figure with new position info
    set(rectHandle1,'Position',[(position1 - radius/2) 40 10]);
    %set(rectHandle2,'Position',[(position2 - radius/2) 40 10]);


end


