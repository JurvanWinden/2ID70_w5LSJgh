-- this file should load all data in the previously-created tables
-- the data will be stored under /mnt/ramdisk/tables
-- for example, the Students file is under /mnt/ramdisk/tables/Students.table
-- The files of the folder are as follows (mind the lower-case/upper-case):
--   CourseOffers.table, CourseRegistrations.table, Courses.table, Degrees.table
--   StudentAssistants.table, StudentRegistrationsToDegrees.table, Students.table
--   TeacherAssignmentsToCourses.table, Teachers.table
-- Don't forget to analyze at the end. It can make a difference in query performance.

COPY Courses(CourseId, CourseName, CourseDescription, DegreeId, ECTS) FROM '/home/jur/Documents/2ID70/tables-light/tables/Courses.table' DELIMITER ',' CSV HEADER;

COPY CourseOffers(CourseOfferId, CourseId, Year, Quartile) FROM '/home/jur/Documents/2ID70/tables-light/tables/CourseOffers.table' DELIMITER ',' CSV HEADER;

COPY TeacherAssignmentsToCourses(CourseOfferId, TeacherId) FROM '/home/jur/Documents/2ID70/tables-light/tables/TeacherAssignmentsToCourses.table' DELIMITER ',' CSV HEADER;

COPY StudentAssistants(CourseOfferId, StudentRegistrationId) FROM '/home/jur/Documents/2ID70/tables-light/tables/StudentAssistants.table' DELIMITER ',' CSV HEADER;

COPY CourseRegistrations(CourseOfferId, StudentRegistrationId, Grade) FROM '/home/jur/Documents/2ID70/tables-light/tables/CourseRegistrations.table' DELIMITER ',' CSV HEADER;

COPY Degrees(DegreeId, Dept, DegreeDescription, TotalECTS) FROM '/home/jur/Documents/2ID70/tables-light/tables/Degrees.table' DELIMITER ',' CSV HEADER;

COPY Students(StudentId, StudentName, Address, BirthyearStudent, Gender) FROM '/home/jur/Documents/2ID70/tables-light/tables/Students.table' DELIMITER ',' CSV HEADER;

COPY StudentRegistrationsToDegrees(StudentRegistrationId, StudentId, DegreeId, RegistrationYear) FROM '/home/jur/Documents/2ID70/tables-light/tables/StudentRegistrationsToDegrees.table' DELIMITER ',' CSV HEADER;

COPY Teachers(TeacherId, TeacherName, Address, BirthyearTeacher, Gender) FROM '/home/jur/Documents/2ID70/tables-light/tables/Teachers.table' DELIMITER ',' CSV HEADER;

ANALYZE VERBOSE;
