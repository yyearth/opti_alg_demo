clc
clear
%%
POINTS = 50;
%%
C = [3, 1; -1, -2];
min_c1= linprog(C(1, :), [0, 1; 3, -1], [3; 6], [], [], [0; 0])
min_c2 = linprog(C(2, :), [0, 1; 3, -1], [3; 6], [], [], [0; 0])
most_left = C*min_c1
most_right = C*min_c2
%%
% plot([0, 12], [0, -9], 'LineWidth', 2)
% hold on
%%
syms f(x)
f(x) = (-3/4)*x;
%%
select = linspace(0, 12, POINTS)
q = [select; double(f(select))]
%%
A = [0, 1, 0; 3, -1, 0];
b = [3; 6];
Aeq = [-C, [-3; -4]];
%%
front = zeros(2, POINTS);
solution = zeros(3, POINTS);
for i = 1:POINTS
    solution(:, i) = linprog([0, 0, -1], A, b, Aeq, -q(:, i), [0, 0, 0]);
    front(:,i) = q(:,i) + solution(3, i)*[-3; -4]; 
end
%%
scatter(front(1,:), front(2, :))
hold on
scatter(q(1,:), q(2,:));
scatter([0, 12], [0, -9], 'red');
title('NBI');

xlim([-1.3 15.5])
ylim([-10.2 2.5])