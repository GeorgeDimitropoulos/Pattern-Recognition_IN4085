%PE_MTIMES Pseudo-Euclidean matrix product
%
%  C = PE_MTIMES(A,B)
%
% A should be a PE dataset. Its PE signature SIG is retrieved,
% C = A*J*B, where J is a diagonal matrix with 1's, followed by -1's.
% J = diag ([ONES(SIG(1),1);  -ONES(SIG(2),1)])

function c = pe_mtimes(a,b)

isdataset(a);
sig = getsig(a); 
J = diag([ones(1,sig(1))  -ones(1,sig(2))]);
c = a*J*b;
  
  