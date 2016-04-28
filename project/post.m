clear
clc

global N P number_of_samples

samples = P * number_of_samples;
L = (N-1)*(N-2)/2;
A = zeros(L*samples,1);

for nn = 1:samples

file_name = ['output_',num2str(nn,'%04d'),'_1.txt'];

ints = load(file_name);

deaths = ints(:,2);

A((nn-1)*L+1:nn*L) = deaths(:)/10000;

end

A_normal = A./max(A);

histogram(A,20,'normalization','probability');