/*Statistics: Analysis on Superstore retail dataset
  Author: Rashpinder Kaur Chahal
  Database Name: SampleSuperstore
  Library: Project
  */

libname Project "D:\statistics\Project"; *Creating a libref;

/*The dataset contains sales details of different stores of a supermarket chain 
  that has multiple stores in different parts of the US with columns such as:

Ship Mode
Segment
Country
City
State
Postal code
Region
Category
Sub-category
Sales
Quantity
Discount
Profit

Filetype: CSV
*/

*Importing Data;

proc import 
datafile='D:\statistics\dataset\SampleSuperstore.csv'
out=project.stats
DBMS=CSV
REPLACE;
getnames=yes;
RUN;

*Browsing data portion;
proc print data=project.stats (obs=10);
run;

*Browsing descriptor portion in order to see the data types;
proc contents data=project.stats varnum;
run;
proc contents data= project.stats short;
run;


*Univariate analysis;
*Categorical variables;

*1. Shipment Mode:
    used the variable because mode of shipment is important as we need to 
    analyse which shipment mode is most used;
*Tabular form;
proc freq data=project.stats;
table ship_mode;
run;
*Graphical representation;
proc sgplot data=project.stats;
vbar ship_mode;
run;
*OR We can also use pie chart as we have only four groups of variables;
proc gchart data=project.stats;
pie ship_mode /percentage=inside value=outside;
run;

/*The analysis focuses on the distribution of the variable "Shipment mode" within the 
dataset. 
The data reveals a total of 9994 observations,
First Class -1538 ie:15.39%
Same Day-543 ie: 5.43%
Second Class-1945 ie: 19.46%
Standard Class-5968 ie: 59.72%
*/

*2. Segment: 
    used the variable because segment needs to be analysed to see the division of 
    utilision of the superstore in following areas;
*Tabular form;
proc freq data=project.stats;
table segment;
run;

*Graphical representation;
proc gchart data=project.stats;
pie segment /percentage=inside value=outside;
run;

/*The analysis focuses on the distribution of the variable "Segment" within the dataset. 
The data reveals a total of 9994 observations,
Consumer -5191 ie:51.94%
Corporate-3020 ie: 30.22%
Home office-1783 ie: 17.84%
*/

*3. Region: to analyse the region where sales is higher;
*Tabular form;
proc freq data=project.stats;
table region;
run;

*graphical representation;
proc sgplot data=project.stats;
vbar region;
run;

/*The analysis focuses on the distribution of the variable "Region" within the dataset. 
The data reveals a total of 9994 observations,
Central -2323 ie:23.24%
East-2848 ie: 28.50%
South-1620 ie: 16.21%
West-3203 i.e., 32.05%
*/

*4. Category;
*Tabular form;
proc freq data=project.stats;
table category;
run;

*Graphical representation;
proc gchart data=project.stats;
pie category / value=inside percentage=outside;
run;

/*
The analysis focuses on the distribution of the variable "Category" within the dataset. 
The data reveals a total of 9994 observations,
Furniture -2121 ie:21.22%
Office Supplies-6060 ie: 60.30%
Technology-1847 ie: 18.48%
*/

*5. Sub Category;
*Tabular form;
proc freq data=project.stats;
table sub_category;
run;

*Graphical representation;
proc sgplot data=project.stats;
vbar sub_category;
run;

*Quantitative variables;
*1. Profit;
*Tabular form;
proc univariate data=project.stats;
var profit;
run;

*Graphical representation;
proc sgplot data=project.stats;
histogram profit;
density profit;
run;

/*
Total observation are 9994 with average profit is 28.65 for all the observations, 
standard deviation is 234.26 that means the spread ness of data, we have positive skewness 
value i.e., right skewed, value is 7.56 Similarly, kurtosis is 397.18 

Range is 13 i.e., max-min =15000

The value of Q1=1.7280 (75% data have profit value more than 1.7280 and 25% data have 
less than 1.7280)
Similarly, Q3=29.36 (25% data have profit more than 29.36 and 75% data for quantity is 
less than 29.36)
*/

*2. Quantity;
*Tabular form;
proc univariate data=project.stats;
var quantity;
run;

*Graphical representation;
proc sgplot data=project.stats;
histogram quantity;
density quantity;
run;

/*BOX PLOT*/
proc sgplot data=project.stats;
vbox quantity;
run;

/*
Total observation are 9994 with average quantity is 3.7895 for all the observations, 
standard deviation is 2.225 that means the spread ness of data, we have positive skewness 
value i.e., right skewed, value is 1.2785 Similarly, kurtosis is 1.991 which is between 
threshold (-3,3)

Range is 13 i.e., max-min =14-1=13

The value of Q1=2 (75% data have quantity value more than 2 and 25% data have less than 2)
Similarly, Q3=5 (25% data for quantity is more than 5 and 75% data for quantity is less 
than 5)
*/

*3. Sales;
*Tabular form;
proc univariate data=project.stats;
var sales;
run;

*Graphical representative;
proc sgplot data=project.stats;
histogram sales;
density sales;
run;

/*
Right skewed: Can be easily interpreted graphically, through the density curve as it has 
large tail on the right side of the data as well as through the value of skewness which is
12.97, (positive) which indicates that the mean is shifted to the right side of the data 
and outliers exist in the right side of the data.
Kurtosis is very high (305.31) which is not in the threshold of (-3,3) that indicates 
existence of potential outliers.
Data is not normal as the values of mean and median are very different mean is 229.85 
while median is 54.49

*/

*4. Discount;
*Tabular form;
proc univariate data=project.stats;
var discount;
run;

*Graphical representation;
proc sgplot data=project.stats;
histogram discount;
density discount;
run;

/*
Skewness value is 1.68 which is positively skewed (right skewed) that means possibility 
of outliers in right side of the data.
Kurtosis value (2.40) is between threshold value that is (-3,3) which indicates possibility
of outliers.
Data is not normal as the values of mean (0.15) and median (0.20) are not similar. 
*/

*Bivariate analysis;
*Checking correlation between every numerical variable;
proc corr data=project.stats plot(maxpoints=10000000)=matrix(histogram);
var sales discount profit quantity;
run;
*Continuous numerical variable * Continuous numerical variable;


*1. Sales and Discount;
*H0: R=0: The superstore sales do not have any relation with discount offered;
*H1: R!=0: The superstore sales have relation with discount offered;

*Summarization;
proc means data=project.stats n nmiss min Q1 median Q3 max mean std cv maxdec=2;
var sales discount;
run;

*Pearson Correlation Test;
proc corr data=project.stats plot(maxpoints=1000000)=matrix(histogram);
var sales discount;
run;

*Graphical represenation: Scatter plot;
proc sgplot data=project.stats;
scatter y=sales x=discount;
run;

/*Conclusion of pearson correaltion test on Sales and discount
  The coefficient of correlation (r)= -0.02819 i.e. between 0 < |r| < 0.3 which is 
  low linear correlation
  p-value = 0.0048 which is less than alpha p-value 5% that means we reject null hypothesis
  and we accept alternative hypothesis that states The superstore sales have relation with
  discount offered.*/

proc reg data=project.stats;
model sales=discount;
run;


*2. Sales and Profit;
*H0: R=0: Profit is not affected by the number of Sales made in superstore;
*H1: R!=0: Profit is affected by the number of Sales made in the superstore;

*Summarization;
proc means data=project.stats n nmiss min Q1 median Q3 max mean std cv maxdec=2;
var sales profit;
run;

*Pearson Correlation Test;
proc corr data=project.stats plot(maxpoints=1000000)=matrix(histogram);
var sales profit;
run;

*Graphical represenation: Scatter plot;
proc sgplot data=project.stats;
scatter y=sales x=profit;
run;

/*Conclusion of pearson correaltion test on Sales and profit
  The coefficient of correlation (r)= 0.47906 i.e. between 0.3 < |r| < 0.5 which is 
  medium linear correlation
  p-value <.0001 which is less than alpha p-value 5% that means we reject null hypothesis
  and we accept alternative hypothesis that states Profit is affected by the number of 
  Sales made in the superstore*/

proc reg data=project.stats;
model sales=profit;
run;

*3. Sales-Quantity;
*H0: R=0: Sales made is not related to the quantity of the items sold;
*H1: R!=0: Sales made is related to the quantity of the items sold;

*Summarization;
proc means data=project.stats n nmiss min Q1 median Q3 max mean std cv maxdec=2;
var sales quantity;
run;

*Pearson Correlation Test;
proc corr data=project.stats plot(maxpoints=1000000)=matrix(histogram);
var sales quantity;
run;

*Graphical represenation: Scatter plot;
proc sgplot data=project.stats;
scatter y=sales x=quantity;
run;

/*Conclusion of pearson correaltion test on Sales and quantity
  The coefficient of correlation (r)= 0.20079 i.e. between 0 < |r| < 0.3 which is 
  low linear correlation
  p-value <.0001 which is less than alpha p-value 5% that means we reject null hypothesis
  and we accept alternative hypothesis that states Sales made is related to the quantity of 
  items sold.*/

proc reg data=project.stats;
model sales=quantity;
run;

*4. Discount and profit;
*H0: R=0: Discount given on items does not have any relation with profit earned;
*H1: R!=0: Discount given on items have relation with profit earned;

*Summarization;
proc means data=project.stats n nmiss min Q1 median Q3 max mean std cv maxdec=2;
var discount profit;
run;

*Pearson Correlation Test;
proc corr data=project.stats plot(maxpoints=1000000)=matrix(histogram);
var discount profit;
run;

*Graphical represenation: Scatter plot;
proc sgplot data=project.stats;
scatter y=discount x=profit;
run;

/*Conclusion of pearson correaltion test on discount and profit
  The coefficient of correlation (r)= -0.21949 i.e. between 0 < |r| < 0.3 which is 
  low linear correlation
  p-value <.0001 which is less than alpha p-value 5% that means we reject null hypothesis
  and we accept alternative hypothesis which states that discount given on items have relation 
  with profit earned.*/

proc reg data=project.stats;
model discount=profit;
run;

*5. Profit and quantity;
*H0: R=0: Quantity of the items sold does not have any relation with profit earned;
*H1: R!=0: Quantity of the items sold does affect the profit earned;

*Summarization;
proc means data=project.stats n nmiss min Q1 median Q3 max mean std cv maxdec=2;
var profit quantity;
run;

*Pearson Correlation Test;
proc corr data=project.stats plot(maxpoints=1000000)=matrix(histogram);
var profit quantity;
run;

*Graphical represenation: Scatter plot;
proc sgplot data=project.stats;
scatter y=profit x=quantity;
run;

/*Conclusion of pearson correaltion test on quantity and profit
  The coefficient of correlation (r)= 0.06625 i.e. between 0 < |r| < 0.3 which is 
  low linear correlation
  p-value <.0001 which is less than alpha p-value 5% that means we reject null hypothesis
  and we accept alternative hypothesis which states that quantity of the items sold affects
  the profit earned.*/

/* R-Squared
The R-squared value indicates the proportion of the variance in the dependent variable
that is explained by the independent variables.
Values range from 0 to 1. A higher value (e.g., 0.80) means the model explains 80% of 
the variance, which suggests a good fit.
However, R-squared alone should not be used to judge model fit without checking other 
diagnostic measures, as it can increase with more predictors, even if they are irrelevant.
e) Adjusted R-Squared
Adjusted R-squared adjusts for the number of predictors in the model, giving a more 
accurate measure of model fit, especially when comparing models with different numbers 
of predictors.
It penalizes the model for including variables that don't improve the fit significantly.*/

proc reg data=project.stats;
model quantity=profit;
run;

*Categorical Variables * Categorical variables;

*1. Segment*Ship_mode;
*H0: There is no relationship between type of segment and Mode of Shipment;
*H1: There is relation between type of segment and Shipment Mode;

*Chi-Square test;
Proc freq data=project.stats;
table segment*ship_mode/ chisq ;
run;

*Stacked bar chart;
proc sgplot data=project.stats;
vbar segment /group=ship_mode;
run;

*Grouped bar chart;
proc sgplot data=project.stats;
vbar segment /group=ship_mode groupdisplay=cluster;
run;

*Conclusion of chi-square test
 p-value <.0001 which is less than alpha p-value(0.05), this interprets that we reject null 
 hypothesis and accept alternative hypothesis which states that there is relation between 
 type of segment and shipment mode where chi-square value (x(6))^2 is 28.0979 where 6 is D.F;


*2. Segment*State;
*H0: There is no relation between Segment and State;
*H1: There is a relation between Segment and State;

Proc freq data=project.stats;
table segment*state/ chisq ;
run;

*Stacked bar chart;
proc sgplot data=project.stats;
vbar segment /group=state;
run;

*Grouped bar chart;
proc sgplot data=project.stats;
vbar segment /group=state groupdisplay=cluster;
run;


*Conclusion of chi-square test
 p-value <.0001 which is less than alpha p-value(0.05), this interprets that we reject null 
 hypothesis and accept alternative hypothesis which states that there is relation between 
 type of segment and State where chi-square value (x(96))^2 is 259.1242 where 96 is D.F;


*Categhorical * Continuous numerical;
*1. Sales*Segment;
*H0:There is no difference between mean of sales for all three segments;
*H1:There is difference between the mean of sales for three segments;


*Checking means for the variables: interpret about means, standard deviation and 
number of obs;
proc means data=project.stats;
var sales;
class segment;
run;

*Anova Test;
proc anova data=project.stats;
class segment;
model sales=segment;
run;

*Graphical representation;
PROC SGPLOT DATA = project.stats;
VBOX sales / GROUP = segment;
RUN;

*2. Profit*Segment;

*Anova Test;
proc anova data=project.stats;
class segment;
model profit=segment;
run;

*Graphical representation;
PROC SGPLOT DATA = project.stats;
VBOX profit / GROUP = segment;
RUN;

*3. Sales*Category;

*Anova Test;
proc anova data=project.stats;
class category;
model sales=category;
run;

*Graphical representation;
PROC SGPLOT DATA = project.stats;
VBOX sales / GROUP = category;
RUN;

*4. Profit*Category;

*Anova Test;
proc anova data=project.stats;                                 
class category;
model profit=category;
run;

*Graphical representation;
PROC SGPLOT DATA = project.stats;
VBOX profit / GROUP = category;
RUN;

*Multivariate analysis;
*Profit*Category*Sales;

*Graphical representation;
PROC SGPLOT DATA = project.stats;
SCATTER X = profit  Y= sales / GROUP= category;
KEYLEGEND/ LOCATION = INSIDE POSITION = BOTTOMRIGHT;
INSET "PROFIT AND SALES" / POSITION = TOPLEFT;
RUN;
QUIT;

*Correlation;
PROC CORR DATA = PROJECT.STATS;
VAR PROFIT SALES ;

RUN;

*Summarization;
PROC MEANS DATA = project.stats n nmiss min q1 median q3 max std var mean cv clm ;
VAR PROFIT SALES;
CLASS CATEGORY;
RUN;

/*The proc means table explains about the relation between category levels with sales and profit which states 
Total observation are 9994 with
Average profit for Furniture between [2.90608,14.4925] with a confidence level of 95%
Average profit for Office supplies between [16.16,24.49] with a confidence level of 95%
Average profit for Technology between [59.18,98.32] with a confidence level of 95%

Average Sales for Furniture between [328.40,371.26] with a confidence level of 95%
Average Sales for Office supplies between [109.57,128.97] with a confidence level of 95%
Average Sales for Technology between [402.11,503.302] with a confidence level of 95%
*/

*Question: List the top 10 cities with highest profit;
*Sort the data by stste and then profit in descending order to get highest at the top;
proc sort data =project.stats out=sorted;
by state descending profit;
run;

*using First keyword to get the first in that category and then retaining it and iterating 
it every step;
data sort;
set sorted;
by state;
if first.state then rank=0;
rank+1;
if rank<=10 then output;
run;

proc print data=sort;run;

*******************Thank You************************;
