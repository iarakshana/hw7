--Education. State with the lowest fraction of high school graduates. Refer to the table in the "twisty" above -- HS is 39.
--If you haven't memorized the FIPS codes, you can find them here.
--lowest fraction of hs graduates

SELECT
  state_code,
  AVG(educational_attainment > 39) AS Hs
FROM cps
JOIN roster ON
  cps.case_id = roster.case_id AND
  cps.line_no = roster.line_no
WHERE
  educational_attainment > 0
GROUP BY state_code
ORDER BY Hs ASC
LIMIT 10;

-- Answer is FIPS code 54 for West Virginia
