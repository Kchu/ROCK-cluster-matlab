function link = cal_links(X, theta)
[m,~] = size(X);
nbrlist = zeros(m,m);    % Initialize the neighbor matrix
for i = 1:m-1
    for j = i+1:m
        % Calculate similarity
        intersection = sum( X(i,:) & X(j,:) );
        union = sum( X(i,:) | X(j,:) );
        % If the similarity is greater than the threshold, the pair (i, j) is a neighbor.
        if (intersection/union >= theta)    
            nbrlist(i,j) = 1; 
            nbrlist(j,i) = 1;
        end
    end
end
% Calculating the link matrix
link = nbrlist * nbrlist;