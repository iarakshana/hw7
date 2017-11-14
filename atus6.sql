--[BONUS] Marriage and Religion. Respondent married average (spouse_or_partner_present = TRSPPRES = 1) grouped by attended religions services
--(activity code 1401XX; data dictionary). Consider only respondents reporting Sunday (dow_of_diary_day, 1), Friday (6)
--or Saturday (7), and households with kids. (Note that the most-naïve interpretation already dramatically understates the difference,
--due to contamination over which is the religious day. Many of the people in the no religious services category, actually did go...)
SELECT service,
  AVG(respondents.spouse_or_partner_present = 1) spouse
FROM (SELECT case_id,  SUM(activity_code/10000 = 14) >0 AS service
FROM activities GROUP BY case_id) religion
JOIN cps ON
  religion.case_id = cps.case_id AND
  cps.line_no = 1
JOIN respondents ON
  religion.case_id = respondents.case_id AND
  respondents.line_no = 1
WHERE
  respondents.number_of_hh_children > 0 AND
  years_education > 0 AND
  respondents.dow_of_diary_day IN (1, 6, 7)
GROUP BY service;

--answer
--0|0.624093847962382
--1|0.691116306253653 = Married
