clear
clc

global N P number_of_samples

samples = P * number_of_samples;
L = (N-1)*(N-2)/2;
A = zeros(L*samples,1)+1;

for nn = 1:samples

    file_name = ['output\output_',num2str(nn,'%04d'),'_1.txt'];

    ints = load(file_name);
    deaths = ints(:,2);
    len = length(deaths);
    A((nn-1)*L+1:(nn-1)*L+len) = deaths(:);


end

save('1-homology.txt','A','-ascii')