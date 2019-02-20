-- this file should load all data in the previously-created tables
-- the data will be stored under /mnt/ramdisk/tables
-- for example, the Students file is under /mnt/ramdisk/tables/Students.table
-- The files of the folder are as follows (mind the lower-case/upper-case):
--   CourseOffers.table, CourseRegistrations.table, Courses.table, Degrees.table
--   StudentAssistants.table, StudentRegistrationsToDegrees.table, Students.table
--   TeacherAssignmentsToCourses.table, Teachers.table
-- Don't forget to analyze at the end. It can make a difference in query performance.
-- Example:

COPY Degrees(DegreeId, Dept, DegreeDescription, TotalECTS) FROM '/mnt/ramdisk/tables/Degrees.table' DELIMITER ',' CSV HEADER;
COPY Students(StudentId, StudentName, Address, BirthyearStudent, Gender) FROM '/mnt/ramdisk/tables/Students.table' DELIMITER ',' CSV HEADER;
COPY StudentRegistrationToDegrees(StudentRegistrationId, StudentId, DegreeId, RegistrationYear) FROM '/mnt/ramdisk/tables/StudentRegistrationsToDegrees.table' DELIMITER ',' CSV HEADER;
COPY Teachers(TeacherId, TeacherName, Address, BirthyearTeacher, Gender) FROM '/mnt/ramdisk/tables/Teachers.table' DELIMITER ',' CSV HEADER;
ANALYZE VERBOSE;
