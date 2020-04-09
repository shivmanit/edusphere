----------Member Details-----------------------
CREATE TABLE EduSphere.Members
(
RegCode uniqueidentifier NOT NULL DEFAULT newid(),
MemberID INT IDENTITY (100,1) CONSTRAINT cstAflIdPK PRIMARY KEY ,
AccessRequestID INT CONSTRAINT cstReqID FOREIGN KEY REFERENCES Edusphere.RoleRequests(RequestID),
OrganizationID INT constraint cstOrgFK FOREIGN KEY REFERENCES EduSphere.Organizations(OrganizationID),
PhotoPath varchar(100),
FullName varchar(50),
Gender VARCHAR(20) CONSTRAINT cstGender CHECK(Gender IN('MALE','FEMALE')),
MaritalStatus VARCHAR(20) CONSTRAINT cstMS CHECK(MaritalStatus IN('SINGLE','MARRIED','SEPEARATED','DIVORCED','WIDOWED')),
DateOfBirth DateTime,
Anniversary DateTime,
PhoneOne varchar(20),
PhoneTwo varchar(20),
Email    varchar(50),
ProgramID INT,
BatchID INT,
Website varchar(50),
SocialMediaOne varchar(100),
SocialMediaTwo varchar(100),
SocialMediaThree varchar(100),
Designation varchar(50),
FathersName VARCHAR(50),
MothersName VARCHAR(50),
PanNumber VARCHAR(20),
AadhaarNumber VARCHAR(50),
BankName VARCHAR(20),
BankAccountNumber VARCHAR(20),
BankIFSC VARCHAR(20),
MentorID varchar(50),
AcademicExamStatus varchar(50) CONSTRAINT cstExam CHECK(AcademicExamStatus IN('SSC','HSC','GRADUATE','POSTGRADUATE')),
MembershipStatus varchar(10) constraint cstMemStatus CHECK(MembershipStatus IN('ACTIVE','NOTACTIVE')),
DateOfJoining Date,
MembershipValidForYears INT,
MembershipType varchar(20) CONSTRAINT cstMemType CHECK(MembershipType IN('NONE','STUDENT','ALUMANI')),
MembershipExpiryDate DATE,
DateOfLeaving Date,
Remarks VARCHAR(100)
)


SELECT * FROM EduSphere.Members
ALTER TABLE EduSphere.Members DROP CONSTRAINT cstExam
ALTER TABLE EduSphere.Members DROP COLUMN  AcademicExamStatus
ALTER TABLE EduSphere.Members ADD  AcademicExamStatus varchar(50) CONSTRAINT cstExam CHECK(AcademicExamStatus IN('SSC','HSC','GRADUATE','POSTGRADUATE'))

UPDATE EduSphere.Members SET AcademicExamStatus='GRADUATE'

DROP TABLE EduSphere.Members
sp_help 'EduSphere.Members'


------------------------------------------------------------------TEST--------------------------------
SELECT TOP 10 MemberID, FullName, Gender,ProgramTitle FROM EduSphere.Members c 
						JOIN EduSphere.Programs m ON c.ProgramID=m.ProgramID WHERE MembershipType='STUDENT' ORDER BY MemberID DESC

SELECT OrganizationName,MemberID,FullName,st.PhoneOne,st.Email,st.MembershipStatus,st.AadhaarNumber,st.PanNumber,st.AcademicExamStatus,st.MembershipType
                                                 FROM EduSphere.Members st 
                                                 JOIN EduSphere.Organizations org ON st.OrganizationID=org.OrganizationID 
                                                  WHERE MembershipStatus='NOTACTIVE' AND MembershipType='STUDENT' 
                                                  ORDER BY st.MemberID DESC

SELECT OrganizationName,MemberID,FullName,st.PhoneOne,st.Email,st.MembershipStatus 
                                                 FROM EduSphere.Members st 
                                                 JOIN EduSphere.Organizations org ON st.OrganizationID=org.OrganizationID 
                                                 WHERE MembershipStatus='NOTACTIVE' AND st.Email='shivmanit@yahoo.com' ORDER BY st.FullName ASC

------------------------------------------------------------------------------------------------------

CREATE PROCEDURE spDeleteMember
@MemberID INT
AS
BEGIN
 DELETE FROM Evaluations.OnlineTestTransaction WHERE CandidateID=@MemberID
 DELETE FROM Evaluations.CandidateTestAttendance WHERE CandidateID=@MemberID
 DELETE FROM Evaluations.OnlineTestTransaction WHERE CandidateID=@MemberID
 DELETE FROM EduSphere.PostalAddresses WHERE MemberID=@MemberID
 DELETE FROM EduSphere.MemberDocuments WHERE MemberID=@MemberID
 DELETE FROM EduSphere.MemberAccount WHERE MemberID=@MemberID
 DELETE FROM EduSphere.MemberAcademics WHERE MemberID=@MemberID
 DELETE FROM EduSphere.Members WHERE MemberID=@MemberID
END

EXEC spDeleteMember 100
DROP PROCEDURE spDeleteMember

SELECT * FROM EduSphere.Members WHERE Email='s.ankita_23@yahoo.com'
Select MemberID,FullName,Email, PhoneOne FROM EduSphere.Members
SELECT * FROM EduSphere.Members WHERE MemberID='260'
SELECT * FROM EduSphere.Members WHERE FullName like '%Uday%'
DROP TABLE EduSphere.Members
ALTER TABLE EduSphere.Members ADD  ProgramID INT
ALTER TABLE EduSphere.Members ADD  BatchID INT

ALTER TABLE EduSphere.Member DROP COLUMN EMAIL
ALTER TABLE EduSphere.Members ADD  Anniversary DateTime
ALTER TABLE EduSphere.Member DROP CONSTRAINT  cstGender
ALTER TABLE EduSphere.Members DROP COLUMN Designation
ALTER TABLE EduSphere.Members ADD MaritalStatus VARCHAR(20) CONSTRAINT cstNeuroMS CHECK(MaritalStatus IN('SINGLE','MARRIED','SEPEARATED','DIVORCED','WIDOWED'))
ALTER TABLE EduSphere.Members ADD Remarks VARCHAR(100)
ALTER TABLE EduSphere.Members ADD MembershipValidForYears INT

ALTER TABLE EduSphere.Members ALTER COLUMN FullName VARCHAR(50)

ALTER TABLE EduSphere.Members DROP CONSTRAINT  cstMemType
ALTER TABLE EduSphere.Members DROP COLUMN MembershipType
ALTER TABLE EduSphere.Members ADD MembershipType varchar(20) CONSTRAINT cstMemType CHECK(MembershipType IN('NONE','STUDENT','ALUMNI'))
ALTER TABLE EduSphere.Members ADD  AcademicExamStatus varchar(50) CONSTRAINT cstExam CHECK(AcademicExamStatus IN('Passed','Failed','NotAppeared'))
ALTER TABLE EduSphere.Member ADD AccessRequestID INT CONSTRAINT cstRoleReqID FOREIGN KEY REFERENCES Edusphere.RoleRequests(RequestID)
--Add Proxy--
SET IDENTITY_INSERT EduSphere.Members ON
 INSERT INTO EduSphere.Members(MemberID,OrganizationID,FullName) VALUES('90','90','Proxy')
SET IDENTITY_INSERT EduSphere.Members OFF

SELECT * FROM EduSphere.Members WHERE FullName LIKE '%Uday%'
SELECT * FROM EduSphere.Members WHERE MemberID='3'
SELECT MemberID,FullName,Gender FROM EduSphere.Member WHERE MembershipStatus='ACTIVE' ORDER BY FullName ASC
SELECT OrganizationName,MemberID,FullName,st.PhoneOne,st.Email FROM EduSphere.Member st JOIN EduSphere.Organizations org ON st.OrganizationID=org.OrganizationID WHERE MembershipStatus='NOTACTIVE' ORDER BY st.FullName ASC
DELETE FROM EduSphere.Members WHERE MemberID='348'
SELECT OrganizationName,MemberID,FullName,st.PhoneOne,st.Email,st.MembershipStatus,st.AadhaarNumber,st.PanNumber,st.AcademicExamStatus,MembershipType 
                                                 FROM EduSphere.Members st 
                                                 JOIN EduSphere.Organizations org ON st.OrganizationID=org.OrganizationID 
                                                  WHERE MembershipStatus='NOTACTIVE' AND MembershipType!='STUDENT' OR MembershipType is null
                                                  ORDER BY st.MemberID DESC


UPDATE EduSphere.Members SET MEMBERSHIPTYPE='STUDENT' WHERE MemberID ='348'
-----------INSERT NEW Member-------------

CREATE PROCEDURE spInsertMember
@AccessRequestID INT,
@OrganizationID INT,
@ProgramID INT,
@PhotoPath varchar(100),
@FullName varchar(20),
@Gender VARCHAR(20),
@PhoneOne varchar(20),
@PhoneTwo varchar(20),
@Email    varchar(50),
@Designation varchar(50),
@DateOfBirth DateTime,
@FathersName VARCHAR(50),
@MothersName VARCHAR(50),
@PanNumber VARCHAR(20),
@AadhaarNumber VARCHAR(50),
@BankName VARCHAR(20),
@BankAccountNumber VARCHAR(20),
@BankIFSC VARCHAR(20),
@MentorId varchar(50),
@MembershipStatus varchar(10),
@DateOfJoining DateTime,
@MembershipType varchar(20),
@DateOfLeaving DateTime
AS
BEGIN
	INSERT INTO EduSphere.Members (AccessRequestID,RegCode,OrganizationID,ProgramID,PhotoPath,FullName,Gender,PhoneOne,PhoneTwo,Email,Designation,DateOfBirth,
	                                 FathersName,MothersName,PanNumber,AadhaarNumber,BankName,BankAccountNumber,BankIFSC,MentorId,MembershipStatus,DateOfJoining,MembershipType,DateOfLeaving) 
	                   values(@AccessRequestID,NEWID(),@OrganizationID,@ProgramID,@PhotoPath,@FullName,@Gender,@PhoneOne,@PhoneTwo,@Email,@Designation,@DateOfBirth,
					                   @FathersName,@MothersName,@PanNumber,@AadhaarNumber,@BankName,@BankAccountNumber,@BankIFSC,@MentorId,@MembershipStatus,@DateOfJoining,@MembershipType,@DateOfLeaving)
	--CREATE Account--
	DECLARE @MemberId int = (SELECT TOP 1 MemberId from EduSphere.Members ORDER BY MemberId DESC)
	INSERT INTO EduSphere.MemberAccount (MemberId,SkuId,TxDate, Notes,ConsultantOneID,DebitAmount,CreditAmount, BalanceAmount) 
	                                       values(@MemberId,90,GETDATE(),'Account Created',90,0,0,0)
END

drop procedure spInsertMember

insert into Users (UserEmpID) values('E11136')
update Users set UserRole='Member' where UserEmpId='E1210'
-----------------------------------------------------------------

CREATE PROCEDURE spUpdateMember
@MemberID int,
@OrganizationID INT,
@ProgramID INT,
@MaritalStatus VARCHAR(20),
@PhotoPath varchar(100),
@FullName varchar(20),
@PhoneOne varchar(20),
@PhoneTwo varchar(20),
@Email    varchar(50),
@Designation varchar(50),
@DateOfBirth DateTime,
@FathersName VARCHAR(50),
@MothersName VARCHAR(50),
@PanNumber VARCHAR(20),
@AadhaarNumber VARCHAR(50),
@BankName VARCHAR(20),
@BankAccountNumber VARCHAR(20),
@BankIFSC VARCHAR(20),
@AcademicExamStatus varchar(50),
@MentorId varchar(50),
@MembershipStatus varchar(10),
--@DateOfJoining DateTime,--
@MembershipValidForYears INT,
@MembershipType varchar(20),
@DateOfLeaving DateTime
AS
BEGIN
	UPDATE EduSphere.Members SET OrganizationID=@OrganizationID,ProgramID=@ProgramID,PhotoPath=@PhotoPath,FullName=@FullName,PhoneOne=@PhoneOne,PhoneTwo=@PhoneTwo,Email=@Email,
	                              Designation=@Designation,DateOfBirth=@DateOfBirth,MaritalStatus=@MaritalStatus,
								  FathersName=@FathersName,MothersName=@MothersName,PanNumber=@PanNumber,AadhaarNumber=@AadhaarNumber,BankName=@BankName,
								  BankAccountNumber=@BankAccountNumber,BankIFSC=@BankIFSC,AcademicExamStatus=@AcademicExamStatus,MentorId=@MentorId,MembershipStatus=@MembershipStatus,
								  MembershipValidForYears=@MembershipValidForYears,MembershipType=@MembershipType,DateOfLeaving=@DateOfLeaving WHERE MemberID=@MemberID
	
------Update Pan & Aadhaaer File Paths in Documents table---
END

drop procedure spUpdateMember
---------------------------------------------------------------------------------------------
CREATE PROCEDURE spUpdateMembership
@MemberID int,
@Designation varchar(50),
@MembershipType varchar(20),
@MembershipStatus varchar(10),
@MembershipValidForYears INT
AS
BEGIN
    UPDATE EduSphere.Members SET Designation=@Designation,
	                                     MembershipType=@MembershipType,
	                                     MembershipStatus=@MembershipStatus,
	                                     DateOfJoining=(SELECT GETDATE()),
										 MembershipValidForYears=@MembershipValidForYears,
										 MembershipExpiryDate=(SELECT DATEADD(year,@MembershipValidForYears,GETDATE())),
										 DateOfLeaving=(SELECT DATEADD(year,@MembershipValidForYears,GETDATE()))
                                   WHERE MemberID=@MemberID
END

DROP PROCEDURE spUpdateMembership

EXEC spUpdateMembership 100,'testDesg','NONE','ACTIVE',GETDATE,'1',DATEADD(year,1,getdate)),'01/01/1900'
-------------------------------------------------------------------------------------------
CREATE TABLE EduSphere.PostalAddresses
(
AddressID INT IDENTITY(100,1) CONSTRAINT cstAddressPK PRIMARY KEY, 
MemberID INT CONSTRAINT cstMemIDFK FOREIGN KEY REFERENCES EduSphere.Members(MemberID),
AddressType VARCHAR(50) CONSTRAINT chkAdrType CHECK(AddressType IN('PERMANENT','CORRESPONDENCE')),
PostalAddress varchar(200),
City varchar(50),
PinCode varchar(20),
State varchar(50),
Country varchar(50),
)

DROP TABLE EduSphere.PostalAddresses
SELECT * FROM EduSphere.PostalAddresses

ALTER TABLE EduSphere.PostalAddresses DROP CONSTRAINT  chkAdrType
ALTER TABLE EduSphere.PostalAddresses DROP COLUMN AddressType
ALTER TABLE EduSphere.PostalAddresses ADD AddressType VARCHAR(50) CONSTRAINT chkAdrType CHECK(AddressType IN('PERMANENT','CORRESPONDENCE'))

SET IDENTITY_INSERT EduSphere.PostalAddresses ON
 INSERT INTO EduSphere.PostalAddresses(AddressID,MemberID,AddressType,PostalAddress) VALUES('90','90','PROXY','ProxyAddress')
SET IDENTITY_INSERT EduSphere.PostalAddresses OFF

SELECT * FROM EduSphere.PostalAddresses
DELETE FROM EduSphere.PostalAddresses WHERE MemberID='166'
UPDATE EduSphere.PostalAddresses SET AddressType='CORRESPONDENCE' WHERE AddressID='101' OR AddressID='105' OR AddressID='109' OR 

SELECT n.MemberID,p.PostalAddress as PermAddr FROM EduSphere.Members n
        JOIN EduSphere.PostalAddresses p ON n.MemberID=p.MemberID 
		WHERE n.MemberID='101' GROUP BY n.MemberID,p.PostalAddress 
------------------------------------------------------------------------------------------
CREATE PROCEDURE spInsertPostalAddress
@MemberID INT,
@AddressType VARCHAR(50)
AS
BEGIN
  INSERT INTO EduSphere.PostalAddresses(MemberID,AddressType) VALUES(@MemberID,@AddressType)
END


------------------------------------------------------------------------------------------
CREATE PROCEDURE spUpdateAddress
@Id INT,
@AddressType VARCHAR(20),
@PostalAddress varchar(200),
@City varchar(50),
@PinCode varchar(20),
@State varchar(50),
@Country varchar(50),
@CorresAdrSameAsPermaAdr VARCHAR(10)
AS
BEGIN
    UPDATE EduSphere.PostalAddresses SET PostalAddress=@PostalAddress,
									  City=@City,									 
									  PinCode=@PinCode,
									  State=@State,
									  Country=@Country 
									  WHERE MemberID=@ID AND AddressType=@AddressType 
IF(@CorresAdrSameAsPermaAdr='YES')
	BEGIN
	UPDATE EduSphere.PostalAddresses SET PostalAddress=@PostalAddress,
									  City=@City,									 
									  PinCode=@PinCode,
									  State=@State,
									  Country=@Country 
									  WHERE MemberID=@ID AND AddressType='CORRESPONDENCE' 
	END 
END

DROP PROCEDURE spUpdateAddress
------------------------------------------------------------------------------------------
create procedure spDeleteEmployee
@EmployeesID varchar(50)
AS
BEGIN
delete  from EduSphere.Photos where EmployeesID=@EmployeesID
delete  from EduSphere.EmpContacts where EmployeesID=@EmployeesID
delete  from EduSphere.Employees where EmployeesID=@EmployeesID
delete from Users where UserEmpID=@EmployeesID
END

EXEC spDeleteEmployee 100
drop procedure spDeleteEmployee
---------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------
create table EduSphere.MemberDocuments
(
DocumentId INT IDENTITY(100,1) CONSTRAINT neurodocPK PRIMARY KEY,
DocumentType VARCHAR(50) CONSTRAINT cstDocType CHECK(DocumentType IN('PAN','AADHAR','BIRTH-CERT','SCHOOL-CERT','GRAD-CERT','PG-CERT','NEUROTHERAPY-CERT','PROFESSIONAL-CERT','OTHERS')),
UploadDate DATETIME,
MemberID INT constraint fkpNeuroId FOREIGN KEY REFERENCES EduSphere.Members(MemberID),
DocumentTitle varchar(100),
DocumentPath  varchar(100),
)
ALTER TABLE EduSphere.MemberDocuments ADD UplodeDate DATETIME
ALTER TABLE EduSphere.MemberDocuments DROP CONSTRAINT cstDocType
ALTER TABLE EduSphere.MemberDocuments DROP COLUMN DocumentType
ALTER TABLE EduSphere.MemberDocuments ADD DocumentType VARCHAR(50) CONSTRAINT cstDocType CHECK(DocumentType IN('PAN','AADHAAR','BIRTH-CERT','SCHOOL-CERT','GRAD-CERT','PG-CERT','NEUROTHERAPY-CERT','PROFESSIONAL-CERT','OTHERS'))
drop table EduSphere.MemberDocuments 
select * from EduSphere.MemberDocuments
TRUNCATE TABLE EduSphere.MemberDocuments
alter table EduSphere.MemberDocuments drop constraint fkpEmployeesId
truncate table EduSphere.MemberDocuments

DELETE FROM EduSphere.MemberDocuments WHERE MemberID='101'
UPDATE EduSphere.MemberDocuments SET DocumentType='AADHAAR'
------------------------------------------------------------------------------------------
create procedure spInsertMemberDocument
@MemberID INT,
@UploadDate DATETIME,
@DocumentTitle varchar(100),
@DocumentPath  varchar(100)
AS
BEGIN
	INSERT INTO EduSphere.MemberDocuments (MemberID,UploadDate,DocumentTitle,DocumentPath) values(@MemberID,@UploadDate,@DocumentTitle,@DocumentPath)
END

drop procedure spInsertMemberDocument
-------------------------------------------------------------------------------------------
CREATE PROCEDURE spUpdate

-------------------------------------------------------------------------------------------
create procedure spFilterMember
@DepartmentID varchar(50),
@MembershipStatus varchar(10)
AS
BEGIN	
select  * from EduSphere.Employees emp JOIN EduSphere.Photos ph ON emp.EmployeesID=ph.EmployeesID JOIN EduSphere.EmpContacts cnt on emp.EmployeesID=cnt.EmployeesID where (DepartmentID=@DepartmentID AND MembershipStatus=@MembershipStatus )		
END

execute spFilterMember
drop procedure spFilterMember
------------------------------------------------------------------------------------------------
create procedure spEmpSummary
@CountTeachingMember int output,
@DepartmentID varchar(50),
@MembershipStatus varchar(10)
AS
BEGIN
 declare @retValue int
 declare @retNotActive int
	select @retValue = count(*) from EduSphere.Employees where DepartmentID=@DepartmentID and MembershipStatus=@MembershipStatus
 set  @CountTeachingMember=@retValue
END

drop procedure spEmpSummary
execute spEmpSummary
------------------------------------------
create table EduSphere.MemberAcademics
(
AcadID int identity(1,1) constraint pkNeueoAcadID PRIMARY KEY,
MemberID INT constraint fkNeuroID FOREIGN KEY REFERENCES EduSphere.Members(MemberID),
Degree varchar(100),
Institute varchar(100),
University varchar(50),
StartDate datetime,
CompletionYear datetime,
Grade varchar(20)
)

ALTER TABLE EduSphere.MemberAcademics ADD StartDate datetime
DROP TABLE EduSphere.MemberAcademics
select * from EduSphere.MemberAcademics
SELECT * FROM EduSphere.MemberAcademics where MemberID='101'
DELETE FROM EduSphere.MemberAcademics WHERE MemberID='101'

create procedure spInsertMemberDegree
@MemberID INT,
@Degree varchar(100)='New Qualification',
@Institute varchar(100)='Institute',
@University varchar(50)='' ,
@StartDate datetime='',
@CompletionYear datetime='',
@Grade varchar(20)=''
AS
BEGIN
 insert into EduSphere.MemberAcademics values(@MemberID,@Degree,@Institute,@University,@StartDate,@CompletionYear,@Grade)
END

drop procedure  spInsertMemberDegree
execute spInsertMemberDegree

UPDATE EduSphere.MemberAcademics SET Grade='60.33%'
--------------------------------------------------------------------------------------------
create procedure spUpdateMemberDegree
@AcadID int,
@Degree varchar(100),
@Institute varchar(100),
@University varchar(50),
@StartDate datetime,
@CompletionYear datetime,
@Grade varchar(20)
AS
BEGIN
update EduSphere.MemberAcademics set Degree=@Degree,Institute=@Institute,University=@University,StartDate=@StartDate,CompletionYear=@CompletionYear,Grade=@Grade where AcadID=@AcadID
END

drop procedure spUpdateMemberDegree 
-----------------------------------------------------------------------

create table EduSphere.EmpExperience
(
EmpExpID int identity(1,1) constraint pkExpID PRIMARY KEY,
EmployeesID varchar(50) constraint fkEmID FOREIGN KEY REFERENCES EduSphere.Employees(EmployeesID),
Designation varchar(100),
OrgName varchar(100),
FromDate datetime,
ToDate datetime,
Achievements varchar(200)
)
-------------------------------------------------------------------------------------------
create table EduSphere.Publications
(
PublicationID int identity(1,1) constraint pkNeuroPubID PRIMARY KEY,
MemberID varchar(50),
PublicationType varchar(50),
PublicationCode varchar(50),
PublicationTitle varchar(100),
PublicationDescription varchar(300),
PublishDate datetime,
PublisherDetails varchar(100),
Remarks varchar(100),
)

select * FROM EduSphere.Publications
SELECT * FROM EduSphere.Publications WHERE MemberID='101'
truncate table EduSphere.Publications
drop table EduSphere.Publications

create procedure spMemberPublication
@Action varchar(10),
@MemberID varchar(20),
@PublicationID int,
@PublicationType varchar(50),
@PublicationCode varchar(50),
@PublicationTitle varchar(100),
@PublicationDescription varchar(300),
@PublishDate datetime,
@PublisherDetails varchar(100),
@Remarks varchar(100)
AS
BEGIN
 if(@Action='INSERT')
	INSERT INTO EduSphere.Publications (MemberID,PublicationType,PublicationCode,PublicationTitle,PublicationDescription,PublishDate,PublisherDetails,Remarks)  values (@MemberID,@PublicationType,@PublicationCode,@PublicationTitle,@PublicationDescription,@PublishDate,@PublisherDetails,@Remarks)
 if(@Action='UPDATE')
    UPDATE EduSphere.Publications SET PublicationType=@PublicationType,PublicationCode=@PublicationCode,PublicationTitle=@PublicationTitle,PublicationDescription=@PublicationDescription,PublishDate=@PublishDate,PublisherDetails=@PublisherDetails,Remarks=@Remarks WHERE PublicationID=@PublicationID
END


drop procedure spMemberPublication 
select count(*) from EduSphere.Employees
