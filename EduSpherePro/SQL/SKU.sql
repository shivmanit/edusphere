----------------------------------SALON SkuS--------------------------------------------------------
CREATE TABLE EduSphere.SkuGroups
(
  SkuGroupId INT IDENTITY(100,1) CONSTRAINT cstSgPK PRIMARY KEY,
  SkuGroup VARCHAR(50),
  SkuGroupDescription VARCHAR(100)
)
DROP TABLE EduSphere.SkuGroups
SELECT * FROM EduSphere.SkuGroups
SELECT SkuGroup,SkuGroupId FROM EduSphere.SkuGroups
UPDATE EduSphere.SkuGroups SET SkuGroup='Proxy' WHERE SkuGroupId='100'
DELETE FROM EduSphere.SkuGroups WHERE SkuGroupId='12'

--------------------TEST-------------------------------------
SELECT SkuGroupID,SkuGroup FROM EduSphere.SkuGroups WHERE SkuGroupID>=100

-------------Not Visibsible SkuGroups------------
SET IDENTITY_INSERT EduSphere.SkuGroups ON
  INSERT INTO EduSphere.SkuGroups(SkuGroupID,SkuGroup, SkuGroupDescription) VALUES('90','MEMBER-ACCOUNT','Not Visible Sku Groups')
SET IDENTITY_INSERT EduSphere.SkuGroups OFF
-------------Not Visibsible SkuSubGroups------------
--Account Initialized--
SET IDENTITY_INSERT EduSphere.SkuSubGroups ON
  INSERT INTO EduSphere.SkuSubGroups(SkuSubGroupID,SkuGroupID,SkuSubGroup, SkuSubGroupDescription) VALUES('90','90','MEMBER-ACCOUNT-CREATION','Account Initialized')
SET IDENTITY_INSERT EduSphere.SkuSubGroups OFF
--Received Payment--
SET IDENTITY_INSERT EduSphere.SkuSubGroups ON
  INSERT INTO EduSphere.SkuSubGroups(SkuSubGroupID,SkuGroupID,SkuSubGroup, SkuSubGroupDescription) VALUES('91','90','PAYMENT-RECEIPT','Received Payment')
SET IDENTITY_INSERT EduSphere.SkuSubGroups OFF
--Reversed Payment--
SET IDENTITY_INSERT EduSphere.SkuSubGroups ON
  INSERT INTO EduSphere.SkuSubGroups(SkuSubGroupID,SkuGroupID,SkuSubGroup, SkuSubGroupDescription) VALUES('92','90','PAYMENT-REFUND','Reversed Payment')
SET IDENTITY_INSERT EduSphere.SkuSubGroups OFF
--VOUCHER Credit--
SET IDENTITY_INSERT EduSphere.SkuSubGroups ON
  INSERT INTO EduSphere.SkuSubGroups(SkuSubGroupID,SkuGroupID,SkuSubGroup, SkuSubGroupDescription) VALUES('93','90','VOUCHER-CREDIT','VOUCHER Credit')
SET IDENTITY_INSERT EduSphere.SkuSubGroups OFF

CREATE PROCEDURE spInsertSkuGroups
AS
BEGIN
 INSERT INTO EduSphere.SkuGroups (SkuGroup,SkuGroupDescription) VALUES('FEE','Institute Fee')
 --INSERT INTO EduSphere.SkuGroups (SkuGroup,SkuGroupDescription) VALUES('HAIR_EXTENSION','Hair Extension Skus')--
 --INSERT INTO EduSphere.SkuGroups (SkuGroup,SkuGroupDescription) VALUES('SKIN','Skin Skus')
 --INSERT INTO EduSphere.SkuGroups (SkuGroup,SkuGroupDescription) VALUES('BODY','Body Skus')
 --INSERT INTO EduSphere.SkuGroups (SkuGroup,SkuGroupDescription) VALUES('MAKEUP','Makeup Skus')
 --INSERT INTO EduSphere.SkuGroups (SkuGroup,SkuGroupDescription) VALUES('NAIL','Nail Skus')
 --INSERT INTO EduSphere.SkuGroups (SkuGroup,SkuGroupDescription) VALUES('PACKAGES','Packaged Skus')
 --INSERT INTO EduSphere.SkuGroups (SkuGroup,SkuGroupDescription) VALUES('MEMBERSHIP','Membership Registration Skus')
 --INSERT INTO EduSphere.SkuGroups (SkuGroup,SkuGroupDescription) VALUES('EXTRA','Extra Charges')
END

EXEC spInsertSkuGroups
DROP PROCEDURE spInsertSkuGroups

SELECT * FROM EduSphere.SkuGroups
UPDATE EduSphere.SkuGroups SET SkuGroup=
DELETE FROM EduSphere.SkuGroups WHERE SkuGroupId='109'
-----------------------------------------------------------------------------------------
CREATE TABLE EduSphere.SkuSubGroups
(
  SkuSubGroupId INT IDENTITY(100,1) CONSTRAINT cstSerSubGrpPK PRIMARY KEY,
  SkuGroupID INT constraint cstServGroup FOREIGN KEY REFERENCES EduSphere.SkuGroups(SkuGroupID),
  SkuSubGroup VARCHAR(50),
  SkuSubGroupDescription VARCHAR(100),
)

DROP TABLE EduSphere.SkuSubGroups
SELECT * FROM EduSphere.SkuSubGroups
INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuSubGroupDescription) VALUES('Haircut','Hair Sub Groups')

DELETE FROM EduSphere.SkuSubGroups WHERE SkuSubGroupID=121
CREATE PROCEDURE spInsertSkuSubGroups
AS
BEGIN
 ----------------------------SubSkus-Fee(101)--------------------
 INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('ADMISSION FEE','101','Admission Fee')
 INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('TUITION FEE','101','Tuition Fee')
 --INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('MEN BASIC SkuS','101','Hair Sub Groups')
 --INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('MEN HAIR WASH','101','Hair Sub Groups')
 --INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('MEN HAIR COLOUR','101','Hair Sub Groups')
 --INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('WOMEN HAIR CUT','101','Hair Sub Groups')
 --INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('WOMEN HAIR WASH','101','Hair Sub Groups')
 --INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('HAIR STYLING','101','Hair Sub Groups')
 --INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('WOMEN GLOBAL COLORING','101','Hair Sub Groups')
 --INSERT INTO EduSphere.SkuSubGroups (SkuSubSkuGroupID,SkuSubGroupDescription) VALUES('PERMANENT STYLING','101','Hair Sub Groups')
 --INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('HAIR  SPA & TREATMENT','101','Hair Sub Groups')
 --INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('PROTEIN TREATMENT','101','Hair Sub Groups')
 --INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('HAIR EXTENSION','101','Hair Sub Groups')
  ----------------------------SubSkus-SKIN(102)--------------------
 INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('Threading','102','Skin Sub Groups')
 INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('Facial','102','Skin Sub Groups')
 INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('Cleanup','102','Skin Sub Groups')
 INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('Waxing','102','Skin Sub Groups')
 INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('Bleach','102','Skin Sub Groups')
 INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('Mask','102','Skin Sub Groups')
 INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('D-Tanning','102','Skin Sub Groups')
 --INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('Pedicure & Manicure','102','Skin Sub Groups')--
  ----------------------------SubSkus-BODY WELLNESS(103)--------------------
 INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('MASSAGE','103','Body Wellness Sub Groups')
 INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('SKIN POLISHING','103','Body Wellness Sub Groups')
 INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('MANICURE','103','Body Wellness Sub Groups')
 INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('PEDICURE','103','Body Wellness Sub Groups')
 INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('HEAD MASSAGE','103','Body Wellness Sub Groups')
  ----------------------------SubSkus-MAKEUP(104)--------------------
 INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('BRIDAL MAKE UP','104','Makeup Sub Groups')
 INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('GROOM MAKE UP','104','Makeup Sub Groups')
 INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('ENGAGEMENT MAKE UP','104','Makeup Sub Groups')
 INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('SIDER MAKE UP','104','Makeup Sub Groups')
 INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('GLAM YOUR DAY','104','Makeup Sub Groups')
 INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('PRE BRIDAL PACKEGE','104','Makeup Sub Groups')
  INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('PRE GROOM PACKAGE','104','Makeup Sub Groups')
 ----------------------------SubSkus-Nail(105)--------------------
 INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('GEL EXTENTION','105','Nail Sub Groups')
 INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('ACRYLIC EXTENTION','105','Nail Sub Groups')
 INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('NAIL MAINTANANCE','105','Nail Sub Groups')
 INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('NAIL MAINTANANCE','105','Nail Sub Groups')

------------------------------PACKAGES_OFFERS(106)------------------------------
INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('PACKAGES_OFFERS_Proxy','106','PACKAGES_OFFERS Sub Group')

-------------------------------MEMEBERSHIP(107)---------------------------------
INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('MEMEBERSHIP_Proxy','107','MEMEBERSHIP Sub Groups')

-------------------------------EXTRA(108)---------------------------------
INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('EXTRA_Proxy','108','EXTRA Sub Group')

-------------------------------HAIR_EXTENSION(109)-------------------------------
INSERT INTO EduSphere.SkuSubGroups (SkuSubGroup,SkuGroupID,SkuSubGroupDescription) VALUES('HAIR_EXTENSION_Proxy','109','HAIR_EXTENSION Sub Group')

END

EXEC spInsertSkuSubGroups
UPDATE EduSphere.SkuSubGroups SET SkuGroupID='107' WHERE SkuSubGroupID='139'

-----------------------------------------------------------------------------------------
SELECT * FROM EduSphere.SkuSubGroups
SELECT * FROM EduSphere.SKU WHERE SkuSubGroupID=109
SELECT * FROM EduSphere.SKU WHERE SkuGroupID=109

UPDATE EduSphere.SkuSubGroups SET SkuSubGroup='KIDZ HAIR CUT' WHERE SkuSubGroup='Haircut'
UPDATE EduSphere.SkuSubGroups SET SkuSubGroup='MEN HAIR CUT' WHERE SkuSubGroup='Shampoo & Conditioning'
UPDATE EduSphere.SkuSubGroups SET SkuSubGroup='MEN BASIC SkuS' WHERE SkuSubGroup='Hair Styling'
UPDATE EduSphere.SkuSubGroups SET SkuSubGroup='MEN HAIR WASH' WHERE SkuSubGroup='Hair Colour'
UPDATE EduSphere.SkuSubGroups SET SkuSubGroup='MEN HAIR COLOUR' WHERE SkuSubGroup='Chemical Treatment'
UPDATE EduSphere.SkuSubGroups SET SkuSubGroup='WOMEN HAIR CUT' WHERE SkuSubGroup='Treatment'
UPDATE EduSphere.SkuSubGroups SET SkuSubGroup='WOMEN HAIR WASH' WHERE SkuSubGroup='Spa'
UPDATE EduSphere.SkuSubGroups SET SkuSubGroup='HAIR STYLING' WHERE SkuSubGroup='Hair Extensions'

DELETE FROM EduSphere.SkuGroups WHERE SkuGroupId=106
UPDATE EduSphere.SkuSubGroup SET SkuGroupID='KIDZ HAIR CUT'

-------------------------------------------------------------------------------------------
-----------------------------------------SKUs-------------------------------------
create table EduSphere.SKU
(
SkuId int IDENTITY(100,1) constraint cstSrv PRIMARY KEY,
SkuType VARCHAR(50) CONSTRAINT cstSkuType CHECK (SkuType IN('SERVICE','PRODUCT','OTHERS')),
SkuTitle varchar(100),
SkuGroupID INT CONSTRAINT cstServGrp FOREIGN KEY REFERENCES EduSphere.SkuGroups(SkuGroupID),
SkuSubGroupID INT CONSTRAINT cstSubServGrp FOREIGN KEY REFERENCES EduSphere.SkuSubGroups(SkuSubGroupID),
SkuDuration varchar(20),
SkuDescription varchar(200),
UnitRate decimal(19,2),
TaxCode VARCHAR(20) CONSTRAINT sacTaxCode FOREIGN KEY  REFERENCES EduSphere.TaxCodes(TaxCode),
SkuScore INT
)

sp_help 'EduSphere.SKU'
DROP TABLE EduSphere.SKU
ALTER TABLE EduSphere.SKU ALTER COLUMN SkuTitle varchar(100)
ALTER TABLE EduSphere.SKU ALTER COLUMN UnitRate decimal(19,2)
ALTER TABLE EduSphere.SKU
ADD RepeatAfter int

ALTER TABLE EduSphere.SKU
ALTER COLUMN SkuDuration varchar(20)
SELECT * FROM EduSphere.SKU

SELECT SkuSubGroupID,SkuSubGroup FROM EduSphere.SkuSubGroups WHERE SkuGroupID=101

ALTER TABLE EduSphere.SKU ADD TaxCode VARCHAR(20) CONSTRAINT sacTaxCode FOREIGN KEY  REFERENCES EduSphere.TaxCodes(TaxCode)
ALTER TABLE EduSphere.SKU ADD SkuScore INT
UPDATE EduSphere.SKU SET SkuType='OTHERS' WHERE SkuId=236
SELECT * FROM EduSphere.SKU
-------------Dummy Skus------------

--Account creation Sku----
SET IDENTITY_INSERT EduSphere.SKU ON
 INSERT INTO EduSphere.SKU(SkuId,SkuSubGroupID,SkuGroupID,SkuTitle,SkuDescription) VALUES('90','90','90','MEMBER-ACCOUNT-CREATION','ProxySku-Account Creation')
SET IDENTITY_INSERT EduSphere.SKU OFF

--Account creation Sku----
SET IDENTITY_INSERT EduSphere.SKU ON
 INSERT INTO EduSphere.SKU(SkuId,SkuSubGroupID,SkuGroupID,SkuTitle,SkuDescription) VALUES('91','91','90','PAYMENT-RECEIPT','ProxySku-Payment-Receipt')
SET IDENTITY_INSERT EduSphere.SKU OFF

--Voucher Credit Sku----
SET IDENTITY_INSERT EduSphere.SKU ON
 INSERT INTO EduSphere.SKU(SkuId,SkuSubGroupID,SkuGroupID,SkuTitle,SkuDescription) VALUES('93','93','90','VOUCHER-CREDIT','ProxySku-Payment-Receipt')
SET IDENTITY_INSERT EduSphere.SKU OFF

---------------end Dummy Skus------

SELECT * FROM EduSphere.SKU
DROP TABLE EduSphere.SKU
ALTER TABLE EduSphere.SKU ALTER COLUMN SkuTitle varchar(100)
ALTER TABLE EduSphere.SKU
ADD RepeatAfter int

ALTER TABLE EduSphere.SKU
ALTER COLUMN SkuDuration varchar(20)

UPDATE EduSphere.SKU SET TaxCode='999721'

select * from EduSphere.SKU where SkuId='616'
delete  from EduSphere.SKU where SkuId='96'
truncate table EduSphere.SKU
drop table EduSphere.SKU

update EduSphere.SKU set SkuTitle='Select Sku',UnitRate=0, SkuGroup='',SkuDuration=0  where SkuId=1
update EduSphere.SKU set SkuGroup='Packages' WHERE SkuGroup='BrideGroom'


---------------------------------------------------------------------------------------------
create procedure spAddSku
@SkuTitle varchar(100),
@SkuType VARCHAR(50),
@UnitRate int,
@SkuGroupID INT,
@SkuSubGroupID INT,
@SkuDuration varchar(20),
@SkuDescription varchar(200),
@TaxCode int
AS
BEGIN
 INSERT INTO EduSphere.SKU (SkuTitle,SkuType, UnitRate,SkuGroupID,SkuSubGroupID,SkuDuration,SkuDescription,TaxCode)
                            VALUES(@SkuTitle,@SkuType, @UnitRate,@SkuGroupID,@SkuSubGroupID,@SkuDuration,@SkuDescription,@TaxCode)
END

----
INSERT INTO EduSphere.SKU (SkuTitle, UnitRate,SkuGroupID,SkuSubGroupID,SkuDuration,SkuDescription,TaxCode)
                           VALUES('Salon Director (Female)', 1350,101,100,'3','Salon Director (Female)','999721')
drop procedure spAddSku
-----------------------------------------------------------------------------------------
create procedure spUpdateSku
@SkuId int,
@SkuType varchar(50),
@SkuTitle varchar(100),
@SkuDescription varchar(200),
@UnitRate int,
@SkuDuration varchar(20)
AS
BEGIN
	update EduSphere.SKU set SkuType=@SkuType,SkuTitle=@SkuTitle,SkuDescription=@SkuDescription,UnitRate=@UnitRate, SkuDuration=@SkuDuration where SkuId=@SkuId
END

drop procedure spUpdateSku
---------------------------------------------------------------------------------
CREATE PROCEDURE spDeleteSku
@SkuId INT
AS
BEGIN
 DELETE FROM EduSphere.MemberSkuAccount WHERE SkuId=@SkuId
 DELETE FROM EduSphere.MemberSkuEnquiry WHERE SkuId=@SkuId
 DELETE FROM EduSphere.OnlineAppointments WHERE SkuId=@SkuId
 DELETE FROM EduSphere.SkuReminders WHERE SkuId=@SkuId
 DELETE FROM EduSphere.SKU WHERE SkuId=@SkuId
END

sp_help 'EduSphere.SKU'
DROP PROCEDURE spDeleteSku
EXEC spDeleteSku 103
select * FROM EduSphere.SKU
---------------------------------------------------------------------------------------
create procedure spDeleteFromTable
@KeyID varchar(20),
@SourceTable varchar(20)
AS
BEGIN
if(@SourceTable='EduSphere.SKU')
DELETE  from EduSphere.SKU  where SkuId=@KeyID
END

drop procedure spDeleteFromTable
---------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
create procedure spSelectSkus
@ProgName varchar(20)='CSE',
@AcadYear varchar(10)='FOURTH',
@AcadSem varchar(10)='SECOND'
AS
BEGIN
select * from EduSphere.SKU
END

drop procedure spSelectSkus
