create schema MedSphere

---Different Business Organizations invloved---
create table MedSphere.Organizations
(
OrganizationID int identity(100,1) constraint cstCustPK PRIMARY KEY,
OrganizationName varchar(100),
OrganizationType varchar(50) CONSTRAINT cstCType CHECK(OrganizationType IN('HOSPITAL','SHOP','RETAIL')), 
ManagerName varchar(50),
ManagerEmail varchar(30),
ManagerPhone varchar(50),
ContactPerson varchar(50),
PhoneOne varchar(20),
PhoneTwo varchar(20),
Email varchar(30),
OfficeAddress varchar (200),
EnrolmentDate datetime,
MemberPhoto varchar(100),
Remarks varchar(200),
Notify varchar(10) CONSTRAINT cstNtfy CHECK(Notify IN('YES','NO'))
)

SELECT OrganizationName,OrganizationId FROM MedSphere.Organizations WHERE OrganizationType='HOSPITAL'
DROP TABLE MedSphere.FinAccountDetails
DROP TABLE MedSphere.Organizations
sp_help 'MedSphere.Organizations'
SELECT TOP 100 * FROM MedSphere.Organizations WHERE OrganizationId>=100 ORDER BY OrganizationId DESC
--Add Proxy--
SET IDENTITY_INSERT MedSphere.Organizations ON
 INSERT INTO MedSphere.Organizations(OrganizationID,OrganizationName,OrganizationType) VALUES('90','Proxy','FRANCHISEE')
SET IDENTITY_INSERT MedSphere.Organizations OFF

INSERT INTO MedSphere.Organizations(OrganizationName,OrganizationType) VALUES('SJA-Andheri','FRANCHISEE')
-----------------------------------------------
------DEPARMENTS-------
create table MedSphere.Departments
(
DepartmentID int identity(100,1) constraint cstDeptPK PRIMARY KEY,
DepartmentName varchar(100),
)

DROP TABLE MedSphere.Departments
INSERT INTO MedSphere.Departments VALUES('AVIATION')
INSERT INTO MedSphere.Departments VALUES('MANAGEMENT')

--Add Proxy--
SET IDENTITY_INSERT MedSphere.Departments ON
 INSERT INTO MedSphere.Departments(DepartmentID,DepartmentName) VALUES('90','Proxy')
SET IDENTITY_INSERT MedSphere.Departments OFF

SELECT * FROM MedSphere.Departments 

-----------------------------------------------------------------------------------------
create procedure spInsertMedOrganization
@OrganizationName varchar(50),
@OrganizationType varchar(50),
@ManagerName varchar(50),
@ManagerEmail varchar(30),
@ManagerPhone varchar(50),
@ContactPerson varchar(50),
@PhoneOne varchar(20),
@PhoneTwo varchar(20),
@Email varchar(30),
@OfficeAddress varchar (200),
@EnrolmentDate datetime,
@MemberPhoto varchar(100),
@Remarks varchar(200),
@Notify varchar(10)
AS
BEGIN 
	insert into MedSphere.Organizations (OrganizationName,OrganizationType,ManagerName,ManagerEmail,ManagerPhone,ContactPerson,PhoneOne,PhoneTwo,Email,OfficeAddress,EnrolmentDate,MemberPhoto,Remarks,Notify) 
	                             values(@OrganizationName,@OrganizationType,@ManagerName,@ManagerEmail,@ManagerPhone,@ContactPerson,@PhoneOne,@PhoneTwo,@Email,@OfficeAddress,@EnrolmentDate,@MemberPhoto,@Remarks,@Notify)
	DECLARE @OrganizationId int = (SELECT TOP 1 OrganizationId from MedSphere.Organizations ORDER BY OrganizationId DESC)
	EXEC spInsertMedAccountDetails @OrganizationId,'','','','','','',''	
END

exec [dbo].[spInsertOrganization]
drop procedure spInsertOrganization

EXEC spInsertMedAccountDetails 2,'','','','','','',''
--------------------------------------------------------------------------------------------
create procedure spUpdateMedOrganization
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
 UPDATE MedSphere.Organizations set OrganizationName=@OrganizationName,ManagerName=@ManagerName,ManagerEmail=@ManagerEmail,ManagerPhone=@ManagerPhone,ContactPerson=@ContactPerson,PhoneOne=@PhoneOne,PhoneTwo=@PhoneTwo,Email=@Email,OfficeAddress=@OfficeAddress,
                                     MemberPhoto=@MemberPhoto, Remarks=@Remarks,Notify=@Notify WHERE OrganizationId=@OrganizationId
END

drop procedure spUpdateOrganization
-----------------------------------------------------------------------------------------
create procedure spDeleteMedOrganization
@OrganizationId int
AS
BEGIN
delete from MedSphere.MemberServiceAccount where OrganizationId=@OrganizationId
delete from MedSphere.Organizations where OrganizationId=@OrganizationId
END

execute spDeleteOrganization
 
drop procedure spDeleteOrganization
select * from MedSphere.Organizations
----------------------------------------------------------------------------------------

CREATE TABLE MedSphere.MedAccountDetails
(
OrganizationId INT CONSTRAINT cstMedOrg FOREIGN KEY REFERENCES MedSphere.Organizations(OrganizationId),
GoodsAndServicesTaxCode VARCHAR(50),
ServiceTaxCode VARCHAR(50),
ValueAddedTaxCode VARCHAR(50),
PermanentAccountNumber VARCHAR(50),
BankName VARCHAR(50),
BankAccountNumber VARCHAR(50),
BankIFSCCode VARCHAR(50),
)

DROP TABLE MedSphere.MedAccountDetails
SELECT * FROM MedSphere.MedAccountDetails
------------------------------------------------------------
CREATE PROCEDURE spInsertMedAccountDetails
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
	INSERT INTO MedSphere.MedAccountDetails(OrganizationId,GoodsAndServicesTaxCode,ServiceTaxCode,ValueAddedTaxCode,PermanentAccountNumber,BankName,BankAccountNumber,BankIFSCCode)
	                                         VALUES(@OrganizationId,@GoodsAndServicesTaxCode,@ServiceTaxCode,@ValueAddedTaxCode,@PermanentAccountNumber,@BankName,@BankAccountNumber,@BankIFSCCode)  
END

DROP PROCEDURE spInsertMedAccountDetails
---------------------------------------------------------
CREATE PROCEDURE spUpdateMedAccountDetails
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
	UPDATE MedSphere.MedAccountDetails SET GoodsAndServicesTaxCode=@GoodsAndServicesTaxCode,ServiceTaxCode=@ServiceTaxCode, ValueAddedTaxCode=@ValueAddedTaxCode, 
	                                          PermanentAccountNumber=@PermanentAccountNumber,BankName=@BankName,BankAccountNumber=@BankAccountNumber,
											  BankIFSCCode=@BankIFSCCode WHERE OrganizationId=@OrganizationId
END

drop procedure spUpdateOrganizationContactDetails




-------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------
