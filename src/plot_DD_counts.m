% plot_DD_counts.m
%
% plot the DD with the number of count over count
% maybe measure the exponent
%
% written by andy reagan

% clear all
% close all
% 
load ../data/proofwiki_edge_table_with_stats_from_gephi_hacked.csv
% 
proofwiki = proofwiki_edge_table_with_stats_from_gephi_hacked;

frequency = zeros(1,max(proofwiki(:,4)));

for i=1:max(proofwiki(:,4))
    frequency(i)=length(find(proofwiki(:,4)==i));
end

plot(1:max(proofwiki(:,4)),frequency,'.')
title('frequency')

figure
plot(log10(1:max(proofwiki(:,4))),log10(frequency),'.')
title('log-log frequency')

% now do the CCDP
freqCCDF=frequency;
for i=1:length(freqCCDF)
    freqCCDF(i)=sum(freqCCDF(i:end));
end

figure
plot(log10(1:length(freqCCDF)),log10(freqCCDF),'.')
title('frequency CCDF in log-log')