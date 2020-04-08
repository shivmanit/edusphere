-----------------MEMEBERSHIP-------------------
CREATE TABLE EduSphere.MembershipTypes
(
MembershipTypeId INT IDENTITY(1000,1) CONSTRAINT cstMembership PRIMARY KEY,
MembershipTitle VARCHAR(20),
MembershipFee DECIMAL(19,2),
DiscountPercentage DECIMAL(19,2),
MembershipDetails VARCHAR(200)
)
SELECT * FROM EduSphere.MembershipTypes
DROP TABLE EduSphere.MembershipTypes

CREATE PROCEDURE spInsertNewMembershipType
@MembershipTitle VARCHAR(20),
@MembershipFee DECIMAL(19,2),
@DiscountPercentage DECIMAL(19,2),
@MembershipDetails VARCHAR(200)
AS
BEGIN
  INSERT INTO EduSphere.MembershipTypes (MembershipTitle,MembershipFee,DiscountPercentage,MembershipDetails) VALUES(@MembershipTitle,@MembershipFee,@DiscountPercentage,@MembershipDetails)
END

DROP PROCEDURE spInsertNewMembershipType

EXECUTE spInsertNewMembershipType 'NONE','0','0','NONE Member'
EXECUTE spInsertNewMembershipType 'SILVER','5000','10','SILVER Member'
EXECUTE spInsertNewMembershipType 'GOLD','10000','15','GOLD Member'
EXECUTE spInsertNewMembershipType 'PLATINUM','15000','20','PLATINUM Member'
EXECUTE spInsertNewMembershipType 'NC','20000','100','No Charge Member'

UPDATE EduSphere.MembershipTypes SET DiscountPercentage=10 WHERE MembershipTypeId=1003
SELECT COUNT(MemberID) FROM EduSphere.Members WHERE MembershipTypeId !='1000' AND MembershipExpiringDate< DATEADD(day,20,GETDATE())
SELECT * FROM EduSphere.Members WHERE MembershipTypeId !='1000' AND MembershipExpiringDate< DATEADD(day,20,GETDATE())
-----------------------------------------------------------------------------
SELECT MemberId, FullName, Gender,MembershipTitle FROM EduSphere.Members c JOIN EduSphere.MembershipTypes m ON c.MembershipTypeId=m.MembershipTypeId

---------------------------------BonusWallet----------------------
CREATE TABLE EduSphere.BonusWallet
(
BonusWalletTxID INT IDENTITY(100,1) CONSTRAINT cstBWTxID PRIMARY KEY,
MemberID INT CONSTRAINT cstBWCid FOREIGN KEY REFERENCES EduSphere.Members(MemberID),
TaxInvoiceNumber INT CONSTRAINT cstBWCTIN FOREIGN KEY REFERENCES EduSphere.TaxInvoices(TaxInvoiceNumber),
CreditPoints INT,
DebitPoints INT,
BonusWalletTxDate DATETIME,
BonusWalletTxDoneBy VARCHAR(50),
Comments VARCHAR(100),
)

SELECT * FROM EduSphere.BonusWallet WHERE TaxInvoiceNumber=337
DELETE FROM EduSphere.BonusWallet WHERE MemberID=52 AND BonusWalletTxID !=173
DELETE FROM EduSphere.BonusWallet WHERE TaxInvoiceNumber=337
DROP TABLE EduSphere.BonusWallet

---------------------CREATE BONUS WALLET FOR EXISTING MemberS----------
INSERT INTO EduSphere.BonusWallet (MemberID,TaxInvoiceNumber,CreditPoints,DebitPoints,BonusWalletTxDate,BonusWalletTxDoneBy,Comments)
									SELECT MemberID ,90,0,0,GETDATE(),'SALONSYSTEM','BONUS WALLET CREATED' FROM EduSphere.Members

-----------------END TEST---------------------



CREATE PROCEDURE spUpdateBonusWallet
@MemberID INT ,
@TaxInvoiceNumber INT,
@CreditPoints INT,
@DebitPoints INT,
@BonusWalletTxDoneBy VARCHAR(50),
@Comments VARCHAR(100)
AS
BEGIN
	------CREATE BONUS WALLET IF DOESN'T EXIST FOR A Member----
	IF NOT EXISTS (SELECT MemberID FROM EduSphere.BonusWallet WHERE MemberID=@MemberID)
	BEGIN
		INSERT INTO EduSphere.BonusWallet (MemberID,TaxInvoiceNumber,CreditPoints,DebitPoints,BonusWalletTxDate,BonusWalletTxDoneBy,Comments)
										VALUES(@MemberID,90,0,0,GETDATE(),'SALONSYSTEM','BONUS WALLET CREATED')		
	END
	--------SELECT LATEST TAX INVOICE NUMBER OF Member----
	INSERT INTO EduSphere.BonusWallet (MemberID,TaxInvoiceNumber,CreditPoints,DebitPoints,BonusWalletTxDate,BonusWalletTxDoneBy,Comments)
										VALUES(@MemberID,(SELECT TOP 1 TaxInvoiceNumber FROM EduSphere.BonusWallet ORDER BY TaxInvoiceNumber desc),@CreditPoints,@DebitPoints,GETDATE(),@BonusWalletTxDoneBy,@Comments)
END


DROP PROCEDURE spUpdateBonusWallet

-----------------------BonusWallet Query------
SELECT c.MemberId, FullName, Gender,MembershipTitle, SUM(b.CreditPoints)-SUM(b.DebitPoints) AS BonusPoints FROM EduSphere.Members c 
                                                                                            JOIN EduSphere.MembershipTypes m ON c.MembershipTypeId=m.MembershipTypeId 
                                                                                            JOIN EduSphere.BonusWallet b ON b.MemberID=c.MemberID
                                                                                            WHERE c.MemberId like '%300%' OR FullName like '%test%' OR PhoneOne like '%99675%'
																							GROUP BY c.MemberId,FullName, Gender,MembershipTitle

------------------------CREATE BONUS WALLET FOR A Member--------------
DECLARE @MemberID INT
SET @MemberID=52
IF NOT EXISTS (SELECT MemberID FROM EduSphere.BonusWallet WHERE MemberID=52)
	BEGIN
		INSERT INTO EduSphere.BonusWallet (MemberID,TaxInvoiceNumber,CreditPoints,DebitPoints,BonusWalletTxDate,BonusWalletTxDoneBy,Comments)
										VALUES(@MemberID,90,0,0,GETDATE(),'SALONSYSTEM','BONUS WALLET CREATED')		
	END



