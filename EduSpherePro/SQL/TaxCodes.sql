----------------------------------TAXCODES--------------------

CREATE TABLE EduSphere.TaxCodes
(
TaxCode VARCHAR(20) CONSTRAINT gstTaxCode PRIMARY KEY,
TaxCodeDescription VARCHAR(200),
CGSTPercentage FLOAT,
SGSTPercentage FLOAT,
)

SELECT * FROM EduSphere.TaxCodes
DROP TABLE EduSphere.TaxCodes

CREATE PROCEDURE spInsertTaxCode
@TaxCode VARCHAR(20),
@TaxCodeDescription VARCHAR(200),
@CGSTPercentage FLOAT,
@SGSTPercentage FLOAT
AS
BEGIN
 INSERT INTO EduSphere.TaxCodes (TaxCode,TaxCodeDescription,CGSTPercentage,SGSTPercentage) VALUES(@TaxCode,@TaxCodeDescription,@CGSTPercentage,@SGSTPercentage)
END


EXEC spInsertTaxCode '999721','Hairdressing and barbers services',9,9
EXEC spInsertTaxCode '999722','Cosmetic treatment',9,9
EXEC spInsertTaxCode '999729','All other beauty treatment services',9,9

EXEC spInsertTaxCode '30039011','Ayurvedic System',6,6

EXEC spInsertTaxCode '33043000','Manicure or pedicure preparations',9,9
EXEC spInsertTaxCode '33049910','Face Cream',9,9
EXEC spInsertTaxCode '33049930','Moisturising Lotion-Ayurvedic',6,6
EXEC spInsertTaxCode '999299','Other Educational Support Services',9,9

----------------------------------------------------------------------
-----------------------------------------GST--------------------------------
----------------------------------------------------------------------------
CREATE TABLE EduSphere.TaxInvoices
(
TaxInvoiceNumber INT IDENTITY(100,1) CONSTRAINT cstTaxInvoice PRIMARY KEY,
InvoiceDate DATETIME,
MemberId INT,
ConsultantOneID INT,
LocationId VARCHAR(50),
DiscountAmount FLOAT,
SubTotal FLOAT,
BaseAmount FLOAT,
SGSTAmount FLOAT,
CGSTAmount FLOAT
)

DROP TABLE EduSphere.TaxInvoices 
SELECT * FROM EduSphere.TaxInvoices

SELECT * FROM EduSphere.TaxInvoices WHERE MemberId=1 AND CAST(InvoiceDate AS DATE)=CAST(GETDATE() AS DATE)
DELETE FROM EduSphere.TaxInvoices WHERE MemberId=1

-----------------------INVOICE TEST QUERIES---------------
SELECT  InvoiceDate, ServiceTitle,sa.DebitAmount AS ServiceAmt,productTitle,pa.debitAmount as ProductAmount, sa.CreditAmount AS Paymnet 
       FROM EduSphere.TaxInvoices ti
         JOIN EduSphere.MemberAccount sa ON ti.TaxInvoiceNumber=sa.TaxInvoiceNumber
		  JOIN EduSphere.Services sr ON sa.ServiceID=sr.ServiceID
		  JOIN EduSphere.ProductSaleTransaction pa ON ti.TaxInvoiceNumber=pa.TaxInvoiceNumber 
		  JOIN EduSphere.Products pr ON pa.ProductID=pr.ProductID
		 WHERE ti.MemberId='3370' GROUP BY InvoiceDate,ServiceTitle,productTitle,pa.debitAmount,sa.CreditAmount

SELECT InvoiceDate,(SELECT SUM(CreditAmount) FROM EduSphere.MemberAccount WHERE MemberId='3370')+ (SELECT SUM(creditAmount) FROM EduSphere.ProductSaleTransaction WHERE MemberId='3370')-SUM(SubTotal) AS Balnace 
      FROM EduSphere.TaxInvoices  WHERE 
	  MemberId='3370' GROUP BY InvoiceDate

------------------------END INVOICE TEST QUERIES..........
-------------------------------------------------

CREATE PROCEDURE spGenerateInvoiceNumber
@MemberId INT,
@ConsultantOneID INT,
@LocationId VARCHAR(50)
AS
BEGIN
 IF NOT EXISTS (SELECT TaxInvoiceNumber FROM EduSphere.TaxInvoices WHERE MemberId=@MemberId AND (CAST(InvoiceDate AS DATE)=CAST(GETDATE() AS DATE)))
 BEGIN
   INSERT INTO EduSphere.TaxInvoices (MemberId,ConsultantOneID,LocationId,InvoiceDate) VALUES(@MemberId,@ConsultantOneID,@LocationId,GETDATE())
 END
END

DROP PROCEDURE spGenerateInvoiceNumber 
EXEC spGenerateInvoiceNumber 46

---------------INSERT INVOICE NUMBER FORECEFULLY-----
SET IDENTITY_INSERT EduSphere.TaxInvoices ON
  INSERT INTO EduSphere.TaxInvoices(TaxInvoiceNumber,MemberId,InvoiceDate) VALUES(494,3130,GETDATE())
SET IDENTITY_INSERT EduSphere.TaxInvoices OFF

UPDATE  EduSphere.TaxInvoices SET ConsultantOneID='110',LocationId='TM01' WHERE TaxInvoiceNumber='494'
---------------------------------------------------------------

---------------------------spUpdateTaxInvoiceTotal-Update total after each Debit/Credit---------------
CREATE PROCEDURE spUpdateTaxInvoiceTotal
@TaxInvoiceNumber INT
AS
BEGIN
    DECLARE @SubTotal FLOAT
    DECLARE @DiscountAmount FLOAT
	DECLARE @CGSTAmount FLOAT
	DECLARE @SGSTAmount FLOAT

	 
	IF EXISTS (SELECT TaxInvoiceNumber FROM EduSphere.MemberAccount WHERE TaxInvoiceNumber=@TaxInvoiceNumber)
	BEGIN
	  (SELECT @SubTotal	=SUM(DebitAmount) FROM EduSphere.MemberAccount WHERE TaxInvoiceNumber=@TaxInvoiceNumber)
	  (SELECT @DiscountAmount=SUM(DiscountAmount) FROM EduSphere.MemberAccount WHERE TaxInvoiceNumber=@TaxInvoiceNumber)
	  (SELECT @CGSTAmount=SUM(CGSTAmount) FROM EduSphere.MemberAccount WHERE TaxInvoiceNumber=@TaxInvoiceNumber)
	  (SELECT @SGSTAmount=SUM(SGSTAmount) FROM EduSphere.MemberAccount WHERE TaxInvoiceNumber=@TaxInvoiceNumber)
	  --IF EXISTS (SELECT TaxInvoiceNumber FROM EduSphere.ProductSaleTransaction WHERE TaxInvoiceNumber=@TaxInvoiceNumber)
	  --BEGIN
	  --   (SELECT  @SubTotal=@SubTotal+SUM(DebitAmount) FROM EduSphere.ProductSaleTransaction WHERE TaxInvoiceNumber=@TaxInvoiceNumber)
	  --   (SELECT  @DiscountAmount=@DiscountAmount+SUM(DiscountAmount) FROM EduSphere.ProductSaleTransaction WHERE TaxInvoiceNumber=@TaxInvoiceNumber)
		 --(SELECT  @CGSTAmount= @CGSTAmount+SUM(CGSTAmount) FROM EduSphere.ProductSaleTransaction WHERE TaxInvoiceNumber=@TaxInvoiceNumber)
	  --   (SELECT  @SGSTAmount=@SGSTAmount+SUM(SGSTAmount) FROM EduSphere.ProductSaleTransaction WHERE TaxInvoiceNumber=@TaxInvoiceNumber)
	  --END
	END	
    UPDATE EduSphere.TaxInvoices SET DiscountAmount=@DiscountAmount,SubTotal=@SubTotal,BaseAmount=@SubTotal-@CGSTAmount-@SGSTAmount,SGSTAmount=@SGSTAmount,CGSTAmount=@CGSTAmount WHERE TaxInvoiceNumber=@TaxInvoiceNumber
END

DROP PROCEDURE spUpdateTaxInvoiceTotal
EXEC spUpdateTaxInvoiceTotal 494

---------------------------spUpdateTaxInvoiceTotalForProducts-Update total after each Debit/Credit---------------
CREATE PROCEDURE spUpdateTaxInvoiceTotalForProducts
@TaxInvoiceNumber INT
AS
BEGIN
	DECLARE @DiscountAmount FLOAT= (SELECT SUM(DiscountAmount) FROM EduSphere.ProductSaleTransaction WHERE TaxInvoiceNumber=@TaxInvoiceNumber)
    DECLARE @SubTotal FLOAT		= (SELECT SUM(DebitAmount) FROM EduSphere.ProductSaleTransaction WHERE TaxInvoiceNumber=@TaxInvoiceNumber)
    DECLARE @CGSTAmount FLOAT	= (SELECT SUM(CGSTAmount) FROM EduSphere.ProductSaleTransaction WHERE TaxInvoiceNumber=@TaxInvoiceNumber)
    DECLARE @SGSTAmount FLOAT	= (SELECT SUM(SGSTAmount) FROM EduSphere.ProductSaleTransaction WHERE TaxInvoiceNumber=@TaxInvoiceNumber)

    UPDATE EduSphere.TaxInvoices SET DiscountAmount=@DiscountAmount,SubTotal=@SubTotal,BaseAmount=@SubTotal-@CGSTAmount-@SGSTAmount,SGSTAmount=@SGSTAmount,CGSTAmount=@CGSTAmount WHERE TaxInvoiceNumber=@TaxInvoiceNumber
END
