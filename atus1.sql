--Gaming Average (video) game playing (code 120307) for men and women (1 and 2), in three ten-year age groups from 20-29, 30-39, 40-49. Use edited_age and edited_sex so you can keep it to just two tables.
--Hint: you can do multiple group by variables.
--Hint: to group by age, use the fact that the default integer division in SQL is floor division.
---we need the tables - activities and roster
--Within activities we need the case_id, activity_code and duration and from the roster we need case_id, line_no,
--edited_age and edited_sex

--Women 20-30
SELECT
  AVG(gaming)
  FROM (
    SELECT
      case_id,
      SUM((activity_code/10000 = 12) * duration/60.) gaming
    FROM
      activities
    GROUP BY case_id
  )
JOIN roster ON
  roster.case_id = activities.case_id AND
  roster.line_no = 1
WHERE edited_age >20 AND
edited_age <30 AND
edited_sex = 2
GROUP BY
  gaming, sex
;

--Men 20-30
SELECT
  AVG(gaming)
  FROM (
    SELECT
      case_id,
      SUM((activity_code/10000 = 12) * duration/60.) gaming
    FROM
      activities
    GROUP BY case_id
  )
JOIN roster ON
  roster.case_id = activities.case_id AND
  roster.line_no = 1
WHERE edited_age >20 AND
edited_age <30 AND
edited_sex = 1
GROUP BY
  gaming, sex
;

--Women 30-40
SELECT
  AVG(gaming)
  FROM (
    SELECT
      case_id,
      SUM((activity_code/10000 = 12) * duration/60.) gaming
    FROM
      activities
    GROUP BY case_id
  )
JOIN roster ON
  roster.case_id = activities.case_id AND
  roster.line_no = 1
WHERE edited_age >30 AND
edited_age <40 AND
edited_sex = 2
GROUP BY
  gaming, sex
;

--Men 30-40
SELECT
  AVG(gaming)
  FROM (
    SELECT
      case_id,
      SUM((activity_code/10000 = 12) * duration/60.) gaming
    FROM
      activities
    GROUP BY case_id
  )
JOIN roster ON
  roster.case_id = activities.case_id AND
  roster.line_no = 1
WHERE edited_age >20 AND
edited_age <30 AND
edited_sex = 1
GROUP BY
  gaming, sex
;

--Women 40-50
SELECT
  AVG(gaming)
  FROM (
    SELECT
      case_id,
      SUM((activity_code/10000 = 12) * duration/60.) gaming
    FROM
      activities
    GROUP BY case_id
  )
JOIN roster ON
  roster.case_id = activities.case_id AND
  roster.line_no = 1
WHERE edited_age >40 AND
edited_age <50 AND
edited_sex = 2
GROUP BY
  gaming, sex
;

--Men 40-50
SELECT
  AVG(gaming)
  FROM (
    SELECT
      case_id,
      SUM((activity_code/10000 = 12) * duration/60.) gaming
    FROM
      activities
    GROUP BY case_id
  )
JOIN roster ON
  roster.case_id = activities.case_id AND
  roster.line_no = 1
WHERE edited_age >40 AND
edited_age <50 AND
edited_sex = 2
GROUP BY
  gaming, sex
;
