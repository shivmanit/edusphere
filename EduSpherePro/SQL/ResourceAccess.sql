
CREATE TABLE EduSphere.LearningTokens
(
TokenID INT IDENTITY(100,1) CONSTRAINT cstPerID PRIMARY KEY,
CourseID INT CONSTRAINT cstCidToken FOREIGN KEY REFERENCES EduSphere.Courses(CourseID),
MemberID INT CONSTRAINT cstMemIDToken FOREIGN KEY REFERENCES EduSphere.Members(MemberID),
StartDate DATETIME,
EndDate DATETIME,
TokenStatus VARCHAR(10) CONSTRAINT cstChkTokenStatus CHECK(TokenStatus IN('YES','NO'))
)

DROP TABLE EduSphere.LearningTokens
SELECT * FROM EduSphere.LearningTokens

------------------TEST----------------------------------------------------------------------------------
SELECT * FROM EduSphere.CourseVideos v
         JOIN EduSphere.LearningTokens t ON v.CourseID=t.CourseID 
         WHERE t.TokenStatus='NO' and t.MemberID=(SELECT MemberID FROM EduSphere.Members WHERE Email='shivmanit@yahoo.com')

------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE spCreateLearningTokens
@MemberID INT
AS
BEGIN
	-------DELETE EARLIER ASSIGNED TOKENS-------
	DELETE FROM EduSphere.LearningTokens WHERE MemberID=@MemberID
	INSERT INTO EduSphere.LearningTokens (MemberID,CourseID,StartDate,EndDate,TokenStatus) 
	(SELECT @MemberID,CourseID,GETDATE(),GETDATE(),'NO' FROM EdusPhere.Courses WHERE ProgramID=(SELECT ProgramID FROM EduSphere.Members WHERE MemberID=@MemberID))
END

DROP PROCEDURE spCreateLearningTokens
EXEC spCreateLearningTokens 100
------------------------------------------------------------------------------------
CREATE PROCEDURE spUpdateLearningToken
@TokenID INT,
@TokenStatus VARCHAR(10)
AS
BEGIN
	UPDATE  EduSphere.LearningTokens SET StartDate=GETDATE(),EndDate=DATEADD(DD, 10, GETDATE()), TokenStatus=@TokenStatus WHERE TokenID=@TokenID
END

DROP PROCEDURE spUpdateLearningToken 

EXEC spUpdateLearningToken 100,'YES' 