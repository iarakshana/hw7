# Structured Query Language  

The homework is due, November 2 at 1:30am.  You can accept it, [here](https://classroom.github.com/assignment-invitations/de7acce809fc99f051f534d4b454ba0a).

## Time Use Survey

You can find the database [here](http://tinyurl.com/z24cdoz).

Each of your scripts must be written in a file named `atus1.sql`, `atus2.sql`, etc.
The answers should be placed in `SOLUTIONS`.

Please remember throughout, that when using the tables `roster` or `cps`, you must require that the `line_no` value be 1.
This has nothing to do with SQL generically, and just represents the fact that there are many people in a household, and the respondent and activities correspond to person "1."


1. Average (video) game playing (code 120307; [activity codes](http://www.bls.gov/tus/lexiconwex2015.pdf)) for men and women (1 and 2), in three ten-year age groups from 20-29, 30-39, 40-49.
   * Hint: you can do multiple `group by` variables.
   * Hint: to group by age, use the fact that the default integer division in SQL is floor division.
2. Whether or not the respondent worked last week as a fraction (1 = yes, 2 = no; exclude retired/disabled/unable 3-5 and no answer; see TUFWK [here](http://www.bls.gov/tus/atusintcodebk15.pdf)), grouped by whether or not
   a spouse or partner was present, or not (1 or 2, v. 3; see TRSPPRES; same [resource](http://www.bls.gov/tus/atusintcodebk15.pdf)). 
3. State with the lowest fraction of high school graduates.
   * [CPS codebook](http://www.bls.gov/tus/atuscpscodebk15.pdf), variable PEEDUCA -- 39 or higher.
4. Average marital status (spouse or partner present), by educational attainment.
   * Use respondent `spouse_or_partner_present` and cps `educational_attainment`.  Require that the educational attainment be non-negative.
5. Average housework (activity code 02XXXX, i.e., all those starting by 02, see [here](http://www.bls.gov/tus/lexiconwex2015.pdf) -- use floor division, which is the default) by sex and educational attainment.
6. Respondent married average (spouse_or_partner_present = `TRSPPRES` = 1) grouped by attended religions services (activity code 140101; [data dictionary](http://www.bls.gov/tus/lexiconwex2015.pdf)), Sunday (`dow_of_diary_day`, 1), Friday (6) or Saturday (7) only, for households with kids.  (Note that the most-naive interpretation understates the difference, significantly, due to contamination over which is the religious day).
7. Daily time spent directly engaging children (activity code [0301XX](http://www.bls.gov/tus/lexiconwex2015.pdf)), by sex.  (Read, understand, and adapt class example.  Use cps `sex` variable, 1 for men, 2 for women.)

## Create and Query a Table

The Chicago salaries file, it turns out, is not fit to be loaded into a database from the get-go.  First get it by

```
curl https://data.cityofchicago.org/api/views/xzkq-xp2w/rows.csv -o salaries.csv
```

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
