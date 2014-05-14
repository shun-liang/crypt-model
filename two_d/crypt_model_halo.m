% Two D stem cell model with halo boundary conditions
crypt_num = 100;
n = 4;
lambda = 1;
time_length = 1000;
t_all_marked = zeros(1, crypt_num);
t_all_zeroed = zeros(1, crypt_num);
state_fixed = false(1, crypt_num);
marked_ratios = zeros(crypt_num, time_length + 1); % marked_ratios(c, t + 1) is the ratio of 
                                                   % marked clone in all cells of crypt c at
                                                   % time step t
marked_cells = zeros(crypt_num, time_length + 1); % marked_cells(c, t + 1) is the number of 
                                                  % cells in the marked clone in crypt c at
                                                  % time step t
cells = zeros(n, n, crypt_num);

for c=1:crypt_num
    cells(n/2, n/2, c) = 1;
end

all_influence_values = generate_influence_values_halo(n, n, crypt_num);

%cells
% marked_cells(:, 0 + 1) is a vector of the marked clone width of each crypt at the initial state
for c = 1:crypt_num
    crypt = cells(:, :, c);
    marked_cells(c, 0 + 1) = sum(crypt(:));
end

for c = 1:crypt_num
    for t = 1:time_length
        i = unidrnd(n);
        j = unidrnd(n);
        new_state = cell_update_halo(cells(:, : ,c), all_influence_values(:, :, c), i, j, n, n, lambda);
        marked_cells = update_marked_cells_two_d(marked_cells, cells, t, new_state, c, i, j);
        cells(i, j, c) = new_state;
        if isequal(cells(:, :, c), ones(n, n)) && (~state_fixed(c))
            t_all_marked(c) = t;
            state_fixed(c) = true;
        end
        if isequal(cells(:, :, c), zeros(n, n)) && (~state_fixed(c))
            t_all_zeroed(c) = t;
            state_fixed(c) = true;
        end
    end
end
t_all_marked
t_all_zeroed
for c = 1:crypt_num
    for t = 1:time_length
        marked_ratios(c, t) = marked_cells(c, t) / (n * n);
    end
end
for c=1:crypt_num
    %print("crypt ", c, marked_ratios(c, :));
    %print(marked_ratios(c, :)):
    %disp(sprintf('Marked ratio of crypt %d\n', c))
    %ratio = marked_ratios(c, :)
    disp(sprintf('Crypt %d after %d iterations\n', c, time_length))
    cells(:, :, c)
    marked_cells_in_crypt = marked_cells(c, :)

end

distributions = get_distributions(marked_cells, time_length, n * n, crypt_num);
% distributions(t + 1, i + 1) is the number of crypts having i marked cells at time t.

% Plot the clone width distributions over time.
plot_distributions(distributions, time_length, n * n)

filtered_clone_widths = get_filtered_clone_widths(marked_cells, time_length, crypt_num, n * n);
% filtered_clone_widths(c, t + 1) is the clone widths of crypt c at time t, but crypts that are
% fully marked or has not remaining marked cell will be filtered as NaN.
filtered_clone_widths
average_clone_widths = get_average_clone_widths(filtered_clone_widths, time_length, crypt_num);
% average_clone_widths(t + 1) is the average clone width of all crypts at time t, without
% considering the fully-cloned crypts or the crypts have no remaining marked cell.
average_clone_widths
plot_average_clone_widths(average_clone_widths, time_length);
clone_probabilities = get_clone_probabilities(filtered_clone_widths, time_length, crypt_num);
% clone_probabilities(c, t + 1) is the probabilitiy of the clone width of crypt c, in all 
% possible clone width values at time t, except 0 and full clone
clone_probabilities

% Plot the scaling behaviour of the clone width data.
scaling_start = 10;
scaling_end = 20;
plot_scaled_distributions(filtered_clone_widths, clone_probabilities,...
    average_clone_widths, scaling_start, scaling_end);
