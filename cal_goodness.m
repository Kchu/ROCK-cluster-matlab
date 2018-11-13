function goodness = cal_goodness(Link, Cluster, i, j)
% Calculate the similarity between two clusters according to the goodness measure formula
% g(Ci, Cj) = [link(Ci, Cj)] / [(ni + nj)^(1+2f(theta)) - (ni)^(1+2f(theta)) - (nj)^(1+2fs(theta))]
up = Link(i, j);
global f;
ni = size(Cluster{i}, 1); 
nj = size(Cluster{j}, 1); 
down = (ni + nj)^(1 + 2*f) - ni^(1 + 2*f) - nj^(1 + 2*f);
goodness =  up / down;