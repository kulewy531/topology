clear
clc

global N P number_of_samples B

N = 40; % number of nodes

P = 6; % split the work into P parts for parellel computing 
number_of_samples = 150; % number of samples of each part

C = zeros(N,N); % random skew-sym matrix 
B = 100; % bound on elements

% % ----- create bash file for running under Linux -----
% runLin = fopen('runLin5','w'); 
% fprintf(runLin,'#!/bin/bash\n\n');
% % ----------------------------------------------------

for mm = 1:P

    % create batch file for Perseus under Windows under the folder "run"
    runWin_name = ['run\',num2str(mm,'%d'),'.bat']; 
    runWin = fopen(runWin_name,'w'); 
    
for nn = (mm-1)*number_of_samples+1:mm*number_of_samples
    
    % create input files for Perseus under the folder "input"
    
    % ---------------- generate random skew-sym matrix ------------------
    for i = 1:N-1
    for j = i+1:N
        C(i,j) = randi([-B,B]); % normal r.v.
%         C(i,j) = normrnd(0,1); % normal r.v.
%         while abs(C(i,j)) > 10;
%             C(i,j) = normrnd(0,1); % trancate by [-10,10]
%         end
        C(j,i) = -C(i,j);
    end
    end
    
    file_name = ['input\',num2str(nn,'%04d'),'.txt']; 
    file = fopen(file_name,'w');
    
    % output files for Perseus under the folder "output"
    outputfile_name = ['output\output_',num2str(nn,'%04d')];  
    
    
    % head of file
    fprintf(file,'1 \n');
    
    % 1 simplices
    for i = 1:N-1
        for j = i+1:N
            fprintf(file,'1 %d %d 1 \n', i, j);
        end
    end
    
    % 2 simplices
    for i = 1:N-2
        for j = i+1:N-1
            for k = j+1:N
                 t = ceil(abs(C(i,j)+C(j,k)+C(k,i)))+1;
                 fprintf(file,'2 %d %d %d %d \n', i, j, k, t);
            end
        end
    end
    
    fclose(file);
    
    fprintf(runWin, '..\\perseusWin.exe nmfsimtop ..\\%s ..\\%s\n', file_name, outputfile_name);
%     fprintf(runLin, 'perseusLin nmfsimtop %s %s\n', file_name, outputfile_name);
end
 
fclose(runWin);
% fclose(runLin);

end
 