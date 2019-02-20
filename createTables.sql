-- Commands to create all tables needed for our database

-- Teacher table
CREATE UNLOGGED TABLE Teachers (
    TeacherId INT,
    TeacherName VARCHAR(50),
    Address VARCHAR(200),
    BirthyearTeacher SMALLINT,
    Gender CHAR
);

-- Courses table
CREATE UNLOGGED TABLE Courses (
    CourseId INT,
    CourseName VARCHAR(50),
    CourseDescription VARCHAR(200),
    DegreeId INT,
    ECTS SMALLINT
);

-- CourseOffers table
CREATE UNLOGGED TABLE CourseOffers (
    CourseOfferId INT,
    CourseId INT,
    Year SMALLINT,
    Quartile SMALLINT
);

-- TeacherAssignmentsToCourses table
CREATE UNLOGGED TABLE TeacherAssignmentsToCourses (
    CourseOfferId INT,
    TeacherId INT
);

-- StudentAssistants table
CREATE UNLOGGED TABLE StudentAssistants (
    CourseOfferId INT,
    StudentRegistrationId INT
);

-- CourseRegistrations table
CREATE UNLOGGED TABLE CourseRegistrations (
    CourseOfferId INT,
    StudentRegistrationId INT,
    Grade SMALLINT
);
