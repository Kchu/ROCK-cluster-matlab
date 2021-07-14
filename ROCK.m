function Label = ROCK(X, theta, k)
%% Matlab code for ROCK cluster algorithm.
% Inputs:
%   - X: the dataset(m*n, m is the number of the samples, n is the number 
%   of the attributes. A sample i has attribute j means X(i,j)==1 while no 
%   attribute j means X(i,j)=0.
%   - theta: the threshold of judging whether two samples are neighbors
%   - k: the specified number of clusters
% Outputs:
%   - Label: the label of samples
% Created at August 23th, 2018
% Created by Kun Chu <kun_chu@outlook.com>

%% Initialization
numPts = size(X,1);
numCluster = numPts;
global f;
f = (1-theta)/(1+theta);
% Initialize each sample point into a cluster
for i=1:numPts
    Cluster{i} = i;
end

%% Compute initial Link and Goodness array
Link = cal_links(X, theta);
Goodness = zeros(numPts);
for i=2:numPts
    for j=1:i-1
        Goodness(i,j) = cal_goodness(Link, Cluster, i, j);
    end
end

%% Merge clusters to the specified number
while numCluster > k 
%     if mod( numCluster, 20 ) == 0 
%         disp(['   Group count: ' num2str(size(Cluster,2))]);
%     end
    
    % Find a pair of clusters whose goodness measure is the highest
    [MinDis, MinIndex1] = max(Goodness, [], 1);
    [~, MinIndex2] = max(MinDis);
    MinIndex1 = MinIndex1(MinIndex2);
    
    % Merge the two clusters as the new cluster
    Cluster{MinIndex1} = [Cluster{MinIndex1}; Cluster{MinIndex2}];
    Link(MinIndex1, :) = Link(MinIndex1, :) + Link(MinIndex2, :);
    Link(:, MinIndex1) = Link(:, MinIndex1) + Link(:, MinIndex2);

    % Recalculate the similarity between the new cluster and each cluster
    for i = 1 : MinIndex1-1
        Goodness(MinIndex1, i) = cal_goodness(Link, Cluster, MinIndex1, i);
    end
    for i = MinIndex1+1 : numCluster
        Goodness(i, MinIndex1) = cal_goodness(Link, Cluster, i, MinIndex1);
    end
    
    % Delete the old cluster
    Cluster(MinIndex2) = [];
    Link(MinIndex2,:) = [];
    Link(:,MinIndex2) = [];
    Goodness(MinIndex2,:) = [];
    Goodness(:,MinIndex2) = [];
    
    numCluster = numCluster - 1;
end

%% Generate sample labels
Label = zeros(numPts, 1);
for i = 1:size(Cluster,2)
    for j = 1:size(Cluster{i},1)
        Label(Cluster{i}(j)) = i;
    end
end

end
