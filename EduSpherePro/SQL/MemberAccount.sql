create table EduSphere.MemberAccount
(
TransactionID int identity(1,1) constraint cstTransactionPK PRIMARY KEY,
MemberId int constraint custIdFK FOREIGN KEY REFERENCES EduSphere.Members(MemberId),
SkuId int constraint servIdFK FOREIGN KEY REFERENCES EduSphere.SKU(SkuId),
TxDate DateTime,
TxLocation INT constraint locId FOREIGN KEY REFERENCES EduSphere.Organizations(OrganizationID),
OfferedRate int,
Notes varchar(100),
ConsultantOneID INT constraint conOneId FOREIGN KEY REFERENCES EduSphere.Staff(EmployeeId),
ConsultantOneEffortPercentage INT,
ConsultantTwoID INT constraint conTwoId FOREIGN KEY REFERENCES EduSphere.Staff(EmployeeId),
ConsultantTwoEffortPercentage INT,
ConsultantThreeID INT constraint conThreeId FOREIGN KEY REFERENCES EduSphere.Staff(EmployeeId),
ConsultantThreeEffortPercentage INT,
PaymentMode varchar(50),
DigitalPaymentRefCode varchar(100),
NextFollowup INT,
TransactionTrigger varchar(20) CONSTRAINT cstTransTrig CHECK(TransactionTrigger IN('DEBIT-Sku','REVERSAL','VOUCHER-CREDIT','RECEIPT-PREV-BILL','RECEIPT-CURR-BILL','RECEIPT-MEMBERSHIP')),
DebitAmount DECIMAL(19,2),
CreditAmount DECIMAL(19,2),
BalanceAmount DECIMAL(19,2),
DiscountAmount DECIMAL(19,2), 
CGSTAmount DECIMAL(19,2),
SGSTAmount DECIMAL(19,2),
TaxInvoiceNumber INT,
RatingCompletionStatus VARCHAR(20) CONSTRAINT ratComStatus CHECK(RatingCompletionStatus IN ('OPEN','COMPLETED')),
DiscountReason VARCHAR(50),
DiscountComments VARCHAR(50) 
)

alter table EduSphere.MemberAccount add DiscountReason VARCHAR(50)
alter table EduSphere.MemberAccount add DiscountComments VARCHAR(50)

ALTER TABLE EduSphere.MemberAccount DROP CONSTRAINT cstTransTrig
ALTER TABLE EduSphere.MemberAccount DROP COLUMN TransactionTrigger
ALTER TABLE EduSphere.MemberAccount ADD TransactionTrigger varchar(20) CONSTRAINT cstTransTrig CHECK(TransactionTrigger IN('DEBIT-Sku','REVERSAL','VOUCHER-CREDIT','RECEIPT-PREV-BILL','RECEIPT-CURR-BILL','RECEIPT-MEMBERSHIP')) 
DROP TABLE EduSphere.MemberAccount

ALTER TABLE EduSphere.MemberAccount ADD RatingCompletionStatus VARCHAR(20) CONSTRAINT ratComStatus CHECK(RatingCompletionStatus IN ('OPEN','COMPLETED'))
UPDATE EduSphere.MemberAccount SET RatingCompletionStatus='OPEN'
SELECT * FROM EduSphere.MemberAccount WHERE RatingCompletionStatus!='COMPLETED'
sp_help 'EduSphere.MemberAccount'

SELECT  *  FROM EduSphere.MemberAccount WHERE MemberId='135'  order by TransactionID desc
SELECT BalanceAmount,CustomerID FROM EduSphere.MemberAccount WHERE BalanceAmount =0  ORDER BY CustomerID
DELETE  EduSphere.MemberAccount where TaxInvoiceNumber=337
SELECT  * From EduSphere.MemberAccount a JOIN EduSphere.Members c ON a.CustomerID=c.CustomerID JOIN EduSphere.SKU s ON a.SkuID=s.SkuID WHERE a.DebitAmount!=0    order by a.TxDate desc
SELECT TOP 10 *,c.FullName as CustomerName,a.TransactionID,s.SkuTitle,con.FullName as ConsultantName,ref.FullName as ReferedBy,a.TxDate,a.OfferedRate,a.SkuStatus,a.DebitAmount,a.CreditAmount,a.PaymentMode,a.DigitalPaymentRefCode,a.BalanceAmount FROM EduSphere.MemberAccount a JOIN EduSphere.Members c  ON c.MemberId=a.MemberId JOIN EduSphere.SKU s ON s.SkuId=a.SkuId JOIN EduSphere.Staff con ON con.EmployeeId=a.ConsultantName JOIN EduSphere.Staff ref ON ref.EmployeeId=a.Reference where a.MemberId='2705'  order by a.TransactionID desc
SELECT TOP 7 *,c.FullName as CustomerName,a.TransactionID,SkuTitle,con.FullName as ConsultantName,ref.FullName as ReferedBy,TxDate,OfferedRate,SkuStatus,DebitAmount,CreditAmount,PaymentMode,DigitalPaymentRefCode,BalanceAmount FROM EduSphere.MemberAccount a JOIN EduSphere.Members c  ON a.MemberId=c.MemberId JOIN EduSphere.SKU s ON a.SkuId=s.SkuId JOIN EduSphere.Staff con ON a.ConsultantName=con.EmployeeId JOIN EduSphere.Staff ref ON a.Reference=ref.EmployeeId where a.MemberId='868'  order by a.TransactionID desc

DELETE FROM EduSphere.MemberAccount WHERE MemberId<=15

SELECT  *  FROM EduSphere.MemberAccount WHERE CAST(TxDate AS DATE)>='2018-09-01' AND CAST(TxDate AS DATE)<='2018-09-04'  order by TransactionID desc
UPDATE EduSphere.MemberAccount SET TxLocation='S02' ='AS0001', Reference='KA0001',AdditonalResourceOneId='TEST0100'

SELECT SUM(DebitAmount) AS BillAmount, year(a.TxDate) AS Year,month(a.TxDate) AS Month, e.EmployeeId AS EmpId,e.FullName AS Name FROM EduSphere.MemberAccount a JOIN EduSphere.Staff e ON a.ConsultantName=e.EmployeeId WHERE month(a.TxDate)=month(GETDATE())   GROUP BY e.EmployeeId,e.FullName,year(a.TxDate),month(a.TxDate) ORDER BY SUM(DebitAmount) DESC
SELECT SUM(DebitAmount) AS BillAmount,a.ConsultantName AS Id,e.FullName+' '+e.Gender AS Name FROM EduSphere.MemberAccount a  JOIN EduSphere.Staff e ON a.ConsultantName=e.EmployeeId WHERE CAST(TxDate AS DATE)=CAST('2017-07-17' AS DATE) AND a.TxLocation='PoonamSagar'   GROUP BY a.ConsultantName,e.FullName,e.Gender ORDER BY SUM(DebitAmount) DESC

SELECT SUM(CreditAmount) AS ReceivedAmount,PaymentMode FROM EduSphere.MemberAccount WHERE CAST(TxDate AS DATE)=CAST('2017-07-17' AS DATE)   GROUP BY PaymentMode ORDER BY PaymentMode DESC



SELECT t1.CustomerID,t1.BalanceAmount,t1.TxDate
FROM EduSphere.MemberAccount t1
LEFT OUTER JOIN EduSphere.MemberAccount t2
  ON (t1.CustomerID = t2.CustomerID AND t1.TxDate < t2.TxDate)
WHERE t2.CUstomerID IS NULL AND t1.BalanceAmount!=0 ORDER BY t1.BalanceAmount ASC;

 

EXEC spCustomerBalance @TxLocation='PoonamSagar'

select * from EduSphere.MemberAccount  where DebitAmount!=0 AND ConsultantName='8001' AND TxDate between '3-20-2017' AND '04-08-2017'
SELECT  * From EduSphere.MemberAccount a JOIN EduSphere.Members c ON a.CustomerID=c.CustomerID JOIN EduSphere.SKU s ON a.SkuID=s.SkuID WHERE a.DebitAmount!=0    order by a.TxDate desc
SELECT *  from EduSphere.MemberAccount WHERE  MemberId ='1'
DELETE   from EduSphere.MemberAccount WHERE  MemberId ='52'
UPDATE EduSphere.MemberAccount SET SkuStatus='SERV', ConsultantName='0000' WHERE SkuStatus='ENQ'

drop table EduSphere.MemberAccount
truncate table EduSphere.MemberAccount



INSERT INTO EduSphere.MemberAccount values(1,1,GETDATE(),GETDATE(),100,'Inital Account Creation','REQ','Hiral',0,0,0)

SELECT    c.FullName,a.TransactionID,s.SkuTitle,e.FullName as cons,em.FullName as ref,a.TxDate,a.OfferedRate,a.SkuStatus,a.DebitAmount,a.CreditAmount,a.PaymentMode,a.DigitalPaymentRefCode,a.BalanceAmount FROM EduSphere.Members c JOIN EduSphere.MemberAccount a ON c.MemberId=a.MemberId JOIN EduSphere.SKU s ON s.SkuId=a.SkuId JOIN EduSphere.Staff e ON e.EmployeeId=a.ConsultantName JOIN EduSphere.Staff em ON em.EmployeeId=a.Reference  order by a.TransactionID desc

SELECT  R1.FullName AS ConsOne,SUM(ConsultantOneEffortPercentage) AS ConsOne_Amount,R2.FullName AS ConsTwo,SUM(ConsultantTwoEffortPercentage) AS ConsTwo_Amount,R3.FullName AS ConsThree,SUM(ConsultantThreeEffortPercentage) AS ConsThree_Amount
                                                            FROM EduSphere.MemberAccount a JOIN EduSphere.Staff R1 ON a.ConsultantOneID=R1.EmployeeId 
			                                                JOIN EduSphere.Staff R2 ON a.ConsultantTwoID=R2.EmployeeId
													        JOIN EduSphere.Staff R3 ON a.ConsultantThreeID=R3.EmployeeId
		                                                    WHERE a.TxLocation='TM01' AND (a.TxDate BETWEEN '2018-04-01' AND '2018-04-10')  GROUP BY R1.FullName,R2.FullName,R3.FullName

SELECT SUM(ConsultantOneEffortPercentage)+SUM(ConsultantTwoEffortPercentage)+SUM(ConsultantThreeEffortPercentage) AS ConsulantEffort FROM EduSphere.MemberAccount WHERE (ConsultantOneID=102 OR ConsultantTwoID=102 OR ConsultantThreeID=102) AND (TxDate BETWEEN '2018-04-01' AND '2018-04-10')  
SELECT * FROM EduSphere.MemberAccount WHERE (ConsultantOneID=102 OR ConsultantTwoID=102 OR ConsultantThreeID=102) AND (TxDate BETWEEN '2018-04-01' AND '2018-04-10')  

SELECT ProductTitle,DiscountAmount,CGSTAmount, SGSTAmount,DebitAmount,CreditAmount FROM EduSphere.ProductSaleTransaction pt JOIN EduSphere.Products p ON pt.ProductId=p.ProductId WHERE MemberId=17 AND (CAST(dtOfPurchase AS DATE)=CAST(GETDATE() AS DATE))
SELECT SkuTitle,DiscountAmount,CGSTAmount, SGSTAmount,DebitAmount,CreditAmount FROM EduSphere.MemberAccount st JOIN EduSphere.SKU s ON st.SkuId=s.SkuId WHERE MemberId=17 AND (CAST(TxDate AS DATE)=CAST(GETDATE() AS DATE))
SELECT (SUM(CreditAmount)-SUM(DebitAmount)-(SELECT SUM(DebitAmount) FROM EduSphere.ProductSaleTransaction WHERE MemberId='10')) 
	                                            FROM EduSphere.MemberAccount WHERE MemberId='10'
SELECT (SUM(CreditAmount)-SUM(DebitAmount)-0) 
	                                            FROM EduSphere.MemberAccount WHERE MemberId='10'

------------------------------------------------------------------------------------------------------------------
create procedure spMemberAccountTransaction
@MemberId varchar(50),
@SkuId int,
@TxDate DateTime,
@TxLocation varchar(50),
@OfferedRate DECIMAL(19,2),
@Notes varchar(100),
@ConsultantOneID INT,
@ConsultantOneEffortPercentage INT,
@ConsultantTwoID INT,
@ConsultantTwoEffortPercentage INT,
@ConsultantThreeID INT,
@ConsultantThreeEffortPercentage INT,
@PaymentMode varchar(50),
@NextFollowup INT,
@TransactionTrigger varchar(20),
@DigitalPaymentRefCode varchar(100),
@DebitAmount DECIMAL(19,2),
@CreditAmount DECIMAL(19,2),
@DiscountAmount DECIMAL(19,2)
AS
BEGIN
   -------------Generate Invoice Number for Transaction and Associate it with Transaction------------
   DECLARE @TaxInvoiceNumber INT
   SET @TaxInvoiceNumber=(SELECT TOP 1 TaxInvoiceNumber FROM EduSphere.TaxInvoices WHERE MemberId=@MemberId AND (CAST(InvoiceDate AS DATE)=CAST(GETDATE() AS DATE)) ORDER BY TaxInvoiceNumber DESC)
   IF @TaxInvoiceNumber is null
	BEGIN
	  EXEC spGenerateInvoiceNumber @MemberId,@ConsultantOneID,@TxLocation
	  SET @TaxInvoiceNumber=(SELECT TaxInvoiceNumber FROM EduSphere.TaxInvoices WHERE MemberId=@MemberId AND (CAST(InvoiceDate AS DATE)=CAST(GETDATE() AS DATE)))
	END
   -------------------------End Invoice------------------------------------------------------------
   -------------------------Compute CGST and SGST-------------------------------------------------
   DECLARE @TaxCode VARCHAR(20)=(SELECT TaxCode FROM EduSphere.SKU WHERE SkuId=@SkuId)
   IF @TaxCode is null 
   BEGIN
      SET @TaxCode='999729'
   END
   -----GET GST RATES----
   DECLARE @CGSTPercentage DECIMAL(19,2) = (SELECT CGSTPercentage FROM EduSphere.TaxCodes WHERE TaxCode=@TaxCode)
   DECLARE @SGSTPercentage DECIMAL(19,2) = (SELECT SGSTPercentage FROM EduSphere.TaxCodes WHERE TaxCode=@TaxCode)
   -------CALCULATE TAX FROM BILL AMOUNT (The rates are inclusive of GST)---------
   --------Following line is needed only if rates are not inclusive of taxes----
   --SET @DebitAmount = @DebitAmount*(100+@CGSTPercentage*2)/100--
   --------------End-line needed only if rates are not inclusive of taxes----------------
   DECLARE @TaxAmount DECIMAL(19,2) = CONVERT(decimal(19,2),(@DebitAmount*@CGSTPercentage*2)/(100+@CGSTPercentage*2))
   DECLARE @CGSTAmount DECIMAL(19,2) = CONVERT(decimal(19,2),0.5*@TaxAmount)
   DECLARE @SGSTAmount DECIMAL(19,2) = CONVERT(decimal(19,2),0.5*@TaxAmount)
   -------------------------End Compute GST----------------------
   -------------------------Generate Bill---------------------------
    --DECLARE @PrevBalanceAmount int = (SELECT TOP 1 BalanceAmount from EduSphere.MemberAccount where MemberId=@MemberId ORDER BY TransactionID DESC)--
	--Get product balance-NA FOR EDUSPHERE-
	--DECLARE @PrevProductBalance DECIMAL(19,2)=(SELECT SUM(DebitAmount) FROM EduSphere.ProductSaleTransaction WHERE MemberId=@MemberId)
	--if(@PrevProductBalance is null) set @PrevProductBalance=0.0
	
	DECLARE @PrevBalanceAmount DECIMAL(19,2) = (SELECT (SUM(CreditAmount)-SUM(DebitAmount)) 
	                                            FROM EduSphere.MemberAccount WHERE MemberId=@MemberId)
	
	if(@PrevBalanceAmount is null)  set @PrevBalanceAmount=0
	If(@TransactionTrigger!='REVERSAL')
	BEGIN
	INSERT INTO EduSphere.MemberAccount (MemberId,SkuId,TxDate,TxLocation,OfferedRate,Notes, ConsultantOneID,ConsultantOneEffortPercentage, ConsultantTwoID,ConsultantTwoEffortPercentage,ConsultantThreeID,ConsultantThreeEffortPercentage,PaymentMode,TransactionTrigger,DigitalPaymentRefCode, DebitAmount,CreditAmount, BalanceAmount,DiscountAmount,TaxInvoiceNumber,CGSTAmount,SGSTAmount,RatingCompletionStatus) 
	                                      values(@MemberId, @SkuId,@TxDate,@TxLocation,@OfferedRate,@Notes,@ConsultantOneID,@ConsultantOneEffortPercentage, @ConsultantTwoID,@ConsultantTwoEffortPercentage,@ConsultantThreeID,@ConsultantThreeEffortPercentage,@PaymentMode,@TransactionTrigger,@DigitalPaymentRefCode,@DebitAmount,@CreditAmount,@PrevBalanceAmount-@DebitAmount+@CreditAmount,@DiscountAmount,@TaxInvoiceNumber,@CGSTAmount,@SGSTAmount,'OPEN')
    END
	IF(@TransactionTrigger='REVERSAL')-------GET ConsutlantID and Effort from TransactionID that is getting reversed. Ignore the values coming from Application-----
	BEGIN
	   DECLARE @tmpTransactionID int=@SkuID
	   DECLARE @rSkuID INT								= (SELECT SkuID FROM EduSphere.MemberAccount WHERE TransactionID=@tmpTransactionID)
	   DECLARE @rDebitAmount decimal(19,2)					= -(SELECT DebitAmount FROM EduSphere.MemberAccount WHERE TransactionID=@tmpTransactionID)
	   DECLARE @rDiscountAmount decimal(19,2)			    = -(SELECT DiscountAmount FROM EduSphere.MemberAccount WHERE TransactionID=@tmpTransactionID)
	   DECLARE @rOfferedRate decimal(19,2)					= -(SELECT OfferedRate FROM EduSphere.MemberAccount WHERE TransactionID=@tmpTransactionID)
	   DECLARE @rCGSTAmount decimal(19,2)					= -(SELECT CGSTAmount FROM EduSphere.MemberAccount WHERE TransactionID=@tmpTransactionID)
	   DECLARE @rSGSTAmount decimal(19,2)					= -(SELECT SGSTAmount FROM EduSphere.MemberAccount WHERE TransactionID=@tmpTransactionID)
	   DECLARE @rPrevBalanceAmount decimal(19,2)			= @PrevBalanceAmount--Its wrong to select the Balance of TransactionID-- (SELECT BalanceAmount FROM EduSphere.MemberAccount WHERE TransactionID=@tmpTransactionID)--
	   DECLARE @rTxLocation varchar(50)				= (SELECT TxLocation FROM EduSphere.MemberAccount WHERE TransactionID=@tmpTransactionID)
	   DECLARE @rConsultantOneID INT						= (SELECT ConsultantOneID FROM EduSphere.MemberAccount WHERE TransactionID=@tmpTransactionID)
	   DECLARE @rConsultantTwoID INT						= (SELECT ConsultantTwoID FROM EduSphere.MemberAccount WHERE TransactionID=@tmpTransactionID)
	   DECLARE @rConsultantThreeID INT						= (SELECT ConsultantThreeID FROM EduSphere.MemberAccount WHERE TransactionID=@tmpTransactionID)
	   DECLARE @rConsultantOneEffortPercentage INT			= -(SELECT ConsultantOneEffortPercentage FROM EduSphere.MemberAccount WHERE TransactionID=@tmpTransactionID)
	   DECLARE @rConsultantTwoEffortPercentage INT			= -(SELECT ConsultantTwoEffortPercentage FROM EduSphere.MemberAccount WHERE TransactionID=@tmpTransactionID)
	   DECLARE @rConsultantThreeEffortPercentage INT		= -(SELECT ConsultantThreeEffortPercentage FROM EduSphere.MemberAccount WHERE TransactionID=@tmpTransactionID)

	   INSERT INTO EduSphere.MemberAccount (MemberId,SkuId,TxDate,TxLocation,OfferedRate,Notes, ConsultantOneID,ConsultantOneEffortPercentage, ConsultantTwoID,ConsultantTwoEffortPercentage,ConsultantThreeID,ConsultantThreeEffortPercentage,PaymentMode,TransactionTrigger,DigitalPaymentRefCode, DebitAmount,CreditAmount, BalanceAmount,DiscountAmount,TaxInvoiceNumber,CGSTAmount,SGSTAmount,RatingCompletionStatus) 
	                                      values(@MemberId, @rSkuId,@TxDate,@rTxLocation,@rOfferedRate,@Notes,@rConsultantOneID,@rConsultantOneEffortPercentage, @rConsultantTwoID,@rConsultantTwoEffortPercentage,@rConsultantThreeID,@rConsultantThreeEffortPercentage,@PaymentMode,@TransactionTrigger,@DigitalPaymentRefCode,@rDebitAmount,@CreditAmount,@rPrevBalanceAmount-@rDebitAmount+@CreditAmount,@rDiscountAmount,@TaxInvoiceNumber,@rCGSTAmount,@rSGSTAmount,'OPEN')
	   -----UPDATE THE NOTES FOR THE Sku THAT IS REVERSED/ This will help to avoid asking Rating and Giving final bill---
	   UPDATE EduSphere.MemberAccount SET Notes='ItemCancelled' WHERE TransactionID=@tmpTransactionID
		 --------------------REVERSE BONUS POINTS IN BONUS WALLET----NOT APPLICABLE FOR EDUSPHERE----------
	   --DECLARE @rDebitPoints DECIMAL(19,2)= -(SELECT DebitAmount FROM EduSphere.MemberAccount WHERE TransactionID=@tmpTransactionID)/100
	   --INSERT INTO EduSphere.BonusWallet (MemberID,TaxInvoiceNumber,CreditPoints,DebitPoints,BonusWalletTxDate,BonusWalletTxDoneBy,Comments)
				--							VALUES(@MemberID,@TaxInvoiceNumber, @rDebitPoints,@CreditAmount,GETDATE(),'SALONSYSTEM','POINTS REVERSED')
	END
	--DECLARE @RepeatAfter int = (SELECT RepeatAfter FROM EduSphere.SKU WHERE SkuID=@SkuId)--
	
	
	-----------------------------Update Invoice Total----------
	EXEC spUpdateTaxInvoiceTotal @TaxInvoiceNumber
	-----------------------------End Update Invoice Total-------
	
	------------ADD TO BONUS WALLET ONLY if its purchase of Sku----NOT APPLICABLE TO EDUSPHERE----
	--IF((@CreditAmount=0) AND (@TransactionTrigger!='REVERSAL'))
	--BEGIN		
	--	INSERT INTO EduSphere.BonusWallet (MemberID,TaxInvoiceNumber,CreditPoints,DebitPoints,BonusWalletTxDate,BonusWalletTxDoneBy,Comments)
	--										VALUES(@MemberID,@TaxInvoiceNumber,@DebitAmount/100,@CreditAmount,GETDATE(),'SALONSYSTEM','EARNED')
	--END	
	----------------END BONUS WALLET----
	
	IF(@NextFollowup >0)
	BEGIN
		DECLARE @SkuDueDate DATETIME = DATEADD(day,@NextFollowup,GETDATE())
		EXECUTE spAddSkuReminders @SkuId,@MemberId,@TxDate,@SkuDueDate,'PLANNED'
	END
END

drop procedure spMemberAccountTransaction
exec spMemberAccountTransaction

SELECT * FROM EduSphere.MemberAccount WHERE CustomerID=23
SELECT * FROM EduSphere.MemberAccount WHERE CustomerID=18

DELETE FROM EduSphere.MemberAccount WHERE CustomerID=23
------------------------------------------------------------------------------------------------------------------------------



-------------------------------------Testing delete later-------------------
SELECT TOP 5 * ,c.FullName as 'custName',a.TransactionID,s.SkuTitle,con.FullName as 'consName',ref.FullName as 'refName',a.TxDate,a.OfferedRate,a.DebitAmount,a.CreditAmount,a.PaymentMode,a.DigitalPaymentRefCode,a.BalanceAmount FROM EduSphere.Members c JOIN EduSphere.MemberAccount a ON c.MemberId=a.MemberId JOIN EduSphere.SKU s ON s.SkuId=a.SkuId JOIN EduSphere.Staff con ON con.EmployeeId=a.ConsultantName JOIN EduSphere.Staff ref ON ref.EmployeeId=a.Reference where c.MemberId='43'  order by a.TransactionID desc


------------------------------------------------------------------------------------
---Adds Divided efforts as ConsOne,ConsTwo,ConsThree for a given Staff-------
CREATE PROCEDURE spSkuBillSpecific
@EmployeeId INT,
@FromDt Date,
@ToDt Date,
@SkuBillAmount DECIMAL(19,2) OUTPUT
AS
BEGIN
	DECLARE @EffortAsC1 DECIMAL(19,2) = (SELECT SUM(ConsultantOneEffortPercentage) FROM EduSphere.MemberAccount WHERE ConsultantOneID=@EmployeeId AND TxDate BETWEEN @FromDt AND @ToDt) 
	if(@EffortAsC1 is null)
	BEGIN 
	   SET @EffortAsC1=0
	 END 
	DECLARE @EffortAsC2 DECIMAL(19,2) = (SELECT SUM(ConsultantTwoEffortPercentage) FROM EduSphere.MemberAccount WHERE ConsultantTwoID=@EmployeeId AND TxDate BETWEEN @FromDt AND @ToDt) 
	if(@EffortAsC2 is null)
	BEGIN 
	   SET @EffortAsC2=0
	 END 
	DECLARE @EffortAsC3 DECIMAL(19,2) = (SELECT SUM(ConsultantThreeEffortPercentage) FROM EduSphere.MemberAccount WHERE ConsultantThreeID=@EmployeeId AND TxDate BETWEEN  @FromDt AND @ToDt) 
	if(@EffortAsC3 is null)
	BEGIN 
	   SET @EffortAsC3=0
	 END 
	SET @SkuBillAmount=@EffortAsC1+@EffortAsC2+@EffortAsC3
	RETURN  @SkuBillAmount
END
---------------------------------------------------------
DROP PROCEDURE spSkuBillSpecific

DECLARE @SkuBillAmount INT
EXEC @SkuBillAmount=spSkuBillSpecific '103',0
PRINT @SkuBillAmount
-----------------------------------------------

create procedure spStudentsFeeStatus
@Branch varchar(50)
AS
BEGIN
 SELECT p.Branch,f.MemberId, p.FullName, p.Gender,  SUM(DebitAmount) AS TotalFee ,SUM(CreditAmount) AS Paid, (SUM(DebitAmount)-SUM(CreditAmount)) AS Balance FROM EduSphere.MemberAccount f JOIN Students.PersonalDetails p ON f.MemberId=p.MemberId WHERE Branch='CREW' GROUP BY f.MemberId,p.FullName,p.Gender,p.Branch
END


drop procedure spStudentsFeeStatus
exec spStudentsFeeStatus

-------------------------------------------------------------------


create table EduSphere.MemberSkuEnquiry
(
EnquiryID int identity(1,1) constraint cstBookingPK PRIMARY KEY,
MemberId int constraint memIdFK FOREIGN KEY REFERENCES EduSphere.Members(MemberId),
SkuId int constraint srvIdFK FOREIGN KEY REFERENCES EduSphere.SKU(SkuId),
EnquiryNotes varchar(100),
EnquiryDate datetime,
PlannedTxDate DateTime,
PlannedSkuTime varchar(20),
PlannedTxLocation varchar(50),
FollowUpDetails varchar(200),
EnquiryStatus varchar(10) CONSTRAINT eStatus CHECK(EnquiryStatus IN ('Open','Closed')),
ConsultantName varchar(50),
)

drop table EduSphere.MemberSkuEnquiry
select * FROM EduSphere.MemberSkuEnquiry
truncate table EduSphere.MemberSkuEnquiry

create procedure spMemberSkuEnquiryTransaction
@MemberId int,
@SkuId int,
@EnquiryNotes varchar(100),
@EnquiryDate datetime,
@PlannedTxDate DateTime,
@PlannedSkuTime varchar(10),
@PlannedTxLocation varchar(50),
@FollowUpDetails varchar(200),
@EnquiryStatus varchar(10),
@ConsultantName varchar(50)
AS
BEGIN
 INSERT INTO EduSphere.MemberSkuEnquiry (MemberId,SkuId,EnquiryNotes,EnquiryDate,PlannedTxDate,PlannedSkuTime,PlannedTxLocation,FollowUpDetails,EnquiryStatus,ConsultantName) VALUES(@MemberId,@SkuId,@EnquiryNotes,@EnquiryDate,@PlannedTxDate,@PlannedSkuTime,@PlannedTxLocation,@FollowUpDetails,@EnquiryStatus,@ConsultantName)
END

drop procedure spMemberSkuEnquiryTransaction
---------------------------------------------------------------------------------------------------
create procedure spMemberSkuEnquiryUpdate
@EnquiryID int,
@FollowUpDetails varchar(200)

AS
BEGIN
 UPDATE EduSphere.MemberSkuEnquiry SET FollowUpDetails=@FollowUpDetails  WHERE EnquiryID=@EnquiryID
END

drop procedure spMemberSkuEnquiryUpdate

------------------------------------------------------------------------------------------------
declare @start datetime

set @start = '2016-10-12'

DECLARE @Days int
SET @Days= DATEDIFF(d, '2016-10-11','2016-10-12') 


DECLARE @TxDate DATETIME ='2016-12-14'
SELECT c.PhoneOne,s.SkuTitle,a.TxDate FROM EduSphere.Members c JOIN EduSphere.MemberAccount a ON c.MemberId=a.MemberId  JOIN EduSphere.SKU s ON s.SkuId=a.SkuId WHERE a.SkuID=1 and a.SkuStatus='SERV' and a.TxDate >=@TxDate

--------------------------------------------------------------------------------------------------
create procedure spSumTotal
@id varchar(50),
@dtFrom DateTime,
@dtTo DateTime,
@intSum int output
AS
BEGIN
 declare @retValue int = 0
  SELECT @retValue = SUM(DebitAmount) from EduSphere.MemberAccount WHERE ConsultantName=@id AND TxDate BETWEEN @dtFrom AND @dtTo
  if @retValue IS NULL SET @retValue=0
  set  @intSum=@retValue
END

drop procedure spSumTotal
execute spSumTotal

declare @retValue int
SELECT SUM(DebitAmount) FROM EduSphere.MemberAccount WHERE ConsultantName='9011' AND TxDate BETWEEN '1/1/2017' AND '7/1/2017'

--------------------------------------------------------------------------------------------

create table EduSphere.SkuReminders
(
SkuReminderID INT IDENTITY(1,1) constraint cstRemPK PRIMARY KEY,
SkuID INT CONSTRAINT cstSerFK FOREIGN KEY REFERENCES EduSphere.SKU(SkuID),
MemberID INT CONSTRAINT cstCusID FOREIGN KEY REFERENCES EduSphere.Members(MemberId),
PreviousTxDate DATETIME,
SkuDueDate DATETIME,
ReminderStatus varchar(20) CONSTRAINT cstRemStatus CHECK(ReminderStatus IN('PLANNED','SENT')) 
)

DROP TABLE EduSphere.SkuReminders
SELECT * FROM EduSphere.SkuReminders
TRUNCATE TABLE EduSphere.SkuReminders
DELETE EduSphere.SkuReminders WHERE SkuReminderID<='26'



CREATE PROCEDURE spAddSkuReminders
@SkuID int,
@MemberId int,
@PreviousTxDate DateTime,
@SkuDueDate DateTime,
@ReminderStatus varchar(20)
AS
BEGIN
	INSERT INTO EduSphere.SkuReminders (SkuID,MemberId,PreviousTxDate,SkuDueDate,ReminderStatus) VALUES(@SkuID,@MemberId,@PreviousTxDate,@SkuDueDate,@ReminderStatus)
END

DROP PROCEDURE spAddSkuReminders

CREATE PROCEDURE spSkuRemindersStatus
@SkuReminderID int,
@ReminderStatus varchar(20)
AS
BEGIN
 UPDATE EduSphere.SkuReminders SET ReminderStatus=@ReminderStatus WHERE SkuReminderID=@SkuReminderID
END

DROP PROCEDURE spSkuRemindersStatus
SELECT * FROM EduSphere.SKU WHERE SkuGroup='Beauty'
UPDATE EduSphere.SkuReminders SET ReminderStatus='PLANNED' WHERE SkuReminderId=27
DELETE FROM EduSphere.SkuReminders WHERE SkuID='46'

SELECT * FROM EduSphere.SkuReminders WHERE SkuDueDate < DATEADD(day,20,GETDATE())

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
DiscountAmount DECIMAL(19,2),
SubTotal DECIMAL(19,2),
CreditAmount DECIMAL(19,2),
BaseAmount DECIMAL(19,2),
SGSTAmount DECIMAL(19,2),
CGSTAmount DECIMAL(19,2),
)

---DUMMY TAXINVOICE NUMBER--
SET IDENTITY_INSERT EduSphere.TaxInvoices ON
  INSERT INTO EduSphere.TaxInvoices(TaxInvoiceNumber) VALUES('90')
SET IDENTITY_INSERT EduSphere.TaxInvoices OFF

DROP TABLE EduSphere.TaxInvoices 
SELECT * FROM EduSphere.TaxInvoices WHERE TaxInvoiceNumber=337

SELECT * FROM EduSphere.TaxInvoices WHERE MemberId=52 AND CAST(InvoiceDate AS DATE)=CAST(GETDATE() AS DATE)
DELETE FROM EduSphere.TaxInvoices WHERE TaxInvoiceNumber=337

-----------------------INVOICE TEST QUERIES---------------
SELECT  InvoiceDate, SkuTitle,sa.DebitAmount AS SkuAmt,productTitle,pa.debitAmount as ProductAmount, sa.CreditAmount AS Paymnet 
       FROM EduSphere.TaxInvoices ti
         JOIN EduSphere.MemberAccount sa ON ti.TaxInvoiceNumber=sa.TaxInvoiceNumber
		  JOIN EduSphere.SKU sr ON sa.SkuID=sr.SkuID
		  JOIN EduSphere.ProductSaleTransaction pa ON ti.TaxInvoiceNumber=pa.TaxInvoiceNumber 
		  JOIN EduSphere.Products pr ON pa.ProductID=pr.ProductID
		 WHERE ti.CustomerID='3370' GROUP BY InvoiceDate,SkuTitle,productTitle,pa.debitAmount,sa.CreditAmount

SELECT InvoiceDate,(SELECT SUM(CreditAmount) FROM EduSphere.MemberAccount WHERE CustomerID='3370')+ (SELECT SUM(creditAmount) FROM EduSphere.ProductSaleTransaction WHERE CustomerID='3370')-SUM(SubTotal) AS Balnace 
      FROM EduSphere.TaxInvoices  WHERE 
	  CustomerID='3370' GROUP BY InvoiceDate

------------------------END INVOICE TEST QUERIES..........
-------------------------------------------------

CREATE PROCEDURE spGenerateInvoiceNumber
@MemberId INT,
@ConsultantOneID INT,
@LocationId VARCHAR(50)
AS
BEGIN
 IF NOT EXISTS (SELECT TOP 1 TaxInvoiceNumber FROM EduSphere.TaxInvoices WHERE MemberId=@MemberId AND (CAST(InvoiceDate AS DATE)=CAST(GETDATE() AS DATE)) ORDER BY TaxInvoiceNumber DESC)
 BEGIN
   INSERT INTO EduSphere.TaxInvoices (MemberId,ConsultantOneID,LocationId,InvoiceDate) VALUES(@MemberId,@ConsultantOneID,@LocationId,GETDATE())
 END
END

DROP PROCEDURE spGenerateInvoiceNumber 
EXEC spGenerateInvoiceNumber 46

----------GENERATE NEW INVOICE NUMBER -------------------------
CREATE PROCEDURE spGenerateNewInvoiceNumber
@MemberId INT,
@ConsultantOneID INT,
@LocationId VARCHAR(50)
AS
BEGIN
 --IF NOT EXISTS (SELECT TaxInvoiceNumber FROM EduSphere.TaxInvoices WHERE MemberId=@MemberId AND (CAST(InvoiceDate AS DATE)=CAST(GETDATE() AS DATE)))--
 BEGIN
   INSERT INTO EduSphere.TaxInvoices (MemberId,ConsultantOneID,LocationId,InvoiceDate) VALUES(@MemberId,@ConsultantOneID,@LocationId,GETDATE())
 END
END

---------------------------------------------------------------------------------------------------------------------

---------------INSERT INVOICE NUMBER FORCEFULLY-----
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
    DECLARE @SubTotal DECIMAL(19,2)
	DECLARE @CreditAmount DECIMAL(19,2)
    DECLARE @DiscountAmount DECIMAL(19,2)
	DECLARE @CGSTAmount DECIMAL(19,2)
	DECLARE @SGSTAmount DECIMAL(19,2)

	 
	IF EXISTS (SELECT TaxInvoiceNumber FROM EduSphere.MemberAccount WHERE TaxInvoiceNumber=@TaxInvoiceNumber)
	BEGIN
	  (SELECT @SubTotal			=SUM(DebitAmount) FROM EduSphere.MemberAccount WHERE TaxInvoiceNumber=@TaxInvoiceNumber)
	  (SELECT @CreditAmount		=SUM(CreditAmount) FROM EduSphere.MemberAccount WHERE TaxInvoiceNumber=@TaxInvoiceNumber)
	  (SELECT @DiscountAmount	=SUM(DiscountAmount) FROM EduSphere.MemberAccount WHERE TaxInvoiceNumber=@TaxInvoiceNumber)
	  (SELECT @CGSTAmount		=SUM(CGSTAmount) FROM EduSphere.MemberAccount WHERE TaxInvoiceNumber=@TaxInvoiceNumber)
	  (SELECT @SGSTAmount		=SUM(SGSTAmount) FROM EduSphere.MemberAccount WHERE TaxInvoiceNumber=@TaxInvoiceNumber)
	  --IF EXISTS (SELECT TaxInvoiceNumber FROM EduSphere.ProductSaleTransaction WHERE TaxInvoiceNumber=@TaxInvoiceNumber)
	  --BEGIN
	  --   (SELECT  @SubTotal			=@SubTotal+SUM(DebitAmount) FROM EduSphere.ProductSaleTransaction WHERE TaxInvoiceNumber=@TaxInvoiceNumber)
		 --(SELECT  @CreditAmount		=@CreditAmount+SUM(CreditAmount) FROM EduSphere.ProductSaleTransaction WHERE TaxInvoiceNumber=@TaxInvoiceNumber)
	  --   (SELECT  @DiscountAmount	=@DiscountAmount+SUM(DiscountAmount) FROM EduSphere.ProductSaleTransaction WHERE TaxInvoiceNumber=@TaxInvoiceNumber)
		 --(SELECT  @CGSTAmount		= @CGSTAmount+SUM(CGSTAmount) FROM EduSphere.ProductSaleTransaction WHERE TaxInvoiceNumber=@TaxInvoiceNumber)
	  --   (SELECT  @SGSTAmount		=@SGSTAmount+SUM(SGSTAmount) FROM EduSphere.ProductSaleTransaction WHERE TaxInvoiceNumber=@TaxInvoiceNumber)
	  --END
	END
	--------Prices are inclusive of taxes---	
    UPDATE EduSphere.TaxInvoices SET DiscountAmount=@DiscountAmount,SubTotal=@SubTotal,CreditAmount=@CreditAmount,BaseAmount=@SubTotal-@CGSTAmount-@SGSTAmount,SGSTAmount=@SGSTAmount,CGSTAmount=@CGSTAmount WHERE TaxInvoiceNumber=@TaxInvoiceNumber
	
END

DROP PROCEDURE spUpdateTaxInvoiceTotal
EXEC spUpdateTaxInvoiceTotal 494

------------------------------------------DELETE INVOICE----------------------
CREATE PROCEDURE spDeleteInvoice
@TaxInvoiceNumber INT
AS
BEGIN
  --DELETE FROM EduSphere.BonusWallet WHERE TaxInvoiceNumber=@TaxInvoiceNumber--
  DELETE FROM EduSphere.TaxInvoices WHERE TaxInvoiceNumber=@TaxInvoiceNumber
  DELETE FROM EduSphere.MemberAccount WHERE TaxInvoiceNumber=@TaxInvoiceNumber
  --DELETE FROM EduSphere.MemberProductAccount WHERE TaxInvoiceNumber=@TaxInvoiceNumber--
END

DROP PROCEDURE spDeleteInvoice
EXEC spDeleteInvoice 100
---------------------------Not USED---spUpdateTaxInvoiceTotalForProducts-Update total after each Debit/Credit---------------
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

----------------------------------TAXCODES--------------------

CREATE TABLE EduSphere.TaxCodes
(
TaxCode VARCHAR(20) CONSTRAINT gstTaxCode PRIMARY KEY,
TaxCodeDescription VARCHAR(200),
CGSTPercentage DECIMAL(19,2),
SGSTPercentage DECIMAL(19,2)
)

SELECT * FROM EduSphere.TaxCodes
DROP TABLE EduSphere.TaxCodes

ALTER TABLE EduSphere.TaxCodes ALTER COLUMN SGSTPercentage DECIMAL(19,2)

CREATE PROCEDURE spInsertTaxCode
@TaxCode VARCHAR(20),
@TaxCodeDescription VARCHAR(200),
@CGSTPercentage FLOAT,
@SGSTPercentage FLOAT
AS
BEGIN
 INSERT INTO EduSphere.TaxCodes (TaxCode,TaxCodeDescription,CGSTPercentage,SGSTPercentage) VALUES(@TaxCode,@TaxCodeDescription,@CGSTPercentage,@SGSTPercentage)
END

---------------------------EDUSPHERE TAX CODES------------
EXEC spInsertTaxCode '999293','Commercial training and coaching Skus',9,9
EXEC spInsertTaxCode '999294','Other education and training Skus n.e.c.',9,9
EXEC spInsertTaxCode '999291','Approved by the NSDC or the Sector Skill Council',0,0

EXEC spInsertTaxCode '999721','Hairdressing and barbers Skus',9,9
EXEC spInsertTaxCode '999722','Cosmetic treatment',9,9
EXEC spInsertTaxCode '999729','All other beauty treatment Skus',9,9

EXEC spInsertTaxCode '30039011','Ayurvedic System',6,6

EXEC spInsertTaxCode '33043000','Manicure or pedicure preparations',9,9
EXEC spInsertTaxCode '33049910','Face Cream',9,9
EXEC spInsertTaxCode '33049930','Moisturising Lotion-Ayurvedic',6,6
EXEC spInsertTaxCode '33049990','Other',9,9
EXEC spInsertTaxCode '00000001','NA',0,0