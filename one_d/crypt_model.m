% One-dimensional crypt stem cell dynamics simulation
crypt_num = 100; % number of crypts in the simulation
n = 12; % number of cells in each crypt
lambda = 1; % stem cell replacement rate
time_length = 100; % total simulation time length
t_all_marked = repmat(NaN, 1, crypt_num); % t_all_marked(c) is the time step when crypt c is fully 
                                    % occupied by marked clone
t_all_zeroed = repmat(NaN, 1, crypt_num); % t_all_zeored(c) is the time step when the marked clone
                                    % in crypt c is fully replaced
state_fixed = false(1, crypt_num); % state_fixed(c) implies if crypt c has a fixed state
marked_ratios = zeros(crypt_num, time_length + 1); % marked_ratios(c, t + 1) is the ratio of 
                                                   % marked clone in all cells of crypt c at
                                                   % time step t
marked_cells = zeros(crypt_num, time_length + 1); % marked_cells(c, t + 1) is the number of 
                                                  % cells in the marked clone in crypt c at
                                                  % time step t
cells = zeros(crypt_num, n); % cells(c) is a vector of the states of all stem cells in crypt c
cells(:, 3) = ones(1, crypt_num); % Inject 1 marked cell in each crypt.

% marked_cells(:, 0 + 1) is a vector of the marked clone width of each crypt at the initial state
for c = 1:crypt_num
    marked_cells(c, 0 + 1) = sum(cells(c, :) == 1);
end

for c = 1:crypt_num
    % In each iteration, a randomly picked stem cell in each crypt is replaced by one of its 
    % adjacent stem cells.
    for t = 1:time_length
        marked_cells_in_crypt = marked_cells(c, (t - 1) + 1);
        i = unidrnd(n); % Ramdomly pick the index of the stem cell to be replaced.
        % Update the state of the randomly picked stem cell in the crypt.
        new_state = cell_update(cells(c, :), i, n, lambda);
        if cells(c, i) == 1 && new_state == 0
            marked_cells_in_crypt = marked_cells_in_crypt - 1;
        end
        if cells(c, i) == 0 && new_state == 1
            marked_cells_in_crypt = marked_cells_in_crypt + 1;
        end
        cells(c, i) = new_state;
        marked_cells(c, t + 1) = marked_cells_in_crypt;
        % Is the marked clone now fixed in the crypt?
        if isequal(cells(c, :), ones(1, n)) && (~state_fixed(c))
            t_all_marked(c) = t;
            state_fixed(c) = true;
        end
        if isequal(cells(c, :), zeros(1, n)) && (~state_fixed(c))
            t_all_zeroed(c) = t;
            state_fixed(c) = true;
        end
    end
end

for c= 1:crypt_num
    for t = 0:time_length
        marked_ratios(c, t + 1) = marked_cells(c, t + 1) / n;
    end
end

distributions = get_distributions(marked_cells, time_length, n, crypt_num);
% distributions(t + 1, i + 1) is the number of crypts having i marked cells at time t.

% Plot the clone width distributions over time.
plot_distributions(distributions, time_length, n)

filtered_clone_widths = get_filtered_clone_widths(marked_cells, time_length, crypt_num);
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
