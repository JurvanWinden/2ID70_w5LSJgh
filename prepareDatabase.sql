-- this file prepares the database for our queries
-- think of indexing, adding keys, views, etc...

-- Add primary keys
ALTER TABLE Degrees
    ADD PRIMARY KEY (DegreeId)

ALTER TABLE Students
    ADD PRIMARY KEY (StudentId)

ALTER TABLE Teachers
    ADD PRIMARY KEY (TeacherId)

ALTER TABLE Courses
    ADD PRIMARY KEY (CourseId)

ALTER TABLE CourseOffers
    ADD PRIMARY KEY (CourseOfferId)

-- Add foreign keys
ALTER TABLE StudentRegistrationsToDegrees
    ADD FOREIGN KEY (StudentId)
    REFERENCES Students(StudentId)
    ADD FOREIGN KEY (DegreeId)
    REFERENCES Degrees(DegreeId)

ALTER TABLE Courses
    ADD FOREIGN KEY (DegreeId)
    REFERENCES Degrees(DegreeId)

ALTER TABLE CourseOffers
    ADD FOREIGN KEY (CourseId)
    REFERENCES Courses(CourseId)

ALTER TABLE TeacherAssignmentsToCourses
    ADD FOREIGN KEY (CourseOfferId)
    REFERENCES CourseOffers(CourseOfferId)
    ADD FOREIGN KEY (TeacherId)
    REFERENCES Teachers(TeacherId)

ALTER TABLE StudentAssistants
    ADD FOREIGN KEY (CourseOfferId)
    REFERENCES CourseOffers(CourseOfferId)
    ADD FOREIGN KEY (StudentRegistrationId)
    REFERENCES StudentRegistrationsToDegrees(StudentRegistrationId)

ALTER TABLE CourseRegistrations
    ADD FOREIGN KEY (CourseOfferId)
    REFERENCES CourseOffers(CourseOfferId)
    ADD FOREIGN KEY (StudentRegistrationId)
    REFERENCES StudentRegistrationsToDegrees(StudentRegistrationId)    

ANALYZE VERBOSE;
