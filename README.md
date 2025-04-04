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

## List of Requerements
1. The first column must be an alphabetically ordered list of Doctor names.
2. The second column must be an alphabetically ordered list of Professor names.
3. The third column must be an alphabetically ordered list of Singer names.
4. The fourth column must be an alphabetically ordered list of Actor names.
5. The empty cell data for columns with less than the maximum number of names per occupation (in this case, the Professor and Actor columns) must be filled with NULL values.

