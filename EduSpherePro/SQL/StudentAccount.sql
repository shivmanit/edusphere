create table EduSphere.MemberServiceAccount
(
TransactionID int identity(1,1) constraint cstTransactionPK PRIMARY KEY,
StudentId int constraint custIdFK FOREIGN KEY REFERENCES EduSphere.Students(StudentId),
ServiceId int constraint servIdFK FOREIGN KEY REFERENCES EduSphere.Services(ServiceId),
ServiceDate DateTime,
ServiceLocation INT constraint locId FOREIGN KEY REFERENCES EduSphere.Organizations(OrganizationId),
OfferedRate int,
Notes varchar(100),
ConsultantID INT constraint conId FOREIGN KEY REFERENCES EduSphere.Staff(EmployeeID),
ConsultantEffortPercentage INT,
Reference INT constraint refId FOREIGN KEY REFERENCES EduSphere.Staff(EmployeeID),
ReferenceEffortPercentage INT,
AdditonalResourceOneId INT constraint addId FOREIGN KEY REFERENCES EduSphere.Staff(EmployeeID),
AdditonalResourceOneEffortPercentage INT,
PaymentMode varchar(50),
DigitalPaymentRefCode varchar(100),
NextFollowup INT,
TransactionTrigger varchar(20) CONSTRAINT cstTransTrig CHECK(TransactionTrigger IN('DEBIT-SERVICE','REVERSAL','VOUCHER-CREDIT','RECEIPT-PREV-BILL','RECEIPT-CURR-BILL','RECEIPT-MEMBERSHIP')),
DebitAmount int,
CreditAmount int,
BalanceAmount int,
DiscountAmount INT, 
CGSTAmount FLOAT,
SGSTAmount FLOAT,
TaxInvoiceNumber INT 
)

alter table EduSphere.MemberServiceAccount add NextFollowup INT
ALTER TABLE EduSphere.MemberServiceAccount DROP CONSTRAINT cstTransTrig
ALTER TABLE EduSphere.MemberServiceAccount DROP COLUMN TransactionTrigger
ALTER TABLE EduSphere.MemberServiceAccount ADD TransactionTrigger varchar(20) CONSTRAINT cstTransTrig CHECK(TransactionTrigger IN('DEBIT-SERVICE','REVERSAL','VOUCHER-CREDIT','RECEIPT-PREV-BILL','RECEIPT-CURR-BILL','RECEIPT-MEMBERSHIP')) 
DROP TABLE EduSphere.MemberServiceAccount
sp_help 'EduSphere.MemberServiceAccount'

SELECT  *  FROM EduSphere.MemberServiceAccount WHERE StudentId='20'  order by TransactionID desc
SELECT BalanceAmount,StudentID FROM EduSphere.MemberServiceAccount WHERE BalanceAmount =0  ORDER BY StudentID
DELETE  EduSphere.MemberServiceAccount where StudentId=46
SELECT  * From EduSphere.MemberServiceAccount a JOIN EduSphere.Students c ON a.StudentID=c.StudentID JOIN EduSphere.Services s ON a.ServiceID=s.ServiceID WHERE a.DebitAmount!=0    order by a.ServiceDate desc
SELECT TOP 10 *,c.FullName as StudentName,a.TransactionID,s.ServiceTitle,con.FullName as ConsultantID,ref.FullName as ReferedBy,a.ServiceDate,a.OfferedRate,a.ServiceStatus,a.DebitAmount,a.CreditAmount,a.PaymentMode,a.DigitalPaymentRefCode,a.BalanceAmount FROM EduSphere.MemberServiceAccount a JOIN EduSphere.Students c  ON c.StudentId=a.StudentId JOIN EduSphere.Services s ON s.ServiceId=a.ServiceId JOIN EduSphere.Staff con ON con.EmployeeID=a.ConsultantID JOIN EduSphere.Staff ref ON ref.EmployeeID=a.Reference where a.StudentId='2705'  order by a.TransactionID desc
SELECT TOP 7 *,c.FullName as StudentName,a.TransactionID,ServiceTitle,con.FullName as ConsultantID,ref.FullName as ReferedBy,ServiceDate,OfferedRate,ServiceStatus,DebitAmount,CreditAmount,PaymentMode,DigitalPaymentRefCode,BalanceAmount FROM EduSphere.MemberServiceAccount a JOIN EduSphere.Students c  ON a.StudentId=c.StudentId JOIN EduSphere.Services s ON a.ServiceId=s.ServiceId JOIN EduSphere.Staff con ON a.ConsultantID=con.EmployeeID JOIN EduSphere.Staff ref ON a.Reference=ref.EmployeeID where a.StudentId='868'  order by a.TransactionID desc

DELETE FROM EduSphere.MemberServiceAccount WHERE TaxInvoiceNumber=100

SELECT  *  FROM EduSphere.MemberServiceAccount WHERE CAST(ServiceDate AS DATE)='2017-07-16'  order by TransactionID desc
UPDATE EduSphere.MemberServiceAccount SET ConsultantID='AS0001', Reference='KA0001',AdditonalResourceOneId='TEST0100'

SELECT SUM(DebitAmount) AS BillAmount, year(a.ServiceDate) AS Year,month(a.ServiceDate) AS Month, e.EmployeeID AS EmpId,e.FullName AS Name FROM EduSphere.MemberServiceAccount a JOIN EduSphere.Staff e ON a.ConsultantID=e.EmployeeID WHERE month(a.ServiceDate)=month(GETDATE())   GROUP BY e.EmployeeID,e.FullName,year(a.ServiceDate),month(a.ServiceDate) ORDER BY SUM(DebitAmount) DESC
SELECT SUM(DebitAmount) AS BillAmount,a.ConsultantID AS Id,e.FullName+' '+e.Gender AS Name FROM EduSphere.MemberServiceAccount a  JOIN EduSphere.Staff e ON a.ConsultantID=e.EmployeeID WHERE CAST(ServiceDate AS DATE)=CAST('2017-07-17' AS DATE) AND a.ServiceLocation='PoonamSagar'   GROUP BY a.ConsultantID,e.FullName,e.Gender ORDER BY SUM(DebitAmount) DESC

SELECT SUM(CreditAmount) AS ReceivedAmount,PaymentMode FROM EduSphere.MemberServiceAccount WHERE CAST(ServiceDate AS DATE)=CAST('2017-07-17' AS DATE)   GROUP BY PaymentMode ORDER BY PaymentMode DESC



SELECT t1.StudentID,t1.BalanceAmount,t1.ServiceDate
FROM EduSphere.MemberServiceAccount t1
LEFT OUTER JOIN EduSphere.MemberServiceAccount t2
  ON (t1.StudentID = t2.StudentID AND t1.ServiceDate < t2.ServiceDate)
WHERE t2.StudentID IS NULL AND t1.BalanceAmount!=0 ORDER BY t1.BalanceAmount ASC;

CREATE PROCEDURE spStudentBalance
@ServiceLocation varchar(50)
AS
BEGIN
SELECT c.StudentID, c.FullName+ c.Gender AS Name ,c.PhoneOne,ServiceDate, BalanceAmount
FROM EduSphere.MemberServiceAccount a JOIN EduSphere.Students c ON a.StudentID=c.StudentID
WHERE ServiceDate = (
   SELECT MAX( ServiceDate )
   FROM EduSphere.MemberServiceAccount b
   WHERE a.StudentID = b.StudentID AND a.BalanceAmount!=0
) ORDER BY a.BalanceAmount ASC
END

EXEC spStudentBalance @ServiceLocation='PoonamSagar'

select * from EduSphere.MemberServiceAccount  where DebitAmount!=0 AND ConsultantID='8001' AND ServiceDate between '3-20-2017' AND '04-08-2017'
SELECT  * From EduSphere.MemberServiceAccount a JOIN EduSphere.Students c ON a.StudentID=c.StudentID JOIN EduSphere.Services s ON a.ServiceID=s.ServiceID WHERE a.DebitAmount!=0    order by a.ServiceDate desc
SELECT *  from EduSphere.MemberServiceAccount WHERE  StudentId ='40'
UPDATE EduSphere.MemberServiceAccount SET ServiceStatus='SERV', ConsultantID='0000' WHERE ServiceStatus='ENQ'

drop table EduSphere.MemberServiceAccount
truncate table EduSphere.MemberServiceAccount



INSERT INTO EduSphere.MemberServiceAccount values(1,1,GETDATE(),GETDATE(),100,'Inital Account Creation','REQ','Hiral',0,0,0)

SELECT    c.FullName,a.TransactionID,s.ServiceTitle,e.FullName as cons,em.FullName as ref,a.ServiceDate,a.OfferedRate,a.ServiceStatus,a.DebitAmount,a.CreditAmount,a.PaymentMode,a.DigitalPaymentRefCode,a.BalanceAmount FROM EduSphere.Students c JOIN EduSphere.MemberServiceAccount a ON c.StudentId=a.StudentId JOIN EduSphere.Services s ON s.ServiceId=a.ServiceId JOIN EduSphere.Staff e ON e.EmployeeID=a.ConsultantID JOIN EduSphere.Staff em ON em.EmployeeID=a.Reference  order by a.TransactionID desc
------------------------------------------------------------------------------------------------------------------
create procedure spMemberServiceAccountTransaction
@StudentId varchar(50),
@ServiceId int,
@ServiceDate DateTime,
@ServiceLocation INT,
@OfferedRate int,
@Notes varchar(100),
@ConsultantID INT,
@ConsultantEffortPercentage INT,
@Reference INT,
@ReferenceEffortPercentage INT,
@AdditonalResourceOneId INT,
@AdditonalResourceOneEffortPercentage INT,
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
   SET @TaxInvoiceNumber=(SELECT TaxInvoiceNumber FROM EduSphere.TaxInvoices WHERE StudentId=@StudentId AND (CAST(InvoiceDate AS DATE)=CAST(GETDATE() AS DATE)))
   IF @TaxInvoiceNumber is null
	BEGIN
	  EXEC spGenerateInvoiceNumber @StudentId,@ConsultantID,@ServiceLocation
	  SET @TaxInvoiceNumber=(SELECT TaxInvoiceNumber FROM EduSphere.TaxInvoices WHERE StudentId=@StudentId AND (CAST(InvoiceDate AS DATE)=CAST(GETDATE() AS DATE)))
	END

   -------------------------End Invoice------------------------------------------------------------
   -------------------------Compute CGST and SGST-------------------------------------------------
   DECLARE @TaxCode VARCHAR(20)=(SELECT TaxCode FROM EduSphere.Services WHERE ServiceId=@ServiceId)
   IF @TaxCode is null 
   BEGIN
      SET @TaxCode='999729'
   END
   DECLARE @CGSTAmount FLOAT = @DebitAmount*(SELECT CGSTPercentage FROM EduSphere.TaxCodes WHERE TaxCode=@TaxCode)/100
   DECLARE @SGSTAmount FLOAT = @DebitAmount*(SELECT SGSTPercentage FROM EduSphere.TaxCodes WHERE TaxCode=@TaxCode)/100 
   -------------------------End Compute GST----------------------
    DECLARE @PrevBalanceAmount int = (SELECT TOP 1 BalanceAmount from EduSphere.MemberServiceAccount where StudentId=@StudentId ORDER BY TransactionID DESC)
	if(@PrevBalanceAmount is null)  set @PrevBalanceAmount=0 
	INSERT INTO EduSphere.MemberServiceAccount (StudentId,ServiceId,ServiceDate,ServiceLocation,OfferedRate,Notes, ConsultantID,ConsultantEffortPercentage,Reference,ReferenceEffortPercentage,AdditonalResourceOneId,AdditonalResourceOneEffortPercentage,PaymentMode,TransactionTrigger,DigitalPaymentRefCode, DebitAmount,CreditAmount, BalanceAmount,DiscountAmount,TaxInvoiceNumber,CGSTAmount,SGSTAmount) 
	                                      values(@StudentId, @ServiceId,@ServiceDate,@ServiceLocation,@OfferedRate,@Notes,@ConsultantID,@ConsultantEffortPercentage,@Reference,@ReferenceEffortPercentage,@AdditonalResourceOneId,@AdditonalResourceOneEffortPercentage,@PaymentMode,@TransactionTrigger,@DigitalPaymentRefCode,@DebitAmount,@CreditAmount,@PrevBalanceAmount-@DebitAmount+@CreditAmount,@DiscountAmount,@TaxInvoiceNumber,@CGSTAmount,@SGSTAmount)
    --DECLARE @RepeatAfter int = (SELECT RepeatAfter FROM EduSphere.Services WHERE ServiceID=@ServiceId)--
	-----------------------------Update Invoice Total----------
	EXEC spUpdateTaxInvoiceTotal @TaxInvoiceNumber
	-----------------------------End Update Invoice Total-------
	IF(@NextFollowup >0)
	BEGIN
		DECLARE @ServiceDueDate DATETIME = DATEADD(day,@NextFollowup,GETDATE())
		EXECUTE spAddServiceReminders @ServiceId,@StudentId,@ServiceDate,@ServiceDueDate,'PLANNED'
	END
END

drop procedure spMemberServiceAccountTransaction
exec spMemberServiceAccountTransaction

-------------------------------------Testing delete later-------------------
SELECT TOP 5 * ,c.FullName as 'custName',a.TransactionID,s.ServiceTitle,con.FullName as 'consName',ref.FullName as 'refName',a.ServiceDate,a.OfferedRate,a.DebitAmount,a.CreditAmount,a.PaymentMode,a.DigitalPaymentRefCode,a.BalanceAmount FROM EduSphere.Students c JOIN EduSphere.MemberServiceAccount a ON c.StudentId=a.StudentId JOIN EduSphere.Services s ON s.ServiceId=a.ServiceId JOIN EduSphere.Staff con ON con.EmployeeID=a.ConsultantID JOIN EduSphere.Staff ref ON ref.EmployeeID=a.Reference where c.StudentId='43'  order by a.TransactionID desc


-------------------------------------------------------------------------
-----------------------------------------------

create procedure spStudentsFeeStatus
@Branch varchar(50)
AS
BEGIN
 SELECT p.Branch,f.StudentId, p.FullName, p.Gender,  SUM(DebitAmount) AS TotalFee ,SUM(CreditAmount) AS Paid, (SUM(DebitAmount)-SUM(CreditAmount)) AS Balance FROM EduSphere.MemberAccount f JOIN Students.PersonalDetails p ON f.StudentId=p.StudentId WHERE Branch='CREW' GROUP BY f.StudentId,p.FullName,p.Gender,p.Branch
END


drop procedure spStudentsFeeStatus
exec spStudentsFeeStatus

-------------------------------------------------------------------


create table EduSphere.MemberServiceEnquiry
(
EnquiryID int identity(1,1) constraint cstBookingPK PRIMARY KEY,
StudentId int constraint memIdFK FOREIGN KEY REFERENCES EduSphere.Students(StudentId),
ServiceId int constraint srvIdFK FOREIGN KEY REFERENCES EduSphere.Services(ServiceId),
EnquiryNotes varchar(100),
EnquiryDate datetime,
PlannedServiceDate DateTime,
PlannedServiceTime varchar(20),
PlannedServiceLocation varchar(50),
FollowUpDetails varchar(200),
EnquiryStatus varchar(10) CONSTRAINT eStatus CHECK(EnquiryStatus IN ('Open','Closed')),
ConsultantID INT,
)

drop table EduSphere.MemberServiceEnquiry
select * FROM EduSphere.MemberServiceEnquiry
truncate table EduSphere.MemberServiceEnquiry

create procedure spMemberServiceEnquiryTransaction
@StudentId int,
@ServiceId int,
@EnquiryNotes varchar(100),
@EnquiryDate datetime,
@PlannedServiceDate DateTime,
@PlannedServiceTime varchar(10),
@PlannedServiceLocation varchar(50),
@FollowUpDetails varchar(200),
@EnquiryStatus varchar(10),
@ConsultantID INT
AS
BEGIN
 INSERT INTO EduSphere.MemberServiceEnquiry (StudentId,ServiceId,EnquiryNotes,EnquiryDate,PlannedServiceDate,PlannedServiceTime,PlannedServiceLocation,FollowUpDetails,EnquiryStatus,ConsultantID) VALUES(@StudentId,@ServiceId,@EnquiryNotes,@EnquiryDate,@PlannedServiceDate,@PlannedServiceTime,@PlannedServiceLocation,@FollowUpDetails,@EnquiryStatus,@ConsultantID)
END

drop procedure spMemberServiceEnquiryTransaction
---------------------------------------------------------------------------------------------------
create procedure spMemberServiceEnquiryUpdate
@EnquiryID int,
@FollowUpDetails varchar(200)

AS
BEGIN
 UPDATE EduSphere.MemberServiceEnquiry SET FollowUpDetails=@FollowUpDetails  WHERE EnquiryID=@EnquiryID
END

drop procedure spMemberServiceEnquiryUpdate

------------------------------------------------------------------------------------------------
declare @start datetime

set @start = '2016-10-12'

DECLARE @Days int
SET @Days= DATEDIFF(d, '2016-10-11','2016-10-12') 


DECLARE @ServiceDate DATETIME ='2016-12-14'
SELECT c.PhoneOne,s.ServiceTitle,a.ServiceDate FROM EduSphere.Students c JOIN EduSphere.MemberServiceAccount a ON c.StudentId=a.StudentId  JOIN EduSphere.Services s ON s.ServiceId=a.ServiceId WHERE a.ServiceID=1 and a.ServiceStatus='SERV' and a.ServiceDate >=@ServiceDate

--------------------------------------------------------------------------------------------------
create procedure spSumTotal
@id varchar(50),
@dtFrom DateTime,
@dtTo DateTime,
@intSum int output
AS
BEGIN
 declare @retValue int = 0
  SELECT @retValue = SUM(DebitAmount) from EduSphere.MemberServiceAccount WHERE ConsultantID=@id AND ServiceDate BETWEEN @dtFrom AND @dtTo
  if @retValue IS NULL SET @retValue=0
  set  @intSum=@retValue
END

drop procedure spSumTotal
execute spSumTotal

declare @retValue int
SELECT SUM(DebitAmount) FROM EduSphere.MemberServiceAccount WHERE ConsultantID='9011' AND ServiceDate BETWEEN '1/1/2017' AND '7/1/2017'

--------------------------------------------------------------------------------------------

create table EduSphere.ServiceReminders
(
ServiceReminderID INT IDENTITY(1,1) constraint cstRemPK PRIMARY KEY,
ServiceID INT CONSTRAINT cstSerFK FOREIGN KEY REFERENCES EduSphere.Services(ServiceID),
StudentID INT CONSTRAINT cstCusID FOREIGN KEY REFERENCES EduSphere.Students(StudentId),
PreviousServiceDate DATETIME,
ServiceDueDate DATETIME,
ReminderStatus varchar(20) CONSTRAINT cstRemStatus CHECK(ReminderStatus IN('PLANNED','SENT')) 
)

DROP TABLE EduSphere.ServiceReminders
SELECT * FROM EduSphere.ServiceReminders
TRUNCATE TABLE EduSphere.ServiceReminders
DELETE EduSphere.ServiceReminders WHERE ServiceReminderID<='26'

CREATE PROCEDURE spAddServiceReminders
@ServiceID int,
@StudentId int,
@PreviousServiceDate DateTime,
@ServiceDueDate DateTime,
@ReminderStatus varchar(20)
AS
BEGIN
	INSERT INTO EduSphere.ServiceReminders (ServiceID,StudentId,PreviousServiceDate,ServiceDueDate,ReminderStatus) VALUES(@ServiceID,@StudentId,@PreviousServiceDate,@ServiceDueDate,@ReminderStatus)
END

CREATE PROCEDURE spServiceRemindersStatus
@ServiceReminderID int,
@ReminderStatus varchar(20)
AS
BEGIN
 UPDATE EduSphere.ServiceReminders SET ReminderStatus=@ReminderStatus WHERE ServiceReminderID=@ServiceReminderID
END

DROP PROCEDURE spServiceRemindersStatus
SELECT * FROM EduSphere.Services WHERE ServiceGroup='Beauty'

DELETE FROM EduSphere.ServiceReminders WHERE ServiceID='46'

SELECT * FROM EduSphere.ServiceReminders WHERE ServiceDueDate < DATEADD(day,20,GETDATE())

----------------------------------------------------------------------
-----------------------------------------GST--------------------------------
----------------------------------------------------------------------------
CREATE TABLE EduSphere.TaxInvoices
(
TaxInvoiceNumber INT IDENTITY(100,1) CONSTRAINT cstTaxInvoice PRIMARY KEY,
InvoiceDate DATETIME,
StudentId INT,
ConsultantId INT,
LocationId INT,
DiscountAmount FLOAT,
SubTotal FLOAT,
BaseAmount FLOAT,
SGSTAmount FLOAT,
CGSTAmount FLOAT
)

DROP TABLE EduSphere.TaxInvoices 
SELECT * FROM EduSphere.TaxInvoices

SELECT * FROM EduSphere.TaxInvoices WHERE StudentId=46 AND CAST(InvoiceDate AS DATE)=CAST(GETDATE() AS DATE)
DELETE FROM EduSphere.TaxInvoices WHERE StudentId=46
SELECT * FROM EduSphere.TaxInvoices i JOIN EduSphere.Students c ON i.StudentId=c.StudentId WHERE i.StudentId=2 AND CAST(InvoiceDate AS DATE)=CAST(GETDATE() AS DATE)
-------------------------------------------------

CREATE PROCEDURE spGenerateInvoiceNumber
@StudentId INT,
@ConsultantId INT,
@LocationId INT
AS
BEGIN
 IF NOT EXISTS (SELECT TaxInvoiceNumber FROM EduSphere.TaxInvoices WHERE StudentId=@StudentId AND (CAST(InvoiceDate AS DATE)=CAST(GETDATE() AS DATE)))
 BEGIN
   INSERT INTO EduSphere.TaxInvoices (StudentId,ConsultantId,LocationId,InvoiceDate) VALUES(@StudentId,@ConsultantId,@LocationId,GETDATE())
 END
END

DROP PROCEDURE spGenerateInvoiceNumber 
EXEC spGenerateInvoiceNumber 46

---------------------------spUpdateTaxInvoiceTotal-Update total after each Debit/Credit---------------
CREATE PROCEDURE spUpdateTaxInvoiceTotal
@TaxInvoiceNumber INT
AS
BEGIN
	DECLARE @DiscountAmount FLOAT= (SELECT SUM(DiscountAmount) FROM EduSphere.MemberServiceAccount WHERE TaxInvoiceNumber=@TaxInvoiceNumber)
    DECLARE @SubTotal FLOAT		= (SELECT SUM(DebitAmount) FROM EduSphere.MemberServiceAccount WHERE TaxInvoiceNumber=@TaxInvoiceNumber)
    DECLARE @CGSTAmount FLOAT	= (SELECT SUM(CGSTAmount) FROM EduSphere.MemberServiceAccount WHERE TaxInvoiceNumber=@TaxInvoiceNumber)
    DECLARE @SGSTAmount FLOAT	= (SELECT SUM(SGSTAmount) FROM EduSphere.MemberServiceAccount WHERE TaxInvoiceNumber=@TaxInvoiceNumber)

    UPDATE EduSphere.TaxInvoices SET DiscountAmount=@DiscountAmount,SubTotal=@SubTotal,BaseAmount=@SubTotal-@CGSTAmount-@SGSTAmount,SGSTAmount=@SGSTAmount,CGSTAmount=@CGSTAmount WHERE TaxInvoiceNumber=@TaxInvoiceNumber
END

DROP PROCEDURE spUpdateTaxInvoiceTotal
EXEC spUpdateTaxInvoiceTotal 100

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

EXEC spInsertTaxCode '999293','Community, Social, Personal Services And Other Miscellaneous Services',9,9
