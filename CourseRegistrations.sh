CREATE UNLOGGED TABLE CourseRegistrations (
    CourseOfferId INT REFERENCES courseOffers(CourseId),
    StudentRegistrationId INT REFERENCES StudentRegistrationsToDegrees(StudentRegistrationId),
    Grade SMALLINT
)
