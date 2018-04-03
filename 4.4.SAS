data Airfright;
Input X Y;
DATALINES;
1.0 16.0
0.0 9.0
2.0 17.0
0.0 12.0
3.0 22.0
1.0 13.0
0.0 8.0
1.0 15.0
2.0 19.0
0.0 11.0
;
run;

data;
t=tinv(.9975,8);
run;
proc print;
run;


proc reg data=Airfright;
Model Y = X /clb alpha = 0.01;
run;

proc iml;
use Airfright;
read all var{Y} into x_temp;
read all var{X} into y;
n=nrow(y);
i= repeat(1,n,1);
x=i||x_temp;
print x y;
a1 = inv(t(x)*x);
print a1;
b=inv(t(x)*x)*t(x)*y;
print b;
beta_hat = inv(t(x)*x) * t(x) * y;
print beta_hat;
y_hat = x * beta_hat;
print y_hat;
y_hat2 = x * beta_hat;
print y_hat2;
e = y - y_hat;
print e;
H = x * inv(t(x)*x)*t(x);
print H;
J = repeat(1,n,n);
SSTO = t(y)*y-((1/n) * t(y)*J*y);
SSE = t(e)*e;
print SSE;
MSE = SSE/(n-nrow(beta_hat));
cov_e = MSE*(I(n)-H);
SSR = SSTO - SSE;
print SSTO; print SSE; print MSE; print SSR; print cov_e;
cov_beta  = MSE*inv(t(X)*X);
print cov_beta;
aa =  t(i);
print aa;
SSE = t(y)*(H-1/n*J)*y;
print SSE;
run;
