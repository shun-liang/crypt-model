%function to plot clonal crypt ratios in format of observations
function plotratios(marked_cells, numberofcells)

mc=marked_cells;
n=numberofcells;

%histogram of all ratios changing over time.
figure(1)
y=hist(mc(:,:),(0:n));
plot((0:n),y);


%histogram of ratio counts changing over time
%need to bin in 1/6 1/4/ 1/2 etc/ do simply over all ratios.

figure(2)
for i=1:n

fraction(:,i)=(sum(mc==i));

%hold on
end
plot(fraction)


