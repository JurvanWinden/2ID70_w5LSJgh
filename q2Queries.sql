SELECT CourseName, Grade FROM PassedCoursesPerStudent AS P, Courses AS C WHERE P.StudentId = %1% AND P.DegreeId = %2% AND P.CourseId = C.CourseId;
SELECT StudentId FROM StudentGPA WHERE GPA >= %1%;
WITH ActiveStudents AS ( SELECT P.StudentId, D.DegreeId FROM StudentRegistrationsToDegrees AS SD, Degrees AS D, PassedCoursesPerStudent AS P, Courses AS C WHERE P.StudentId = SD.StudentId AND SD.DegreeId = D.DegreeId AND P.CourseId = C.CourseId AND D.DegreeId = C.DegreeId GROUP BY P.StudentId, TotalECTS, D.DegreeId HAVING SUM(P.ECTS) < TotalECTS), ActiveFemaleStudents AS ( SELECT A.DegreeId, COUNT(A.StudentId) AS Active FROM ActiveStudents AS A INNER JOIN Students ON Students.StudentId =  A.StudentId WHERE Gender = 'F' GROUP BY A.DegreeId) SELECT A.DegreeId, (AF.Active / CAST (COUNT(A.StudentId) AS DECIMAL)) AS Percentage FROM ActiveStudents AS A, ActiveFemaleStudents AS AF WHERE A.DegreeId = AF.DegreeId GROUP BY A.DegreeId, AF.Active;
WITH StudentCount AS (SELECT COUNT(Students.StudentId) AS SC FROM Degrees, StudentRegistrationsToDegrees, Students WHERE Students.StudentId = StudentRegistrationsToDegrees.StudentId AND StudentRegistrationsToDegrees.DegreeId = Degrees.DegreeId AND Dept = %1% GROUP BY Degrees.Dept ), FemaleStudentCount AS ( SELECT COUNT(Students.StudentId) AS FSC FROM Degrees, StudentRegistrationsToDegrees, Students WHERE Students.StudentId = StudentRegistrationsToDegrees.StudentId AND StudentRegistrationsToDegrees.DegreeId = Degrees.DegreeId AND Gender = 'F' AND Degrees.Dept = %1% GROUP BY Degrees.Dept) SELECT (FSC / CAST (SC AS DECIMAL) ) AS Percentage FROM FemaleStudentCount, StudentCount;
SELECT 0;
WITH BestGrades AS (SELECT CourseOffers.CourseOfferId, MAX(Grade) AS Best FROM CourseOffers, CourseRegistrations WHERE CourseOffers.CourseOfferId = CourseRegistrations.CourseOfferId AND Year = 2018 AND Quartile = 1 GROUP BY CourseOffers.CourseOfferId) SELECT StudentId, COUNT(CourseRegistrations.StudentRegistrationId) AS NumberOfCoursesWhereExcellent FROM StudentRegistrationsToDegrees, CourseRegistrations, BestGrades WHERE CourseRegistrations.CourseOfferId = BestGrades.CourseOfferId AND StudentRegistrationsToDegrees.StudentRegistrationId = CourseRegistrations.StudentRegistrationId AND Grade = BestGrades.Best GROUP BY StudentId HAVING COUNT(CourseRegistrations.StudentRegistrationId) >= 1;
SELECT 0;
WITH SC AS (SELECT CourseRegistrations.CourseOfferId, COUNT(CourseRegistrations.StudentRegistrationId) as StudentCount FROM CourseRegistrations GROUP BY CourseRegistrations.CourseOfferId ), AC AS (SELECT CourseOfferId, COUNT(StudentAssistants.StudentRegistrationId) as StudentAssistantCount FROM StudentAssistants GROUP BY StudentAssistants.CourseOfferId) SELECT Courses.CourseName, CourseOffers.Year, CourseOffers.Quartile FROM Courses, CourseOffers, SC, AC WHERE SC.CourseOfferId = AC.CourseOfferId AND AC.CourseOfferId = CourseOffers.CourseOfferId AND CourseOffers.CourseId = Courses.CourseId AND (AC.StudentAssistantCount * 50 < SC.StudentCount) ORDER BY CourseOffers.CourseOfferId;


