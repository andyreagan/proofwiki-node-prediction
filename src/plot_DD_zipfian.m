% plot_DD_zipfian.m
%
% plot the degree distribution a la Zipf
%
% written by Andy Reagan

clear all
close all

load ../data/proofwiki_edge_table_with_stats_from_gephi_hacked.csv

proofwiki = proofwiki_edge_table_with_stats_from_gephi_hacked;

% plot(log10(1:length(proofwiki(:,4))),log10(sort(proofwiki(:,4),'descend')),'.')
% xlabel('log_10 (rank)')
% ylabel('log_10 (degree)')
% xlabel('log_{10} (rank)')
% ylabel('log_{10} (degree)')
% title('Log-log degree distribution of mathematical theorems')

tmpfigh = gcf;
clf;
figshape(1000,750);
%% automatically create postscript whenever
%% figure is drawn
tmpfilename = '../data/proofwiki_dist001';

tmpfilenoname = sprintf('%s_noname',tmpfilename);

%% global switches

set(gcf,'Color','none');
%% set(gcf,'InvertHardCopy', 'off');

set(gcf,'Color','none');
set(gcf,'InvertHardCopy', 'off');

set(gcf,'DefaultAxesFontname','helvetica');
set(gcf,'DefaultLineColor','r');
set(gcf,'DefaultAxesColor','none');
set(gcf,'DefaultLineMarkerSize',7);
set(gcf,'DefaultLineMarkerEdgeColor','k');
set(gcf,'DefaultLineMarkerFaceColor','g');
set(gcf,'DefaultAxesLineWidth',0.5);
set(gcf,'PaperPositionMode','auto');

tmpsym = {'o','s','v','o','s','v'};
tmpcol = {'g','b','r','k','c','m'};


%%%%%%%%%%%%%%%%%%%
tmpx1 = 0.05;
tmpy1 = 0.20;
tmpy2 = 0.15;

tmpxg1 = 0.075;
tmpxg2 = 0.075;
%% tmpxg3 = 0.04;

tmpyg1 = 0.05;

tmpw1 = 0.25;
tmpw2 = 0.20;
%% tmpw3 = 0.22;

tmph1 = 0.25;



positions(3).box = [ tmpy2                   , tmpx1, tmpw2, tmph1];
positions(2).box = [ tmpy2 , tmpx1 + tmph1 + tmpxg1, tmpw2, tmph1];
positions(1).box = [ tmpy2 , tmpx1 + 2*tmph1 + tmpxg1 + tmpxg2, tmpw2, tmph1];

tmplabels = {' A ',' B ',' C ',' D ',' E ',' F '};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% for use with layered plots
% set(gca,'box','off')

% adjust limits
% tmpv = axis;
% axis([]);

% ylim([0 8]);
% xlim([0 4.5]);



% fix up tickmarks
%set(gca,'ytick',[1:8]);
% set(gca,'xticklabel',{'','',''})

% change font

%% use latex interpreter for text, sans serif

i=2;
axesnum = i;
tmpaxes(axesnum) = axes('position',positions(axesnum).box);
set(tmpaxes(axesnum),'linewidth',0.6)
set(gca,'fontsize',12);
set(gca,'color','none');



%% histogram
%hist(proofwiki(:,18)); %4
%xlabel('Degree');
%ylabel('Count');
%title('Degree Distribution');
%xlim([0 40]);

%% power law fit w line

% get the fit to include
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

line = plot(log10(c(:,1)),log10(c(:,2)),'Color',0.7*[1 1 1]);
hold on;
tmph(1) = plot(log10(c(:,1)),log10(c(:,2)),'Marker',tmpsym{1},'MarkerFaceColor',tmpcol{1},'LineStyle','none');
tmph(2) = plot(log10(cf(:,1)),log10(cf(:,2)),'r--','LineWidth',2);

xlabel('$\log _{10}$ n','fontname','helvetica','interpreter','latex');
ylabel('$\log _{10}$ Frequency','fontname','helvetica','interpreter','latex');

text(0.4,-3,'$\alpha = 3.2$','fontname','helvetica','interpreter','latex');
text(0.4,-3.45,'$D = 4.82\cdot 10^{-3}$','fontname','helvetica','interpreter','latex');
text(0.4,-3.9,'$p = 0.03$','fontname','helvetica','interpreter','latex');

tmplh = legend(tmph,{'CCDF','Fit'},'location','northeast');
tmplh = findobj(tmplh,'type','text');
set(tmplh,'FontSize',10);
%% remove box:
legend boxoff

% tmplh = legend(tmph,tmpyearstr,'location','northeast');
% tmplh = findobj(tmplh,'type','text');
% set(tmplh,'FontSize',10);
% %% remove box:
% legend boxoff

% tmpxlab=xlabel('$\log_{10}$ Gift rank $r$', ...
%     'fontsize',20,'verticalalignment','top','fontname','helvetica','interpreter','latex');
% set(tmpxlab,'position',get(tmpxlab,'position') - [0 .05 0]);

%%

i=3;
axesnum = i;
tmpaxes(axesnum) = axes('position',positions(axesnum).box);
set(tmpaxes(axesnum),'linewidth',0.6)
hist(proofwiki(:,9),100);
xlabel('Closeness Centrality');
ylabel('Count');
%title('Out Degree Distribution');
set(gca,'fontsize',12);
set(gca,'color','none');
xlim([1.0 5]);
set(gca,'xtick',[1:5]);
set(gca,'xticklabel',{'1','2','3','4','5'});

axesnum = 4;
tmpaxes(axesnum) = axes('position',[positions(3).box(1) + 0.5*positions(3).box(3), positions(3).box(2) + 0.5*positions(3).box(4) , 0.4*positions(3).box(3), 0.4*positions(3).box(4)]);
set(tmpaxes(axesnum),'linewidth',0.6)
hist(proofwiki(:,11),5);
xlabel('Pagerank')
ylabel('Norm Count')
set(gca,'ytick',[0 7500 15000]);
set(gca,'yticklabel',{'0','','1'});
set(gca,'xtick',[0 0.5 1]);
set(gca,'xticklabel',{'0','','1'});
% tmplh = legend(tmph,tmpyearstr,'location','northeast');
% tmplh = findobj(tmplh,'type','text');
% set(tmplh,'FontSize',10);
% %% remove box:
% legend boxoff

% tmpylab=ylabel('$\log_{10}$ Gift size $S$','fontsize',10,'verticalalignment','bottom','fontname','helvetica','interpreter','latex');
% set(tmpylab,'position', + [.5 .5 0]);

%%%%%%%%%%%%%%%%%%%%%

i=1;
axesnum = i;
tmpaxes(axesnum) = axes('position',positions(axesnum).box);
set(tmpaxes(axesnum),'linewidth',0.6)
% this is the power law...

line = plot(log10(1:length(proofwiki(:,4))),log10(sort(proofwiki(:,4),'descend')),'Color',0.7*[1 1 1]);
hold on;
tmph(1) = plot(log10(1:length(proofwiki(:,4))),log10(sort(proofwiki(:,4),'descend')),'Marker',tmpsym{2},'MarkerFaceColor',tmpcol{2},'MarkerEdgeColor',tmpcol{4},'LineStyle','none');


line = plot(log10(1:length(proofwiki(:,3))),log10(sort(proofwiki(:,3),'descend')),'Color',0.7*[1 1 1]);
tmph(2) = plot(log10(1:length(proofwiki(:,3))),log10(sort(proofwiki(:,3),'descend')),'Marker',tmpsym{1},'MarkerFaceColor',tmpcol{1},'MarkerEdgeColor',tmpcol{4},'LineStyle','none');


%title('Zipfian Degree, Out Component Distribution');
xlabel('$\log _{10}$ Rank','fontname','helvetica','interpreter','latex');
ylabel('$\log _{10}$ Degree,Size','fontname','helvetica','interpreter','latex');

set(gca,'fontsize',12);
set(gca,'color','none');


tmplh = legend(tmph,{'Out Component','Degree'},'location','northeast');
tmplh = findobj(tmplh,'type','text');
set(tmplh,'FontSize',10);
%% remove box:
legend boxoff


%% automatic creation of postscript
%% without name/date
psprintcpdf_keeppostscript(tmpfilenoname);

%% name label
tmpt = pwd;
tmpnamememo = sprintf('[source=%s/%s.ps]',tmpt,tmpfilename);

tmpcommand = sprintf('open %s.pdf;',tmpfilenoname);
system(tmpcommand);

%% archivify
figurearchivify(tmpfilenoname);

close(tmpfigh);
%clear all