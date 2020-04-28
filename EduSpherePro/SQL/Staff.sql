----------Staff Details-----------------------
CREATE TABLE EduSphere.Staff
(
EmpCode uniqueidentifier NOT NULL DEFAULT newid(),
EmployeeId INT IDENTITY (100,1) CONSTRAINT cstEmpIdPK PRIMARY KEY ,
AccessRequestID INT CONSTRAINT cstRoleReqID FOREIGN KEY REFERENCES Edusphere.RoleRequests(RequestID),
OrganizationID INT constraint cstOrgIdFK FOREIGN KEY REFERENCES EduSphere.Organizations(OrganizationID),
EmpPhotoPath varchar(100),
FullName varchar(20),
Gender VARCHAR(20) CONSTRAINT cstStaffGender CHECK(Gender IN('MALE','FEMALE')),
PhoneOne varchar(20),
PhoneTwo varchar(20),
Email    varchar(50),
ContactAddress varchar(256),
City varchar(50),
District varchar(50),
PinCode varchar(20),
State varchar(50),
Country varchar(50),
Designation varchar(20),
DateOfBirth DateTime,
FathersName VARCHAR(50),
MothersName VARCHAR(50),
PanNumber VARCHAR(20),
AadhaarNumber VARCHAR(50),
BankName VARCHAR(20),
BankAccountNumber VARCHAR(20),
BankIFSC VARCHAR(20),
ManagerID varchar(50),
DepartmentID INT,
EmploymentStatus varchar(10) constraint cstCheckStatus CHECK(EmploymentStatus IN('ACTIVE','NOTACTIVE')),
DateOfJoining DateTime,
EmploymentType varchar(20) CONSTRAINT cstEmpType CHECK(EmploymentType IN('EMPLOYEE','CONTRACT')),
DateOfLeaving DateTime
)

ALTER TABLE EduSphere.Staff ALTER COLUMN FullName VARCHAR(50)

ALTER TABLE EduSphere.Staff DROP COLUMN EMAIL
ALTER TABLE EduSphere.Staff ADD  EMAIL varchar(50)
ALTER TABLE EduSphere.Staff DROP CONSTRAINT  cstStaffGender
ALTER TABLE EduSphere.Staff DROP COLUMN Gender
ALTER TABLE EduSphere.Staff ADD Gender VARCHAR(20) CONSTRAINT cstStaffGender CHECK(Gender IN('MALE','FEMALE'))
sp_help 'EduSphere.Staff'
DROP TABLE EduSphere.Staff 

ALTER TABLE EduSphere.Staff ADD AccessRequestID INT CONSTRAINT cstRoleReqID FOREIGN KEY REFERENCES Edusphere.RoleRequests(RequestID)
--Add Proxy--
SET IDENTITY_INSERT EduSphere.Staff ON
 INSERT INTO EduSphere.Staff(EmployeeId,OrganizationID,FullName) VALUES('90','90','Proxy')
SET IDENTITY_INSERT EduSphere.Staff OFF

SELECT * FROM EduSphere.Staff WHERE Email LIKE '%balwant%'
SELECT * FROM EduSphere.Staff WHERE EmployeeId='100'
SELECT EmployeeID,FullName,Gender FROM EduSphere.Staff WHERE EmploymentStatus='ACTIVE' ORDER BY FullName ASC
SELECT OrganizationName,EmployeeId,FullName,st.PhoneOne,st.Email FROM EduSphere.Staff st JOIN EduSphere.Organizations org ON st.OrganizationID=org.OrganizationID WHERE EmploymentStatus='NOTACTIVE' ORDER BY st.FullName ASC
DELETE FROM EduSphere.Staff WHERE EmployeeId>='100'
SELECT OrganizationName,EmployeeId,FullName,st.PhoneOne,st.Email FROM EduSphere.Staff st JOIN EduSphere.Organizations org ON st.OrganizationID=org.OrganizationID WHERE EmploymentStatus='NOTACTIVE' ORDER BY st.FullName ASC
UPDATE EduSphere.Staff SET EmploymentStatus='ACTIVE' WHERE EmployeeId='100'

SELECT FullName,Email,OrgID FROM EduSphere.Staff WHERE Email='101'
SELECT OrganizationName,o.OrganizationID FROM EduSphere.Organizations o JOIN EduSphere.Staff e ON o.OrganizationID=e.OrganizationID WHERE e.Email='bhuvi.d@speedjetaviation.com'
 
-----------INSERT NEW STAFF-------------
CREATE PROCEDURE spInsertStaff
--@AccessRequestID INT,
@OrganizationID INT,
@EmpPhotoPath varchar(100),
@FullName varchar(50),
@Gender VARCHAR(20),
@PhoneOne varchar(20),
@PhoneTwo varchar(20),
@Email    varchar(50),
@ContactAddress varchar(256),
@City varchar(50),
@District varchar(50),
@PinCode varchar(20),
@State varchar(50),
@Country varchar(50),
@Designation varchar(20),
@DateOfBirth DateTime,
@FathersName VARCHAR(50),
@MothersName VARCHAR(50),
@PanNumber VARCHAR(20),
@AadhaarNumber VARCHAR(50),
@BankName VARCHAR(20),
@BankAccountNumber VARCHAR(20),
@BankIFSC VARCHAR(20),
@ManagerId varchar(50),
@EmploymentStatus varchar(10),
@DateOfJoining DateTime,
@EmploymentType varchar(20),
@DateOfLeaving DateTime
AS
BEGIN
	INSERT INTO EduSphere.Staff (EmpCode,OrganizationID,EmpPhotoPath,FullName,Gender,PhoneOne,PhoneTwo,Email,ContactAddress,City,District,PinCode,State,Country,Designation,DateOfBirth,
	                                 FathersName,MothersName,PanNumber,AadhaarNumber,BankName,BankAccountNumber,BankIFSC,ManagerId,EmploymentStatus,DateOfJoining,EmploymentType,DateOfLeaving) 
	                   values(NEWID(),@OrganizationID,@EmpPhotoPath,@FullName,@Gender,@PhoneOne,@PhoneTwo,@Email,@ContactAddress,@City,@District,@PinCode,@State,@Country,@Designation,@DateOfBirth,
					                   @FathersName,@MothersName,@PanNumber,@AadhaarNumber,@BankName,@BankAccountNumber,@BankIFSC,@ManagerId,@EmploymentStatus,@DateOfJoining,@EmploymentType,@DateOfLeaving)
	
END

drop procedure spInsertStaff

insert into Users (UserEmpID) values('E11136')
update Users set UserRole='Member' where UserEmpId='E1210'
-----------------------------------------------------------------

CREATE PROCEDURE spUpdateStaff
@EmployeeId int,
@OrganizationID varchar(20),
@EmpPhotoPath varchar(100),
@FullName varchar(20),
@PhoneOne varchar(20),
@PhoneTwo varchar(20),
@Email    varchar(50),
@ContactAddress varchar(256),
@City varchar(50),
@District varchar(50),
@PinCode varchar(20),
@State varchar(50),
@Country varchar(50),
@Designation varchar(20),
@DateOfBirth DateTime,
@FathersName VARCHAR(50),
@MothersName VARCHAR(50),
@PanNumber VARCHAR(20),
@AadhaarNumber VARCHAR(50),
@BankName VARCHAR(20),
@BankAccountNumber VARCHAR(20),
@BankIFSC VARCHAR(20),
@ManagerId varchar(50),
@EmploymentStatus varchar(10),
@DateOfJoining DateTime,
@EmploymentType varchar(20),
@DateOfLeaving DateTime
AS
BEGIN
	UPDATE EduSphere.Staff SET OrganizationID=@OrganizationID,EmpPhotoPath=@EmpPhotoPath,FullName=@FullName,PhoneOne=@PhoneOne,PhoneTwo=@PhoneTwo,Email=@Email,ContactAddress=@ContactAddress,
	                              City=@City,District=@District,PinCode=@PinCode,State=@State,Country=@Country,Designation=@Designation,DateOfBirth=@DateOfBirth,
								  FathersName=@FathersName,MothersName=@MothersName,PanNumber=@PanNumber,AadhaarNumber=@AadhaarNumber,BankName=@BankName,
								  BankAccountNumber=@BankAccountNumber,BankIFSC=@BankIFSC,ManagerId=@ManagerId,EmploymentStatus=@EmploymentStatus,
								  DateOfJoining=@DateOfJoining,EmploymentType=@EmploymentType,DateOfLeaving=@DateOfLeaving WHERE EmployeeId=@EmployeeId
	
END

drop procedure spUpdateStaff
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
create table EduSphere.StaffDocuments
(
DocumentId INT IDENTITY(100,1) CONSTRAINT docPK PRIMARY KEY,
UploadDate DATETIME,
EmployeeId INT constraint fkpEmployeesId FOREIGN KEY REFERENCES EduSphere.Staff(EmployeeId),
DocumentTitle varchar(100),
DocumentPath  varchar(100),
)
ALTER TABLE EduSphere.StaffDocuments ADD UplodeDate DATETIME
drop table EduSphere.StaffDocuments 
select * from EduSphere.StaffDocuments
TRUNCATE TABLE EduSphere.StaffDocuments
alter table EduSphere.StaffDocuments drop constraint fkpEmployeesId
truncate table EduSphere.StaffDocuments
------------------------------------------------------------------------------------------
create procedure spInsertStaffDocument
@EmployeeId INT,
@UploadDate DATETIME,
@DocumentTitle varchar(100),
@DocumentPath  varchar(100)
AS
BEGIN
	INSERT INTO EduSphere.StaffDocuments (EmployeeId,UploadDate,DocumentTitle,DocumentPath) values(@EmployeeId,@UploadDate,@DocumentTitle,@DocumentPath)
END

drop procedure spInsertStaffDocument
-------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------
create procedure spFilterStaff
@DepartmentID varchar(50),
@EmploymentStatus varchar(10)
AS
BEGIN	
select  * from EduSphere.Employees emp JOIN EduSphere.Photos ph ON emp.EmployeesID=ph.EmployeesID JOIN EduSphere.EmpContacts cnt on emp.EmployeesID=cnt.EmployeesID where (DepartmentID=@DepartmentID AND EmploymentStatus=@EmploymentStatus )		
END

execute spFilterStaff
drop procedure spFilterStaff
------------------------------------------------------------------------------------------------
create procedure spEmpSummary
@CountTeachingStaff int output,
@DepartmentID varchar(50),
@EmploymentStatus varchar(10)
AS
BEGIN
 declare @retValue int
 declare @retNotActive int
	select @retValue = count(*) from EduSphere.Employees where DepartmentID=@DepartmentID and EmploymentStatus=@EmploymentStatus
 set  @CountTeachingStaff=@retValue
END

drop procedure spEmpSummary
execute spEmpSummary
------------------------------------------
create table EduSphere.EmpAcademics
(
EmpAcadID int identity(1,1) constraint pkEmpAcadID PRIMARY KEY,
EmployeesID INT constraint fkEmpID FOREIGN KEY REFERENCES EduSphere.Staff(EmployeeID),
Degree varchar(100),
Institute varchar(100),
University varchar(50),
CompletionYear datetime,
Grade varchar(20)
)

select * from EduSphere.EmpAcademics
DROP TABLE EduSphere.EmpAcademics
create procedure spInsertEmpDegree
@EmployeeID INT,
@Degree varchar(100)='New Qualification',
@Institute varchar(100)='Institute',
@University varchar(50)='' ,
@CompletionYear datetime='',
@Grade varchar(20)=''
AS
BEGIN
 insert into EduSphere.EmpAcademics values(@EmployeeID,@Degree,@Institute,@University,@CompletionYear,@Grade)
END

drop procedure  spInsertEmpDegree
execute spInsertEmpDegree
--------------------------------------------------------------------------------------------
create procedure spUpdateEmpDegree
@EmpAcadID int,
@Degree varchar(100),
@Institute varchar(100),
@University varchar(50),
@CompletionYear datetime,
@Grade varchar(20)
AS
BEGIN
update EduSphere.EmpAcademics set Degree=@Degree,Institute=@Institute,University=@University,CompletionYear=@CompletionYear,Grade=@Grade where EmpAcadID=@EmpAcadID
END

drop procedure spUpdateEmpDegree 
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
create table EduSphere.EmpPublications
(
EmpPublicationID int identity(1,1) constraint pkPubID PRIMARY KEY,
EmployeesID varchar(50),
PublicationType varchar(50),
PublicationCode varchar(50),
PublicationTitle varchar(100),
PublicationDescription varchar(300),
PublishDate datetime,
PublisherDetails varchar(100),
Remarks varchar(100),
)

select * FROM EduSphere.EmpPublications
truncate table EduSphere.EmpPublications
drop table EduSphere.EmpPublications

create procedure spEmpPublication
@Action varchar(10),
@EmployeesID varchar(20),
@EmpPublicationID int,
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
	INSERT INTO EduSphere.EmpPublications (EmployeesID,PublicationType,PublicationCode,PublicationTitle,PublicationDescription,PublishDate,PublisherDetails,Remarks)  values (@EmployeesID,@PublicationType,@PublicationCode,@PublicationTitle,@PublicationDescription,@PublishDate,@PublisherDetails,@Remarks)
 if(@Action='UPDATE')
    UPDATE EduSphere.EmpPublications SET PublicationType=@PublicationType,PublicationCode=@PublicationCode,PublicationTitle=@PublicationTitle,PublicationDescription=@PublicationDescription,PublishDate=@PublishDate,PublisherDetails=@PublisherDetails,Remarks=@Remarks WHERE EmpPublicationID=@EmpPublicationID
END


drop procedure spEmpPublication 
select count(*) from EduSphere.Employees
