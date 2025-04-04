# Advanced-SQL (Pivot Table)
An example of how to make pivot tables in SQL with meeting specific requrements

## Problem
Pivot the Occupation column in **OCCUPATIONS** so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. The output should consist of four columns (Doctor, Professor, Singer, and Actor) in that specific order, with their respective names listed alphabetically under each column.

### Input Format:
| *Colomn* | *Type* |
| ----------- | ----------- |
| *Name* | *String* |
| *Occupation* | *String* |

Occupation only contains one of the following values: *Doctor*, *Professor*, *Singer* or *Actor*.

### Input Sample Data:

| *Name* | *Occupation* |
| ----------- | ----------- |
| *Samantha* | *Doctor* |
| *Julia* | *Actor* |
| *Maria* | *Actor* |
| *Meera* | *Singer* |
| *Ashely* | *Professor* |

## List of Requirements
1. The first column must be an alphabetically ordered list of Doctor names.
2. The second column must be an alphabetically ordered list of Professor names.
3. The third column must be an alphabetically ordered list of Singer names.
4. The fourth column must be an alphabetically ordered list of Actor names.
5. The empty cell data for columns with less than the maximum number of names per occupation (in this case, the Professor and Actor columns) must be filled with NULL values.

## Solution
My approach to the solution of this problem has the following structure:
### 1. Create four separate tables for each **occupation** for the further use as a subquery
  An example for one table:
  
  `SELECT 
    CASE WHEN occupation = 'Doctor' THEN name END AS Doctor 
  FROM occupations`
  
  The decision to turn this into subquery is made to work easier with aliases.
### 2. Utilize window function to create a colomn which can be used later for joining + sort the result
 An example for the same table:
 
  `WITH occ_1 AS (
  SELECT
  Doctor,
  ROW_NUMBER() OVER(ORDER BY Doctor IS NULL, Doctor) AS doc
FROM (
  SELECT 
    CASE WHEN occupation = 'Doctor' THEN name END AS Doctor 
  FROM occupations
  ) AS temp_1
),`
  
  In this case the window function numerates all the rows for the table and sorts them so that cells with **names** are in alphabetical order while **NULL** cells are located below. Using CTE we prepare the tables for a future join.
### 3. Join all tables (made within CTE) in a single one

`SELECT 
    occ_1.Doctor,
    occ_2.Professor,
    occ_3.Singer,
    occ_4.Actor
FROM occ_1
JOIN occ_2 ON occ_1.doc=occ_2.prof
JOIN occ_3 ON occ_1.doc=occ_3.sing
JOIN occ_4 ON occ_1.doc=occ_4.act`

Here we have all temporary tables for each **occupation**: *occ_1*, *occ_2*, *occ_3*, and *occ_4*. Since weapplied window function previouly, now we can join all the tables together using row numbers as a key.
### 4. Filter obtained data to meet all the requirements of the problem
The only thing which remains is to remove the unnecessary rows (those rows in which all colomns contain **NULL**). We can filter those rows out using the folling:

`WHERE NOT(
    occ_1.Doctor IS NULL AND
    occ_2.Professor IS NULL AND
    occ_3.Singer IS NULL AND
    occ_4.Actor IS NULL
)`

In the result, we obtain processed data which fully satify the requirements of the problem.

You can access the full SQL Code via [this link](https://github.com/IvanDehtiarov/Advanced-SQL/blob/234a9c6063f5d8f9778da4e76db7a6b605ecfd9f/Code.sql)

## Summary
The following list represents fuctions and techniques utilized in the solution:
- Nested queries / subqueries;
- Common table expressions (WITH);
- Conditional expressions (CASE);
- Window functions (ROW_NUMBER);
- Using aliases (AS);
- Sorting within window functions, manipulation with NULL cells (ORDER BY);
- Joining mutiple tables (JOIN);
- Filtering out unnecessary data (WHERE NOT).
