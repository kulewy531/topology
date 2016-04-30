A1 = load('1-homology_uniform.txt','-ascii');
A1 = (A1-1)/(3*100);

A2 = load('1-homology_gaussian_5.txt','-ascii');
A2 = (A2-1)/(3*100);

A3 = load('1-homology_gaussian_3.txt','-ascii');
A3 = (A3-1)/(3*100);

figure
hold on

cdfplot(A1)
cdfplot(A2)
cdfplot(A3)
legend('uniform','gaussian sigma=1/5','gaussian sigma=1/3')
xlim([0,1])
xlabel('normalized time')
ylabel('percentage of death')
title('1-homology persistence')

hold off