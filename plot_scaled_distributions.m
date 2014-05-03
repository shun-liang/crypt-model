% Plot the scalled distribution
function plot_scaled_distribution(marked_cells, scaling_start, scaling_end)
% marked_cells(c, t + 1) is the number of marked cells of crypt c at time t
figure;
%scaling_start = 1;
%scaling_end = 2;
scaling_time_length = scaling_end - scaling_start + 1;
cc=hsv(scaling_time_length);
for t = scaling_start:scaling_end
    clone_widths_t = marked_cells(:, t + 1);
    filter = clone_widths_t > 0 & clone_widths_t < n;
    clone_widths_t_filtered = clone_widths_t(filter);
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
    hold on
end
m = legend(strsplit(num2str(scaling_start:scaling_end)));
