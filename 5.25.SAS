data airFreight;
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

proc iml;

use airFreight;
read all var{X} into x;
read all var{Y} into y;

n=nrow(y);

i= repeat(1,n,1);

x=i||x;
print x, y;

/*(1) Inverse of X'X */
invXtX= inv(t(x)*x);
print invXtX;

/* (2) b */
b=invXtX*t(x)*y;
print b;

/* (3) e */
beta_hat = inv(t(x)*x) * t(x) * y; 
print beta_hat;
y_hat = x * beta_hat;
e = y - y_hat;
print e;

/* (4) H */
H = x * inv(t(x)*x)*t(x);
print H;

/* (5) SSE = e'e*/
SSE = t(e)*e;
print SSE;

J = repeat(1,n,n);
SSR = t(Y)*(H-(1/n)*J)*Y;
print SSR;
run;
