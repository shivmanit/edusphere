create table EduSphere.NeurotherapistAccount
(
TransactionID int identity(1,1) constraint cstFinTransPK PRIMARY KEY,
NeurotherapistId int constraint NeurotherapistIdFK FOREIGN KEY REFERENCES EduSphere.Neurotherapists(NeurotherapistId),
ItemId INT,
ItemType VARCHAR(50),
TransactionDate DateTime,
TransactionLocation INT constraint feeLocId FOREIGN KEY REFERENCES EduSphere.Organizations(OrganizationId),
OfferedRate INT,
Notes VARCHAR(100),
ConsultantID INT constraint consId FOREIGN KEY REFERENCES EduSphere.Staff(EmployeeID),
PaymentMode varchar(50),
DigitalPaymentRefCode varchar(100),
NextFollowup INT,
TransactionTrigger varchar(20) CONSTRAINT cstTransactionTrig CHECK(TransactionTrigger IN('DEBIT-Fee','REVERSAL','PART-PAYMENT')),
DebitAmount INT,
CreditAmount INT,
BalanceAmount INT,
DiscountAmount INT, 
CGSTAmount FLOAT,
SGSTAmount FLOAT,
TaxInvoiceNumber INT 
)

alter table EduSphere.NeurotherapistAccount add NextFollowup INT
ALTER TABLE EduSphere.NeurotherapistAccount DROP CONSTRAINT cstTransTrig
ALTER TABLE EduSphere.NeurotherapistAccount DROP COLUMN TransactionTrigger
ALTER TABLE EduSphere.NeurotherapistAccount ADD TransactionTrigger varchar(20) CONSTRAINT cstTransTrig CHECK(TransactionTrigger IN('DEBIT-Fee','REVERSAL','VOUCHER-CREDIT','RECEIPT-PREV-BILL','RECEIPT-CURR-BILL','RECEIPT-MEMBERSHIP')) 
DROP TABLE EduSphere.NeurotherapistAccount
sp_help 'EduSphere.NeurotherapistAccount'
ALTER TABLE EduSphere.NeurotherapistAccount DROP CONSTRAINT feeLocId
ALTER TABLE EduSphere.NeurotherapistAccount DROP COLUMN TransactionLocation
ALTER TABLE EduSphere.NeurotherapistAccount ADD TransactionLocation VARCHAR(20) constraint feeLocId FOREIGN KEY REFERENCES EduSphere.Organization(OrgId)

SELECT  *  FROM EduSphere.NeurotherapistAccount WHERE NeurotherapistId='20'  order by TransactionID desc
SELECT BalanceAmount,NeurotherapistID FROM EduSphere.NeurotherapistAccount WHERE BalanceAmount =0  ORDER BY NeurotherapistID
DELETE  EduSphere.NeurotherapistAccount where NeurotherapistId=46
SELECT  * From EduSphere.NeurotherapistAccount a JOIN EduSphere.Neurotherapists c ON a.NeurotherapistID=c.NeurotherapistID JOIN EduSphere.Fees s ON a.ItemId=s.ItemId WHERE a.DebitAmount!=0    order by a.TransactionDate desc
SELECT TOP 10 *,c.FullName as NeurotherapistName,a.TransactionID,s.FeeTitle,con.FullName as ConsultantID,ref.FullName as ReferedBy,a.TransactionDate,a.OfferedRate,a.FeeStatus,a.DebitAmount,a.CreditAmount,a.PaymentMode,a.DigitalPaymentRefCode,a.BalanceAmount FROM EduSphere.NeurotherapistAccount a JOIN EduSphere.Neurotherapists c  ON c.NeurotherapistId=a.NeurotherapistId JOIN EduSphere.Fees s ON s.ItemId=a.ItemId JOIN EduSphere.Staff con ON con.EmployeeID=a.ConsultantID JOIN EduSphere.Staff ref ON ref.EmployeeID=a.Reference where a.NeurotherapistId='2705'  order by a.TransactionID desc
SELECT TOP 7 *,c.FullName as NeurotherapistName,a.TransactionID,FeeTitle,con.FullName as ConsultantID,ref.FullName as ReferedBy,TransactionDate,OfferedRate,FeeStatus,DebitAmount,CreditAmount,PaymentMode,DigitalPaymentRefCode,BalanceAmount FROM EduSphere.NeurotherapistAccount a JOIN EduSphere.Neurotherapists c  ON a.NeurotherapistId=c.NeurotherapistId JOIN EduSphere.Fees s ON a.ItemId=s.ItemId JOIN EduSphere.Staff con ON a.ConsultantID=con.EmployeeID JOIN EduSphere.Staff ref ON a.Reference=ref.EmployeeID where a.NeurotherapistId='868'  order by a.TransactionID desc

DELETE FROM EduSphere.NeurotherapistAccount WHERE TaxInvoiceNumber=100

SELECT  *  FROM EduSphere.NeurotherapistAccount WHERE CAST(TransactionDate AS DATE)='2017-07-16'  order by TransactionID desc
UPDATE EduSphere.NeurotherapistAccount SET ConsultantID='AS0001', Reference='KA0001',AdditonalResourceOneId='TEST0100'

SELECT SUM(DebitAmount) AS BillAmount, year(a.TransactionDate) AS Year,month(a.TransactionDate) AS Month, e.EmployeeID AS EmpId,e.FullName AS Name FROM EduSphere.NeurotherapistAccount a JOIN EduSphere.Staff e ON a.ConsultantID=e.EmployeeID WHERE month(a.TransactionDate)=month(GETDATE())   GROUP BY e.EmployeeID,e.FullName,year(a.TransactionDate),month(a.TransactionDate) ORDER BY SUM(DebitAmount) DESC
SELECT SUM(DebitAmount) AS BillAmount,a.ConsultantID AS Id,e.FullName+' '+e.Gender AS Name FROM EduSphere.NeurotherapistAccount a  JOIN EduSphere.Staff e ON a.ConsultantID=e.EmployeeID WHERE CAST(TransactionDate AS DATE)=CAST('2017-07-17' AS DATE) AND a.TransactionLocation='PoonamSagar'   GROUP BY a.ConsultantID,e.FullName,e.Gender ORDER BY SUM(DebitAmount) DESC

SELECT SUM(CreditAmount) AS ReceivedAmount,PaymentMode FROM EduSphere.NeurotherapistAccount WHERE CAST(TransactionDate AS DATE)=CAST('2017-07-17' AS DATE)   GROUP BY PaymentMode ORDER BY PaymentMode DESC



SELECT t1.NeurotherapistID,t1.BalanceAmount,t1.TransactionDate
FROM EduSphere.NeurotherapistAccount t1
LEFT OUTER JOIN EduSphere.NeurotherapistAccount t2
  ON (t1.NeurotherapistID = t2.NeurotherapistID AND t1.TransactionDate < t2.TransactionDate)
WHERE t2.NeurotherapistID IS NULL AND t1.BalanceAmount!=0 ORDER BY t1.BalanceAmount ASC;

CREATE PROCEDURE spNeurotherapistBalance
@TransactionLocation varchar(20)
AS
BEGIN
SELECT c.NeurotherapistID, c.FullName+ c.Gender AS Name ,c.PhoneOne,TransactionDate, BalanceAmount
FROM EduSphere.NeurotherapistAccount a JOIN EduSphere.Neurotherapists c ON a.NeurotherapistID=c.NeurotherapistID
WHERE TransactionDate = (
   SELECT MAX( TransactionDate )
   FROM EduSphere.NeurotherapistAccount b
   WHERE a.NeurotherapistID = b.NeurotherapistID AND a.BalanceAmount!=0
) ORDER BY a.BalanceAmount ASC
END

EXEC spNeurotherapistBalance @TransactionLocation='PoonamSagar'

select * from EduSphere.NeurotherapistAccount  where DebitAmount!=0 AND ConsultantID='8001' AND TransactionDate between '3-20-2017' AND '04-08-2017'
SELECT  * From EduSphere.NeurotherapistAccount a JOIN EduSphere.Neurotherapists c ON a.NeurotherapistID=c.NeurotherapistID JOIN EduSphere.Fees s ON a.ItemId=s.ItemId WHERE a.DebitAmount!=0    order by a.TransactionDate desc
SELECT *  from EduSphere.NeurotherapistAccount WHERE  NeurotherapistId ='40'
UPDATE EduSphere.NeurotherapistAccount SET FeeStatus='SERV', ConsultantID='0000' WHERE FeeStatus='ENQ'

drop table EduSphere.NeurotherapistAccount
truncate table EduSphere.NeurotherapistAccount



INSERT INTO EduSphere.NeurotherapistAccount values(1,1,GETDATE(),GETDATE(),100,'Inital Account Creation','REQ','Hiral',0,0,0)

SELECT    c.FullName,a.TransactionID,s.FeeTitle,e.FullName as cons,em.FullName as ref,a.TransactionDate,a.OfferedRate,a.FeeStatus,a.DebitAmount,a.CreditAmount,a.PaymentMode,a.DigitalPaymentRefCode,a.BalanceAmount FROM EduSphere.Neurotherapists c JOIN EduSphere.NeurotherapistAccount a ON c.NeurotherapistId=a.NeurotherapistId JOIN EduSphere.Fees s ON s.ItemId=a.ItemId JOIN EduSphere.Staff e ON e.EmployeeID=a.ConsultantID JOIN EduSphere.Staff em ON em.EmployeeID=a.Reference  order by a.TransactionID desc
------------------------------------------------------------------------------------------------------------------
create procedure spMemberFeeAccountTransaction
@NeurotherapistId INT,
@ItemId int,
@TransactionDate DateTime,
@TransactionLocation varchar(20),
@OfferedRate int,
@Notes varchar(100),
@ConsultantID INT,
@PaymentMode varchar(50),
@NextFollowup INT,
@TransactionTrigger varchar(20),
@DigitalPaymentRefCode varchar(100),
@DebitAmount int ,
@CreditAmount int,
@DiscountAmount INT
AS
BEGIN
   -------------Generate Invoice Number for Transaction and Associate it with Transaction------------
   DECLARE @TaxInvoiceNumber INT
   SET @TaxInvoiceNumber=(SELECT TaxInvoiceNumber FROM EduSphere.TaxInvoices WHERE NeurotherapistId=@NeurotherapistId AND (CAST(InvoiceDate AS DATE)=CAST(GETDATE() AS DATE)))
   IF @TaxInvoiceNumber is null
	BEGIN
	  EXEC spGenerateNeurotherapistInvoiceNumber @NeurotherapistId,@ConsultantID,@TransactionLocation
	  SET @TaxInvoiceNumber=(SELECT TaxInvoiceNumber FROM EduSphere.TaxInvoices WHERE NeurotherapistId=@NeurotherapistId AND (CAST(InvoiceDate AS DATE)=CAST(GETDATE() AS DATE)))
	END

   -------------------------End Invoice------------------------------------------------------------
   -------------------------Compute CGST and SGST-------------------------------------------------
   DECLARE @TaxCode VARCHAR(20)=(SELECT TaxCode FROM EduSphere.Fees WHERE ItemId=@ItemId)
   IF @TaxCode is null 
   BEGIN
      SET @TaxCode='999729'
   END
   -----GET GST RATES----
   DECLARE @CGSTPercentage FLOAT = (SELECT CGSTPercentage FROM EduSphere.TaxCodes WHERE TaxCode=@TaxCode)
   DECLARE @SGSTPercentage FLOAT = (SELECT SGSTPercentage FROM EduSphere.TaxCodes WHERE TaxCode=@TaxCode)
   -------CALCULATE TAX FROM BILL AMOUNT (The rates are inclusive of GST)---------
   DECLARE @TaxAmount FLOAT = CONVERT(decimal(10,2),(@DebitAmount*@CGSTPercentage*2)/(100+@CGSTPercentage*2))
   DECLARE @CGSTAmount FLOAT = CONVERT(decimal(10,2),0.5*@TaxAmount)
   DECLARE @SGSTAmount FLOAT = CONVERT(decimal(10,2),0.5*@TaxAmount)
   -------------------------End Compute GST----------------------
    DECLARE @PrevBalanceAmount int = (SELECT TOP 1 BalanceAmount from EduSphere.NeurotherapistAccount where NeurotherapistId=@NeurotherapistId ORDER BY TransactionID DESC)
	if(@PrevBalanceAmount is null)  set @PrevBalanceAmount=0 
	INSERT INTO EduSphere.NeurotherapistAccount (NeurotherapistId,ItemId,TransactionDate,TransactionLocation,OfferedRate,Notes, ConsultantID,PaymentMode,TransactionTrigger,DigitalPaymentRefCode, DebitAmount,CreditAmount, BalanceAmount,DiscountAmount,TaxInvoiceNumber,CGSTAmount,SGSTAmount) 
	                                      values(@NeurotherapistId, @ItemId,@TransactionDate,@TransactionLocation,@OfferedRate,@Notes,@ConsultantID,@PaymentMode,@TransactionTrigger,@DigitalPaymentRefCode,@DebitAmount,@CreditAmount,@PrevBalanceAmount-@DebitAmount+@CreditAmount,@DiscountAmount,@TaxInvoiceNumber,@CGSTAmount,@SGSTAmount)
    --DECLARE @RepeatAfter int = (SELECT RepeatAfter FROM EduSphere.Fees WHERE ItemId=@ItemId)--
	-----------------------------Update Invoice Total----------
	EXEC spUpdateNeurotherapistTaxInvoiceTotal @TaxInvoiceNumber
	-----------------------------End Update Invoice Total-------
	IF(@NextFollowup >0)
	BEGIN
		DECLARE @FeeDueDate DATETIME = DATEADD(day,@NextFollowup,GETDATE())
		EXECUTE spAddFeeReminders @ItemId,@NeurotherapistId,@TransactionDate,@FeeDueDate,'PLANNED'
	END
END

drop procedure spMemberFeeAccountTransaction
exec spMemberFeeAccountTransaction 2,104,'2018-04-01','TM01',15930,'',101,'',10,'DEBIT-Fee','',15930,0,1770

-------------------------------------Testing delete later-------------------
SELECT TOP 5 * ,c.FullName as 'custName',a.TransactionID,s.FeeTitle,con.FullName as 'consName',ref.FullName as 'refName',a.TransactionDate,a.OfferedRate,a.DebitAmount,a.CreditAmount,a.PaymentMode,a.DigitalPaymentRefCode,a.BalanceAmount FROM EduSphere.Neurotherapists c JOIN EduSphere.NeurotherapistAccount a ON c.NeurotherapistId=a.NeurotherapistId JOIN EduSphere.Fees s ON s.ItemId=a.ItemId JOIN EduSphere.Staff con ON con.EmployeeID=a.ConsultantID JOIN EduSphere.Staff ref ON ref.EmployeeID=a.Reference where c.NeurotherapistId='43'  order by a.TransactionID desc


-------------------------------------------------------------------------
-----------------------------------------------

create procedure spNeurotherapistsFeeStatus
@Branch varchar(50)
AS
BEGIN
 SELECT p.Branch,f.NeurotherapistId, p.FullName, p.Gender,  SUM(DebitAmount) AS TotalFee ,SUM(CreditAmount) AS Paid, (SUM(DebitAmount)-SUM(CreditAmount)) AS Balance FROM EduSphere.MemberAccount f JOIN Neurotherapists.PersonalDetails p ON f.NeurotherapistId=p.NeurotherapistId WHERE Branch='CREW' GROUP BY f.NeurotherapistId,p.FullName,p.Gender,p.Branch
END


drop procedure spNeurotherapistsFeeStatus
exec spNeurotherapistsFeeStatus

-------------------------------------------------------------------


create table EduSphere.MemberFeeEnquiry
(
EnquiryID int identity(1,1) constraint cstBookingPK PRIMARY KEY,
NeurotherapistId int constraint memIdFK FOREIGN KEY REFERENCES EduSphere.Neurotherapists(NeurotherapistId),
ItemId int constraint srvIdFK FOREIGN KEY REFERENCES EduSphere.Fees(ItemId),
EnquiryNotes varchar(100),
EnquiryDate datetime,
PlannedTransactionDate DateTime,
PlannedFeeTime varchar(20),
PlannedTransactionLocation varchar(50),
FollowUpDetails varchar(200),
EnquiryStatus varchar(10) CONSTRAINT eStatus CHECK(EnquiryStatus IN ('Open','Closed')),
ConsultantID INT,
)

drop table EduSphere.MemberFeeEnquiry
select * FROM EduSphere.MemberFeeEnquiry
truncate table EduSphere.MemberFeeEnquiry

create procedure spMemberFeeEnquiryTransaction
@NeurotherapistId int,
@ItemId int,
@EnquiryNotes varchar(100),
@EnquiryDate datetime,
@PlannedTransactionDate DateTime,
@PlannedFeeTime varchar(10),
@PlannedTransactionLocation varchar(50),
@FollowUpDetails varchar(200),
@EnquiryStatus varchar(10),
@ConsultantID INT
AS
BEGIN
 INSERT INTO EduSphere.MemberFeeEnquiry (NeurotherapistId,ItemId,EnquiryNotes,EnquiryDate,PlannedTransactionDate,PlannedFeeTime,PlannedTransactionLocation,FollowUpDetails,EnquiryStatus,ConsultantID) VALUES(@NeurotherapistId,@ItemId,@EnquiryNotes,@EnquiryDate,@PlannedTransactionDate,@PlannedFeeTime,@PlannedTransactionLocation,@FollowUpDetails,@EnquiryStatus,@ConsultantID)
END

drop procedure spMemberFeeEnquiryTransaction
---------------------------------------------------------------------------------------------------
create procedure spMemberFeeEnquiryUpdate
@EnquiryID int,
@FollowUpDetails varchar(200)

AS
BEGIN
 UPDATE EduSphere.MemberFeeEnquiry SET FollowUpDetails=@FollowUpDetails  WHERE EnquiryID=@EnquiryID
END

drop procedure spMemberFeeEnquiryUpdate

------------------------------------------------------------------------------------------------
declare @start datetime

set @start = '2016-10-12'

DECLARE @Days int
SET @Days= DATEDIFF(d, '2016-10-11','2016-10-12') 


DECLARE @TransactionDate DATETIME ='2016-12-14'
SELECT c.PhoneOne,s.FeeTitle,a.TransactionDate FROM EduSphere.Neurotherapists c JOIN EduSphere.NeurotherapistAccount a ON c.NeurotherapistId=a.NeurotherapistId  JOIN EduSphere.Fees s ON s.ItemId=a.ItemId WHERE a.ItemId=1 and a.FeeStatus='SERV' and a.TransactionDate >=@TransactionDate

--------------------------------------------------------------------------------------------------
create procedure spSumTotal
@id varchar(50),
@dtFrom DateTime,
@dtTo DateTime,
@intSum int output
AS
BEGIN
 declare @retValue int = 0
  SELECT @retValue = SUM(DebitAmount) from EduSphere.NeurotherapistAccount WHERE ConsultantID=@id AND TransactionDate BETWEEN @dtFrom AND @dtTo
  if @retValue IS NULL SET @retValue=0
  set  @intSum=@retValue
END

drop procedure spSumTotal
execute spSumTotal

declare @retValue int
SELECT SUM(DebitAmount) FROM EduSphere.NeurotherapistAccount WHERE ConsultantID='9011' AND TransactionDate BETWEEN '1/1/2017' AND '7/1/2017'

--------------------------------------------------------------------------------------------

create table EduSphere.FeeReminders
(
FeeReminderID INT IDENTITY(1,1) constraint cstFeeRemPK PRIMARY KEY,
ItemId INT CONSTRAINT cstItemId FOREIGN KEY REFERENCES EduSphere.Fees(ItemId),
NeurotherapistID INT CONSTRAINT cstNeurotherapistID FOREIGN KEY REFERENCES EduSphere.Neurotherapists(NeurotherapistId),
PreviousTransactionDate DATETIME,
FeeDueDate DATETIME,
ReminderStatus varchar(20) CONSTRAINT cstFeeRemStatus CHECK(ReminderStatus IN('PLANNED','SENT')) 
)

DROP TABLE EduSphere.FeeReminders
SELECT * FROM EduSphere.FeeReminders
TRUNCATE TABLE EduSphere.FeeReminders
DELETE EduSphere.FeeReminders WHERE FeeReminderID<='26'

CREATE PROCEDURE spAddFeeReminders
@ItemId int,
@NeurotherapistId int,
@PreviousTransactionDate DateTime,
@FeeDueDate DateTime,
@ReminderStatus varchar(20)
AS
BEGIN
	INSERT INTO EduSphere.FeeReminders (ItemId,NeurotherapistId,PreviousTransactionDate,FeeDueDate,ReminderStatus) VALUES(@ItemId,@NeurotherapistId,@PreviousTransactionDate,@FeeDueDate,@ReminderStatus)
END

CREATE PROCEDURE spFeeRemindersStatus
@FeeReminderID int,
@ReminderStatus varchar(20)
AS
BEGIN
 UPDATE EduSphere.FeeReminders SET ReminderStatus=@ReminderStatus WHERE FeeReminderID=@FeeReminderID
END

DROP PROCEDURE spFeeRemindersStatus
SELECT * FROM EduSphere.Fees WHERE FeeGroup='Beauty'

DELETE FROM EduSphere.FeeReminders WHERE ItemId='46'

SELECT * FROM EduSphere.FeeReminders WHERE FeeDueDate < DATEADD(day,20,GETDATE())

----------------------------------------------------------------------
-----------------------------------------GST--------------------------------
----------------------------------------------------------------------------
CREATE TABLE EduSphere.TaxInvoices
(
TaxInvoiceNumber INT IDENTITY(100,1) CONSTRAINT cstNeurotherapistTaxInvoice PRIMARY KEY,
InvoiceDate DATETIME,
NeurotherapistId INT,
ConsultantId INT,
LocationId VARCHAR(20),
DiscountAmount FLOAT,
SubTotal FLOAT,
BaseAmount FLOAT,
SGSTAmount FLOAT,
CGSTAmount FLOAT
)

DROP TABLE EduSphere.TaxInvoices 
SELECT * FROM EduSphere.TaxInvoices

SELECT * FROM EduSphere.TaxInvoices WHERE NeurotherapistId=46 AND CAST(InvoiceDate AS DATE)=CAST(GETDATE() AS DATE)
DELETE FROM EduSphere.TaxInvoices WHERE NeurotherapistId=46
SELECT * FROM EduSphere.TaxInvoices i JOIN EduSphere.Neurotherapists c ON i.NeurotherapistId=c.NeurotherapistId WHERE i.NeurotherapistId=2 AND CAST(InvoiceDate AS DATE)=CAST(GETDATE() AS DATE)
-------------------------------------------------

CREATE PROCEDURE spGenerateNeurotherapistInvoiceNumber
@NeurotherapistId INT,
@ConsultantId INT,
@LocationId VARCHAR(20)
AS
BEGIN
 IF NOT EXISTS (SELECT TaxInvoiceNumber FROM EduSphere.TaxInvoices WHERE NeurotherapistId=@NeurotherapistId AND (CAST(InvoiceDate AS DATE)=CAST(GETDATE() AS DATE)))
 BEGIN
   INSERT INTO EduSphere.TaxInvoices (NeurotherapistId,ConsultantId,LocationId,InvoiceDate) VALUES(@NeurotherapistId,@ConsultantId,@LocationId,GETDATE())
 END
END

DROP PROCEDURE spGenerateNeurotherapistInvoiceNumber 
EXEC spGenerateNeurotherapistInvoiceNumber 46

---------------------------spUpdateNeurotherapistTaxInvoiceTotal-Update total after each Debit/Credit---------------
CREATE PROCEDURE spUpdateNeurotherapistTaxInvoiceTotal
@TaxInvoiceNumber INT
AS
BEGIN
	DECLARE @DiscountAmount FLOAT= (SELECT SUM(DiscountAmount) FROM EduSphere.NeurotherapistAccount WHERE TaxInvoiceNumber=@TaxInvoiceNumber)
    DECLARE @SubTotal FLOAT		= (SELECT SUM(DebitAmount) FROM EduSphere.NeurotherapistAccount WHERE TaxInvoiceNumber=@TaxInvoiceNumber)
    DECLARE @CGSTAmount FLOAT	= (SELECT SUM(CGSTAmount) FROM EduSphere.NeurotherapistAccount WHERE TaxInvoiceNumber=@TaxInvoiceNumber)
    DECLARE @SGSTAmount FLOAT	= (SELECT SUM(SGSTAmount) FROM EduSphere.NeurotherapistAccount WHERE TaxInvoiceNumber=@TaxInvoiceNumber)

    UPDATE EduSphere.TaxInvoices SET DiscountAmount=@DiscountAmount,SubTotal=@SubTotal,BaseAmount=@SubTotal-@CGSTAmount-@SGSTAmount,SGSTAmount=@SGSTAmount,CGSTAmount=@CGSTAmount WHERE TaxInvoiceNumber=@TaxInvoiceNumber
END

DROP PROCEDURE spUpdateNeurotherapistTaxInvoiceTotal
EXEC spUpdateNeurotherapistTaxInvoiceTotal 100

----------------------------------TAXCODES--------------------

---Refer Member Account-----
