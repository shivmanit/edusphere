-----------Not Requd--Just Place Holder----
----Programs/Degress/Certificates offerred-----
create table MedSphere.Programs
(
ProgramID int identity(100,1) constraint cstProgPK PRIMARY KEY,
ProgramTitle varchar(100),
ProgramDescription varchar(50),
ProgramVision varchar(500),
ProgramMission varchar(500)
)

DROP TABLE MedSphere.Programs
SELECT * FROM MedSphere.Programs
--Add Proxy--
SET IDENTITY_INSERT MedSphere.Programs ON
 INSERT INTO MedSphere.Programs(ProgramID,ProgramTitle,ProgramDescription) VALUES('90','Proxy','ProxyProgram')
SET IDENTITY_INSERT MedSphere.Programs OFF

----List of Enquires Raised-----
CREATE TABLE MedSphere.Enquiries
(
EnquiryId INT IDENTITY(100,1) constraint cstBookingPK PRIMARY KEY,
ProgramId INT CONSTRAINT progIdFK FOREIGN KEY REFERENCES MedSphere.Programs(ProgramId),
FranchiseeId INT CONSTRAINT cstFrId FOREIGN KEY REFERENCES MedSphere.Organizations(OrganizationID),
RaisedOn DATETIME,
RaisedById varchar(50),
RaisedByEmployeeId INT, 
StudentName VARCHAR(50),
Email VARCHAR(50),
Phone VARCHAR(20),
City varchar(50),
State varchar(50),
PinCode varchar(20),
EnquiryMessage VARCHAR(200),
SlaDate DateTime,
EnquiryStatus varchar(10) CONSTRAINT eStatus CHECK(EnquiryStatus IN ('OPEN','ASSIGNED','RESOLVED','CLOSED')),
EnquiryFinStatus VARCHAR(20) CONSTRAINT fStatus CHECK(EnquiryFinStatus IN('TBD','DELIVERED','CANCELLED')),
OwnerEmployeeId int,
AssignedEmployeeId int,
EnquiryAgeDays INT,
LastUpdated DATETIME
)

SELECT * FROM MedSphere.Enquiries
DROP TABLE MedSphere.Enquiries

SELECT  *, o.FullName as Owner,a.FullName as Assigned
                                                    FROM MedSphere.Enquiries e JOIN MedSphere.Organizations org ON e.FranchiseeID=org.OrganizationId 
                                                                                JOIN MedSphere.Staff o ON e.OwnerEmployeeId=o.EmployeeId
                                                                                JOIN MedSphere.Staff a ON e.AssignedEmployeeId=a.EmployeeId
                                                                                JOIN MedSphere.Programs p ON e.ProgramID=p.ProgramID  WHERE EnquiryId=Rupali OR StudentName LIKE '%Rupali%'

--------Add New Enquiry--------
CREATE PROCEDURE spInsertMedEnquiry
@ProgramID int,
@FranchiseeId INT,
@SlaDate DateTime,
@StudentName VARCHAR(50),
@Email VARCHAR(50),
@Phone VARCHAR(20),
@City varchar(50),
@State varchar(50),
@PinCode varchar(20),
@EnquiryMessage varchar(200),
@RaisedById varchar(50),
--ModificationHistory---
@ModificationArtifactTitle varchar(50),
@ModificationAttachment varchar(100)
AS
BEGIN
    DECLARE @tmpEmpoyeeId INT = (SELECT EmployeeId FROM MedSphere.Staff WHERE Email=@RaisedById)
     IF(@tmpEmpoyeeId is null)
	 BEGIN
        SET @tmpEmpoyeeId='90'
     END 
	 INSERT INTO MedSphere.Enquiries (ProgramId,FranchiseeId,RaisedOn,RaisedById,RaisedByEmployeeId,StudentName,Email,Phone,City,State,PinCode,EnquiryMessage,SLADate,EnquiryStatus,OwnerEmployeeId,AssignedEmployeeId) 
	                            VALUES(@ProgramId,@FranchiseeId,GETDATE(),@RaisedById,@tmpEmpoyeeId,@StudentName,@Email,@Phone,@City,@State,@PinCode,@EnquiryMessage,@SLADate,'OPEN',@tmpEmpoyeeId,@tmpEmpoyeeId)   
     ------Make an entry into History----
	 DECLARE @tmpEnquiryId INT = (SELECT TOP 1 EnquiryId FROM MedSphere.Enquiries ORDER BY EnquiryId DESC) 
	 INSERT INTO MedSphere.EnquiryStatusModifications(EnquiryId,FranchiseeId,ModificationDate,ModifiedById,ModifiedByEmployeeId,OwnerEmployeeId,AssignedEmployeeId,EnquiryStatus,ModificationComments,ModificationArtifactTitle,ModificationAttachment)
	                                           VALUES(@tmpEnquiryId,@FranchiseeId,GETDATE(),@RaisedById,@tmpEmpoyeeId,@tmpEmpoyeeId,@tmpEmpoyeeId,'OPEN','NewEnquiry',@ModificationArtifactTitle,@ModificationAttachment)
END

DROP PROCEDURE spInsertMedEnquiry



------------------------------------------------------------------
----Enquiry Status Modifications History------
CREATE TABLE MedSphere.EnquiryStatusModifications
(
ModificationId INT IDENTITY(100,1) CONSTRAINT cstModPK PRIMARY KEY,
EnquiryId int CONSTRAINT cstEnquiryUpdate FOREIGN KEY REFERENCES MedSphere.Enquiries(EnquiryID),
ModificationDate DateTime,
ModifiedById varchar(50),
ModifiedByEmployeeId INT CONSTRAINT cstModByEmpId FOREIGN KEY REFERENCES MedSphere.Staff(EmployeeID),
FranchiseeId int CONSTRAINT vendorId FOREIGN KEY REFERENCES MedSphere.Organizations(OrganizationId),
AssignedEmployeeId int,
OwnerEmployeeId int,
EnquiryStatus varchar(10) CONSTRAINT EnquiryModStatus CHECK(EnquiryStatus IN ('OPEN','ASSIGNED','RESOLVED','CLOSED')),
ModificationComments varchar(200),
ModificationArtifactTitle varchar(50),
ModificationAttachment varchar(100)
)

DROP TABLE MedSphere.EnquiryStatusModifications
SELECT * FROM MedSphere.EnquiryStatusModifications 

------Update Enquiry Status---
create procedure spMedEnquiryModification
@EnquiryId int,
@ModifiedById varchar(50),
@ModifiedByEmployeeId INT,
@FranchiseeId int,
@OwnerEmployeeId int,
@AssignedEmployeeId int,
@EnquiryStatus varchar(10),
@ModificationComments varchar(200),
@ModificationArtifactTitle varchar(50),
@ModificationAttachment varchar(100)
AS
BEGIN
 INSERT INTO MedSphere.EnquiryStatusModifications (EnquiryId,ModificationDate,ModifiedById,ModifiedByEmployeeId,FranchiseeId,OwnerEmployeeId,AssignedEmployeeId,EnquiryStatus,ModificationComments,ModificationArtifactTitle,ModificationAttachment) 
                                           VALUES(@EnquiryId,GETDATE(),@ModifiedById,@ModifiedByEmployeeId,@FranchiseeId,@OwnerEmployeeId,@AssignedEmployeeId,@EnquiryStatus,@ModificationComments,@ModificationArtifactTitle,@ModificationAttachment)
  UPDATE MedSphere.Enquiries SET EnquiryStatus=@EnquiryStatus,OwnerEmployeeId=@OwnerEmployeeId,FranchiseeId=@FranchiseeId,AssignedEmployeeId=@AssignedEmployeeId,
							 EnquiryAgeDays=DATEDIFF(d, RaisedOn, GETDATE()), LastUpdated=GETDATE() WHERE EnquiryId=@EnquiryId
END

drop procedure spEnquiryModification
