
---Access Request----
CREATE TABLE EduSphere.RoleRequests
(
RequestID INT IDENTITY(100,1) constraint cstAReqPK PRIMARY KEY,
RequesterFullName VARCHAR(50),
RequesterPhone VARCHAR(50),
RequesterEmail VARCHAR(50),
RequesterAddress VARCHAR(200),
RequesterState INT,
RequestedRoleName VARCHAR(50),
Comments VARCHAR(100),
RequestApprovalStatus VARCHAR(50) CONSTRAINT cstReqStatusChk CHECK(RequestApprovalStatus IN('NEW','APPROVED','BLOCKED')),
OrganizationID INT constraint cstMentorOrgFK FOREIGN KEY REFERENCES EduSphere.Organizations(OrganizationID),
City VARCHAR(50),
RaisedOn DATETIME
)

DROP TABLE EduSphere.RoleRequests
sp_help 'EduSphere.RoleRequests'
TRUNCATE TABLE EduSphere.RoleRequests
UPDATE EduSphere.RoleRequests SET RequestedRoleName='Student' WHERE  RequestedRoleName='STUDENT'
UPDATE EduSphere.RoleRequests SET OrganizationID=90

SELECT  * FROM EduSphere.RoleRequests r 
                                                                JOIN EduSphere.Organizations o ON r.OrganizationID=o.OrganizationID
                                                                WHERE RequestID='496'

SELECT * FROM EduSphere.RoleRequests WHERE RequesterState=(SELECT RequesterState FROM EduSphere.RoleRequests WHERE RequesterEmail='manore.paresh@gmail.com')
SELECT TOP 1000 * FROM EduSphere.RoleRequests r 
                    JOIN EduSphere.States p ON r.RequesterState=p.StateID
                    WHERE RequesterState=(SELECT RequesterState FROM EduSphere.RoleRequests WHERE RequesterEmail=User.Id.ToString())  
                    ORDER BY RequestID DESC

sp_rename 'EduSphere.RoleRequests.RequesterCountry', 'RequesterState','COLUMN' 

ALTER TABLE EduSphere.RoleRequests ADD  RequesterState INT
ALTER TABLE EduSphere.RoleRequests DROP COLUMN RequesterState
ALTER TABLE EduSphere.RoleRequests ADD RequestApprovalStatus VARCHAR(50) CONSTRAINT cstReqStatusChk CHECK(RequestApprovalStatus IN('NEW','APPROVED','BLOCKED'))
ALTER TABLE EduSphere.RoleRequests DROP COLUMN RequestedRoleName  
ALTER TABLE EduSphere.RoleRequests ADD RequestedRoleName VARCHAR(50)  CONSTRAINT cstChkReqRoleName CHECK(RequestedRoleName IN('NEUROTHERAPIST','STUDENT'))
ALTER TABLE EduSphere.RoleRequests ADD RequestedRoleName VARCHAR(50)  CONSTRAINT cstChkReqRoleName CHECK(RequestedRoleName IN('NEUROTHERAPIST','STUDENT'))

ALTER TABLE EduSphere.RoleRequests ADD OrganizationID INT constraint cstMentorOrgFK FOREIGN KEY REFERENCES EduSphere.Organizations(OrganizationID)
ALTER TABLE EduSphere.RoleRequests ADD City VARCHAR(25)

SELECT * FROM EduSphere.RoleRequests WHERE RequesterEmail='rkneurotherapy@gmail.com'
UPDATE EduSphere.RoleRequests SET RequestApprovalStatus='NEW' WHERE RequestID=111

DELETE FROM EduSphere.RoleRequests WHERE RequestID= '496'

CREATE PROCEDURE spNewRequest
@RequesterFullName VARCHAR(50),
@RequesterPhone VARCHAR(50),
@RequesterEmail VARCHAR(50),
@RequesterAddress VARCHAR(200),
@RequesterState INT,
@RequestedRoleName VARCHAR(50),
@Comments VARCHAR(100),
@RaisedOn DATETIME,--Not Used--
@RequestApprovalStatus VARCHAR(50),
@OrganizationID INT,
@City VARCHAR(50)
AS
BEGIN
  if not exists (SELECT RequesterEmail FROM EduSphere.RoleRequests WHERE RequesterEmail=@RequesterEmail)
  BEGIN
  INSERT INTO EduSphere.RoleRequests (RequesterFullName,RequesterPhone,RequesterEmail,RequesterAddress,RequesterState,RequestedRoleName,Comments,RaisedOn,RequestApprovalStatus,OrganizationID,City)
                              VALUES(@RequesterFullName,@RequesterPhone,@RequesterEmail,@RequesterAddress,@RequesterState,@RequestedRoleName,@Comments,GETDATE(),@RequestApprovalStatus,@OrganizationID,@City)
  END
END

DROP PROCEDURE spNewRequest

----------------------------------DELETE A NEW REQUEST THAT IS NOT YET APPROVED--------------------------------------------
CREATE PROCEDURE spDeleteRequest
@RequestID INT
AS
BEGIN
  DECLARE @reqstatus VARCHAR(50) = (SELECT RequestApprovalStatus FROM EduSphere.RoleRequests WHERE RequestID=@RequestID)
  IF(@reqstatus='NEW')
  BEGIN
     DELETE FROM EduSphere.RoleRequests WHERE RequestID=@RequestID
  END 
END

DROP PROCEDURE spDeleteRequest

EXEC spDeleteRequest 496 


DELETE FROM EduSphere.Neurotherapists WHERE AccessRequestID=217
DELETE FROM EduSphere.RoleRequests WHERE RequestID=217

---------------- DELETE AN APPROVED REQUEST------------------------------
CREATE PROCEDURE spDeleteApprovedNeurotherapist
@RequestID INT
AS
BEGIN
 DECLARE @neuroid INT		= (SELECT NeurotherapistID FROM EduSphere.Neurotherapists WHERE AccessRequestID=@RequestID)
 DECLARE @email varchar(50)	= (SELECT Email FROM EduSphere.Neurotherapists WHERE NeurotherapistID=@neuroid)
 
 DELETE FROM NTADATABSE.EduSphere.NeuroAcademics WHERE NeurotherapistID=@neuroid
 DELETE FROM EduSphere.NeurotherapistAccount WHERE NeurotherapistID=@neuroid
 DELETE FROM EduSphere.NeurotherapistDocuments WHERE NeurotherapistID=@neuroid
 DELETE FROM EduSphere.PostalAddresses WHERE NeurotherapistID=@neuroid
 DELETE FROM Evaluations.CandidateTestAttendance WHERE CandidateID=@neuroid
 DELETE FROM Evaluations.OnlineTestTransaction WHERE CandidateID=@neuroid
 DELETE FROM EduSphere.Neurotherapists WHERE AccessRequestID=@RequestID
 DELETE FROM EduSphere.RoleRequests WHERE RequestID=@RequestID
 DELETE FROM [NTADATABSE].[dbo].[AspNetUsers] WHERE Email=@email
END

DELETE FROM [NTADATABSE].[dbo].[AspNetUsers] WHERE Email='rkneurotherapy@gmail.com'

DROP PROCEDURE spDeleteApprovedNeurotherapist
EXEC spDeleteApprovedNeurotherapist 
EXEC spDeleteApprovedNeurotherapist 529
---------------- END DELETE AN APPROVED ID FROM EVERYWHERE------------------------------
------------------------------------------------------------------------------

----------In case contact request is approved create entry for Therapist or Student----------
CREATE PROCEDURE spUpdateRequestStatus
@RequestID INT,
@RequesterFullName VARCHAR(50),
@RequesterPhone VARCHAR(50),
@RequesterEmail VARCHAR(50),
@RequestedRoleName VARCHAR(50),
@RequestApprovalStatus VARCHAR(50)
AS
BEGIN
  UPDATE EduSphere.RoleRequests SET RequestApprovalStatus=@RequestApprovalStatus WHERE RequestID=@RequestID
  IF(@RequestApprovalStatus='APPROVED')
  BEGIN
   --   DECLARE @Type VARCHAR(20)='NONE'--
	  --IF(@RequestedRoleName='STUDENT')--
		 -- BEGIN--
		 --   SET  @Type='STUDENT'--
		 -- END--
	 EXEC spInsertMember @AccessRequestID=@RequestID,		                  
						   @OrganizationID='90',
						   @ProgramID='90',
						   @PhotoPath='',
						   @FullName=@RequesterFullName,
						   @Gender='FEMALE',
						   @PhoneOne=@RequesterPhone,
						   @PhoneTwo='',
						   @Email=@RequesterEmail,						   
						   @Designation='',
						   @DateOfBirth='01-01-1900',
						   @FathersName='',
						   @MothersName='',
						   @PanNumber='',
						   @AadhaarNumber='',
						   @BankName='',
						   @BankAccountNumber='',
						   @BankIFSC='',
						   @MentorId='90',
						   @MembershipStatus='NOTACTIVE',
						   @DateOfJoining='01-01-1900',
						   @MembershipType=@RequestedRoleName,
						   @DateOfLeaving='01-01-1900'
		-------Create Place Holders for Addresses----
	  DECLARE @MemberID INT = (SELECT TOP 1 MemberID FROM EduSphere.Members ORDER BY MemberID DESC)
	  EXEC spInsertPostalAddress  @MemberID, 'PERMANENT'
	  EXEC spInsertPostalAddress  @MemberID, 'CORRESPONDENCE'
	  -- spInsertPostalAddress  @MemberID, 'TREATMENT_FACILITY'--
	  --EXEC spInsertPostalAddress  @MemberID, 'ACADEMY'--	  
  END 
END

DROP PROCEDURE spUpdateRequestStatus

------------------------CHange UserID Role in AsNetUserRoles----
CREATE PROCEDURE spChangeRole
@Email VARCHAR(50),
@NewRole VARCHAR(50)
AS
BEGIN
  UPDATE AspNetUserRoles SET RoleID=(SELECT Id FROM AspNetRoles WHERE Name=@NewRole) 
                       WHERE UserId=(SELECT Id FROM AspNetUsers WHERE Email=@Email)
END

DROP PROCEDURE spChangeRole

EXECUTE spChangeRole 'AdminID@yahoo.com','AdminIC'


----List of Enquires Raised-----
CREATE TABLE EduSphere.Enquiries
(
EnquiryId INT IDENTITY(100,1) constraint cstBookingPK PRIMARY KEY,
EnquiryType VARCHAR(50) CONSTRAINT cstEnqTypChk CHECK(EnquiryType IN('STUDENT','EMPLOYMENT')),
ProgramId INT CONSTRAINT progIdFK FOREIGN KEY REFERENCES EduSphere.Programs(ProgramId),
FranchiseeId INT CONSTRAINT cstFrId FOREIGN KEY REFERENCES EduSphere.Organizations(OrganizationID),
RaisedOn DATETIME,
RaisedById varchar(50),
RaisedByEmployeeId INT, 
StudentName VARCHAR(50),
Gender VARCHAR(20) CONSTRAINT cstGenderChk CHECK(Gender IN('MALE','FEMALE')),
Education VARCHAR(50),
Institute VARCHAR(50),
Stream VARCHAR(50),
Email VARCHAR(50),
Phone VARCHAR(20),
City varchar(50),
State varchar(50),
PinCode varchar(20),
EnquiryMessage VARCHAR(200),
EnquiryStatus varchar(20) CONSTRAINT eStatus CHECK(EnquiryStatus IN ('NEW','PROSPECTS','TELECALL','COUNSELLING','FOLLOWUP','CONVERTED','COLD')),
OwnerEmployeeId int,
AssignedEmployeeId int,
EnquiryAgeDays INT,
LastUpdated DATETIME,
EnquirySource VARCHAR(50),
)

SELECT * FROM EduSphere.Enquiries
DROP TABLE EduSphere.Enquiries

ALTER TABLE EduSphere.Enquiries DROP CONSTRAINT eStatus

ALTER TABLE EduSphere.Enquiries DROP COLUMN EnquiryStatus
ALTER TABLE EduSphere.Enquiries ADD EnquiryStatus varchar(20) CONSTRAINT eStatus CHECK(EnquiryStatus IN ('NEW','PROSPECTS','TELECALL','COUNSELLING','FOLLOWUP','CONVERTED','COLD'))
ALTER TABLE EduSphere.Enquiries ADD Gender VARCHAR(20) CONSTRAINT cstGenderChk CHECK(Gender IN('MALE','FEMALE'))
ALTER TABLE EduSphere.Enquiries ADD Education VARCHAR(50)
ALTER TABLE EduSphere.Enquiries ADD Institute VARCHAR(50)
ALTER TABLE EduSphere.Enquiries ADD Stream VARCHAR(50)
ALTER TABLE EduSphere.Enquiries ADD EnquirySource VARCHAR(50)
ALTER TABLE EduSphere.Enquiries DROP COLUMN SlaDate

UPDATE EduSphere.Enquiries SET Education='HSC' WHERE EnquiryId!='103'
SELECT  *, o.FullName as Owner,a.FullName as Assigned, (SELECT TOP 1 ModificationComments FROM EduSphere.EnquiryStatusModifications m WHERE m.EnquiryId=e.EnquiryId ORDER BY ModificationId DESC) AS Comments
                                                    FROM EduSphere.Enquiries e JOIN EduSphere.Organizations org ON e.FranchiseeID=org.OrganizationId 
                                                                                JOIN EduSphere.Staff o ON e.OwnerEmployeeId=o.EmployeeId
                                                                                JOIN EduSphere.Staff a ON e.AssignedEmployeeId=a.EmployeeId
                                                                                JOIN eduSphere.Programs p ON e.ProgramID=p.ProgramID  WHERE StudentName LIKE '%Soota%' OR e.Phone LIKE '%1122334455%'  

--------Add New Enquiry--------
CREATE PROCEDURE spInsertEnquiry
@ProgramID int,
@FranchiseeId INT,
@StudentName VARCHAR(50),
@Gender VARCHAR(20),
@Education VARCHAR(50),
@Institute VARCHAR(50),
@Stream VARCHAR(50),
@Email VARCHAR(50),
@Phone VARCHAR(20),
@City varchar(50),
@State varchar(50),
@PinCode varchar(20),
@EnquiryMessage varchar(200),
@RaisedById varchar(50),
@EnquirySource VARCHAR(50)
AS
BEGIN
    DECLARE @tmpEmpoyeeId INT = (SELECT EmployeeId FROM EduSphere.Staff WHERE Email=@RaisedById)
     IF(@tmpEmpoyeeId is null)
	 BEGIN
        SET @tmpEmpoyeeId='90'
     END 
	 INSERT INTO EduSphere.Enquiries (ProgramId,FranchiseeId,RaisedOn,RaisedById,RaisedByEmployeeId,StudentName,Gender,Education,Institute,Stream,Email,Phone,City,State,PinCode,EnquiryMessage,EnquirySource,EnquiryStatus,OwnerEmployeeId,AssignedEmployeeId) 
	                            VALUES(@ProgramId,@FranchiseeId,GETDATE(),@RaisedById,@tmpEmpoyeeId,@StudentName,@Gender,@Education,@Institute,@Stream,@Email,@Phone,@City,@State,@PinCode,@EnquiryMessage,@EnquirySource,'NEW',@tmpEmpoyeeId,@tmpEmpoyeeId)   
     ------Make an entry into History----
	 DECLARE @tmpEnquiryId INT = (SELECT TOP 1 EnquiryId FROM EduSphere.Enquiries ORDER BY EnquiryId DESC) 
	 INSERT INTO EduSphere.EnquiryStatusModifications(EnquiryId,FranchiseeId,ModificationDate,ModifiedById,ModifiedByEmployeeId,OwnerEmployeeId,AssignedEmployeeId,EnquiryStatus,ModificationComments)
	                                           VALUES(@tmpEnquiryId,@FranchiseeId,GETDATE(),@RaisedById,@tmpEmpoyeeId,@tmpEmpoyeeId,@tmpEmpoyeeId,'NEW','NewEnquiry')
END

DROP PROCEDURE spInsertEnquiry

--------------------------TEST-----------------
SELECT  *, o.FullName as Owner,a.FullName as Assigned ,(SELECT TOP 1 ModificationComments FROM EduSphere.EnquiryStatusModifications m WHERE m.EnquiryId=e.EnquiryId ORDER BY ModificationId DESC) AS Comments
                                                    FROM EduSphere.Enquiries e JOIN EduSphere.Organizations org ON e.FranchiseeID=org.OrganizationId 
                                                                                JOIN EduSphere.Staff o ON e.OwnerEmployeeId=o.EmployeeId
                                                                                JOIN EduSphere.Staff a ON e.AssignedEmployeeId=a.EmployeeId
                                                                                JOIN eduSphere.Programs p ON e.ProgramID=p.ProgramID
														WHERE e.EnquiryId='101'

SELECT  *, o.FullName as Owner,a.FullName as Assigned, (SELECT TOP 1 ModificationComments FROM EduSphere.EnquiryStatusModifications m WHERE m.EnquiryId=e.EnquiryId ORDER BY ModificationId DESC) AS Comments
                                                    FROM EduSphere.Enquiries e JOIN EduSphere.Organizations org ON e.FranchiseeID=org.OrganizationId 
                                                                                JOIN EduSphere.Staff o ON e.OwnerEmployeeId=o.EmployeeId
                                                                                JOIN EduSphere.Staff a ON e.AssignedEmployeeId=a.EmployeeId
                                                                                JOIN eduSphere.Programs p ON e.ProgramID=p.ProgramID WHERE EnquiryId=101

SELECT  *, o.FullName as Owner,a.FullName as Assigned, (SELECT ModificationComments FROM EduSphere.EnquiryStatusModifications m WHERE m.EnquiryId=e.EnquiryId ORDER BY ModificationId DESC) AS Comments
                                                    FROM EduSphere.Enquiries e JOIN EduSphere.Organizations org ON e.FranchiseeID=org.OrganizationId 

SELECT ModificationComments FROM EduSphere.EnquiryStatusModifications m WHERE m.EnquiryId=e.EnquiryId ORDER BY ModificationId DESC
------------------------------------------------------------------
----Enquiry Status Modifications History------
CREATE TABLE EduSphere.EnquiryStatusModifications
(
ModificationId INT IDENTITY(100,1) CONSTRAINT cstModPK PRIMARY KEY,
EnquiryId int CONSTRAINT cstEnquiryUpdate FOREIGN KEY REFERENCES EduSphere.Enquiries(EnquiryID),
ModificationDate DateTime,
ModifiedById varchar(50),
ModifiedByEmployeeId INT CONSTRAINT cstModByEmpId FOREIGN KEY REFERENCES EduSphere.Staff(EmployeeID),
FranchiseeId int CONSTRAINT vendorId FOREIGN KEY REFERENCES EduSphere.Organizations(OrganizationId),
AssignedEmployeeId int,
OwnerEmployeeId int,
EnquiryStatus varchar(20) CONSTRAINT cStatus CHECK(EnquiryStatus IN ('NEW','PROSPECTS','TELECALL','COUNSELLING','FOLLOWUP','CONVERTED','COLD')),
ModificationComments varchar(200),
ModificationArtifactTitle varchar(50),
ModificationAttachment varchar(100)
)

DROP TABLE EduSphere.EnquiryStatusModifications
SELECT * FROM EduSphere.EnquiryStatusModifications 

ALTER TABLE EduSphere.EnquiryStatusModifications DROP CONSTRAINT cStatus
ALTER TABLE EduSphere.EnquiryStatusModifications DROP COLUMN EnquiryStatus
ALTER TABLE EduSphere.EnquiryStatusModifications ADD EnquiryStatus varchar(20) CONSTRAINT cStatus CHECK(EnquiryStatus IN ('NEW','PROSPECTS','TELECALL','COUNSELLING','FOLLOWUP','CONVERTED','COLD'))

------Update Enquiry Status---
create procedure spEnquiryModification
@EnquiryId int,
@ModifiedById varchar(50),
@ModifiedByEmployeeId INT,
@FranchiseeId int,
@OwnerEmployeeId int,
@AssignedEmployeeId int,
@EnquiryStatus varchar(20),
@ModificationComments varchar(200),
@ModificationArtifactTitle varchar(50),
@ModificationAttachment varchar(100)
AS
BEGIN
 INSERT INTO EduSphere.EnquiryStatusModifications (EnquiryId,ModificationDate,ModifiedById,ModifiedByEmployeeId,FranchiseeId,OwnerEmployeeId,AssignedEmployeeId,EnquiryStatus,ModificationComments,ModificationArtifactTitle,ModificationAttachment) 
                                           VALUES(@EnquiryId,GETDATE(),@ModifiedById,@ModifiedByEmployeeId,@FranchiseeId,@OwnerEmployeeId,@AssignedEmployeeId,@EnquiryStatus,@ModificationComments,@ModificationArtifactTitle,@ModificationAttachment)
  UPDATE EduSphere.Enquiries SET EnquiryStatus=@EnquiryStatus,OwnerEmployeeId=@OwnerEmployeeId,FranchiseeId=@FranchiseeId,AssignedEmployeeId=@AssignedEmployeeId,
							 EnquiryAgeDays=DATEDIFF(d, RaisedOn, GETDATE()), LastUpdated=GETDATE() WHERE EnquiryId=@EnquiryId
END

drop procedure spEnquiryModification

------------------------------------STATE UPDATE-----------------------
UPDATE EduSphere.RoleRequests SET RequesterState='119' WHERE RequesterEmail='Neurobharat@yahoo.com'
UPDATE EduSphere.RoleRequests SET RequesterState='119' WHERE RequesterEmail='Ojhahemant93@gmail.com'
UPDATE EduSphere.RoleRequests SET RequesterState='119' WHERE RequesterEmail='jpatel.lmnt111@gmail.com'
UPDATE EduSphere.RoleRequests SET RequesterState='119' WHERE RequesterEmail='akku_guna@yahoo.com'
UPDATE EduSphere.RoleRequests SET RequesterState='119' WHERE RequesterEmail='satyamehar77@gmail.com'

UPDATE EduSphere.RoleRequests SET RequesterState='119' WHERE RequesterEmail='yogipriyo@yahoo.co.in'
UPDATE EduSphere.RoleRequests SET RequesterState='119' WHERE RequesterEmail='maheshlmnt@gmail.com'
UPDATE EduSphere.RoleRequests SET RequesterState='119' WHERE RequesterEmail='Prahladsolanki.ps@gmail.cm'
UPDATE EduSphere.RoleRequests SET RequesterState='119' WHERE RequesterEmail='neuro.arvind@gmail.com'

UPDATE EduSphere.RoleRequests SET RequesterState='119' WHERE RequesterEmail='shvptdr@gmail.com'
UPDATE EduSphere.RoleRequests SET RequesterState='119' WHERE RequesterEmail='viveksoni_in@yahoo.com'
UPDATE EduSphere.RoleRequests SET RequesterState='119' WHERE RequesterEmail='Slchouhan84@gmail.com'
UPDATE EduSphere.RoleRequests SET RequesterState='119' WHERE RequesterEmail='ashishr032@gmail.com'

UPDATE EduSphere.RoleRequests SET RequesterState='119' WHERE RequesterEmail='kamna.gpt@gmail.com'
UPDATE EduSphere.RoleRequests SET RequesterState='119' WHERE RequesterEmail='gupta_pradyumn@yahoo.in'
UPDATE EduSphere.RoleRequests SET RequesterState='119' WHERE RequesterEmail='manshunargawe09@gmail.com'
UPDATE EduSphere.RoleRequests SET RequesterState='119' WHERE RequesterEmail='hariomjatav31@gmail.com'

UPDATE EduSphere.RoleRequests SET RequesterState='119' WHERE RequesterEmail='Shivkumarpoter@gmail.com'
UPDATE EduSphere.RoleRequests SET RequesterState='119' WHERE RequesterEmail='swapnil971@rediffmail.com'
UPDATE EduSphere.RoleRequests SET RequesterState='119' WHERE RequesterEmail='Vivaik111@gmail.com'
UPDATE EduSphere.RoleRequests SET RequesterState='119' WHERE RequesterEmail='sukhalalmuzalda575 @emil.com'

UPDATE EduSphere.RoleRequests SET RequesterState='119' WHERE RequesterEmail='ntmanoj407@gmail.com'
UPDATE EduSphere.RoleRequests SET RequesterState='119' WHERE RequesterEmail='Patidarjitendra560@gmail.com'
