% Plot the scalled distribution
function plot_scaled_distributions(filtered_clone_widths, clone_probabilities,...
    average_clone_widths, scaling_start, scaling_end)

figure;
scaling_time_length = scaling_end - scaling_start + 1;
cc=hsv(scaling_time_length);
for t = scaling_start:scaling_end
    clone_width_div_avg_clone_width = filtered_clone_widths(:, t + 1)./  average_clone_widths(...
        :, t + 1);
    clone_pro_times_avg_clone_width = clone_probabilities(:, t + 1).* average_clone_widths(...
        :, t + 1);
    plot(clone_width_div_avg_clone_width, clone_pro_times_avg_clone_width,...
        '*', 'color', cc(t - scaling_start + 1,:));
    hold on
end
m = legend(strsplit(num2str(scaling_start:scaling_end)));
axis([0, 4, 0, 1.5]);
title('Scaled distributions over time')
ylabel('Width probability * average clone width');
xlabel('clone width / average clone width');
