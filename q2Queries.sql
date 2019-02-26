--The 8 queries to be answered
SELECT AVG(Grade) FROM CourseRegistrations WHERE CourseRegistrations.StudentRegistrationId=3;

-- Q2
SELECT Students.StudentId, AVG(Grade) FROM Students, CourseRegistrations, StudentRegistrationsToDegrees
WHERE Students.StudentId = StudentRegistrationsToDegrees.StudentId AND
CourseRegistrations.StudentRegistrationId = StudentRegistrationsToDegrees.StudentRegistrationId

-- Select all students that have completed a degree
SELECT StudentRegistrationsToDegrees.StudentRegistrationID, Degrees.DegreeId FROM StudentRegistrationsToDegrees, Students, Degrees WHERE
StudentRegistrationsToDegrees.StudentId = Students.StudentId AND
Degrees.DegreeId = StudentRegistrationsToDegrees.DegreeId AND
TotalECTS = 200;

SELECT AVG(Grade) FROM Students, CourseRegistrations WHERE CourseRegistrations.StudentRegistrationId;


SELECT J.StudentId FROM CourseRegistrations
    INNER JOIN (
SELECT Students.StudentId, S.StudentRegistrationID FROM Students
    INNER JOIN (
        SELECT Students.StudentId, StudentRegistrationID, Degrees.DegreeId FROM StudentRegistrationsToDegrees, Students, Degrees WHERE
        StudentRegistrationsToDegrees.StudentId = Students.StudentId AND
        Degrees.DegreeId = StudentRegistrationsToDegrees.DegreeId AND
        TotalECTS = 200
    ) as S
 ON Students.StudentId = S.StudentId
 WHERE NOT EXISTS (
     SELECT 1 FROM Courses, CourseOffers, CourseRegistrations
     WHERE Courses.DegreeId = S.DegreeId AND
     CourseOffers.CourseOfferId = CourseRegistrations.CourseOfferId AND
     CourseRegistrations.StudentRegistrationId = S.StudentRegistrationId AND
     CourseRegistrations.Grade < 5
 )
) AS J
ON CourseRegistrations.StudentRegistrationID = J.StudentRegistrationID;
GROUP BY J.StudentId;
