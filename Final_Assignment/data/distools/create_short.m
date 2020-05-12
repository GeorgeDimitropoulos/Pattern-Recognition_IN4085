%CREATE_SHORT
%
%  Create short Contents.m in distools directory

function create_short

disdir = which('distools_long.m');
disdir = fileparts(disdir);
r = readf(fullfile(disdir,'distools_long.m'));
k = grep(r,'%%');
s = listn(r,k);
s = strrep(s,'%%','% ');
writf(fullfile(disdir,'Contents.m'),s);

return

%WRITF Write file
%
% writf(file,r)
% Write file from string r

function writf(file,r)
fid = fopen(file,'w');
if fid < 0
   error('Cannot open file')
end
fprintf(fid,'%c',r);
fclose(fid);
return

%READF Readfile
%
% [r,n] = readf(file,newline)
% Reads file into string r. The number of lines
% is returned in n.

function [r,n] = readf(file,newline)
if nargin < 2, newline = 13; end
fid = fopen(deblank(file),'r');
if fid < 0
   error(['Cann''t open ' file])
end
r = fscanf(fid,'%c');
fclose(fid);
n = length(find(r==newline));
if r(length(r)) ~= newline, n = n + 1; end
return

%LISTN List lines specified by their line number
%
% t = listn(r,n)
% Get the lines in r given by the line numbers in n.
function t = listn(r,n)
k = [0,find(r==newline)];
t = [];
for j = n
    t = [t,r(k(j)+1:k(j+1))];
end
return

%GREP Get line specific lines
%
% [k,n] = grep(r,s)
% Get the numbers of all lines in the set of lines r 
% that contain s.
% n is the total number of lines.

function [k,z] = grep(r,s)
n = [0,find(r==newline)];
m = findstr(r,s);
[i,j] = sort([n,m]);
q = [0,j(1:length(j)-1)]-j;
k = j(find(q>0))-1;
z = length(n)-1; % # of lines
return
