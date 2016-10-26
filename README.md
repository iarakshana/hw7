# Structured Query Language  

The homework is due, November 2 at 1:30am.  You can accept it, [here]().

## Time Use Survey

You can find the database [here](http://tinyurl.com/z24cdoz).

Each of your scripts must be written in a file named `atus1.sql`, `atus2.sql`, etc.
The answers should be placed in `SOLUTIONS`.

1. Average video game playing for men and women, in three ten-year age groups from 20-30, 30-40, 40-50.
2. Whether or not the respondent worked last week (1 = yes, 2 = no), grouped by whether or not
   a spouse or partner (1 or 2) was present, or not (3).
3. State with the lowest fraction of high school graduates.
4. Marital status (spouse or partner present), by educational attainment.
5. Average housework (code 02XXXX) by sex and educational attainment.
6. Married by attend religions services, Sunday (1), Friday (6) or Saturday (7) only, and in households with kids.
7. Daily time spent directly engaging children, by sex.  (Adapt from class.)

## Create and Query a Table

The Chicago salaries file, it turns out, is not fit to be loaded into a database from the get-go.
This is a great moment for some practice with `sed`!
* The empty lines and headers themselves are a nuisance.  Remove lines without dollar signs.
* The `sqlite3` importer doesn't recognize quotation marks, so we need to get rid of these.
* The dollar signs would stop us from manipulating the salary values as numbers.
* There are weird spaces before first names.  Get rid of them.

Once you've done this, import the table using the shortcut from class:

```
CREATE TABLE chicago (Last TEXT, First TEXT, Position TEXT, Department TEXT, Salary REAL);
.mode csv
.import salaries.csv chicago
```

Query this table to find:

1. The average salary of police officers in the city.
2. Total expenditures on salaries in the Mayor's office.
3. Number of people working in the three largest departments.

Save each of your queries as `s1.sql`, `s2.sql`, etc., and mark the responses in SOLUTIONS.

## Never Forget Python

You can find a nicely-formatted copy of _Romeo and Juliet_ [here](http://shakespeare.mit.edu/romeo_juliet/full.html).
You can download it to your directory with 

```
curl http://shakespeare.mit.edu/romeo_juliet/full.html -o rj.html
```

If you `cat` the file, you'll see that new speakers are marked by "A NAME=speech"
and that individual lines also start by "A NAME=" but without "speech".

Begin by making a dictionary of all of the characters in the play.
Then count their spoken lines.
Who has the most lines in the play?  How many lines do they have?
