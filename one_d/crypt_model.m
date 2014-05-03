crypt_num = 100;
n = 12;
lambda = 1;
time_length = 20;
t_all_marked = zeros(1, crypt_num);
t_all_zeroed = zeros(1, crypt_num);
state_fixed = false(1, crypt_num);
marked_ratios = zeros(crypt_num, time_length + 1);
marked_cells = zeros(crypt_num, time_length + 1);
cells = zeros(crypt_num, n);
cells(:, 3) = ones(1, crypt_num);
cells

for c = 1:crypt_num
    marked_cells(c, 0 + 1) = sum(cells(c, :) == 1);
end
for c = 1:crypt_num
    for t=1:time_length
        marked_cells_in_crypt = marked_cells(c, (t - 1) + 1);
        i = unidrnd(n);
        new_state = cell_update(cells(c, :), i, n, lambda);
        if cells(c, i) == 1 && new_state == 0
            %ratio = ratio - 1/n;
            marked_cells_in_crypt = marked_cells_in_crypt - 1;
        end
        if cells(c, i) == 0 && new_state == 1
            %ratio = ratio + 1/n;
            marked_cells_in_crypt = marked_cells_in_crypt + 1;
        end
        cells(c, i) = new_state;
        marked_cells(c, t + 1) = marked_cells_in_crypt;
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
cells
t_all_marked
t_all_zeroed
for c= 1:crypt_num
    for t = 0:time_length
        marked_ratios(c, t + 1) = marked_cells(c, t + 1) / n;
    end
end

% Plot the marked cells distribution over time
%sorted_marked_cells = zeros(time_length, n + 1);
%for t=1:time_length
%    for i=0:n
%        for c=1:crypt_num
%            if marked_cells(c, t) == i
%                sorted_marked_cells(t, i + 1) = sorted_marked_cells(t, i + 1) + 1;
%            end
%        end
%    end
%end 
%figure
%plot(sorted_marked_cells); 
%l = legend(strsplit(num2str(0:n)));
distributions = get_distributions(marked_cells, time_length, n, crypt_num);
% distributions(t + 1, i + 1) is the number of crypts having i marked cells at time t.
plot_distributions(distributions, time_length, n)

% Plot the scaling behaviour
%scaling_start = 1;
%scaling_end = 200;
%scaling_time_length = scaling_end - scaling_start + 1;
%pro_w_div_avg = zeros(crypt_num, scaling_time_length); % Array of probabilities of clone widths
%% divided by average clone width
%w_div_avg = zeros(crypt_num, scaling_time_length); % Array of clone widths divided by average 
% clone width
%clone_widths = marked_cells(:, scaling_start:scaling_end);
%for t = scaling_start:scaling_end
%for t = 1:scaling_time_length
%    avg_w = (sum(marked_cells(:, scaling_start + t - 1)) / crypt_num);
%    for c = 1:crypt_num
%        pro_w = sorted_marked_cells(scaling_start + t - 1 , ... 
%            marked_cells(c, scaling_start + t - 1) + 1) / crypt_num;
%        pro_w_div_avg(c, t) = pro_w * avg_w;
%        clone_width = marked_cells(c, scaling_start + t - 1);
%        w_div_avg(c, t) = clone_width / avg_w;
%    end
%end
%figure
%plot(w_div_avg, pro_w_div_avg, 'o');
%scatter(w_div_avg, pro_w_div_avg);
%m = legend(strsplit(num2str(scaling_start:scaling_end)));
%hist(marked_ratios)
%marked_cells_for_plot = transpose(marked_cells);

%figure;
%scaling_start = 1;
%scaling_end = 2;
%scaling_time_length = scaling_end - scaling_start + 1;
%cc=hsv(scaling_time_length);
%for t = 1:scaling_time_length
%    clone_widths_t = marked_cells(:, scaling_start + t - 1);
%    filter = clone_widths_t > 0 & clone_widths_t < n;
%    clone_widths_t_filtered = clone_widths_t(filter);
%    clone_widths_count_t = sorted_marked_cells(scaling_start + t - 1, ...
%        clone_widths_t_filtered + 1);
%    clone_width_ratios_t_filtered = clone_widths_t_filtered./ n;
%    avg_clone_width_t = mean(clone_widths_t_filtered);
%    avg_clone_width_ratio_t = mean(clone_width_ratios_t_filtered);
%    clone_pros_t = clone_widths_count_t./ size(clone_widths_t_filtered, 1) % crypt_num;
%
%    clone_widths_div_avg_width_t = clone_width_ratios_t_filtered./ avg_clone_width_ratio_t;
%    clone_probs_t_div_avg_width_t = clone_pros_t.* avg_clone_width_ratio_t;
    %plot(clone_widths_div_avg_width_t, clone_probs_t_div_avg_width_t, ...
    %    '*', 'color', cc(t,:));
    %plot(t, avg_clone_width_ratio_t, '*');
    %plot(clone_pros_t, '*');
%    hold on
%end
%m = legend(strsplit(num2str(scaling_start:scaling_end)));
%axis([0, 4, 0, 1.5]);

filtered_clone_widths = get_filtered_clone_widths(marked_cells, time_length, crypt_num);
filtered_clone_widths
average_clone_widths = get_average_clone_widths(filtered_clone_widths, time_length, crypt_num);
average_clone_widths
clone_probabilities = get_clone_probabilities(filtered_clone_widths, time_length, crypt_num);
clone_probabilities

scaling_start = 10;
scaling_end = 20;

plot_scaled_distributions(filtered_clone_widths, clone_probabilities,...
    average_clone_widths, scaling_start, scaling_end);
