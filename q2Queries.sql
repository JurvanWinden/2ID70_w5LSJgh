SELECT 0;
SELECT 0;
SELECT 0;
WITH StudentCount AS (SELECT COUNT(Students.StudentId) AS SC FROM Degrees, StudentRegistrationsToDegrees, StudentsWHERE Students.StudentId = StudentRegistrationsToDegrees.StudentId AND StudentRegistrationsToDegrees.DegreeId = Degrees.DegreeId AND Dept = %1% GROUP BY Degrees.Dept ), FemaleStudentCount AS ( SELECT COUNT(Students.StudentId) AS FSC FROM Degrees, StudentRegistrationsToDegrees, Students WHERE Students.StudentId = StudentRegistrationsToDegrees.StudentId AND StudentRegistrationsToDegrees.DegreeId = Degrees.DegreeId AND Gender = 'F' AND Degrees.Dept = %1% GROUP BY Degrees.Dept) SELECT (FSC / CAST(SC AS DECIMAL)) AS Percentage FROM FemaleStudentCount, StudentCount;
SELECT 0;
SELECT 0;
SELECT 0;
SELECT 0;