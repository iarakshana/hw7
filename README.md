# Homework 7: Structured Query Language  

The homework is due, November 2 at 1:30am.  You can accept it, [here](https://classroom.github.com/assignment-invitations/de7acce809fc99f051f534d4b454ba0a).

## American Time Use Survey

### Data Description

The American Time Use Survey is a stupendous compendium of how Americans actually spend their time.  You can find documentation for the 2003-2015 files [here](https://www.bls.gov/tus/atusintcodebk0315.pdf).
Every _activity_ a _respondent_ performs on a "diary day," is recorded in very narrow categories (activity "lexicon" [here](https://www.bls.gov/tus/lexiconnoex0315.pdf)).  In addition, basic information is recorded for a _roster_ of everyone on the same houshold,
  and the data are linked to the Current Population Survey (CPS), another Census/BLS product.

Taking all years into account, it gets pretty big.  Just the CSV files are around 1.5GB.
But the structure of the files is basically a database, and so I have loaded them together into (somewhat smaller, 200 MB) sqlite database.
Since the codes can be somewhat hard to interpret, 
  I have edited the variable names (but not values) to make them more readable.
Have a look at `.schema` to see all the variables.

There are four tables, which may be merged on the `case_id` and, where appropriate `line_no = 1` (see #1).
1. **`roster`** contains a list of attributes of the people in a file.  
   * You will use this file to get the `edited_sex` and `edited_age` of respondents and family members.
   * It is very important to note that the respondent her/himself is ALWAYS `line_no = 1`.  This means that if you want to ask about the `activities` people of a given age are doing, you must require `line_no = 1` for your join.
2. **`respondents`** contains descriptive data on time spent in various activities, as well as household characteristics and some labor force participation stats.
3. **`activities`** lists the minutes spent in each activity, as enumerated in the [lexicon](https://www.bls.gov/tus/lexiconnoex0315.pdf).  &nbsp;<details><summary>Relevant Activity Codes.</summary>

   | Code  | Activity |
   | --- | --- |
   | 120307 | Playing Games (incl. computers) |
   | 02XXXX | Housework |
   | 140101 | Relgious Services |
   | 0301XX | Direct Engagement of HH Children: Playing or Ed. |
   | 180381 | Travel for HH Children |

4. **`cps`** (Current Population Survey) supplements the activity in `respondents` and `roster`, with data from this additional survey.  In particular, you might use `educational_attainment` and `family_income`. &nbsp;<details><summary>Educational Attainment Details</summary>
  
   Alternatively, consult `PEEDUCA` in the [codebook](https://www.bls.gov/tus/atuscpscodebk0315.pdf).
  
   | Code  | Educational Level |
   | --- | --- |
   | 31 | Less than 1st grade  |
   | 32 | 1st, 2nd, 3rd, or 4th grade |
   | 33 | 5th or 6th grade |
   | 34 | 7th or 8th grade |
   | 35 | 9th grade |
   | 36 | 10th grade |
   | 37 | 11th grade |
   | 38 | 12th grade - no diploma |
   | 39 | High school graduate - diploma or equivalent (GED) |
   | 40 | Some college but no degree |
   | 41 | Associate degree - occupational/vocational |
   | 42 | Associate degree - academic program |
   | 43 | Bachelor's degree (BA, AB, BS, etc.) |
   | 44 | Master's degree (MA, MS, MEng, MEd, MSW, etc.) |
   | 45 | Professional school degree (MD, DDS, DVM, etc.) |
   | 46 | Doctoral degree (PhD, EdD, etc.) |
 
   <details>

You can download the database from my [Google Drive](https://drive.google.com/uc?id=0B7GlTQC1GP2qUUZ3M3RCbl9raTg&export=download).  Google will warn you that the file is too large to be scanned for viruses.  It's OK.  It's a database.

### Exercises

Each of your scripts must be written in a file named `atus1.sql`, `atus2.sql`, etc.
You will read answers off of these tables and place them in `SOLUTIONS`, before completing a quiz on Canvas.

Please remember throughout, that when using the tables `roster` or `cps`, you must require that the `line_no` value be 1.
This has nothing to do with SQL generically, and just represents the fact that there are many people in a household, and the respondent and activities correspond to person "1."

Always exclude negative values (non-responses!!).


1. Who likes games? Average (video) game playing (code 120307) for men and women (1 and 2), in three ten-year age groups from 20-29, 30-39, 40-49.  Use `edited_age` and `edited_sex` so you can keep it to just two tables.
   * Hint: you can do multiple `group by` variables.
   * Hint: to group by age, use the fact that the default integer division in SQL is floor division.
2. Working statWhether or not the respondent worked last week as a fraction (1 = yes, 2 = no; exclude retired/disabled/unable 3-5 and no answer; see TUFWK [here](https://www.bls.gov/tus/atusintcodebk0315.pdf)).
   Group on the presence of a partner (`spouse_or_partner_present`: spouse 1 or partner 2, v. none 3; see TRSPPRES in the [codebook](http://www.bls.gov/tus/atusintcodebk15.pdf)). 
3. State with the lowest fraction of high school graduates.  Refer to the table in the "twisty" above -- HS is 39.  If you haven't memorized the FIPS codes, you can find them [here](https://www.census.gov/geo/reference/ansi_statetables.html).
4. Average marital status (`spouse_or_partner_present`; again 1 or 2, v. 3), by `educational_attainment`.
   * Use respondent `spouse_or_partner_present` and cps `educational_attainment`.  Require that the educational attainment be non-negative.
5. Average housework (activity code 02XXXX, i.e., all those starting by 02, see the [lexicon](http://www.bls.gov/tus/lexiconwex2015.pdf) -- use floor division, which is the default).  Group by `edited_sex` and `educational_attainment`.
6. Respondent married average (`spouse_or_partner_present` = `TRSPPRES` = 1) grouped by attended religions services (activity code 140101; [data dictionary](http://www.bls.gov/tus/lexiconwex2015.pdf)).  Consider only respondents reporting Sunday (`dow_of_diary_day`, 1), Friday (6) or Saturday (7), and households with kids.  (Note that the most-naïve interpretation already dramatically understates the difference, due to contamination over which is the religious day).
7. Average daily time spent directly engaging children in hours (activity codes 0301XX or 180381), by respondent sex. 
   You should require that there be children in the household, and that the respondent is in the labor force (`edited_labor_force_status` = 1 or 2).
   Use roster `edited_sex` variable, 1 for men, 2 for women.  (Read, understand, and adapt [this example](https://github.com/harris-ippp/lectures/blob/master/05/ex/child_engagement_ed.sql); N.B. that the python example at p. 34 of the lecture relied on pandas for the second group by.)

## Create and Query a Table

The Chicago salaries file, it turns out, is not fit to be loaded into a database from the get-go.  First get it by

```
curl https://data.cityofchicago.org/api/views/xzkq-xp2w/rows.csv -o salaries.csv
```

This is a great moment for some practice with `sed` (you could even try `-i` for 'in place'.)

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

1. The average salary of firefighters in the city.
2. Total expenditures on salaries in the Mayor's office.
3. Number of people working in the three largest departments.

Save your queries as `s1.sql`, `s2.sql`, `s3.sql`, and mark the responses in SOLUTIONS.

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
