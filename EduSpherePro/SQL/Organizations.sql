create schema EduSphere

---Diffrennt Business Organizations invloved---
create table EduSphere.Organizations
(
OrganizationID int identity(100,1) constraint cstCustPK PRIMARY KEY,
OrganizationName varchar(100),
OrganizationType varchar(50) CONSTRAINT cstOrgType CHECK(OrganizationType IN('EDUCATION-CENTRE','EMPLOYER','VENDOR')), 
ManagerName varchar(50),
ManagerEmail varchar(50),
ManagerPhone varchar(50),
ContactPerson varchar(50),
PhoneOne varchar(20),
PhoneTwo varchar(20),
Email varchar(50),
OfficeAddress varchar (200),
EnrolmentDate datetime,
MemberPhoto varchar(100),
Remarks varchar(200),
Notify varchar(10) CONSTRAINT cstNtfy CHECK(Notify IN('YES','NO')),
street_number VARCHAR(10),
route VARCHAR(100),
locality VARCHAR(50),
administrative_area_level_1 VARCHAR(50),
postal_code VARCHAR(20),
country VARCHAR(50),
GstNumbar VARCHAR(50)
)

ALTER TABLE EduSphere.Organizations DROP CONSTRAINT cstOrgType
ALTER TABLE EduSphere.Organizations DROP COLUMN GstNumbar
ALTER TABLE EduSphere.Organizations ADD OrganizationType varchar(50) CONSTRAINT cstOrgType CHECK(OrganizationType IN('TREATMENT-CENTRE','EDUCATION-CENTRE','EMPLOYER','VENDOR')) 

ALTER TABLE EduSphere.Organizations DROP  COLUMN GstNumbar
ALTER TABLE EduSphere.Organizations ADD  GstNumber VARCHAR(50)

ALTER TABLE EduSphere.Organizations DROP  COLUMN GstNumbar
ALTER TABLE EduSphere.Organizations ADD  Email VARCHAR(50)

ALTER TABLE EduSphere.Organizations ADD  GstNumber VARCHAR(50)
ALTER TABLE EduSphere.Organizations ADD  route VARCHAR(100)
ALTER TABLE EduSphere.Organizations ADD  locality VARCHAR(50)
ALTER TABLE EduSphere.Organizations ADD  administrative_area_level_1 VARCHAR(50)
ALTER TABLE EduSphere.Organizations ADD  postal_code VARCHAR(20)
ALTER TABLE EduSphere.Organizations ADD  country VARCHAR(50)

DELETE FROM EduSphere.FinAccountDetails WHERE 100<=OrganizationID AND OrganizationID<105
DELETE FROM EduSphere.Organizations WHERE 100<=OrganizationID AND OrganizationID<105
DELETE FROM EduSphere.Organizations WHERE OrganizationID=100

SELECT * FROM EduSphere.Organizations
SELECT OrganizationName,OrganizationID FROM EduSphere.Organizations
SELECT OrganizationID,OrganizationName FROM EduSphere.Organizations WHERE OrganizationType='EMPLOYER'
SELECT * FROM EduSphere.PlacementDrives d JOIN EduSphere.Organizations o ON d.EmployerID=o.OrganizationID ORDER BY DriveDate DESC
--Add Proxy--
SET IDENTITY_INSERT EduSphere.Organizations ON
 INSERT INTO EduSphere.Organizations(OrganizationID,OrganizationName,OrganizationType) VALUES('90','Proxy','EDUCATION-CENTRE')
SET IDENTITY_INSERT EduSphere.Organizations OFF

INSERT INTO EduSphere.Organizations(OrganizationName,OrganizationType) VALUES('PSIMS-Mumbai','EDUCATION-CENTRE')
UPDATE EduSphere.Organizations SET ManagerEmail='sushmita.kumari@speedjetaviation.com' WHERE ManagerEmail='sushmita.kumari@speedjetaviati'

UPDATE EduSphere.Organizations SET GstNumber='27ADMFS2775D1ZS'
-----------------------------------------------
------DEPARMENTS-------
--create table EduSphere.Departments
--(
--DepartmentID int identity(100,1) constraint cstDeptPK PRIMARY KEY,
--DepartmentName varchar(100),
--)

--DROP TABLE EduSphere.Departments
--INSERT INTO EduSphere.Departments VALUES('AVIATION')
--INSERT INTO EduSphere.Departments VALUES('MANAGEMENT')

--Add Proxy--
--SET IDENTITY_INSERT EduSphere.Departments ON
-- INSERT INTO EduSphere.Departments(DepartmentID,DepartmentName) VALUES('90','ProxyDepartment')
--SET IDENTITY_INSERT EduSphere.Departments OFF

--SELECT * FROM EduSphere.Departments 

-----------------------------------------------------------------------------------------
create procedure spInsertOrganization
@OrganizationName varchar(50),
@OrganizationType varchar(50),
@ManagerName varchar(50),
@ManagerEmail varchar(50),
@ManagerPhone varchar(50),
@ContactPerson varchar(50),
@PhoneOne varchar(20),
@PhoneTwo varchar(20),
@Email varchar(50),
@OfficeAddress varchar (200),
@EnrolmentDate datetime,
@MemberPhoto varchar(100),
@Remarks varchar(200),
@Notify varchar(10),
@street_number VARCHAR(10),
@route VARCHAR(100),
@locality VARCHAR(50),
@administrative_area_level_1 VARCHAR(50),
@postal_code VARCHAR(20),
@country VARCHAR(50)
AS
BEGIN 
	insert into EduSphere.Organizations (OrganizationName,OrganizationType,ManagerName,ManagerEmail,ManagerPhone,ContactPerson,PhoneOne,PhoneTwo,Email,OfficeAddress,EnrolmentDate,MemberPhoto,Remarks,Notify,street_number,route,locality,administrative_area_level_1,postal_code,country)
	                             values(@OrganizationName,@OrganizationType,@ManagerName,@ManagerEmail,@ManagerPhone,@ContactPerson,@PhoneOne,@PhoneTwo,@Email,@OfficeAddress,@EnrolmentDate,@MemberPhoto,@Remarks,@Notify,@street_number,@route,@locality,@administrative_area_level_1,@postal_code,@country)
	DECLARE @OrganizationId int = (SELECT TOP 1 OrganizationId from EduSphere.Organizations ORDER BY OrganizationId DESC)
	EXEC spInsertFinAccountDetails @OrganizationId,'','','','','','',''	
END

exec [dbo].[spInsertOrganization]
drop procedure spInsertOrganization

EXEC spInsertFinAccountDetails 2,'','','','','','',''
--------------------------------------------------------------------------------------------
create procedure spUpdateOrganization
@OrganizationId int,
@OrganizationName varchar(50),
@ManagerName varchar(50),
@ManagerEmail varchar(30),
@ManagerPhone varchar(50),
@ContactPerson varchar(50),
@PhoneOne varchar(20),
@PhoneTwo varchar(20),
@Email varchar(30),
@OfficeAddress varchar (200),
@MemberPhoto varchar(100),
@Remarks varchar(200),
@Notify varchar(10)
AS
BEGIN
 UPDATE EduSphere.Organizations set OrganizationName=@OrganizationName,ManagerName=@ManagerName,ManagerEmail=@ManagerEmail,ManagerPhone=@ManagerPhone,ContactPerson=@ContactPerson,PhoneOne=@PhoneOne,PhoneTwo=@PhoneTwo,Email=@Email,OfficeAddress=@OfficeAddress,
                                     MemberPhoto=@MemberPhoto, Remarks=@Remarks,Notify=@Notify WHERE OrganizationId=@OrganizationId
END

drop procedure spUpdateOrganization
-----------------------------------------------------------------------------------------
create procedure spDeleteOrganization
@OrganizationId int
AS
BEGIN
-----Delete all Postal Address of Members belonging to that Organization---
delete from EduSphere.PostalAddresses where MemberId=(SELECT TOP 1 MemberID FROM EduSphere.Members WHERE OrganizationID=@OrganizationId)

-----Delete all Learning Tokens assigned to Students of that Organization---
delete from EduSphere.LearningTokens where MemberId=(SELECT TOP 1 MemberID FROM EduSphere.Members WHERE OrganizationID=@OrganizationID)
-----Delete all Attendace of Members of that Organization---
delete from Evaluations.CandidateTestAttendance where CandidateId=(SELECT TOP 1 MemberID FROM EduSphere.Members WHERE OrganizationID=@OrganizationID)
delete from Evaluations.OnlineTestTransaction where CandidateId=(SELECT TOP 1 MemberID FROM EduSphere.Members WHERE OrganizationID=@OrganizationID)
delete from EduSphere.StudentAttendance where StudentId=(SELECT TOP 1 MemberID FROM EduSphere.Members WHERE OrganizationID=@OrganizationID)




-----Delete all MemberAccounts of Members belonging to that Organization---
delete from EduSphere.MemberAccount where MemberId=(SELECT TOP 1 MemberID FROM EduSphere.Members WHERE OrganizationID=@OrganizationID)
delete from EduSphere.FinAccountDetails where OrganizationId=@OrganizationId
delete from EduSphere.Organizations where OrganizationId=@OrganizationId
delete from EduSphere.Members where OrganizationId=@OrganizationId
delete from EduSphere.RoleRequests where OrganizationId=@OrganizationId

END

execute spDeleteOrganization 101
 
drop procedure spDeleteOrganization
select * from EduSphere.Organizations
UPDATE EduSphere.Organizations SET OrganizationTYpe='FRANCHISEE' WHERE OrganizationID='102'
----------------------------------------------------------------------------------------

CREATE TABLE EduSphere.FinAccountDetails
(
OrganizationId INT CONSTRAINT cstOrg FOREIGN KEY REFERENCES EduSphere.Organizations(OrganizationId),
GoodsAndServicesTaxCode VARCHAR(50),
ServiceTaxCode VARCHAR(50),
ValueAddedTaxCode VARCHAR(50),
PermanentAccountNumber VARCHAR(50),
BankName VARCHAR(50),
BankAccountNumber VARCHAR(50),
BankIFSCCode VARCHAR(50),
)

DROP TABLE EduSphere.FinAccountDetails
SELECT * FROM EduSphere.FinAccountDetails

DELETE FROM EduSphere.FinAccountDetails WHERE OrganizationId=100
------------------------------------------------------------
CREATE PROCEDURE spInsertFinAccountDetails
@OrganizationId INT,
@GoodsAndServicesTaxCode VARCHAR(50),
@ServiceTaxCode VARCHAR(50),
@ValueAddedTaxCode VARCHAR(50),
@PermanentAccountNumber VARCHAR(50),
@BankName VARCHAR(50),
@BankAccountNumber VARCHAR(50),
@BankIFSCCode VARCHAR(50)
AS
BEGIN
	INSERT INTO EduSphere.FinAccountDetails(OrganizationId,GoodsAndServicesTaxCode,ServiceTaxCode,ValueAddedTaxCode,PermanentAccountNumber,BankName,BankAccountNumber,BankIFSCCode)
	                                         VALUES(@OrganizationId,@GoodsAndServicesTaxCode,@ServiceTaxCode,@ValueAddedTaxCode,@PermanentAccountNumber,@BankName,@BankAccountNumber,@BankIFSCCode)  
END

DROP PROCEDURE spInsertFinAccountDetails
---------------------------------------------------------
CREATE PROCEDURE spUpdateFinAccountDetails
@OrganizationId INT,
@GoodsAndServicesTaxCode VARCHAR(50),
@ServiceTaxCode VARCHAR(50),
@ValueAddedTaxCode VARCHAR(50),
@PermanentAccountNumber VARCHAR(50),
@BankName VARCHAR(50),
@BankAccountNumber VARCHAR(50),
@BankIFSCCode VARCHAR(50)
AS
BEGIN
	UPDATE EduSphere.FinAccountDetails SET GoodsAndServicesTaxCode=@GoodsAndServicesTaxCode,ServiceTaxCode=@ServiceTaxCode, ValueAddedTaxCode=@ValueAddedTaxCode, 
	                                          PermanentAccountNumber=@PermanentAccountNumber,BankName=@BankName,BankAccountNumber=@BankAccountNumber,
											  BankIFSCCode=@BankIFSCCode WHERE OrganizationId=@OrganizationId
END

drop procedure spUpdateOrganizationContactDetails




-------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------
