
--------------------ProgramGroups for management----------------------------------------------------------------------
CREATE TABLE EduSphere.ProgramGroups
(
  ProgramGroupID INT IDENTITY(100,1) CONSTRAINT cstProgGrpPK PRIMARY KEY,
  ProgramGroup VARCHAR(50),
  ProgramGroupDescription VARCHAR(100),
)

DROP TABLE EduSphere.ProgramGroups
SELECT * FROM EduSphere.ProgramGroups
--Add Proxy--
SET IDENTITY_INSERT EduSphere.ProgramGroups ON
 INSERT INTO EduSphere.ProgramGroups(ProgramGroupId,ProgramGroup) VALUES('90','Proxy-ProgramGroup')
SET IDENTITY_INSERT EduSphere.ProgramGroups OFF

INSERT INTO EduSphere.ProgramGroups(ProgramGroup,ProgramGroupDescription) VALUES('Finance','Banking & Financial Management')
INSERT INTO EduSphere.ProgramGroups(ProgramGroup,ProgramGroupDescription) VALUES('Aviation','Aviation')
----Programs/Degress/Certificates offerred-----
create table EduSphere.Programs
(
ProgramID int identity(100,1) constraint cstProgPK PRIMARY KEY,
ProgramGroupID INT CONSTRAINT cstPgGr FOREIGN KEY REFERENCES EduSphere.ProgramGroups(ProgramGroupID),
ProgramTitle varchar(100),
ProgramDescription varchar(200),
ProgramVision varchar(500),
ProgramMission varchar(500),
ProgramCost INT,
ProgramDuration INT,
ProgramImagePath VARCHAR(50)
)

DROP TABLE EduSphere.Programs
SELECT * FROM EduSphere.Programs

UPDATE EduSphere.Programs SET ProgramImagePath='Images/Products/finance.jpg' WHERE ProgramID=100
UPDATE EduSphere.Programs SET ProgramImagePath='Images/Products/BankingFinance.jpg' WHERE ProgramID=101

UPDATE EduSphere.Programs SET ProgramTitle='Aviation Management & Hospitality-Domestic', ProgramImagePath='Images/Products/cabincrew1.jpg', ProgramDescription='Cabin crew are also known as flight attendants, air hostesses, and flight stewards who are primarily on board an aircraft for the safety and welfare of the passengers, and secondly for their comfort.' WHERE ProgramID='102'
UPDATE EduSphere.Programs SET ProgramTitle='Aviation Management & Hospitality-International', ProgramImagePath='Images/Products/cabincrew2.jpg', ProgramDescription='The cabin crew & other aviation management jobs might take you into the clouds, but you need some down-to-earth skills to work as a successful cabin crew or aviation industry professional.' WHERE ProgramID='103'
UPDATE EduSphere.Programs SET ProgramGroupID='101', ProgramImagePath='Images/Products/cpl1.jpg' WHERE ProgramID='104'
UPDATE EduSphere.Programs SET ProgramGroupID='101' WHERE ProgramID='102'
--Add Proxy--
SET IDENTITY_INSERT EduSphere.Programs ON
 INSERT INTO EduSphere.Programs(ProgramID,ProgramGroupID,ProgramTitle,ProgramDescription) VALUES('90','90','Proxy','ProxyProgram')
SET IDENTITY_INSERT EduSphere.Programs OFF

 INSERT INTO EduSphere.Programs(ProgramGroupID,ProgramTitle,ProgramDescription) VALUES('100','Diploma in Financial Management','For 12th pass students, Job Oriented Course, Working with agency companies till course completion')
 INSERT INTO EduSphere.Programs(ProgramGroupID,ProgramTitle,ProgramDescription) VALUES('100','Diploma in Banking & Financial Management','For Graduate students, Job Oriented Course, Placement in Banks & Financial Companies')
 ALTER TABLE EduSphere.Programs ADD ProgramCost INT
 ALTER TABLE EduSphere.Programs ADD ProgramDuration INT
 ALTER TABLE EduSphere.Programs ADD ProgramImagePath VARCHAR(50)
  
---------Add New Program----------
create procedure spInsertPrograms
@ProgramTitle varchar(100),
@ProgramDescription varchar(200),
@ProgramVision varchar(500),
@ProgramMission varchar(500)
AS
BEGIN
	INSERT INTO EduSphere.Programs (ProgramGroupID,ProgramTitle,ProgramDescription,ProgramVision,ProgramMission) values('101',@ProgramTitle,@ProgramDescription,@ProgramVision,@ProgramMission)
END

drop procedure  spInsertPrograms

UPDATE EduSphere.Programs SET ProgramTitle='Cabin Crew' WHERE ProgramID=100

--------Courses/Subjects/Labs/Trainings conducted under the program-------------------
create table EduSphere.Courses
(
CourseID INT IDENTITY(100,1) CONSTRAINT cstCoursePK PRIMARY KEY,
ProgramID int CONSTRAINT cstPrg FOREIGN KEY REFERENCES EduSphere.Programs(ProgramID),
CourseTitle varchar(50),
CourseDescription VARCHAR(200),
Credits int,
AcadYear varchar(10),
AcadSem varchar(10),
Regulation varchar(10),
LectureHours int,
TPDHours int
)

--Add Proxy--
SET IDENTITY_INSERT EduSphere.Courses ON
 INSERT INTO EduSphere.Courses(CourseID,ProgramID,CourseTitle) VALUES('90','90','ProxyCourse')
SET IDENTITY_INSERT EduSphere.Courses OFF

DROP TABLE EduSphere.Courses

SELECT * FROM EduSphere.Courses
ALTER TABLE EduSphere.Courses ADD CourseDescription VARCHAR(200)

create procedure spAddCourse
@CourseTitle varchar(50),
@Credits int,
@ProgramID int,
@LectureHours int,
@TPDHours  int
AS
BEGIN
	INSERT INTO EduSphere.Courses (CourseTitle, Credits,ProgramID,LectureHours,TPDHours) VALUES(@CourseTitle, @Credits,@ProgramID,@LectureHours,@TPDHours)
END

drop procedure spAddCourse
----------------------------------------------
create procedure spUpdateCourse
@CourseID INT,
@CourseTitle varchar(50),
@CourseDescription VARCHAR(200),
@Credits int
AS
BEGIN
  UPDATE EduSphere.Courses set CourseTitle=@CourseTitle,CourseDescription=@CourseDescription,Credits=@Credits where CourseID=@CourseID
END

drop procedure spUpdateCourse
---------------------------------------------------
----Course Videos-->
CREATE TABLE EduSphere.CourseVideos
(
VideoID INT IDENTITY(100,1) CONSTRAINT cstVidId PRIMARY KEY,
CourseID INT constraint cstCourseVidFK FOREIGN KEY REFERENCES EduSphere.Courses(CourseID),
ProgramID INT,
VideoTitle VARCHAR(100),
VideoDescription VARCHAR(300),
VideoPath VARCHAR(300)
)

SELECT * FROM EduSphere.CourseVideos
DROP TABLE EduSphere.CourseVideos 

ALTER TABLE EduSphere.CourseVideos ALTER COLUMN VideoDescription VARCHAR(300) 

INSERT INTO EduSphere.CourseVideos (CourseID,ProgramID,VideoTitle, VideoDescription,VideoPath)
                                 VALUES(100,100,'Principles & Practice of Banking','Introduction','<iframe width="560" height="315" src="https://www.youtube.com/embed/_YW9vxgDw58" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>')
INSERT INTO EduSphere.CourseVideos (CourseID,ProgramID,VideoTitle, VideoDescription,VideoPath)
                                 VALUES(100,100,'Dry Skin','Tips for dry skin and face','<iframe width="560" height="315" src="https://www.youtube.com/embed/zdsCWRY39wc?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>')
INSERT INTO EduSphere.CourseVideos (CourseID,ProgramID,VideoTitle, VideoDescription,VideoPath)
                                 VALUES(100,100,'Dry Skin Makeup','Tutorial for dry skin Makeup','<iframe width="560" height="315" src="https://www.youtube.com/embed/EhupWtwQ8cM?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>')


INSERT INTO EduSphere.CourseVideos (CourseID,ProgramID,VideoTitle, VideoDescription,VideoPath)
                                 VALUES(100,101,'Introduction to Aviation','Introduction','<iframe width="560" height="315" src="http://speedjetaviation.in/Artifacts/docs/introaviation.mp4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>')

UPDATE EduSphere.CourseVideos SET VideoPath='<iframe width="560" height="315" src="http://speedjetaviation.in/Artifacts/docs/introaviation.mp4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>' WHERE VideoID=100
UPDATE EduSphere.CourseVideos SET VideoPath='http://speedjetaviation.in/Artifacts/docs/introaviation.mp4' WHERE VideoID=100
UPDATE EduSphere.CourseVideos SET VideoPath='https://eduspherestorage.blob.core.windows.net/learnart/IntroAviation.mp4' WHERE VideoID=104

CREATE PROCEDURE spAddCourseVideo
@CourseID INT,
@ProgramID INT,
@VideoTitle VARCHAR(100), 
@VideoDescription VARCHAR(200),
@VideoPath VARCHAR(100)
AS
BEGIN
 INSERT INTO EduSphere.CourseVideos (CourseID,ProgramID,VideoTitle, VideoDescription,VideoPath)
                                 VALUES(@CourseID,@ProgramID,@VideoTitle,@VideoDescription,@VideoPath)
END


DELETE FROM EduSphere.CourseVideos WHERE VideoID>=103

CREATE PROCEDURE spDeleteVideo
@VideoID INT
AS
BEGIN
	DELETE FROM EduSphere.CourseVideos WHERE VideoID=@VideoID
END

--------------COURSE MATERIAL---------
create table EduSphere.CourseDocs
(
DocID int IDENTITY(1,1) constraint cstDocPK PRIMARY KEY,
CourseID INT constraint cstCourseFK FOREIGN KEY REFERENCES EduSphere.Courses(CourseID),
ProgramID int,
ArtifactType varchar(100),
ArtifactPath varchar(100),
ArtifactName varchar(100)
)


alter table   EduSphere.CourseDocs add ArtifactName varchar(100)

select * from EduSphere.CourseDocs
truncate table EduSphere.CourseDocs
drop table EduSphere.CourseDocs

CREATE PROCEDURE spDeleteDoc
@DocID INT
AS
BEGIN
	DELETE FROM EduSphere.CourseDocs WHERE DocID=@DocID
END
-----------------------Add New Document----
create procedure spInsertNewDocument
@CourseID INT,
@ProgramID int,
@ArtifactType varchar(100),
@ArtifactPath varchar(100),
@ArtifactName varchar(100)
AS
BEGIN
	INSERT INTO  EduSphere.CourseDocs VALUES(@CourseID, @ProgramID, @ArtifactType, @ArtifactPath,@ArtifactName)
END

drop procedure spInsertNewDocument

-------NBA-CO-------
--------------------------------------------------------------------------------------------------------
create table CO
(
CoID int identity(1,1) constraint cstPK primary key,
CourseID INT constraint cstCourseID foreign key references EduSphere.Courses(CourseID),
CourseOutcome varchar(50),
CourseOutcomeDescription varchar(300),
)

select * from CO
truncate table CO
drop table CO

create procedure spInsertCO
@CourseID varchar(20),
@CourseOutcome varchar(50)='Course Outcome',
@CourseOutcomeDescription varchar(300)='CO Description'
AS
BEGIN
 insert into CO values(@CourseID,@CourseOutcome,@CourseOutcomeDescription)
END

drop procedure  spInsertCO
execute spInsertCO

insert into CO values('51001','CO1English','The students would be able to write business poroposal')
--------------------------------------
create procedure spUpdateCO
@CoID int,
@CourseOutcome varchar(10),
@CourseOutcomeDescription varchar(200)
AS
BEGIN
 update CO set CourseOutcome=@CourseOutcome,CourseOutcomeDescription=@CourseOutcomeDescription where CoID=@CoID
END