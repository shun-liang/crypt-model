crypt_num = 1;
n = 4;
lambda = 1;
time_length = 500;
t_all_marked = zeros(1, crypt_num);
t_all_zeroed = zeros(1, crypt_num);
state_fixed = false(1, crypt_num);
marked_ratios = zeros(crypt_num, time_length);
marked_cells = zeros(crypt_num, time_length);
cells = zeros(n, n, crypt_num);
for c=1:crypt_num
    cells(n/2, n/2, c) = 1;
end
%cells
for c=1:crypt_num
    for t=1:time_length
        if t-1 == 0
            marked_cells_in_crypt = 1;
        else
            marked_cells_in_crypt = marked_cells(c, t-1);
        end
        i = unidrnd(n);
        j = unidrnd(n);
        %disp(sprintf('Main: Row: %d, Col: %d\n', i, j))
        disp(sprintf('Time: %d\n', t));
        cells_display = cells(:, :, c)
        new_state = cell_update(cells(:, : ,c), i, j, n, n, lambda);
        if cells(i, j, c) == 1 && new_state == 0
            marked_cells_in_crypt = marked_cells_in_crypt - 1;
        end
        if cells(i, j, c) == 0 && new_state == 1
            marked_cells_in_crypt = marked_cells_in_crypt + 1;
        end
        cells(i, j, c) = new_state;
        marked_cells(c, t) = marked_cells_in_crypt;
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
for c=1:crypt_num
    for t=1:time_length
        marked_ratios(c, t) = marked_cells(c, t) / n;
    end
end
for c=1:crypt_num
    %print("crypt ", c, marked_ratios(c, :));
    %print(marked_ratios(c, :)):
    %disp(sprintf('Marked ratio of crypt %d\n', c))
    %ratio = marked_ratios(c, :)
    cells(:, :, c)
    disp(sprintf('Number of marked cells of crypt %d\n', c))
    marked_cells_in_crypt = marked_cells(c, :)

end
%hist(marked_ratios)
