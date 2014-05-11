%function to plot clonal crypt ratios in format of observations
function plotratiosv2(marked_cells, numberofcells)

mc=marked_cells;
n=numberofcells;


%bin marked cells, excluding lost and fixed clones i.e. 1..(n-1)
y=histc(mc(:,:),(1:n-1));
%histogram of marked cells excluding lost and fixed clones i.e. 1..(n-1)
figure(4)
plot(y)



%%%%  scale y to unit prob density function (pdf)
for s=1:size(y,2)
yscale(:,s)=y(:,s)./sum(y(:,s));
end
%%plot scale hisogram
figure(5)
plot(yscale)

%w=mean(mc,1);
%size(w)
%plot((1:n-1),y);


%histogram of ratio counts changing over time
%need to bin in 1/6 1/4/ 1/2 etc/ do simply over all ratios.

%calculate width mean wmean

%wmean(t)= sum of values/ number of values (t)

%create count for avarage and sum for all time.
for t=1:size(y,2)

%ycount is the y times by bin value     
%possible bins are w
w=(1:n-1);
%ysum
ysum(t,:)=w.'.*y(:,t);

%ynumber 
ynumber(t)=sum(y(:,t));
end

%creates wmean as function of time. 
for j=1:length(ynumber)
    wmean(j)=sum(ysum(j,:)./ynumber(j));
end



%plots ybar=yscale*w against xbar=x/w)
for t=1:length(wmean)
 %   ynorm(:,t)= y(:,t)/ysum(t);
  ybar(:,t)=yscale(:,t).*wmean(t);
  xbar(t,:)=(1:n-1)/wmean(t);

end

%transpose x for plotting

xbar=xbar.';
figure(6)
%size(ybar)
%size(xbar)
plot(xbar,ybar,'*')

