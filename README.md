
<!-- README.md is generated from README.Rmd. Please edit that file -->

# macklinear

<!-- badges: start -->

<!-- badges: end -->

The goal of this project is to develop an R package that implements a
foundational machine learning algorithm - linear regression. The scope
of the package includes producing outputs such as statistical confidence
intervals (C.I.) at the user selected significance level and method of
solution. The two methods of solution available in the developed package
are the asymptotic and the bootstrap methods.

You can also check our Shiny app using this link: [Shiny
App](https://finalprojectgroup5.shinyapps.io/shinymacklinear/)

## Installation

1.  Download and install/update R.

2.  Open R and install the development version of the package from
    [GitHub](https://github.com/) with:

<!-- end list -->

``` install_github
# install.packages("devtools")
devtools::install_github("AU-R-Programming/Final_Project_Group_5")
```

## Usage

There are two functions contained in the package: `my_lm()` for building
a linear regression model and outputting related statistics, and
`plot_func()` for creating plots of some of these statistics from linear
regression. The full form of each function with each argument and
default value, if any, is listed below:

``` r
my_lm(response, covariates, alpha = 0.05, method = "asymptotic", intercept = 1)

plot_func(lm)
```

The function `my_lm()` needs five parameters: `response`, `covariates`,
`alpha`, `method`, & `intercept`.

  - `response` - a one-dimensional vector of numerical y values used as
    the response variable in the regression equation.
  - `covariates` - a matrix of numerical x values used as the
    explanatory variable(s) in the regression equation. Can be
    one-dimensional if running simple linear regression or
    two-dimensional if running multiple linear regression.
  - `alpha` - a value between 0 and 1 that specifies the alpha level
    with which to form the two-tailed confidence interval for beta.hat.
    The default value is 0.05.
  - `method` - a string value indicating the method used for generating
    the confidence intervals for beta.hat. The asymptotic method will be
    performed if “asymptotic” or “a” are specified. The bootstrap method
    will be performed if “bootstrap” or “b” are specified. The default
    value is “asymptotic”.
  - `intercept` - a binary value of either 1 or -1 specifying if the
    model should estimate the intercept. A value of 1 will include the
    intercept while -1 will exclude the intercept. The default value is
    1.

<br><br><br>

## Tutorial - Simple Linear Regression

### Cars Dataset

This is a basic example using the base R data set, cars, which shows you
how to solve a common problem. <br><br><br> The cars data set has two
variables, **speed** and **distance**. We will use the `my_lm` function
of the `macklinear` package to fit a regression and estimate the fit of
our explanatory variable to our response variable. <br><br><br>

``` r
library(macklinear)

head(cars)
#>   speed dist
#> 1     4    2
#> 2     4   10
#> 3     7    4
#> 4     7   22
#> 5     8   16
#> 6     9   10

plot(cars)
```

<img src="man/figures/README-example cars-1.png" width="100%" />

<br><br><br> We can see that the y variable, or the response variable,
is distance. The variable **“dist”** is our `response` parameter in our
function. <br><br><br> The x variable, or the explanatory variable, is
speed. The variable **“speed”** is our `covariate` parameter in our
function. <br><br><br> `Alpha` is our level of significance set for our
function. Alpha is generally set at 0.05, indicating a 95% confidence
interval. If you do not set 0 \< alpha \< 1, you will have a warning
generated as the true value of alpha must be between 0 and 1 and the
function will not complete. Additionally, if you do not set 0.01 \<
alpha \< 0.1, you will have a warning generated, but the function will
still run as intended. Alpha is typically between 0.01 and 0.1,
therefore you should consider using a different alpha value.
<br><br><br> The parameter `method` is used to determine the method with
which confidence intervals for β will be generated. You can choose to
use a “bootstrap” or “asymptotic” method for generating confidence
intervals. The “asymptotic” method is a more mathematical approach using
the square root of the variance of each β to construct a confidence
interval. The “bootstrap” method simply generates a new matrix of x and
y values with the same length of the original data by sampling with
replacement from the original data. This is repeated 1000 times. The βs
are estimated for each of the 1000 new datasets, and the confidence
intervals are constructed by taking the upper and lower quantiles of the
distribution of these βs. The quantiles are specified by `alpha`.
<br><br><br> The final parameter of the function is `intercept`. As
stated before, this determines whether to include an intercept in the
model or not. <br><br><br> We will now use the `my_lm()` function to
analyze the relationship between **speed and distance**, with a **95%**
confidence interval and a **bootstrap** approach for generating
confidence interval, and including the intercept.

``` r
fit_my_lm <- my_lm(cars$dist, cars$speed, alpha = 0.05, method = "bootstrap", intercept = 1)
fit_my_lm
#> $y.avg
#>       [,1]
#> [1,] 42.98
#> 
#> $sigma2
#>          [,1]
#> [1,] 236.5317
#> 
#> $mspe
#>          [,1]
#> [1,] 227.0704
#> 
#> $ssm
#>          [,1]
#> [1,] 21185.46
#> 
#> $sse
#>          [,1]
#> [1,] 11353.52
#> 
#> $f.stat
#>          [,1]
#> [1,] 89.56711
#> 
#> $p.value
#>              [,1]
#> [1,] 1.489836e-12
#> 
#> $y.table
#>       actual.y.values     y.hat   residual
#>  [1,]               2 -1.849460   3.849460
#>  [2,]              10 -1.849460  11.849460
#>  [3,]               4  9.947766  -5.947766
#>  [4,]              22  9.947766  12.052234
#>  [5,]              16 13.880175   2.119825
#>  [6,]              10 17.812584  -7.812584
#>  [7,]              18 21.744993  -3.744993
#>  [8,]              26 21.744993   4.255007
#>  [9,]              34 21.744993  12.255007
#> [10,]              17 25.677401  -8.677401
#> [11,]              28 25.677401   2.322599
#> [12,]              14 29.609810 -15.609810
#> [13,]              20 29.609810  -9.609810
#> [14,]              24 29.609810  -5.609810
#> [15,]              28 29.609810  -1.609810
#> [16,]              26 33.542219  -7.542219
#> [17,]              34 33.542219   0.457781
#> [18,]              34 33.542219   0.457781
#> [19,]              46 33.542219  12.457781
#> [20,]              26 37.474628 -11.474628
#> [21,]              36 37.474628  -1.474628
#> [22,]              60 37.474628  22.525372
#> [23,]              80 37.474628  42.525372
#> [24,]              20 41.407036 -21.407036
#> [25,]              26 41.407036 -15.407036
#> [26,]              54 41.407036  12.592964
#> [27,]              32 45.339445 -13.339445
#> [28,]              40 45.339445  -5.339445
#> [29,]              32 49.271854 -17.271854
#> [30,]              40 49.271854  -9.271854
#> [31,]              50 49.271854   0.728146
#> [32,]              42 53.204263 -11.204263
#> [33,]              56 53.204263   2.795737
#> [34,]              76 53.204263  22.795737
#> [35,]              84 53.204263  30.795737
#> [36,]              36 57.136672 -21.136672
#> [37,]              46 57.136672 -11.136672
#> [38,]              68 57.136672  10.863328
#> [39,]              32 61.069080 -29.069080
#> [40,]              48 61.069080 -13.069080
#> [41,]              52 61.069080  -9.069080
#> [42,]              56 61.069080  -5.069080
#> [43,]              64 61.069080   2.930920
#> [44,]              66 68.933898  -2.933898
#> [45,]              54 72.866307 -18.866307
#> [46,]              70 76.798715  -6.798715
#> [47,]              92 76.798715  15.201285
#> [48,]              93 76.798715  16.201285
#> [49,]             120 76.798715  43.201285
#> [50,]              85 80.731124   4.268876
#> 
#> $beta.table
#>          beta variance.beta CI.lower.bound CI.upper.bound
#> b0 -17.579095    45.6765135     -28.692910      -6.287511
#> b1   3.932409     0.1726509       3.137822       4.721378
```

Our function returns multiple statistical outputs regarding the
relationship between our x and y variables, **speed** and **distance**.

  - `y.avg` is the mean of all y-values in the data set
  - `sigma2` is an estimate of the residual variance
  - `mspe` is an estimate of how well the model predicts the response
    variable
  - `ssm` is the model sum of squares
  - `sse` is the error sum of squares, which quantifies how much the
    residual data points vary around the estimated regression line
    points, y-hat
  - `f.stat` is the f statistic for use in f test and model fitting
  - `p.value` is the probability of the observed data, or data more
    extreme, given the null hypothesis is true

There are two tables that are also output with additional information.
From the output `y.table`:

  - `actual.y.values` are the response variable values taken from the
    input data
  - `y.hat` is the predicted y-value
  - `residual` is the difference between the observed y-value and the
    predicted y-value, or y.hat

From the output `beta.table`:

  - `beta` is the estimated value of beta-hat
  - `variance.beta` is an estimate of the variance of the estimated beta
  - `CI.lower.bound` is the lower bound of the confidence interval based
    on the alpha set in the function parameters
  - `CI.upper.bound` is the upper bound of the confidence interval based
    on the alpha set in the function parameters <br><br><br> For every 1
    unit increase in speed, there is a *3.932409 (beta)* *(+/- 0.743139
    95% CI)* unit increase in distance. <br><br> Our **p-value** is
    1.489836e-12, which indicates that there is a significant
    relationship between our descriptive and response variables.
    <br><br><br> We can also produce descriptive plot of our residuals
    using `plot_func()`. The parameter needed in `plot_func()` is the
    name of the object created when using the `my_lm()` function.
    <br><br> In the example above we called our object `fit_my_lm` - so
    this is what will be used as the parameter in `plot_func()`.
    <br><br> `plot_func()` will return 3 plots:

<!-- end list -->

1.  A plot of the estimated residual values versus the estimated fitted
    values
2.  A qq-plot plotting estimated residual values, with a fitted line
3.  A histogram of the estimated residual values <br><br><br>

<!-- end list -->

``` r
my_plots <- plot_func(fit_my_lm)
```

<img src="man/figures/README-example cars plot-1.png" width="100%" /><img src="man/figures/README-example cars plot-2.png" width="100%" /><img src="man/figures/README-example cars plot-3.png" width="100%" />
<br><br><br>

## Tutorial - Multiple Regression

### Iris Dataset

We can also use the `my_lm()` function to perform multiple linear
regression. Compared to simple linear regressions, performed in the
example above, multiple linear regressions are used to predict the value
of the response variable when two or more covariates are present.
<br><br><br>

``` r
library(macklinear)

head(iris)
#>   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
#> 1          5.1         3.5          1.4         0.2  setosa
#> 2          4.9         3.0          1.4         0.2  setosa
#> 3          4.7         3.2          1.3         0.2  setosa
#> 4          4.6         3.1          1.5         0.2  setosa
#> 5          5.0         3.6          1.4         0.2  setosa
#> 6          5.4         3.9          1.7         0.4  setosa

plot(iris)
```

<img src="man/figures/README-example iris-1.png" width="100%" />
<br><br><br>

There are four continuous variables in the iris data set that can be
used for multiple regression: **sepal length, sepal width, petal
length**, and **petal width**.

Using our `my_lm()` function, we want to see if our covariates sepal
length and sepal width can explain the relationship in our response
variable, petal length.

We will use a **90% confidence interval** and, the **asymptotic** method
for the confidence interval, and no intercept. <br><br><br>

``` r
iris.response <- iris$Petal.Length
iris.covariates <- cbind(iris$Sepal.Length, iris$Sepal.Width)
iris_results <- my_lm(iris.response, iris.covariates, alpha = 0.1, method = "asymptotic", intercept = -1)
iris_results
#> $y.avg
#>       [,1]
#> [1,] 3.758
#> 
#> $sigma2
#>           [,1]
#> [1,] 0.4718147
#> 
#> $mspe
#>           [,1]
#> [1,] 0.4655239
#> 
#> $ssm
#>          [,1]
#> [1,] 2512.881
#> 
#> $sse
#>          [,1]
#> [1,] 69.82858
#> 
#> $f.stat
#>          [,1]
#> [1,] 2662.996
#> 
#> $p.value
#>               [,1]
#> [1,] 9.222726e-117
#> 
#> $y.table
#>        actual.y.values     y.hat     residual
#>   [1,]             1.4 1.8475699 -0.447569862
#>   [2,]             1.4 2.4083618 -1.008361844
#>   [3,]             1.3 1.7471608 -0.447160769
#>   [4,]             1.5 1.7657011 -0.265701104
#>   [5,]             1.4 1.5169693 -0.116969325
#>   [6,]             1.7 1.6173784  0.082621582
#>   [7,]             1.4 1.2419898  0.158010205
#>   [8,]             1.5 1.8661102 -0.366110198
#>   [9,]             1.4 1.8027818 -0.402781776
#>  [10,]             1.5 2.2337914 -0.733791407
#>  [11,]             1.5 1.9665193 -0.466519292
#>  [12,]             1.6 1.5540500  0.045950004
#>  [13,]             1.4 2.2523317 -0.852331743
#>  [14,]             1.1 1.4721812 -0.372181239
#>  [15,]             1.2 2.0669284 -0.866928385
#>  [16,]             1.5 1.2126165  0.287383462
#>  [17,]             1.3 1.6173784 -0.317378418
#>  [18,]             1.4 1.8475699 -0.447569862
#>  [19,]             1.7 2.2600392 -0.560039158
#>  [20,]             1.5 1.3238586  0.176141447
#>  [21,]             1.7 2.4902306 -0.790230601
#>  [22,]             1.5 1.4984290  0.001571011
#>  [23,]             1.0 0.8928489  0.107151079
#>  [24,]             1.7 2.1967107 -0.496710736
#>  [25,]             1.9 1.5540500  0.345950004
#>  [26,]             1.6 2.5643919 -0.964391944
#>  [27,]             1.6 1.8661102 -0.266110198
#>  [28,]             1.5 2.0036000 -0.503599963
#>  [29,]             1.4 2.1781704 -0.778170400
#>  [30,]             1.6 1.7471608 -0.147160769
#>  [31,]             1.6 2.0777613 -0.477761306
#>  [32,]             1.5 2.4902306 -0.990230601
#>  [33,]             1.5 0.9561773  0.543822656
#>  [34,]             1.4 1.2496972  0.150302790
#>  [35,]             1.5 2.2337914 -0.733791407
#>  [36,]             1.2 2.2152511 -1.015251071
#>  [37,]             1.3 2.4716903 -1.171690266
#>  [38,]             1.4 1.3609392  0.039060776
#>  [39,]             1.3 1.6282113 -0.328211339
#>  [40,]             1.5 2.0221403 -0.522140299
#>  [41,]             1.3 1.6915398 -0.391539761
#>  [42,]             1.3 3.0062345 -1.706234496
#>  [43,]             1.3 1.2790705  0.020929534
#>  [44,]             1.6 1.6915398 -0.091539761
#>  [45,]             1.9 1.3238586  0.576141447
#>  [46,]             1.4 2.2523317 -0.852331743
#>  [47,]             1.6 1.3238586  0.276141447
#>  [48,]             1.4 1.5911307 -0.191130668
#>  [49,]             1.5 1.8104892 -0.310489191
#>  [50,]             1.4 2.0406806 -0.640680635
#>  [51,]             4.7 5.3358531 -0.635853088
#>  [52,]             4.5 4.3996725  0.100327517
#>  [53,]             4.9 5.3543934 -0.454393424
#>  [54,]             4.0 4.5665355 -0.566535505
#>  [55,]             4.6 5.2539843 -0.653984330
#>  [56,]             4.5 4.0057435  0.494256476
#>  [57,]             4.7 4.0690719  0.630928054
#>  [58,]             3.3 3.4557845 -0.155784463
#>  [59,]             4.6 5.2354440 -0.635443995
#>  [60,]             3.9 3.4001635  0.499836544
#>  [61,]             3.5 4.3100963 -0.810096310
#>  [62,]             4.2 3.9686629  0.231337148
#>  [63,]             4.0 5.5212564 -1.521256446
#>  [64,]             4.7 4.4552935  0.244706510
#>  [65,]             3.6 3.6751430 -0.075142986
#>  [66,]             4.4 5.0423332 -0.642333222
#>  [67,]             4.5 3.5005725  0.999427450
#>  [68,]             4.1 4.3363441 -0.236344061
#>  [69,]             4.5 5.8333166 -1.333316647
#>  [70,]             3.9 4.3734247 -0.473424733
#>  [71,]             4.8 3.6195220  1.180478021
#>  [72,]             4.0 4.6298639 -0.629863927
#>  [73,]             4.9 5.4656354 -0.565635438
#>  [74,]             4.7 4.6298639  0.070136073
#>  [75,]             4.3 4.9233838 -0.623383793
#>  [76,]             4.4 5.0608736 -0.660873558
#>  [77,]             4.8 5.7220746 -0.922074633
#>  [78,]             5.0 5.2169037 -0.216903659
#>  [79,]             4.5 4.2992634  0.200736610
#>  [80,]             3.5 4.3548844 -0.854884397
#>  [81,]             3.8 4.3919651 -0.591965068
#>  [82,]             3.7 4.3919651 -0.691965068
#>  [83,]             3.9 4.3363441 -0.436344061
#>  [84,]             5.1 4.6484043  0.451595737
#>  [85,]             4.5 3.1885123  1.311487652
#>  [86,]             4.5 3.4264112  1.073588793
#>  [87,]             4.7 5.0423332 -0.342333222
#>  [88,]             4.4 5.8147763 -1.414776312
#>  [89,]             4.1 3.5005725  0.599427450
#>  [90,]             4.0 4.2173946 -0.217394632
#>  [91,]             4.4 4.0428242  0.357175805
#>  [92,]             4.6 4.2807231  0.319276946
#>  [93,]             4.0 4.5109145 -0.510914498
#>  [94,]             3.3 3.7863850 -0.486385001
#>  [95,]             4.2 4.0242839  0.175716141
#>  [96,]             4.2 3.6566027  0.543397350
#>  [97,]             4.2 3.8311731  0.368826913
#>  [98,]             4.3 4.6113236 -0.311323591
#>  [99,]             3.0 3.5932742 -0.593274228
#> [100,]             4.1 4.0057435  0.094256476
#> [101,]             6.0 4.0690719  1.930928054
#> [102,]             5.1 4.3363441  0.763655939
#> [103,]             5.9 5.8410241  0.058975938
#> [104,]             5.6 4.7673537  0.832646308
#> [105,]             5.8 4.9048435  0.895156543
#> [106,]             6.6 6.6211746 -0.021174566
#> [107,]             4.5 3.2812140  1.218785973
#> [108,]             6.3 6.3276547 -0.027654701
#> [109,]             5.8 6.0897558 -0.289755842
#> [110,]             6.1 4.9496315  1.150368456
#> [111,]             5.1 4.5557026  0.544297416
#> [112,]             5.3 5.2725247  0.027475334
#> [113,]             5.5 5.3729338  0.127066240
#> [114,]             5.0 4.5294548  0.470545167
#> [115,]             5.1 4.1617736  0.938226376
#> [116,]             5.3 4.3996725  0.900327517
#> [117,]             5.5 4.9048435  0.595156543
#> [118,]             6.7 5.3806412  1.319358825
#> [119,]             6.9 7.4754864 -0.575486414
#> [120,]             5.0 5.5212564 -0.521256446
#> [121,]             5.7 5.1798230  0.520177013
#> [122,]             4.9 3.8497134  1.050286577
#> [123,]             6.7 7.1263455 -0.426345541
#> [124,]             4.9 5.1164946 -0.216494565
#> [125,]             5.7 4.6931923  1.006807651
#> [126,]             6.0 5.6479133  0.352086710
#> [127,]             4.8 4.7858940  0.014105972
#> [128,]             4.9 4.2807231  0.619276946
#> [129,]             5.6 5.0979542  0.502045770
#> [130,]             5.8 5.9970542 -0.197054163
#> [131,]             6.1 6.6582552 -0.558255238
#> [132,]             6.4 5.6927014  0.707298624
#> [133,]             5.6 5.0979542  0.502045770
#> [134,]             5.1 4.9419241  0.158075871
#> [135,]             5.6 4.9790048  0.620995200
#> [136,]             6.1 6.7772047 -0.677204667
#> [137,]             5.6 3.8945015  1.705498491
#> [138,]             5.5 4.5742429  0.925757080
#> [139,]             4.8 4.1246930  0.675307047
#> [140,]             5.4 5.3543934  0.045606576
#> [141,]             5.6 5.0423332  0.557666778
#> [142,]             5.1 5.3543934 -0.254393424
#> [143,]             5.1 4.3363441  0.763655939
#> [144,]             5.9 5.0237929  0.876207113
#> [145,]             5.7 4.6931923  1.006807651
#> [146,]             5.2 5.2169037 -0.016903659
#> [147,]             5.0 5.4656354 -0.465635438
#> [148,]             5.2 4.9048435  0.295156543
#> [149,]             5.4 3.7384714  1.661528592
#> [150,]             5.1 3.9686629  1.131337148
#> 
#> $beta.table
#>         beta variance.beta CI.lower.bound CI.upper.bound
#> b1  1.560301   0.002076776       1.485342       1.635260
#> b2 -1.745704   0.007584428      -1.888952      -1.602456
```

<br><br><br> From the output, we no longer have the estimate for the
intercept, or “b0”. However, now that we have added an additional x
value, there now exists a “b1” and a “b2”.

To get our descriptive plots, we can use `plot_func()` with the
parameter again the object we called our `my_lm()` function.
<br><br><br>

``` r
iris_plots <- plot_func(iris_results)
```

<img src="man/figures/README-example iris plot-1.png" width="100%" /><img src="man/figures/README-example iris plot-2.png" width="100%" /><img src="man/figures/README-example iris plot-3.png" width="100%" />
<br><br><br>

## Error Messages and Constraints

There are a few checks built into the function to make sure the
regressions are performed accurately. For example, as mentioned before,
the function will not run if the `alpha` value is less than 0 or greater
than 1. An example of the error output in this situation is below:

``` r
iris_results <- my_lm(iris$Petal.Length, iris$Petal.Width, alpha = 2, method = "asymptotic", intercept = 1)
#> Error in my_lm(iris$Petal.Length, iris$Petal.Width, alpha = 2, method = "asymptotic", : True value of alpha must lie between 0 and 1
```

Another potential error message a user can encounter is when entering
the method for generating the confidence interval. If the user enters a
method that is unknown, the function will not run:

``` r
iris_results <- my_lm(iris$Petal.Length, iris$Petal.Width, alpha = 0.05, method = "unbiased", intercept = 1)
#> Error in my_lm(iris$Petal.Length, iris$Petal.Width, alpha = 0.05, method = "unbiased", : Unrecognized confidence interval method. Try "asymptotic" or "bootstrap".
```

Additionally, there is one warning that will appear pertaining to
`alpha` again, but it will not halt the function. As mentioned earlier,
a warning will be produced if the `alpha` value is an uncommon value:

``` r
iris_results <- my_lm(iris$Petal.Length, iris$Petal.Width, alpha = 0.4, method = "a", intercept = 1)
#> Warning in my_lm(iris$Petal.Length, iris$Petal.Width, alpha = 0.4, method =
#> "a", : Alpha is typically between 0.01 and 0.1. Consider using a different alpha
#> value
iris_results
#> $y.avg
#>       [,1]
#> [1,] 3.758
#> 
#> $sigma2
#>           [,1]
#> [1,] 0.2286808
#> 
#> $mspe
#>           [,1]
#> [1,] 0.2256317
#> 
#> $ssm
#>          [,1]
#> [1,] 430.4806
#> 
#> $sse
#>          [,1]
#> [1,] 33.84475
#> 
#> $f.stat
#>          [,1]
#> [1,] 1882.452
#> 
#> $p.value
#>              [,1]
#> [1,] 4.675004e-86
#> 
#> $y.table
#>        actual.y.values    y.hat     residual
#>   [1,]             1.4 1.529546 -0.129546132
#>   [2,]             1.4 1.529546 -0.129546132
#>   [3,]             1.3 1.529546 -0.229546132
#>   [4,]             1.5 1.529546 -0.029546132
#>   [5,]             1.4 1.529546 -0.129546132
#>   [6,]             1.7 1.975534 -0.275534231
#>   [7,]             1.4 1.752540 -0.352540181
#>   [8,]             1.5 1.529546 -0.029546132
#>   [9,]             1.4 1.529546 -0.129546132
#>  [10,]             1.5 1.306552  0.193447918
#>  [11,]             1.5 1.529546 -0.029546132
#>  [12,]             1.6 1.529546  0.070453868
#>  [13,]             1.4 1.306552  0.093447918
#>  [14,]             1.1 1.306552 -0.206552082
#>  [15,]             1.2 1.529546 -0.329546132
#>  [16,]             1.5 1.975534 -0.475534231
#>  [17,]             1.3 1.975534 -0.675534231
#>  [18,]             1.4 1.752540 -0.352540181
#>  [19,]             1.7 1.752540 -0.052540181
#>  [20,]             1.5 1.752540 -0.252540181
#>  [21,]             1.7 1.529546  0.170453868
#>  [22,]             1.5 1.975534 -0.475534231
#>  [23,]             1.0 1.529546 -0.529546132
#>  [24,]             1.7 2.198528 -0.498528280
#>  [25,]             1.9 1.529546  0.370453868
#>  [26,]             1.6 1.529546  0.070453868
#>  [27,]             1.6 1.975534 -0.375534231
#>  [28,]             1.5 1.529546 -0.029546132
#>  [29,]             1.4 1.529546 -0.129546132
#>  [30,]             1.6 1.529546  0.070453868
#>  [31,]             1.6 1.529546  0.070453868
#>  [32,]             1.5 1.975534 -0.475534231
#>  [33,]             1.5 1.306552  0.193447918
#>  [34,]             1.4 1.529546 -0.129546132
#>  [35,]             1.5 1.529546 -0.029546132
#>  [36,]             1.2 1.529546 -0.329546132
#>  [37,]             1.3 1.529546 -0.229546132
#>  [38,]             1.4 1.306552  0.093447918
#>  [39,]             1.3 1.529546 -0.229546132
#>  [40,]             1.5 1.529546 -0.029546132
#>  [41,]             1.3 1.752540 -0.452540181
#>  [42,]             1.3 1.752540 -0.452540181
#>  [43,]             1.3 1.529546 -0.229546132
#>  [44,]             1.6 2.421522 -0.821522330
#>  [45,]             1.9 1.975534 -0.075534231
#>  [46,]             1.4 1.752540 -0.352540181
#>  [47,]             1.6 1.529546  0.070453868
#>  [48,]             1.4 1.529546 -0.129546132
#>  [49,]             1.5 1.529546 -0.029546132
#>  [50,]             1.4 1.529546 -0.129546132
#>  [51,]             4.7 4.205475  0.494525274
#>  [52,]             4.5 4.428469  0.071531224
#>  [53,]             4.9 4.428469  0.471531224
#>  [54,]             4.0 3.982481  0.017519323
#>  [55,]             4.6 4.428469  0.171531224
#>  [56,]             4.5 3.982481  0.517519323
#>  [57,]             4.7 4.651463  0.048537175
#>  [58,]             3.3 3.313499 -0.013498528
#>  [59,]             4.6 3.982481  0.617519323
#>  [60,]             3.9 4.205475 -0.305474726
#>  [61,]             3.5 3.313499  0.186501472
#>  [62,]             4.2 4.428469 -0.228468776
#>  [63,]             4.0 3.313499  0.686501472
#>  [64,]             4.7 4.205475  0.494525274
#>  [65,]             3.6 3.982481 -0.382480677
#>  [66,]             4.4 4.205475  0.194525274
#>  [67,]             4.5 4.428469  0.071531224
#>  [68,]             4.1 3.313499  0.786501472
#>  [69,]             4.5 4.428469  0.071531224
#>  [70,]             3.9 3.536493  0.363507423
#>  [71,]             4.8 5.097451 -0.297450924
#>  [72,]             4.0 3.982481  0.017519323
#>  [73,]             4.9 4.428469  0.471531224
#>  [74,]             4.7 3.759487  0.940513373
#>  [75,]             4.3 3.982481  0.317519323
#>  [76,]             4.4 4.205475  0.194525274
#>  [77,]             4.8 4.205475  0.594525274
#>  [78,]             5.0 4.874457  0.125543125
#>  [79,]             4.5 4.428469  0.071531224
#>  [80,]             3.5 3.313499  0.186501472
#>  [81,]             3.8 3.536493  0.263507423
#>  [82,]             3.7 3.313499  0.386501472
#>  [83,]             3.9 3.759487  0.140513373
#>  [84,]             5.1 4.651463  0.448537175
#>  [85,]             4.5 4.428469  0.071531224
#>  [86,]             4.5 4.651463 -0.151462825
#>  [87,]             4.7 4.428469  0.271531224
#>  [88,]             4.4 3.982481  0.417519323
#>  [89,]             4.1 3.982481  0.117519323
#>  [90,]             4.0 3.982481  0.017519323
#>  [91,]             4.4 3.759487  0.640513373
#>  [92,]             4.6 4.205475  0.394525274
#>  [93,]             4.0 3.759487  0.240513373
#>  [94,]             3.3 3.313499 -0.013498528
#>  [95,]             4.2 3.982481  0.217519323
#>  [96,]             4.2 3.759487  0.440513373
#>  [97,]             4.2 3.982481  0.217519323
#>  [98,]             4.3 3.982481  0.317519323
#>  [99,]             3.0 3.536493 -0.536492577
#> [100,]             4.1 3.982481  0.117519323
#> [101,]             6.0 6.658409 -0.658409271
#> [102,]             5.1 5.320445 -0.220444974
#> [103,]             5.9 5.766433  0.133566927
#> [104,]             5.6 5.097451  0.502549076
#> [105,]             5.8 5.989427 -0.189427122
#> [106,]             6.6 5.766433  0.833566927
#> [107,]             4.5 4.874457 -0.374456875
#> [108,]             6.3 5.097451  1.202549076
#> [109,]             5.8 5.097451  0.702549076
#> [110,]             6.1 6.658409 -0.558409271
#> [111,]             5.1 5.543439 -0.443439023
#> [112,]             5.3 5.320445 -0.020444974
#> [113,]             5.5 5.766433 -0.266433073
#> [114,]             5.0 5.543439 -0.543439023
#> [115,]             5.1 6.435415 -1.335415221
#> [116,]             5.3 6.212421 -0.912421172
#> [117,]             5.5 5.097451  0.402549076
#> [118,]             6.7 5.989427  0.710572878
#> [119,]             6.9 6.212421  0.687578828
#> [120,]             5.0 4.428469  0.571531224
#> [121,]             5.7 6.212421 -0.512421172
#> [122,]             4.9 5.543439 -0.643439023
#> [123,]             6.7 5.543439  1.156560977
#> [124,]             4.9 5.097451 -0.197450924
#> [125,]             5.7 5.766433 -0.066433073
#> [126,]             6.0 5.097451  0.902549076
#> [127,]             4.8 5.097451 -0.297450924
#> [128,]             4.9 5.097451 -0.197450924
#> [129,]             5.6 5.766433 -0.166433073
#> [130,]             5.8 4.651463  1.148537175
#> [131,]             6.1 5.320445  0.779555026
#> [132,]             6.4 5.543439  0.856560977
#> [133,]             5.6 5.989427 -0.389427122
#> [134,]             5.1 4.428469  0.671531224
#> [135,]             5.6 4.205475  1.394525274
#> [136,]             6.1 6.212421 -0.112421172
#> [137,]             5.6 6.435415 -0.835415221
#> [138,]             5.5 5.097451  0.402549076
#> [139,]             4.8 5.097451 -0.297450924
#> [140,]             5.4 5.766433 -0.366433073
#> [141,]             5.6 6.435415 -0.835415221
#> [142,]             5.1 6.212421 -1.112421172
#> [143,]             5.1 5.320445 -0.220444974
#> [144,]             5.9 6.212421 -0.312421172
#> [145,]             5.7 6.658409 -0.958409271
#> [146,]             5.2 6.212421 -1.012421172
#> [147,]             5.0 5.320445 -0.320444974
#> [148,]             5.2 5.543439 -0.343439023
#> [149,]             5.4 6.212421 -0.812421172
#> [150,]             5.1 5.097451  0.002549076
#> 
#> $beta.table
#>        beta variance.beta CI.lower.bound CI.upper.bound
#> b0 1.083558   0.005324178       1.022147       1.144969
#> b1 2.229940   0.002641573       2.186684       2.273197
```
