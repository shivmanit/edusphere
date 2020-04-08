
create schema Evaluations

create table Evaluations.ObjQuestions
(
SessionID int,
QuestionID int identity(1,1) constraint cstPkQid PRIMARY KEY,
CourseID INT constraint cstFK FOREIGN KEY references EduSphere.Courses(CourseID),
Question varchar(200),
CorrectAnswer varchar(100) 
)

sp_help 'Evaluations.ObjQuestions'
select * from Evaluations.ObjQuestions WHERE CourseID=121

select * FROM Evaluations.ObjQuestions WHERE CourseID=121 AND Question='The cardio vascular system is responsible for transportation of________ throughout the body.'

select * FROM Evaluations.ObjQuestions WHERE CorrectANswer LIKE '%(4) Para%'
UPDATE Evaluations.ObjQuestions SET CourseID='111', Question='The cardio vascular system is responsible for transportation of________ throughout the body.',CorrectAnswer='All of the above' WHERE QuestionID='110'

DELETE FROM Evaluations.ObjQuestions WHERE CourseID=121 AND QuestionID=1151
alter table Evaluations.ObjQuestions drop column SessionID

alter table Evaluations.ObjQuestions alter column CorrectAnswer varchar(100)
SELECT * FROM Evaluations.ObjQuestions WHERE QuestionID=4042 
DELETE FROM Evaluations.ObjQuestions WHERE QuestionID=4042
truncate table Evaluations.ObjQuestions
drop table Evaluations.ObjQuestions
alter table Evaluations.ObjQuestions alter column CorrectAnswer varchar(100)
SELECT TOP 1 * FROM Evaluations.ObjQuestions Q join Evaluations.ObjAnswers A on Q.QuestionID=A.QuestionID ORDER BY Q.QuestionID DESC

SELECT Q.CourseID,Q.QuestionID,Q.Question,CorrectAnswer,OptionA,OptionB,OptionC,OptionD
		FROM Evaluations.ObjQuestions Q join Evaluations.ObjAnswers A on Q.QuestionID=A.QuestionID 
										JOIN EduSphere.Courses C ON Q.CourseID=C.CourseID WHERE Q.CourseID=109 AND Question LIKE '%If there is more bleeding during menses in women then neurotherapy treatment is%'

SELECT Q.CourseID,Q.QuestionID,Q.Question,CorrectAnswer,OptionA,OptionB,OptionC,OptionD
		FROM Evaluations.ObjQuestions Q join Evaluations.ObjAnswers A on Q.QuestionID=A.QuestionID  
										JOIN EduSphere.Courses C ON Q.CourseID=C.CourseID WHERE Q.CourseID=109 AND OptionC='(4) Para	'


create procedure spManageObjQuestions
@ManageCmd varchar(10),
@SessionID int,
@CourseID INT,
@QuestionID int,
@Question varchar(200),
@CorrectAnswer varchar(100),
@OptionA varchar(100),
@OptionB varchar(100),
@OptionC varchar(100),
@OptionD varchar(100)
AS
BEGIN
if @ManageCmd='AddNewQ'
    BEGIN
	insert into Evaluations.ObjQuestions values(@SessionID,@CourseID,@Question,@CorrectAnswer)
	DECLARE @QId INT = (SELECT TOP 1 QuestionID FROM Evaluations.ObjQuestions ORDER BY QuestionID DESC)
	insert into Evaluations.ObjAnswers (SessionID,QuestionID,CourseID, OptionA, OptionB,OptionC,OptionD) VALUES(@SessionID,@Qid,@CourseID, @OptionA, @OptionB,@OptionC,@OptionD) 
	--update Evaluations.ObjQuestions set Question='Edit Question' where Question='NewQuestion'----
	END
if @ManageCmd='UpdateQ'
    BEGIN
	update Evaluations.ObjQuestions set SessionID=@SessionID,Question=@Question,CorrectAnswer=@CorrectAnswer where QuestionID=@QuestionID 
	update Evaluations.ObjAnswers set SessionID=@SessionID,OptionA=@OptionA,OptionB=@OptionB,OptionC=@OptionC,OptionD=@OptionD where QuestionID=@QuestionID 
	END
END

drop procedure spManageObjQuestions

insert Evaluations.ObjQuestions values(1,51001,'Test Question1','OptionA')
insert Evaluations.ObjQuestions values(1,51001,'Test Question2','OptionB')
insert Evaluations.ObjQuestions values(1,51001,'Test Question3','OptionC')
insert Evaluations.ObjQuestions values(1,51001,'Test Question4','OptionD')
insert Evaluations.ObjQuestions values(1,51001,'Test Question5','OptionA')
insert Evaluations.ObjQuestions values(1,51001,'Test Question6','OptionC')

truncate table Evaluations.ObjQuestions
---------------------------------------------------------------------------------
create table Evaluations.ObjAnswers
(
SessionID varchar(20),
OptionsID int identity(1,1) constraint cstPkOid PRIMARY KEY, 
QuestionID int constraint cstFkQid FOREIGN KEY references Evaluations.ObjQuestions(QuestionID),
CourseID INT constraint cstFKey FOREIGN KEY references EduSphere.Courses(CourseID),
OptionA varchar(100),
OptionB varchar(100),
OptionC varchar(100),
OptionD varchar(100),
)

alter table Evaluations.ObjAnswers alter column OptionA varchar(100) 
alter table Evaluations.ObjAnswers alter column OptionB varchar(100) 
alter table Evaluations.ObjAnswers alter column OptionC varchar(100) 
alter table Evaluations.ObjAnswers alter column OptionD varchar(100)


drop table Evaluations.ObjAnswers
insert Evaluations.ObjAnswers values(1,1,'OptionA','OptionB','OptionC','OptionD')
insert Evaluations.ObjAnswers values(1,2,'OptionA','OptionB','OptionC','OptionD')
insert Evaluations.ObjAnswers values(1,3,'OptionA','OptionB','OptionC','OptionD')
insert Evaluations.ObjAnswers values(1,4,'OptionA','OptionB','OptionC','OptionD')
insert Evaluations.ObjAnswers values(1,5,'OptionA','OptionB','OptionC','OptionD')
insert Evaluations.ObjAnswers values(1,6,'OptionA','OptionB','OptionC','OptionD')
select * from Evaluations.ObjAnswers WHERE OptionA='Deficiency in erythrocyte production'
truncate table Evaluations.ObjAnswers

UPDATE Evaluations.ObjAnswers SET QuestionID=3091 WHERE OptionsID=687
UPDATE Evaluations.ObjAnswers SET QuestionID=3092 WHERE OptionsID=688

UPDATE Evaluations.ObjAnswers SET QuestionID=33,OptionA='Deficiency in erythrocyte production',OptionB='Increased erythrocyte loss',OptionC='Increased erythropoiesis',OptionD='A and B' WHERE OptionsID='96'
SELECT * FROM Evaluations.ObjAnswers WHERE CourseID='121'
DELETE FROM Evaluations.ObjAnswers WHERE QuestionID='4042'
DELETE FROM Evaluations.ObjAnswers WHERE OptionsID='1067'
DELETE FROM Evaluations.ObjAnswers WHERE OptionsID>='380' AND OptionsID<='382'
DELETE FROM Evaluations.ObjAnswers WHERE OptionsID>='384' AND OptionsID<='386'
DELETE FROM Evaluations.ObjAnswers WHERE OptionsID>='391' AND OptionsID<='392'
DELETE FROM Evaluations.ObjAnswers WHERE OptionsID>='422' AND OptionsID<='424'

create table Evaluations.ObjTestPaper
(
TestTitle VARCHAR(50),
TestID INT constraint cstTestID FOREIGN KEY REFERENCES Evaluations.TestConfigParameters(TestID),
CourseID INT constraint cstFkTest FOREIGN KEY references EduSphere.Courses(CourseID),
QuestionID int identity(1,1) constraint cstPkTest PRIMARY KEY, 
Question varchar(200),
CorrectAnswer varchar(100),
OptionA varchar(100),
OptionB varchar(100),
OptionC varchar(100),
OptionD varchar(100)
)
select * from Evaluations.ObjTestPaper WHERE TestID='1025'  AND OptionA LIKE '%Glyco%'OR OptionB LIKE '%Glyco%' OR OptionC LIKE '%Glyco%'
drop table Evaluations.ObjTestPaper
ALTER TABLE Evaluations.ObjTestPaper ADD TestTitle VARCHAR(50)
ALTER TABLE Evaluations.ObjTestPaper ADD TestID INT constraint cstTestID FOREIGN KEY REFERENCES Evaluations.TestConfigParameters(TestID) 

alter table Evaluations.ObjTestPaper alter column OptionA varchar(100) 
alter table Evaluations.ObjTestPaper alter column OptionB varchar(100) 
alter table Evaluations.ObjTestPaper alter column OptionC varchar(100) 
alter table Evaluations.ObjTestPaper alter column OptionD varchar(100)
alter table Evaluations.ObjTestPaper alter column CorrectAnswer varchar(100) 
select * from Evaluations.ObjTestPaper WHERE OptionD LIKE '%Low BP%'
DELETE FROM Evaluations.ObjTestPaper WHERE QuestionID=190

SELECT TestID,TestTitle FROM Evaluations.ObjTestPaper

create procedure spCreateTest
@CourseID1 INT,
@CourseID2 INT,
@CourseID3 INT,
@CourseID4 INT,
@TestTitle VARCHAR(100),
@TestDate DATETIME,
@TestClosureDate DATETIME,
@TestDuration INT,
@QCount INT
AS
BEGIN
 ----------remove old entries---
 truncate table Evaluations.ObjTestPaper
 ------INSERT NEW CONFIG Details----
 EXECUTE spInsertTestConfigParameters @TestTitle,@TestDate,@TestClosureDate,@TestDuration,@QCount
 ----------EXTRACT NEWLY CREATED ID for insertion ito testpaper-----
 DECLARE @testid INT = (SELECT TOP 1 TestID FROM Evaluations.TestConfigParameters ORDER BY TestID DESC)
 
 INSERT INTO  Evaluations.ObjTestPaper (CourseID,Question,CorrectAnswer,OptionA,OptionB,OptionC,OptionD,TestID,TestTitle) 
								(SELECT q.CourseID,q.Question,q.CorrectAnswer,a.OptionA,a.OptionB,a.OptionC,a.OptionD,@testid,@TestTitle FROM Evaluations.ObjQuestions q join Evaluations.ObjAnswers a on q.QuestionID=a.QuestionID 
								WHERE a.CourseID=@CourseID1 OR a.CourseID=@CourseID2 OR a.CourseID=@CourseID3 OR a.CourseID=@CourseID4)
 
 select * from Evaluations.ObjTestPaper where QuestionID=5
 ----Update TestConfig with MaxQID from Paper----
 UPDATE Evaluations.TestConfigParameters SET MaxQID =(SELECT MAX(QuestionID) FROM Evaluations.ObjTestPaper) WHERE TestID=@testid
 ------------Add All Registered Users as TestCandidates
 INSERT INTO Evaluations.CandidateTestAttendance (TestID,CandidateID,AttendanceStatus,RegisterationDate) (SELECT @TestID,MemberID,'UNSUBSCRIBED',GETDATE() FROM EduSphere.Members)
END

execute spCreateTest 102
drop procedure spCreateTest

SELECT TOP 1 * FROM Evaluations.TestConfigParameters c JOIN Evaluations.ObjTestPaper p ON c.TestID=p.TestID  ORDER BY c.TestID DESC

SELECT TOP 1 * FROM Evaluations.TestConfigParameters ORDER BY TestID DESC

------------------------------------------------------------------------------------------------
----------------------TestConfigurationParameters-------------
CREATE TABLE Evaluations.TestConfigParameters
(
TestID INT IDENTITY(1000,1) CONSTRAINT cstTestConfig PRIMARY KEY,
TestTitle VARCHAR(100),
TestDate DATETIME,
TestDuration INT,
QCount INT,
TestCreationDate DATETIME,
TestStatus VARCHAR(10) CONSTRAINT cstTestStatus CHECK(TestStatus IN('Open','Closed')),
TestClosureDate DATETIME,
MaxQID INT
)

ALTER TABLE Evaluations.TestConfigParameters ADD TestStatus VARCHAR(10) CONSTRAINT cstTestStatus CHECK(TestStatus IN('Open','Closed'))
ALTER TABLE Evaluations.TestConfigParameters ADD TestTitle VARCHAR(100)
ALTER TABLE Evaluations.TestConfigParameters ADD TestClosureDate DATETIME
ALTER TABLE Evaluations.TestConfigParameters ADD MaxQID INT

DROP TABLE Evaluations.TestConfigParameters

SELECT * FROM Evaluations.TestConfigParameters WHERE TestID=1028
SELECT TOP 1 * FROM Evaluations.TestConfigParameters WHERE TestCreationDate <= GETDATE() ORDER BY TestID DESC
SELECT TestID FROM Evaluations.TestConfigParameters c JOIN Evaluations.ObjTestPaper p ON c.TestID=p.TestID

UPDATE Evaluations.TestConfigParameters SET TestClosureDate ='2019-06-24 22:00:00.000' WHERE TestID=1028

CREATE PROCEDURE spInsertTestConfigParameters
@TestTitle VARCHAR(100),
@TestDate DATETIME,
@TestClosureDate DATETIME,
@TestDuration INT,
@QCount INT
AS
BEGIN
	INSERT INTO Evaluations.TestConfigParameters (TestTitle,TestDate,TestClosureDate,TestDuration,QCount,TestCreationDate,TestStatus) VALUES(@TestTitle,@TestDate,@TestClosureDate,@TestDuration,@QCount,GETDATE(),'Open')
END

DROP PROCEDURE spInsertTestConfigParameters



---------------------------------------------------------------------------------------------
create table Evaluations.OnlineTestResults
(
OnlineTestRecordID int IDENTITY(1,1) constraint cstOTR PRIMARY KEY,
CandidateID INT,
Score int,
MaxMarks int,
PercentageMarks decimal(19,2),
TestID INT,
TestDate DateTime,
TimeTaken INT
)


ALTER TABLE Evaluations.OnlineTestResults ADD TimeTaken INT 
SELECT * FROM Evaluations.TestConfigParametersCHECK

SELECT r.TestID, TestTitle FROM Evaluations.OnlineTestResults r JOIN Evaluations.TestConfigParameters c ON r.TestID=c.TestID GROUP BY r.TestID,TestTitle
sp_help 'Evaluations.TestConfigParameters'
SELECT * FROM Evaluations.OnlineTestResults WHERE TestID=1034 AND CandidateID=315 AND TestID=1025
DELETE FROM Evaluations.OnlineTestResults WHERE TestID='1020'
drop table Evaluations.OnlineTestResults

create procedure spInsertOnlineTR
@CandidateID INT,
@Score int,
@MaxMarks int,
@PercentageMarks decimal(19,2),
@TestID INT,
@TestDate DateTime,
@TimeTaken INT
AS
BEGIN
 ---INSERT Result only if candidate has not appeared for the same test previously ie status is only SUBSCRIBED. This is to prevent acting on Submit more than once using back button in browser----
 DECLARE @testattendance varchar(50) = (SELECT AttendanceStatus FROM Evaluations.CandidateTestAttendance WHERE CandidateID=@CandidateID AND TestID=@TestID)
 IF(@testattendance='SUBSCRIBED')
	BEGIN
		INSERT INTO Evaluations.OnlineTestResults (CandidateID,Score,MaxMarks,PercentageMarks,TestID,TestDate,TimeTaken) values(@CandidateID,@Score,@MaxMarks,@PercentageMarks,@TestID,@TestDate,@TimeTaken)
		UPDATE Evaluations.CandidateTestAttendance SET AttendanceStatus='APPEARED',AttendanceDate=GETDATE() WHERE CandidateID=@CandidateID AND TestID=@TestID
	END
END

drop procedure spInsertOnlineTR
UPDATE Evaluations.CandidateTestAttendance SET AttendanceStatus='UNSUBSCRIBED'
----------------------------------------------TestCompletion-----------


---------------------------------CandidateOnlineTest Particiaption Status-----
CREATE TABLE Evaluations.CandidateTestAttendance
(
	RecordID INT IDENTITY(100,1) CONSTRAINT cstRecID PRIMARY KEY,
	TestID INT CONSTRAINT cstTeID FOREIGN KEY REFERENCES Evaluations.TestConfigParameters(TestID),
	CandidateID INT CONSTRAINT cstCID FOREIGN KEY REFERENCES EduSphere.Members(MemberID),
	AttendanceStatus VARCHAR(20) CONSTRAINT cstAttnSt CHECK(AttendanceStatus IN('UNSUBSCRIBED','SUBSCRIBED','APPEARED')),
	RegisterationDate DATETIME,
	AttendanceDate DATETIME 
)

ALTER TABLE Evaluations.CandidateTestAttendance DROP CONSTRAINT cstAttnSt
ALTER TABLE Evaluations.CandidateTestAttendance DROP COLUMN AttendanceStatus
ALTER TABLE Evaluations.CandidateTestAttendance ADD AttendanceStatus VARCHAR(20) CONSTRAINT cstAttnSt CHECK(AttendanceStatus IN('UNSUBSCRIBED','SUBSCRIBED','APPEARED'))

SELECT * FROM Evaluations.CandidateTestAttendance WHERE TestID=1034 AND (AttendanceStatus='SUBSCRIBED' OR  AttendanceStatus='APPEARED') 
SELECT * FROM Evaluations.CandidateTestAttendance WHERE CandidateID=321

DROP TABLE Evaluations.CandidateTestAttendance
UPDATE Evaluations.CandidateTestAttendance SET AttendanceStatus='SUBSCRIBED' WHERE CandidateID=315 AND TestID=1028

SELECT TOP 1 FullName,MemberID,AttendanceStatus,p.TestID,CandidateID FROM Evaluations.CandidateTestAttendance a 
                                                                    JOIN Evaluations.ObjTestPaper p ON a.TestID=p.TestID
                                                                    JOIN EduSphere.Members n ON a.CandidateID=n.MemberID
                                                                    WHERE n.Email='shivmanit@yahoo.com'


SELECT * FROM Evaluations.CandidateTestAttendance a
                                                        JOIN EduSphere.Members n ON a.CandidateID=n.MemberID
                                                        WHERE a.TestID=1029 ORDER BY AttendanceStatus


CREATE PROCEDURE spRegisterForTest
@TestID INT,
@CandidateID INT
AS
BEGIN
	INSERT INTO Evaluations.CandidateTestAttendance(TestID,CandidateID,AttendanceStatus,RegisterationDate) VALUES(@TestID,@CandidateID,'SUBSCRIBED',GETDATE())
END

EXECUTE spRegisterForTest '1002','315'

--------------------------------------------OnEvaluations.OnlineTestTransactlineTestTransactions------------------------------
CREATE TABLE Evaluations.OnlineTestTransaction
(
TransactionID INT IDENTITY(100,1) CONSTRAINT cTID PRIMARY KEY,
CandidateID INT CONSTRAINT cstCanID FOREIGN KEY REFERENCES EduSphere.Members(MemberID),
TestID INT CONSTRAINT cstTesID FOREIGN KEY REFERENCES Evaluations.TestConfigParameters(TestID),
CourseID INT,
QuestionID int, 
Question varchar(200),
CorrectAnswer varchar(100),
OptionA varchar(100),
OptionB varchar(100),
OptionC varchar(100),
OptionD varchar(100),
CandidateSelection VARCHAR(100),
EvaluationStatus VARCHAR(20) CONSTRAINT cstES CHECK(EvaluationStatus IN('SKIPPED','CORRECT','INCORRECT','NA')) 
)

sp_help 'Evaluations.OnlineTestTransaction'

ALTER TABLE Evaluations.OnlineTestTransaction DROP CONSTRAINT cstES
ALTER TABLE Evaluations.OnlineTestTransaction DROP COLUMN EvaluationStatus
ALTER TABLE Evaluations.OnlineTestTransaction ADD EvaluationStatus VARCHAR(20) CONSTRAINT cstES CHECK(EvaluationStatus IN('SKIPPED','CORRECT','INCORRECT','NA')) 
alter table Evaluations.OnlineTestTransaction alter column OptionA varchar(100) 
alter table Evaluations.OnlineTestTransaction alter column OptionB varchar(100) 
alter table Evaluations.OnlineTestTransaction alter column OptionC varchar(100) 
alter table Evaluations.OnlineTestTransaction alter column OptionD varchar(100)
alter table Evaluations.OnlineTestTransaction alter column CorrectAnswer varchar(100) 
alter table Evaluations.OnlineTestTransaction alter column CandidateSelection varchar(100) 

SELECT * FROM Evaluations.OnlineTestTransaction WHERE TestID='1044' AND CandidateID='273'
SELECT * FROM Evaluations.OnlineTestTransaction WHERE CandidateID='321' AND TestID='1025' AND EvaluationStatus!='SKIPPED'
SELECT * FROM Evaluations.OnlineTestTransaction WHERE CandidateID='320' AND TestID='1025' AND EvaluationStatus!='SKIPPED'
SELECT * FROM Evaluations.OnlineTestTransaction WHERE Question='The nerves responsible for smooth muscle contraction and secretion of digestive juices are'
SELECT * FROM Evaluations.OnlineTestTransaction WHERE Question='Which of the following is not a function of the stomach'
SELECT * FROM Evaluations.OnlineTestTransaction WHERE Question='Which of the following is not a function of the stomach'
SELECT * FROM Evaluations.OnlineTestTransaction WHERE Question='Smooth muscle contraction and secretion of digestive juices is caused by'

DROP TABLE Evaluations.OnlineTestTransaction

-----------CREATE QUESTION PAPAER AND CLEAN IF HALF ATTEMPTED without submission---------
CREATE PROCEDURE spOnlineTestTransaction
@CandidateID INT,
@TestID INT
AS
BEGIN
--------------------------CREATE ANSWER SHEET For CandidateID and TestID if it doesnt exist-----------------
	if NOT EXISTS (SELECT TOP 1 CandidateID FROM Evaluations.OnlineTestTransaction WHERE TestID=@TestID AND CandidateID=@CandidateID)
	BEGIN
		INSERT INTO Evaluations.OnlineTestTransaction (CandidateID,TestID,CourseID,QuestionID,Question,CorrectAnswer,OptionA,OptionB,OptionC,OptionD,CandidateSelection,EvaluationStatus)
	                                              (SELECT @CandidateID,p.TestID,p.CourseID,p.QuestionID,p.Question,p.CorrectAnswer,p.OptionA,p.OptionB,p.OptionC,p.OptionD,NULL,'SKIPPED' FROM Evaluations.ObjTestPaper p)  
	END
------------------IF Candidate Answer Sheet is half completed without final submission, ensure that its cleaned. set previously answer questions to SKIPPED---
	if EXISTS (SELECT TOP 1 CandidateID FROM Evaluations.CandidateTestAttendance WHERE TestID=@TestID AND CandidateID=@CandidateID AND AttendanceStatus='SUBSCRIBED')
	BEGIN
		UPDATE Evaluations.OnlineTestTransaction SET CandidateSelection=NULL,EvaluationStatus='SKIPPED' WHERE TestID=@TestID AND CandidateID=@CandidateID
	END
END



EXECUTE spOnlineTestTransaction 315,1002
DROP PROCEDURE spOnlineTestTransaction
SELECT TOP 1 CandidateID FROM Evaluations.CandidateTestAttendance WHERE TestID=1005 AND CandidateID=315 AND AttendanceStatus='SUBSCRIBED'


CREATE PROCEDURE spUpdateOnlineTestTransaction
@TransactionID INT,
@CandidateSelection VARCHAR(100),
@EvaluationStatus VARCHAR(20) 
AS
BEGIN
	UPDATE Evaluations.OnlineTestTransaction SET CandidateSelection=@CandidateSelection,EvaluationStatus=@EvaluationStatus WHERE TransactionID=@TransactionID
END

DROP PROCEDURE spUpdateOnlineTestTransaction

-----------------------INSERT FROM EXCEL-------
create table Evaluations.TestObjQuestions
(
SessionID int,
QuestionID int identity(1,1) constraint cstPkTQid PRIMARY KEY,
CourseID INT constraint cstTFK FOREIGN KEY references EduSphere.Courses(CourseID),
Question varchar(200),
CorrectAnswer varchar(20) 
)

SELECT * FROM Evaluations.TestObjQuestions
