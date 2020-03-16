function night_mode_project
%by Elif Ozdemir
%This is a very simple simulation of a tree and its falling leaves in autumn

% set up figure
figure;
canvas_width = 1000;
canvas_height = 800;
axis('equal');
axis([0 canvas_width 0 canvas_height]);
set(gca,'color',[10, 10, 10]/255, 'XColor', 'none','YColor','none');
set(gcf,'color',[10, 10, 10]/255);

root_thickness = 14;
root_length = 280;
branch_decay_factor = 0.680;
branch_decay_randomness = 0.2;  
branch_angle = deg2rad(25);
branch_angle_randomness = 0.4;
branch_color = [231, 204, 177]/255;
min_branch_length = root_length * branch_decay_factor^7;

line([canvas_width/2 canvas_width/2], [0 100+root_thickness], ...
    'LineWidth', root_thickness, 'Color', branch_color);

% draw branches
 draw_branch_at(canvas_width/2, 100, ...
     branch_decay_factor * root_thickness, branch_decay_factor * root_length, 1j);



function can_branch = draw_branch_at(x, y, thickness, len, direction)
if len < min_branch_length
    can_branch = false;
    return;
end

% generate branch angles
theta_1 = branch_angle * (1.0 + branch_angle_randomness * max(min(randn(), 1), -1));
theta_2 = -branch_angle * (1.0 + branch_angle_randomness * max(min(randn(), 1), -1));
% unit length complex number is used to represent the directional vector
% rotation is done via complex number multiplication
dir_1 = direction * (cos(theta_1) + 1j*sin(theta_1));
dir_2 = direction * (cos(theta_2) + 1j*sin(theta_2));
%compute end locations of the new branches
x_1 = x + real(dir_1) * len;
y_1 = y + imag(dir_1) * len;
x_2 = x + real(dir_2) * len;
y_2 = y + imag(dir_2) * len;

% draw the two branches
line([x x_1], [y y_1], ...
    'LineWidth', thickness, 'Color', branch_color);
line([x x_2], [y y_2], ...
    'LineWidth', thickness, 'Color', branch_color);

% make new branches
decay = branch_decay_factor * (1.0 + branch_decay_randomness * max(min(randn(), 1), -1));
new_length = decay * len;
new_thickness = decay * thickness;
if ~draw_branch_at(x_1, y_1, new_thickness, new_length, dir_1) || ...
   ~draw_branch_at(x_2, y_2, new_thickness, new_length, dir_2)
end
can_branch = true;
end

%animation of falling leaves
while 1==1
   leaf(randi([200,800],1), 500);

end

end



