/* [BONUS] Housework. Average daily housework in hours (activity code 02XXXX, i.e., all those starting by 02, see the
 lexicon -- use floor division, which is the default). Group by edited_sex and educational_attainment.
*/
SELECT
  cps.educational_attainment ed,
  roster.edited_sex sex,
  ROUND(AVG(housework), 2) housework,
  COUNT(housework) "(N)"
FROM (
  SELECT
    case_id,
    AVG((activity_code/10000 = 2) * duration/60.) housework
  FROM
    activities
  GROUP BY case_id
) avg_activities
JOIN cps ON
  cps.case_id = avg_activities.case_id AND
  cps.line_no = 1
JOIN roster ON
  avg_activities.case_id = roster.case_id AND
  roster.line_no = 1

GROUP BY
  ed, sex
