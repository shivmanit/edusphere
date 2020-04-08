----------Staff Details-----------------------
CREATE TABLE MedSphere.Staff
(
EmpCode uniqueidentifier NOT NULL DEFAULT newid(),
EmployeeId INT IDENTITY (100,1) CONSTRAINT cstEmpIdPK PRIMARY KEY ,
OrganizationID INT constraint cstOrgIdFK FOREIGN KEY REFERENCES MedSphere.Organizations(OrganizationID),
EmpPhotoPath varchar(100),
FullName varchar(20),
Gender VARCHAR(20) CONSTRAINT cstGender CHECK(Gender IN('MALE','FEMAILE')),
PhoneOne varchar(20),
PhoneTwo varchar(20),
Email    varchar(20),
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
AadharNumber VARCHAR(20),
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

SELECT * FROM MedSphere.Staff
DROP TABLE MedSphere.Staff
--Add Proxy--
SET IDENTITY_INSERT MedSphere.Staff ON
 INSERT INTO MedSphere.Staff(EmployeeId,OrganizationID,FullName) VALUES('90','90','Proxy')
SET IDENTITY_INSERT MedSphere.Staff OFF

SET IDENTITY_INSERT MedSphere.Staff ON
 INSERT INTO MedSphere.Staff(EmployeeId,OrganizationID,FullName,Email) VALUES('100','100','Shivmani Tripathi','shivmanit@gmail.com')
 SET IDENTITY_INSERT MedSphere.Staff OFF