data brandP;
input Y X1 X2;
datalines;
   64.0    4.0    2.0
   73.0    4.0    4.0
   61.0    4.0    2.0
   76.0    4.0    4.0
   72.0    6.0    2.0
   80.0    6.0    4.0
   71.0    6.0    2.0
   83.0    6.0    4.0
   83.0    8.0    2.0
   89.0    8.0    4.0
   86.0    8.0    2.0
   93.0    8.0    4.0
   88.0   10.0    2.0
   95.0   10.0    4.0
   94.0   10.0    2.0
  100.0   10.0    4.0
 ;
run;

/* a) The scatterplot matrix */
proc SGSCATTER data = brandP;
matrix Y X1 X2;
run;

/* a) The correlation matrix */
proc corr data=brandP;
run;

/* b) regression model */
proc reg data = brandP;
model Y = X1 X2 / r p;
output out = brandResult p = yHat r=residual;
run;

/* c) Residuals and the box plot */
data brandResult;
set brandResult;
X1X2 = X1 * X2;
group = 1;
run;

proc Boxplot data = brandResult;
plot residual * group;
run;

/* d) Graphs and normality ploy */
proc gplot data = brandResult;
plot residual * yHat;
plot residual * X1;
plot residual * X2;
plot residual * X1X2;
run;

proc univariate normal plot;
var residual;
run;

/* e) Breusch-Pagan Test */


data brandBP;
set brandResult;
e_sq = residual**2;
run;

proc reg data=brandBP;
model e_sq = X1 X2;
run;

data BP1;
input sse ssr_star n;
X_sq = (SSR_star/2) / (SSE/n)**2;
p_value = 1 - probchi(X_sq, 1);
datalines;
94.3 1872.7 16
;
run;

proc print data=BP1;
run;









