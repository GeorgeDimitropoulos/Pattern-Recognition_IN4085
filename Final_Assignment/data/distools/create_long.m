%CREATE_LONG
%
%  Create long Contents.m in distools directory

function create_long

disdir = which('distools_long.m');
disdir = fileparts(disdir);
s = readf(fullfile(disdir,'distools_long.m'));
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
