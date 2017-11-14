--Marriage and Education. Average marital status (spouse_or_partner_present; again 1 or 2, v. 3), by educational_attainment.
--Use respondent spouse_or_partner_present and cps educational_attainment. Require that the educational attainment be non-negative.
SELECT cps.educational_attainment, AVG((spouse_or_partner_present) IN (1,2))
FROM respondents
INNER JOIN cps ON
respondents.case_id = cps.case_id AND
respondents.line_no = cps.line_no
WHERE cps.educational_attainment >0
GROUP BY cps.educational_attainment;

/* 31|0.424418604651163
32|0.508982035928144
33|0.569444444444444
34|0.331771321462043
35|0.242193598750976
36|0.24385697339434
37|0.268710847345862
38|0.391089108910891
39|0.533061333096811
40|0.498214049477444
41|0.595829991980754
42|0.578700850486873
43|0.644173261644415
44|0.649812866323      = We only need 44
45|0.692018072289157
46|0.670095518001469
*/
