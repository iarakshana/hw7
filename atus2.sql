--Employment. Tabulate whether or not the respondent worked last week as a fraction (1 = yes, 2 = no; exclude retired/disabled/unable 3-5 and no answer;
--see TUFWK here).
-- Group on the presence of a partner (spouse_or_partner_present: spouse 1 or partner 2, v. none 3; see TRSPPRES in the codebook).
SELECT
  spouse_or_partner_present,
  AVG(worked_last_week = 1) Worked
FROM
  respondents
JOIN
  cps
ON
  respondents.case_id = cps.case_id AND
  cps.line_no = 1
  WHERE (spouse_or_partner_present<3)
GROUP BY
  spouse_or_partner_present
;
