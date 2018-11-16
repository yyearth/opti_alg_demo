clc
clear

points = 50;
%%
C = [3, 1; -1, -2];
%%
x = linprog([2; -1], [0, 1; 3, -1], [3; 6], [], [], [0; 0]);
p = C*x;
%%
syms f(x)
f(x) = -x+sum(p);
%%
min_c1= linprog(C(1, :), [0, 1; 3, -1], [3; 6], [], [], [0; 0]);
min_c2 = linprog(C(2, :), [0, 1; 3, -1], [3; 6], [], [], [0; 0]);
%%
most_left = C*min_c1;
most_right = C*min_c2;
%%
select = linspace(-3, 13, points);
q = double([select; f(select)]);
scatter(q(1,:), q(2,:));
hold on
scatter([0, 12], [0, -9], 'red');
%%
front = zeros(2, size(q, 2));
solution = zeros(3, size(q, 2));
for i = 1:size(q, 2)
    solution(:, i) = linprog([0, 0, 1], [C, [-1; -1]; [0, 1, 0; 3, -1, 0]],...
                             [q(:,i); 3; 6], [], [], [0; 0; 0]);
    front(:,i) = q(:,i) + solution(3, i)*[1; 1];      
end
%%
% disp(solution);
scatter(front(1,:), front(2, :))