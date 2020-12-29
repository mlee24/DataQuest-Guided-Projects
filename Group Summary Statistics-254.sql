## 2. If/Then in SQL ##

SELECT 
    CASE
    WHEN Sample_size < 200 THEN 'Small'
    WHEN (Sample_size >= 200 AND Sample_size < 1000) THEN 'Medium'
    ELSE 'Large'
    END AS Sample_category
FROM recent_grads;

## 3. Dissecting CASE ##

SELECT Major, Sample_size,
CASE
WHEN Sample_size < 200 THEN 'Small'
WHEN (Sample_size >= 200 AND Sample_size < 1000) THEN 'Medium'
ELSE 'Large'
END AS Sample_category
FROM recent_grads;

## 4. Calculating Group-Level Summary Statistics ##

SELECT Major_category, SUM(Total) Total_graduates
FROM recent_grads
GROUP BY Major_category;

## 5. GROUP BY Visual Breakdown ##

SELECT Major_category, AVG(ShareWomen) Average_women
FROM recent_grads
GROUP BY Major_category;

## 6. Multiple Summary Statistics by Group ##

SELECT Major_category, Total(Women) AS Total_women, AVG(ShareWomen) AS Mean_women, SUM(Total) * AVG(ShareWomen) AS Estimate_women
FROM recent_grads
GROUP BY Major_category;

## 7. Multiple Group Columns ##

SELECT Major_category, 
CASE
WHEN sample_size < 200 THEN 'Small'
WHEN (sample_size >= 200 AND sample_size < 1000) THEN 'Medium'
ELSE 'Large'
END AS Sample_category,
AVG(ShareWomen) AS Mean_women, 
SUM(total) AS Total_graduates
FROM recent_grads
GROUP BY Major_category, Sample_category;

## 8. Querying Virtual Columns With the HAVING Statement ##

SELECT Major_category, 
    AVG(Low_wage_jobs) / AVG(total) AS Share_low_wage 
FROM new_grads
GROUP BY Major_category
HAVING Share_low_wage > .1;

## 10. Rounding Results With the ROUND() Function ##

SELECT ROUND(ShareWomen, 4) AS Rounded_women,
       Major_category
  FROM new_grads
  LIMIT 10;

## 11. Nesting functions ##

SELECT Major_category, 
       ROUND((AVG(College_jobs) / AVG(Total)), 3) AS 'Share_degree_jobs'
FROM new_grads
GROUP BY Major_category
HAVING Share_degree_jobs < 0.3;

## 12. Casting ##

SELECT Major_category,
       SUM(CAST(Women AS Float)) / SUM(CAST(Total AS Float)) SW
FROM new_grads
GROUP BY Major_category
ORDER BY SW;