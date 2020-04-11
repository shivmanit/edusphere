
--------STUDENTS (Members table is used instead of creting a New Students table--------

--create table EduSphere.Members
--(
--MemberID int identity(1,1) constraint cstStudentPK PRIMARY KEY,
--ProgramID INT,
--BatchID INT,
--CurrentAcadStatus varchar(20) constraint chkAcadYear check(CurrentAcadStatus IN('FIRST','SECOND','THIRD','FOURTH','COMPLETED')),
--Section varchar(5) constraint chkSection check(Section IN('A','B','C','D')),
--FullName varchar(50),
--Gender varchar(10) constraint cstGender CHECK(Gender IN('MALE','FEMALE')),
--PhoneOne varchar(20),
--PhoneTwo varchar(20),
--Email varchar(30),
--ResidenceAddress varchar (200),
--DateOfBirth datetime,
--Anniversary datetime,
--EnrolmentDate datetime,
--MemberPhoto varchar(100),
--Remarks varchar(200),
--Notify varchar(10),
--MembershipExpiringDate DATETIME
--)

SELECT * FROM EduSphere.Members

DELETE FROM EduSphere.Members WHERE MemberID=1
DROP TABLE EduSphere.Members 
ALTER TABLE EduSphere.Members DROP COLUMN MembershipTypeId
ALTER TABLE EduSphere.Members ADD  ProgramID INT
ALTER TABLE EduSphere.Members ADD  BatchID INT
sp_help 'EduSphere.Members'
UPDATE EduSphere.Members SET BatchID='101'

ALTER TABLE EduSphere.Members ADD CurrentAcadStatus varchar(20) constraint chkAcadYear check(CurrentAcadStatus IN('FIRST','SECOND','THIRD','FOURTH','COMPLETED'))
ALTER TABLE EduSphere.Members ADD Section varchar(5) constraint chkSection check(Section IN('A','B','C','D'))
SELECT c.MemberID,FullName,PhoneOne,Email,ProgramTitle,SUM(DebitAmount) as StudentSpent 
                                                                         FROM EduSphere.Members c 
                                                                         JOIN EduSphere.Programs m ON c.ProgramID=m.ProgramID
                                                                         JOIN EduSphere.MemberFeeAccount a ON c.MemberID=a.MemberID
                                                                         WHERE c.MemberID='6' GROUP BY c.MemberID,FullName,PhoneOne,Email,ProgramTitle
SELECT TOP 10 MemberID, FullName, Gender,ProgramTitle 
            FROM EduSphere.Members c 
            JOIN EduSphere.Programs m ON c.ProgramID=m.ProgramID 
            WHERE MembershipType='STUDENT' AND OrganizationID=(SELECT OrganizationID FROM EdusPhere.Staff WHERE Email='zenab.sultan@speedjetaviation.com')
			ORDER BY MemberID DESC
--------------------------------
-------Enroll Students (Insert Neurotherapist is used instead)----------
--create procedure spInsertStudentDetails
--@FullName varchar(50),
--@Gender varchar(50),
--@ProgramID INT,
--@CurrentAcadStatus varchar(20),
--@Section varchar(5),
--@PhoneOne varchar(20),
--@PhoneTwo varchar(20),
--@Email varchar(30),
--@ResidenceAddress varchar (200),
--@DateOfBirth datetime ,
--@Anniversary datetime,
--@MembershipExpiringDate DATETIME, 
--@MemberPhoto varchar(100),
--@Remarks varchar(200),
--@Notify varchar(10),
--@ItemID int
--AS
--BEGIN
--	insert into EduSphere.Members (FullName,Gender,CurrentAcadStatus,Section,PhoneOne,PhoneTwo,Email,ResidenceAddress,DateOfBirth,ProgramID,Anniversary,MembershipExpiringDate,EnrolmentDate,MemberPhoto,Remarks,Notify) 
--	                            values(@FullName,@Gender,@CurrentAcadStatus,@Section,@PhoneOne,@PhoneTwo,@Email,@ResidenceAddress,@DateOfBirth,@ProgramID,@Anniversary,@MembershipExpiringDate,GETDATE(),@MemberPhoto,@Remarks,@Notify)
--	DECLARE @MemberID int = (SELECT TOP 1 MemberID from EduSphere.Members ORDER BY MemberID DESC)
--	INSERT INTO EduSphere.NeurotherapistAccount (MemberID,ItemID,TransactionDate, Notes,ConsultantID,DebitAmount,CreditAmount, BalanceAmount) 
--	                                       values(@MemberID,@ItemID,GETDATE(),@Remarks,90,0,0,0)
--END

exec spInsertStudentDetails
drop procedure spInsertStudentDetails
---------------------------------------Update Student Details-----
create procedure spUpdateStudentDetails
@MemberID int,
@FullName varchar(50),
@Gender varchar(50),
@ProgramID INT,
@OrganizationID INT,
@BatchID INT,
@MembershipType varchar(20),
@MaritalStatus varchar(20),
@PhoneOne varchar(20),
@PhoneTwo varchar(20),
@Email varchar(30),
@DateOfBirth datetime,
@Anniversary datetime,
@MembershipExpiryDate DATETIME, 
@Remarks varchar(200)
AS
BEGIN
 UPDATE EduSphere.Members set FullName=@FullName,Gender=@Gender,MembershipType=@MembershipType,MaritalStatus=@MaritalStatus,OrganizationID=@OrganizationID,BatchID=@BatchID,PhoneOne=@PhoneOne,PhoneTwo=@PhoneTwo,Email=@Email,DateOfBirth=@DateOfBirth,ProgramID=@ProgramID,Anniversary=@Anniversary,MembershipExpiryDate=MembershipExpiryDate,Remarks=@Remarks WHERE MemberID=@MemberID
END

DROP PROCEDURE spUpdateStudentDetails
--------------------------------------------------------------------

create procedure spUpdateStudentPhoto
@MemberID varchar(50),
@MemberPhoto varchar(100)
AS
BEGIN
  UPDATE EduSphere.Members SET PhotoPath=@MemberPhoto where MemberID=@MemberID
END


--------Count Students-----------------
create procedure spStudentsCount
@Count int output
AS
BEGIN
 declare @retValue int
 select @retValue = count(*) from EduSphere.Members WHERE MembershipType='STUDENT' 
 set  @Count=@retValue
END

drop procedure spStudentsCount
execute spStudentsCount
----------------------------------------------------------------------------------------------
----------STUDENT FeeS-------Not USed Instead SKU is used--------------------------------
------------------------------------------------------------------------------------------
CREATE TABLE EduSphere.FeeGroups
(
  FeeGroupId INT IDENTITY(100,1) CONSTRAINT cstFgPK PRIMARY KEY,
  FeeGroup VARCHAR(50),
  FeeGroupDescription VARCHAR(100),
)

--Add Proxy--
SET IDENTITY_INSERT EduSphere.FeeGroups ON
 INSERT INTO EduSphere.FeeGroups(FeeGroupId,FeeGroup) VALUES('90','PROXY-FEE-GROUP')
SET IDENTITY_INSERT EduSphere.FeeGroups OFF

DROP TABLE EduSphere.FeeGroups
SELECT * FROM EduSphere.FeeGroups
SELECT FeeGroup,FeeGroupId FROM EduSphere.FeeGroups
UPDATE EduSphere.FeeGroups SET FeeGroup='Proxy' WHERE FeeGroupId='100'
DELETE FROM EduSphere.FeeGroups WHERE FeeGroupId='12'

CREATE PROCEDURE spInsertFeeGroups
AS
BEGIN
 INSERT INTO EduSphere.FeeGroups (FeeGroup,FeeGroupDescription) VALUES('ACADEMIC','Admission Fee,Program Fee, Exam Fee')
 INSERT INTO EduSphere.FeeGroups (FeeGroup,FeeGroupDescription) VALUES('ADMINISTRATIVE','Travel Tickets, Material')
END

EXEC spInsertFeeGroups
DROP PROCEDURE spInsertFeeGroups



SELECT * FROM EduSphere.FeeGroups
-----------------------------------------------------------------------------------------

create table EduSphere.Fees
(
FeeID int IDENTITY(100,1) constraint cstFeePK PRIMARY KEY,
FeeGroupID INT CONSTRAINT cstFeeGrp FOREIGN KEY REFERENCES EduSphere.FeeGroups(FeeGroupID),
FeeTitle varchar(50),
UnitRate int,
FeeDescription varchar(200),
TaxCode VARCHAR(20) CONSTRAINT cstTaxCode FOREIGN KEY  REFERENCES EduSphere.TaxCodes(TaxCode)
)

SELECT * FROM EduSphere.Fees
DROP TABLE EduSphere.Fees
ALTER TABLE EduSphere.Fees ALTER COLUMN FeeDuration varchar(50)
ALTER TABLE EduSphere.Fees
ADD RepeatAfter int

ALTER TABLE EduSphere.Fees
ALTER COLUMN FeeDuration varchar(20)

ALTER TABLE EduSphere.Fees ADD TaxCode VARCHAR(20) CONSTRAINT sacTaxCode FOREIGN KEY  REFERENCES EduSphere.TaxCodes(TaxCode)
-------------Dummy Fees------------
SET IDENTITY_INSERT EduSphere.Fees ON
 INSERT INTO EduSphere.Fees(FeeID,FeeGroupID,FeeTitle) VALUES('90','90','ACCOUNT-CREATION')
SET IDENTITY_INSERT EduSphere.Fees OFF

SET IDENTITY_INSERT EduSphere.Fees ON
 INSERT INTO EduSphere.Fees(FeeID,FeeGroupID,FeeTitle) VALUES('91','90','PAYMENT-RECEIPT')
SET IDENTITY_INSERT EduSphere.Fees OFF
---------------end Dummy Fees------

INSERT INTO EduSphere.Fees(FeeTitle,FeeGroupID,UnitRate) VALUES('Admission Fee',100,10000)
SELECT ItemID, UPPER(FeeTitle +'-'+ Convert(varchar(10),UnitRate)) AS DisplayText FROM EduSphere.Fees ORDER BY FeeTitle ASC
SELECT * FROM EduSphere.Fees
DROP TABLE EduSphere.Fees
ALTER TABLE EduSphere.Fees ALTER COLUMN FeeTitle varchar(100)
ALTER TABLE EduSphere.Fees
ADD RepeatAfter int

ALTER TABLE EduSphere.Fees
ALTER COLUMN FeeDuration varchar(20)

UPDATE EduSphere.Fees SET TaxCode='999293' WHERE ItemID='91'

select * from EduSphere.Fees where ItemID='616'
delete  from EduSphere.Fees where ItemID='96'
truncate table EduSphere.Fees
drop table EduSphere.Fees

update EduSphere.Fees set FeeTitle='Select Fee',UnitRate=0, FeeGroup='',FeeDuration=0  where ItemID=1
update EduSphere.Fees set FeeGroup='Packages' WHERE FeeGroup='BrideGroom'


---------------------------------------------------------------------------------------------
create procedure spAddFee
@FeeTitle varchar(100),
@UnitRate int,
@FeeGroupID INT,
@FeeDescription varchar(200),
@TaxCode VARCHAR(20)
AS
BEGIN
 INSERT INTO EduSphere.Fees (FeeTitle,UnitRate,FeeGroupID,FeeDescription,TaxCode) VALUES(@FeeTitle,@UnitRate,@FeeGroupID,@FeeDescription,@TaxCode)
END

drop procedure spAddFee 
EXEC spAddFee 'CourseFee-Certified Beauty Professional',50000,100,'','999729'
-----------------------------------------------------------------------------------------
create procedure spUpdateFee
@FeeID int,
@FeeTitle varchar(100),
@FeeDescription varchar(200),
@UnitRate int
AS
BEGIN
	update EduSphere.Fees set FeeTitle=@FeeTitle,FeeDescription=@FeeDescription,UnitRate=@UnitRate where FeeID=@FeeID
END

drop procedure spUpdateFee
---------------------------------------------------------------------------------
CREATE PROCEDURE spDeleteFee
@ItemID INT
AS
BEGIN
 DELETE FROM EduSphere.MemberFeeAccount WHERE ItemID=@ItemID
 DELETE FROM EduSphere.MemberFeeEnquiry WHERE ItemID=@ItemID
 DELETE FROM EduSphere.OnlineAppointments WHERE ItemID=@ItemID
 DELETE FROM EduSphere.FeeReminders WHERE ItemID=@ItemID
 DELETE FROM EduSphere.Fees WHERE ItemID=@ItemID
END

sp_help 'EduSphere.Fees'
DROP PROCEDURE spDeleteFee
EXEC spDeleteFee 103
