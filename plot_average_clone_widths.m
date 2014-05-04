% Plot the average clone widths over time
function plot_average_clone_widths(average_clone_widths, time_length)
% average_clone_widths(t + 1) is the average clone width of all crypts at time t, without
% considering the fully-cloned crypts or the crypts have no remaining marked cell.

figure
plot(0:time_length, average_clone_widths, '*');
title('Average clone width over time');
ylabel('Average clone width');
xlabel('Time step');
