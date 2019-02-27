--The 8 queries to be answered
-- Q1
-- Runs in approx 9 seconds... to be runned 100 times
SELECT CourseName, Grade
FROM CourseRegistrations as cr, StudentRegistrationsToDegrees as sd, CourseOffers as co, Courses as c
WHERE StudentId = 3831503 AND sd.DegreeId = 5123 -- replace this with %1%, %2%
AND sd.StudentRegistrationId = cr.StudentRegistrationId
AND cr.CourseOfferId = co.CourseOfferId
AND co.CourseId = c.CourseId
AND	cr.Grade > 5
ORDER BY (co.Year, co.Quartile, co.CourseOfferId);

CREATE MATERIALIZED VIEW PassedCoursesPerDegree AS (
    SELECT StudentId, sd.DegreeId, CourseName, Grade
    FROM CourseRegistrations as cr, StudentRegistrationsToDegrees as sd, CourseOffers as co, Courses as c
    WHERE sd.StudentRegistrationId = cr.StudentRegistrationId
    AND c.DegreeId = sd.DegreeId
    AND cr.CourseOfferId = co.CourseOfferId
    AND co.CourseId = c.CourseId
    AND	cr.Grade > 5
    ORDER BY (co.Year, co.Quartile, co.CourseOfferId)
);

CREATE MATERIALIZED VIEW PassedCoursesPerDegree(StudentId, CourseId, Grade) AS (
    SELECT StudentId, CourseId, Grade
    FROM CourseRegistrations as cr, StudentRegistrationsToDegrees as sd, CourseOffers as co
    WHERE sd.StudentRegistrationId = cr.StudentRegistrationId
    AND cr.CourseOfferId = co.CourseOfferId
    AND	cr.Grade > 5
);


SELECT CourseName, Grade
FROM PassedCoursesPerDegree
WHERE StudentId = 3831503 AND DegreeId = 5123;

-- Q2 Select all excellent students GPA high, no failed courses in a degree
-- Select all students that have completed a degree
SELECT StudentRegistrationsToDegrees.StudentRegistrationID, Degrees.DegreeId FROM StudentRegistrationsToDegrees, Students, Degrees, Courses, CourseOffers, CourseRegistrations
WHERE StudentRegistrationsToDegrees.StudentId = Students.StudentId
AND Degrees.DegreeId = StudentRegistrationsToDegrees.DegreeId
AND TotalECTS = 200
AND Courses.DegreeId = StudentRegistrationsToDegrees.DegreeId
AND CourseOffers.CourseId = Courses.CourseId
AND CourseRegistrations.CourseOfferId = CourseOffers.CourseOfferId
AND CourseRegistrations.Grade >= 5;

SELECT StudentRegistrationsToDegrees.StudentRegistrationId, CourseOffers.CourseOfferId, Grade FROM StudentRegistrationsToDegrees, CourseRegistrations, Courses, Degrees, CourseOffers
WHERE StudentRegistrationsToDegrees.StudentRegistrationId = CourseRegistrations.StudentRegistrationId
AND Courses.CourseId = CourseOffers.CourseId
AND CourseRegistrations.CourseOfferId = CourseOffers.CourseOfferId
AND StudentRegistrationsToDegrees.DegreeId = Courses.DegreeId
AND Degrees.DegreeId = Courses.DegreeId
AND Degrees.TotalECTS = 200
AND NOT EGrade < 5

-- Q3
-- needed: all active students, percentage female

--Q4 Give percentage of female students for all degrees of a department
-- Runs in approx 2.8 seconds... is to be runned 10 times
WITH StudentCount AS (
    SELECT COUNT(Students.StudentId) AS SC FROM Degrees, StudentRegistrationsToDegrees, Students
    WHERE Students.StudentId = StudentRegistrationsToDegrees.StudentId
    AND StudentRegistrationsToDegrees.DegreeId = Degrees.DegreeId
    AND Dept = 'be to thin' -- replace this with var
    GROUP BY Degrees.Dept
),
FemaleStudentCount AS (
    SELECT COUNT(Students.StudentId) AS FSC FROM Degrees, StudentRegistrationsToDegrees, Students
    WHERE Students.StudentId = StudentRegistrationsToDegrees.StudentId
    AND StudentRegistrationsToDegrees.DegreeId = Degrees.DegreeId
    AND Gender = 'F'
    AND Degrees.Dept = 'be to thin' -- replace this with %1%
    GROUP BY Degrees.Dept
)
SELECT (FSC / CAST(SC AS DECIMAL) * 100) AS Percentage FROM FemaleStudentCount, StudentCount;

--Q5


--Q6 excellent students 2.0, highest grade of each course, etc
-- Runs in approx 53 seconds... is to be runned 3 times
WITH BestGrades AS (
    SELECT CourseOffers.CourseOfferId, MAX(Grade) AS Best FROM CourseOffers, CourseRegistrations
    WHERE CourseOffers.CourseOfferId = CourseRegistrations.CourseOfferId
    AND Year = 2018
    AND Quartile = 1
    GROUP BY CourseOffers.CourseOfferId
)
SELECT StudentId, COUNT(CourseRegistrations.StudentRegistrationId) AS NumberOfCoursesWhereExcellent FROM StudentRegistrationsToDegrees, CourseRegistrations, BestGrades
WHERE CourseRegistrations.CourseOfferId = BestGrades.CourseOfferId
AND StudentRegistrationsToDegrees.StudentRegistrationId = CourseRegistrations.StudentRegistrationId
AND Grade = BestGrades.Best
GROUP BY StudentId, CourseRegistrations.StudentRegistrationId;

-- Q7
SELECT sd.DegreeId, BirthYearStudent, Gender, AVG(Grade)
FROM CourseRegistrations as cr, CourseOffers as co, Courses as c, Students as s, StudentRegistrationsToDegrees as sd
WHERE cr.CourseOfferId = co.CourseOfferId
AND	co.CourseId = c.CourseId
AND cr.StudentRegistrationId = sd.StudentRegistrationId
AND s.StudentId = sd.StudentId
GROUP BY CUBE(sd.DegreeId, BirthYearStudent, Gender);

-- Q8
-- Q8 List all CourseOffers which did not have enough student assistants
-- Count Students for each CourseOffer
SELECT CourseRegistrations.CourseOfferId, COUNT(CourseRegistrations.StudentRegistrationId) as StudentCount FROM CourseRegistrations
GROUP BY CourseRegistrations.CourseOfferId;
-- Count StudentAssistants for each CourseOffer
SELECT CourseOfferId, COUNT(StudentAssistants.StudentRegistrationId) as StudentAssistantCount FROM StudentAssistants
GROUP BY StudentAssistants.CourseOfferId;
