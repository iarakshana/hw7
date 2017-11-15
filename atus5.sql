--Human Capital Investments. Average daily time spent directly engaging children in hours
--(activity codes 0301XX or 180381), by respondent sex.
-- You should require that there be children in the household, and that the respondent is
-- in the labor force (edited_labor_force_status = 1 or 2).
--Use roster edited_sex variable, 1 for men, 2 for women. (Read, understand, and adapt this example;
--N.B. that the python example at p.
--34 of the lecture relied on pandas for the second group by.)
SELECT
  respondents.case_id,
  cps.years_education AS 'Education',
  AVG((activity_code/100 IN (301, 302, 303))
        * duration/60.) AS 'Engagement'
FROM respondents
INNER JOIN cps ON
  respondents.case_id = cps.case_id AND
  respondents.line_no = cps.line_no
INNER JOIN activities ON
  respondents.case_id = activities.case_id
WHERE
  number_of_hh_children > 0 AND
  edited_labor_force_status < 3
GROUP BY respondents.case_id;
