
-------------Create Drive for Placement---------------
CREATE TABLE EduSphere.PlacementDrives
(
DriveID INT IDENTITY(100,1) CONSTRAINT cstDrivePK PRIMARY KEY,
DriveTitle VARCHAR(50),
EmployerID INT CONSTRAINT cstEmployerFK FOREIGN KEY REFERENCES EduSphere.Organizations(OrganizationID),
JobDescription VARCHAR(200),
DriveDate DATETIME,
CoordinatorID INT CONSTRAINT cstDriveStaffFK FOREIGN KEY REFERENCES EduSphere.Staff(EmployeeID),
)

SELECT * FROM EduSphere.PlacementDrives
DROP TABLE EduSphere.PlacementDrives

------------------------------------------------------------------
CREATE PROCEDURE spAddDrive
@DriveTitle VARCHAR(50),
@EmployerID INT,
@JobDescription VARCHAR(200),
@DriveDate DATETIME,
@CoordinatorID INT
AS
BEGIN
  INSERT INTO EduSphere.PlacementDrives (DriveTitle,EmployerID,JobDescription,DriveDate,CoordinatorID) VALUES(@DriveTitle,@EmployerID,@JobDescription,@DriveDate,@CoordinatorID)
  ----Creat Date Template for Drive Schdeule----
  --DECLARE @latestDriveID INT = (SELECT TOP 1 DriveID FROM EduSphere.ProgramDrive ORDER BY DriveID DESC)--
  --EXEC spCreateScheduleDates @latestDriveID,'90',@StartDate,@EndDate--
END

DROP PROCEDURE spAddDrive 
---------------------------------------------------------------------------

-------StudentsPlacementDrives---------------------------
CREATE TABLE EduSphere.StudentsPlacementDrives
(
StudentsPlacementDriveID uniqueidentifier NOT NULL DEFAULT newid() CONSTRAINT cstSPDPK PRIMARY KEY,
DriveID INT CONSTRAINT cstPlacementDriveFK FOREIGN KEY REFERENCES EduSphere.PlacementDrives(DriveID),
MemberID INT CONSTRAINT cstPDStudentIDFK FOREIGN KEY REFERENCES EduSphere.Members(MemberID),
StudentsDriveStatus VARCHAR(20) CONSTRAINT cstSDSCheck CHECK(StudentsDriveStatus IN('NOMINATED','APPEARED','OPTEDOUT','SELECTED','NOTSELECTED'))
)

DROP TABLE EduSphere.StudentsPlacementDrives
SELECT * FROM EduSphere.StudentsPlacementDrives

--------ADD SINGLE STUDENT TO DRIVE---------
CREATE PROCEDURE spAddStudentToDrive
(
@DriveID INT,
@MemberID INT
)
AS
BEGIN
     INSERT INTO EduSphere.StudentsPlacementDrives (DriveID,MemberID,StudentsDriveStatus) VALUES(@DriveID,@MemberID,'NOMINATED')
END

DROP PROCEDURE spAddStudentToDrive

----------------------UPDATE PLACEMENT STATUS------------
CREATE PROCEDURE spUpdateStudentsDriveStatus
(
@StudentsPlacementDriveID uniqueidentifier,
@StudentsDriveStatus VARCHAR(20) 
)
AS
BEGIN
   UPDATE EduSphere.StudentsPlacementDrives SET StudentsDriveStatus=@StudentsDriveStatus WHERE StudentsPlacementDriveID=@StudentsPlacementDriveID
END

DROP PROCEDURE spUpdateStudentsDriveStatus