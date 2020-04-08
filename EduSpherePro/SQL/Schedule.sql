	--------------------------------------------------------------
-------------Create Batch for Program---------------
CREATE TABLE EduSphere.ProgramBatch
(
BatchID INT IDENTITY(100,1) CONSTRAINT cstBatchPK PRIMARY KEY,
BatchCode VARCHAR(50),
ProgramID INT CONSTRAINT cstProgFK FOREIGN KEY REFERENCES EduSphere.Programs(ProgramID), 
StartDate DATETIME,
EndDate DATETIME,
)

SELECT * FROM EduSphere.ProgramBatch
DROP TABLE EduSphere.ProgramBatch
SELECT StudentID,FullName FROM EduSphere.Students WHERE BatchID='101'
------------------------------------------------------------------
CREATE PROCEDURE spAddBatch
@BatchCode VARCHAR(50),
@ProgramID INT, 
@StartDate DATETIME,
@EndDate DATETIME
AS
BEGIN
  INSERT INTO EduSphere.ProgramBatch (BatchCode,ProgramID,StartDate,EndDate) VALUES(@BatchCode,@ProgramID,@StartDate,@EndDate)
  ----Creat Date Template for Batch Schdeule----
  DECLARE @latestBatchID INT = (SELECT TOP 1 BatchID FROM EduSphere.ProgramBatch ORDER BY BatchID DESC)
  EXEC spCreateScheduleDates @latestBatchID,'90',@StartDate,@EndDate
END

DROP PROCEDURE spAddBatch 
---------------------------------------------------------------------------
CREATE TABLE EduSphere.BatchSchedule
(
DayID INT IDENTITY(100,1) CONSTRAINT cstSessionPK PRIMARY KEY,
BatchID INT CONSTRAINT cstBatchScheduleFK FOREIGN KEY REFERENCES EduSphere.ProgramBatch(BatchID),
CourseID INT CONSTRAINT cstCourseScheduleFK FOREIGN KEY REFERENCES EduSphere.Courses(CourseID),
SessionTitle VARCHAR(100),
SessionDetails VARCHAR(200),
SessionDate DATETIME,
SessionDay VARCHAR(10),
SessionTime VARCHAR(10),
)

SELECT * FROM EduSphere.BatchSchedule WHERE BatchID='101'
DROP TABLE EduSphere.BatchSchedule
UPDATE EduSphere.BatchSchedule SET CourseID='90'
-----Test Procedure for getting all Dates of Batch--
CREATE PROCEDURE spCreateScheduleDates
(
@BatchID INT,
@CourseID INT,
@StartDate AS DATE,
@EndDate AS DATE
)
AS
DECLARE @Current AS DATE = DATEADD(DD, 1, @StartDate);
WHILE @Current < @EndDate
BEGIN
   INSERT INTO EduSphere.BatchSchedule (BatchID,CourseID,SessionDate,SessionDay) VALUES(@BatchID,@CourseID,@Current,DATENAME(dw,@Current));
   SET @Current = DATEADD(DD, 1, @Current) -- add 1 to current day
END
-------------------------------------------------
DROP PROCEDURE spCreateScheduleDates
EXEC spCreateScheduleDates '100','2017-11-25','2017-12-25'
DROP PROCEDURE spCreateScheduleDates

--------------------UPDATE Batch Schedule----
CREATE PROCEDURE spUpdateBatchSchedule
@DayID INT,
@SessionTime VARCHAR(10),
@CourseID INT,
@SessionTitle VARCHAR(100),
@SessionDetails VARCHAR(200)
AS
BEGIN
    UPDATE EduSphere.BatchSchedule SET SessionTime=@SessionTime, CourseID=@CourseID, SessionTitle=@SessionTitle, SessionDetails=@SessionDetails WHERE DayID=@DayID
END

DROP PROCEDURE spUpdateBatchSchedule

-------------------------------------------------------
---------------------Assessments-------------------
CREATE TABLE EduSphere.Assessments
(
AssessmentID INT IDENTITY(100,1) CONSTRAINT cstAssessPK PRIMARY KEY,
CourseID INT CONSTRAINT cstAssessCourseID FOREIGN KEY REFERENCES Edusphere.Courses(CourseID),
BatchID INT CONSTRAINT cstAssessBatchID FOREIGN KEY REFERENCES Edusphere.ProgramBatch(BatchID),
AssessmentCode VARCHAR(20),
AssessmentTitle VARCHAR(100),
AssessmentDescription VARCHAR(200),
AssessmentDate DATETIME,
AssessmentDuration VARCHAR(20),
TotalMarks INT,
PassingMarks INT,
)

SELECT * FROM EduSphere.Assessments
DROP TABLE EduSphere.Assessments

CREATE PROCEDURE spCreateAssessment
(
@CourseID INT,
@BatchID INT,
@AssessmentCode VARCHAR(20),
@AssessmentTitle VARCHAR(100),
@AssessmentDescription VARCHAR(200),
@AssessmentDate DATETIME,
@AssessmentDuration VARCHAR(20),
@TotalMarks INT,
@PassingMarks INT
)
AS
BEGIN
  INSERT INTO EduSphere.Assessments (CourseID,BatchID,AssessmentCode,AssessmentTitle,AssessmentDescription,AssessmentDate,AssessmentDuration,TotalMarks,PassingMarks) 
                              VALUES(@CourseID,@BatchID,@AssessmentCode,@AssessmentTitle,@AssessmentDescription,@AssessmentDate,@AssessmentDuration,@TotalMarks,@PassingMarks)
  
  --------Add this Assessmment to all Students Selected BatchID----
  DECLARE @assessid INT = (SELECT TOP 1 AssessmentID FROM EduSphere.Assessments ORDER BY AssessmentID DESC) 
  EXEC spCreateStudentAssessments @BatchID,@assessid
END

DROP PROCEDURE spCreateAssessment
EXEC spCreateAssessment '100','100','101','COMM2017-100','Communication Skill Final','Final Exam','2018-10-01','2 Hours','100','40'
-------------------------------------------------

------------Students Assessment Records------
CREATE TABLE EduSphere.StudentAssessments
(
StudentAssessmentID uniqueidentifier NOT NULL DEFAULT newid() CONSTRAINT cstStdAssessPK PRIMARY KEY,
StudentID INT CONSTRAINT cstStudentAssessFK FOREIGN KEY REFERENCES EduSphere.Members(MemberID),
AssessmentID INT CONSTRAINT cstStdAssessmentFK FOREIGN KEY REFERENCES EduSphere.Assessments(AssessmentID),
MarksObtained INT,
MarksPercentage INT,
PassStatus VARCHAR(10) CONSTRAINT cstPassStatus CHECK(PassStatus IN('PASS','PROMOTED','DETAINED')),
Comments VARCHAR(100)
)

DROP TABLE EduSphere.StudentAssessments
SELECT * FROM EduSphere.StudentAssessments

ALTER TABLE EduSphere.StudentAssessments DROP CONSTRAINT cstPassStatus
ALTER TABLE EduSphere.StudentAssessments DROP COLUMN PassStaus
ALTER TABLE EduSphere.StudentAssessments ADD PassStatus VARCHAR(10) CONSTRAINT cstPassStatusChk CHECK(PassStatus IN('PASS','PROMOTED','DETAINED'))
ALTER TABLE EduSphere.StudentAssessments ADD Comments VARCHAR(100)

----Create Assessment Records for selected AssementID---
CREATE PROCEDURE spCreateStudentAssessments
(
@BatchID INT,
@AssessmentID INT
)
AS
BEGIN
   INSERT INTO EduSphere.StudentAssessments (StudentID,AssessmentID,MarksObtained,MarksPercentage,PassStatus,Comments) 
                                            (SELECT MemberID,@AssessmentID,0,0,'DETAINED','First Attempt' FROM EduSphere.Members WHERE BatchID=@BatchID)
END

DROP PROCEDURE spCreateStudentAssessments
EXEC spCreateStudentAssessments '101','100'
------------------------------------------------------------------
--------------Update Student Marks--------------
CREATE PROCEDURE spUpdateStudentAssessments
(
@StudentAssessmentID uniqueidentifier,
@MarksObtained INT,
@MarksPercentage INT,
@PassStatus VARCHAR(10),
@Comments VARCHAR(100)
)
AS
BEGIN
  UPDATE EduSphere.StudentAssessments SET MarksObtained=@MarksObtained,MarksPercentage=@MarksPercentage,PassStatus=@PassStatus,Comments=@Comments WHERE StudentAssessmentID=@StudentAssessmentID
END

DROP PROCEDURE spUpdateStudentAssessments 
-------------------------------------------------------
------Student AssessmentReport-----
-------------------------------------------
SELECT FullName,[COM-SJA2018A001-MID1],[2],[3],[4],[5]
     FROM
	(SELECT FullName,AssessmentCode,MarksObtained,MarksPercentage
	 FROM EduSphere.Assessments a 
	 JOIN  EduSphere.StudentAssessments sa ON a.AssessmentID=sa.AssessmentID
	 JOIN Edusphere.Students st ON sa.StudentID=st.StudentID
	 WHERE a.BatchID='101'
	 GROUP BY FullName,AssessmentCode,MarksObtained,MarksPercentage
	 ) AS SRC_TBL
	PIVOT
	(
	 MAX(MarksObtained)
	 FOR AssessmentCode IN ([COM-SJA2018A001-MID1],[2],[3],[4],[5])
	 )AS PIVOT_TABLE1;
	
 ----------------------------------
CREATE PROCEDURE spGetBatchAssessments
@BatchID INT,
@cols NVARCHAR(4000) OUTPUT
AS
BEGIN
  SELECT DISTINCT AssessmentCode INTO batchAssessments
                                 FROM  EduSphere.Assessments WHERE BatchID=@BatchID
                                 ORDER BY  AssessmentCode
  DECLARE @retcols NVARCHAR(4000)
  SELECT @cols=COALESCE(@cols + ',[' + AssessmentCode+ ']','[' +  AssessmentCode + ']') FROM  batchAssessments ORDER BY AssessmentCode
  DROP TABLE batchAssessments
END

DROP PROCEDURE spGetBatchAssessments

DECLARE @cols NVARCHAR(4000)
EXEC spGetBatchAssessments '101',@cols

SELECT * FROM batchAssessments
---------------------------------------------------

-----------------------------------------------
------------Students Attendance Records------
-----------------------------------------------
CREATE TABLE EduSphere.AttendanceSheets
(
AttendanceSheetID INT IDENTITY(100,1) CONSTRAINT cstAttendanceSheetPK PRIMARY KEY,
CourseID INT CONSTRAINT cstAttendaceSheetCourseID FOREIGN KEY REFERENCES Edusphere.Courses(CourseID),
BatchID INT CONSTRAINT cstAttendaceSheetBatchID FOREIGN KEY REFERENCES Edusphere.ProgramBatch(BatchID),
Topic VARCHAR(50),
ClassLocation VARCHAR(50),
AttendanceDate DATETIME,
AttendanceTakenByID VARCHAR(50)
)

SELECT * FROM  EduSphere.AttendanceSheets
DROP TABLE EduSphere.AttendanceSheets

CREATE PROCEDURE spCreateAttendanceSheet
(
@CourseID INT,
@BatchID INT,
@Topic VARCHAR(50),
@ClassLocation VARCHAR(50),
@AttendanceDate DATETIME,
@AttendanceTakenByID VARCHAR(50)
)
AS
BEGIN
   INSERT INTO EduSphere.AttendanceSheets (CourseID,BatchID,Topic,ClassLocation,AttendanceDate,AttendanceTakenByID) VALUES(@CourseID,@BatchID,@Topic,@ClassLocation,@AttendanceDate,@AttendanceTakenByID)
   --------Create List of Students beloging to the Batch-----
   DECLARE @AttendaceSheet INT = (SELECT TOP 1 AttendanceSheetID FROM EduSphere.AttendanceSheets ORDER BY AttendanceSheetID DESC)
   INSERT INTO EduSphere.StudentAttendance (AttendanceSheetID,StudentID,AttendanceStatus) 
                                            (SELECT @AttendaceSheet,MemberID,1 FROM EduSphere.Members WHERE BatchID=@BatchID)
END

DROP PROCEDURE  spCreateAttendanceSheet
----------------------------------------------------
CREATE TABLE EduSphere.StudentAttendance
(
StudentSwipeID uniqueidentifier NOT NULL DEFAULT newid() CONSTRAINT cstStudentSwipePK PRIMARY KEY,
AttendanceSheetID INT CONSTRAINT cstStudentAttendance FOREIGN KEY REFERENCES EduSphere.AttendanceSheets(AttendanceSheetID),
StudentID INT CONSTRAINT cstStudentAttendanceFK FOREIGN KEY REFERENCES EduSphere.Members(MemberID),
AttendanceStatus INT CONSTRAINT cstAttendaceStatusChk CHECK(AttendanceStatus IN(1,0))
)

SELECT * FROM EduSphere.StudentAttendance
DROP TABLE EduSphere.StudentAttendance
ALTER TABLE EduSphere.StudentAttendance DROP CONSTRAINT cstAttendaceStatusChk
ALTER TABLE EduSphere.StudentAttendance DROP COLUMN AttendanceStatus
ALTER TABLE EduSphere.StudentAttendance ADD AttendanceStatus INT CONSTRAINT cstAttendaceStatusChk CHECK(AttendanceStatus IN(1,0))

CREATE PROCEDURE spUpdateStudentAttendance
(
@StudentSwipeID uniqueidentifier,
@AttendanceStatus INT
)
AS
BEGIN
   UPDATE EduSphere.StudentAttendance SET AttendanceStatus=@AttendanceStatus WHERE StudentSwipeID=@StudentSwipeID
END

DROP PROCEDURE spUpdateStudentAttendance

-------Attendace Reports-----------------------------------------------

SELECT FullName,[Air Navigation],[Mass and Balance-Aeroplane],[Communication Skills],[4],[5]
     FROM
	(SELECT CourseTitle,FullName,SUM(s.AttendanceStatus) AS Present
	 FROM EduSphere.AttendanceSheets a 
	 JOIN EduSphere.StudentAttendance s ON a.AttendanceSheetID=s.AttendanceSheetID
	 JOIN EduSphere.Courses c ON a.CourseID=c.CourseID
	 JOIN Edusphere.Students sn ON s.StudentID=sn.StudentID
	 WHERE a.BatchID='101'
	 GROUP BY FullName,CourseTitle
	 ) AS SRC_TBL
	PIVOT
	(
	 MAX(Present)
	 FOR CourseTitle IN ([Air Navigation],[Mass and Balance-Aeroplane],[Communication Skills],[4],[5])
	 )AS PIVOT_TABLE;

 ----------------------------------
CREATE PROCEDURE spGetBatchCourses
@BatchID INT,
@cols NVARCHAR(4000) OUTPUT
AS
BEGIN
  SELECT DISTINCT CourseTitle INTO batchCourses
                                 FROM EduSphere.Courses WHERE ProgramID=(SELECT ProgramID FROM EduSphere.ProgramBatch WHERE BatchID=@BatchID)
                                 ORDER BY CourseTitle
  DECLARE @retcols NVARCHAR(4000)
  SELECT @cols=COALESCE(@cols + ',[' +CourseTitle+ ']','[' + CourseTitle + ']') FROM  batchCourses ORDER BY CourseTitle
  DROP TABLE batchCourses
END

DROP PROCEDURE spGetBatchCourses

DECLARE @cols NVARCHAR(4000)
EXEC spGetBatchCourses '101',@cols

SELECT * FROM batchCourses
---------------------------------------------------
------Detailed Attendance for Single Student------
SELECT CourseTitle,FullName,SUM(s.AttendanceStatus) AS Present
	 FROM EduSphere.AttendanceSheets a 
	 JOIN SELECT * FROM EduSphere.StudentAttendance s WHERE s.StudentID='5' ON a.AttendanceSheetID=s.AttendanceSheetID
	 JOIN EduSphere.Courses c ON a.CourseID=c.CourseID
	 JOIN Edusphere.Students sn ON s.StudentID=sn.StudentID
	 WHERE a.StudentID='101'
	 GROUP BY FullName,CourseTitle

	 SELECT CourseTitle,CAST(AttendanceDate AS DATE),FullName,AttendanceStatus FROM EduSphere.StudentAttendance sa 
	                                                           JOIN EduSphere.AttendanceSheets sh ON sh.AttendanceSheetID=sa.AttendanceSheetID
			                                                   JOIN EduSphere.Students s ON sa.StudentID=s.StudentID
															   JOIN EduSphere.Courses c ON sh.CourseID=c.CourseID
			WHERE sa.StudentID='5' ORDER BY sh.CourseID