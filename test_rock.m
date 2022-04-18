clear all;
close all;
load test_data.mat;  k = 2; theta = 0.3;
% load congressive-votes.mat;  k = 2;  theta = 0.78;
Result = ROCK(X, theta, k);
%N = nmi(Y,Result);

Index = find(Result>0);
label = True(Index);
result = Result(Index);
N = ClusteringMeasure(label, result)
