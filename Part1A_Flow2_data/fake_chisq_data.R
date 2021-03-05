x1 <- runif(100)   # Creates a variable that has 100 random numbers between 0 and 1.
x2 <- runif(100)
x3 <- runif(100)
x4 <- c(runif(50), 0.5*runif(50)) # Creates a variable that has 50 random numbers between 0 and 1, 
                                  # and 50 random numbers between 0 and 0.5 - introducing a bias 
                                  # to our otherwise random data. 

x <- cbind(x1,x2,x3,x4)  # Binds the variables together into a table.

x_gt_half <- round(x)    # The "round" function takes the value of the nearest whole integer. 
                         # For values above 0.5, this is 1, for values below 0.5, this is 0. 
                         # For x1, x2, x3, there should be about 50 of each.
                         # For x4, there should be about 75 zeroes and 25 ones. 
                         # We don't expect to get exactly 50-50 or 75-25 every time, but the 
                         # chi-squared test will tell us whether the number of zeros and ones 
                         # in a column is statistically significantly different from what we 
                         # would expect. 

x_gt_half_table <- colSums(x_gt_half) # Since every entry in x_gt_half is zero or one, we can count 
                                      # the number of ones in each column by adding the whole column.
x_lt_half_table <- 100-colSums(x_gt_half)  # Since every column has 100 entries, the number of zeroes 
                                           # will just be 100 minus the number of ones.
x_table <- rbind(x_gt_half_table, x_lt_half_table) # We bind the "ones per column" and "zeroes per 
                                                   # column" so that we can run a chi-squared test.
x_table  # It's useful for us to see what the numbers in the table are, to get a sense of scale.

chisq.test(x_table) # When we run a chi-squared test on all four columns, the p-value will be 
                    # less than 0.05 (usually - there can be some randomness, but if you run this 
                    # code more than once you will almost certainly get a small p-value).
chisq.test(x_table[,1:3]) # When we run a chi-squared test on the three columns of unbiased data, 
                          # we will usually get a p-value greater than 0.05.

# When I ran this test, the numbers I got in my table were: 
#  42  51  50  24
#  58  49  50  76 
# When I ran the chi-squared test on this table, I got a p-value of 0.0002399. 
# When I ran the chi-squared test on the first three columns of this table, I got a p-value of 0.377. 
# Even though the 42-58 split seems quite large, it's not more of a deviation from 50-50 than you 
# would expect based on randomness and sample size for unbiased data. But 24-76 is far more than 
# would be expected, and so we get a small p-value from our chi-squared test. 

