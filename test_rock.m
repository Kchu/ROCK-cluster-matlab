clear 
tic
%load pptdata.mat;  k = 2; theta = 0.3;
load congressive-votes-1.mat;  k = 2;  theta = 0.78;
Result = ROCK(X, theta, k);
toc
%N = nmi(Y,Result);

Index = find(Result>0);
label = True(Index);
result = Result(Index);
N = ClusteringMeasure(label, result)
