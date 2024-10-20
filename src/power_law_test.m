% test power law fit

load ../data/proofwiki_edge_table_with_stats_from_gephi_hacked.csv
proofwiki = proofwiki_edge_table_with_stats_from_gephi_hacked;
% dist to test
x = proofwiki(:,4);

[alpha, xmin, D] = plfit(x);
%[a_err, xm_err, nt_err] = plvar(x);
%[p, gof] = plpva(x, xmin);
x = reshape(x,numel(x),1);
q = unique(x); n = length(x);
c = hist(x,q)'./n;
c = [[q; q(end)+1] 1-[0; cumsum(c)]]; c(find(c(:,2)<10^-10),:) = [];
cf = ([xmin:q(end)]'.^-alpha)./(zeta(alpha) - sum([1:xmin-1].^-alpha));
cf = [[xmin:q(end)+1]' 1-[0; cumsum(cf)]];
cf(:,2) = cf(:,2) .* c(find(c(:,1)==xmin),2);
figure(1);
loglog(c(:,1),c(:,2),'bo','MarkerSize',8,'MarkerFaceColor',[1 1 1]); hold on;
loglog(cf(:,1),cf(:,2),'k--','LineWidth',2); hold off;
set(gca,'FontName','Times','FontSize',16);

