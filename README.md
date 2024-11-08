The dataset is a record of sales in electronic stores of a company. 
It consists of information about different customers that are required in purchasing products.
The data was analysed indepthly with SQL to uncover insights and trends about the data and it was also visualized using Microsoft PowerBI to clearly see these trends in graphical representations.

In SQL I cleaned the data before giving analysis and I did that by:
  i) First I created a new empty table and copied all the data from the original table to the new table. I did this in order to preserve the data in the original table and not alter it.
  ii) In the new table (which is what I worked with throughout the analysis) I searched for duplicates in the data by selecting all the columns in the data and also selecting a new custom column using the "ROW_NUMBER", partitioning it by each of the rows. Then I set a condition to return data where "ROW_NUMBER" is greater than 1, since there is no such data there is therefore no duplicates in the data.
  iii) I removed rows with at least one empty column of data as it will not be useful in our analysis.
  iv) I changed the data type of purchase date from text to Date.
      Then I did exploratory analysis:
  i) I analysed the number of products having an Order status of "Completed"
  ii) I also derived the number of products having an Order status of "Cancelled"
  iii) I also showed the most common payment method
  iv) I analysed products with the best shipping type by rating
  v) I did a count of Products that were rated the most
  vi) I analysed products with the most loyalty members
  vii) I exposed products that males and females purchased the most
  viii) Customers aged 50 and above I showed what they bought more
  ix) I represented the products that sold more
  x) I calculated the quantites of "Cancelled" products
  xi) I posed a question if cancelled products were rated lower and I analysed that
  xii) I compared shipping type of products to ratings
  xiii) I compared products to payment method
  xiv) I found the month in 2024 that they sold the most product

With POWERBI I graphically represented some of the exploratory analysis in SQL
  i) I exposed the products with the order status of "Completed" in a stacked bar chart
  ii) Using a stacked column chart, I represented the total products sold per month in 2024
  iii) With stacked column chart and drill down I showed the most common payment method for each product
  iv) I represented products with "Cancelled" Order status in a stacked bar chart
  v) I represented products that were rated higly (filtering "Rating" to >=3) in a stacked column chart
  vi) With a pie chart I showed number of loyal members for each Product
  vii) Products purchased most by both males and females I showed in stacked bar chart and stacked column charts respectively
  viii) In a stacked column chart I exposed products purchased by people aged 50 and above
  ix) In a line chart I represented number of loyal members per age group ( I created a bin for this)
  x) In a stacked column chart I exposed the quantities per Order Status
  xi) Using a line graph I represented all the age groups that spends the most on these products.


By this I saw some interesting information in the data that could be used to increase sales for the store.
