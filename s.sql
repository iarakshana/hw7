--Question 1
SELECT Position, AVG(Salary) avgsal FROM chicago
WHERE (Position == "FIREFIGHTER")
GROUP BY Department;
--Answer
--92610.090

--Question 2
SELECT SUM(Salary) FROM chicago
WHERE (Department = "MAYOR'S OFFICE");

--Answer
--7719741.0

--Question 3
SELECT COUNT(Last), Department FROM chicago
GROUP BY Department
ORDER BY Last DESC;

--Answer
--Police - 13061
--Fire - 4837
--OEMC - 2121
