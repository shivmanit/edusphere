create table EduSphere.AccountTxTitles
(
AccountTxTitleID INT IDENTITY(10,1) CONSTRAINT cstOf PRIMARY KEY,
AccountTxTitleGroup varchar(50),
AccountTxTitle varchar(100),
AccountTxTitleDescription varchar(200)
)

drop table EduSphere.AccountTxTitles
SELECT * FROM EduSphere.AccountTxTitles WHERE AccountTxTitleID='38'
truncate table EduSphere.AccountTxTitles
UPDATE EduSphere.AccountTxTitles SET AccountTxTitleGroup='Incentive' WHERE AccountTxTitleGroup='Bonus'

DELETE FROM EduSphere.AccountTxTitles WHERE AccountTxTitleID='38'

CREATE PROCEDURE spManageAccountTxTitles
@cmd varchar(20),
@AccountTxTitleID int,
@AccountTxTitleGroup varchar(50),
@AccountTxTitle varchar(100),
@AccountTxTitleDescription varchar(200)
AS
BEGIN
IF(@cmd='ADDTITLE')
BEGIN
	INSERT INTO EduSphere.AccountTxTitles (AccountTxTitleGroup,AccountTxTitle,AccountTxTitleDescription) VALUES(@AccountTxTitleGroup,@AccountTxTitle,@AccountTxTitleDescription)
END
IF(@cmd='UPDATETITLE')
BEGIN
   UPDATE EduSphere.AccountTxTitles SET AccountTxTitle=@AccountTxTitle,AccountTxTitleDescription=@AccountTxTitleDescription WHERE AccountTxTitleID=@AccountTxTitleID
END
IF(@cmd='DELETETITLE')
BEGIN
  DELETE EduSphere.AccountTxTitles WHERE AccountTxTitleID=@AccountTxTitleID
  END
END

drop procedure spManageAccountTxTitles
------------------------------------------------------------------------------------------------
CREATE TABLE EduSphere.AccountTxs
(
AccountTxID INT IDENTITY(1,1) CONSTRAINT cstoutF PRIMARY KEY,
AccountTxTitleID INT CONSTRAINT cstOFT FOREIGN KEY REFERENCES EduSphere.AccountTxTitles(AccountTxTitleID),
OrganizationID INT,
EmployeeID INT CONSTRAINT cstSt FOREIGN KEY REFERENCES EduSphere.Staff(EmployeeID),
AccountTxDate DateTime,
AccountTxDetails varchar(200),
DebitAmount DECIMAL(19,2),
CreditAmount DECIMAL(19,2),
TotalAccountTxAmount DECIMAL(19,2),
PaymentMode varchar(50),
ConfirmationString varchar(100),
DocPath varchar(100)
)

ALTER TABLE EduSphere.AccountTxs ADD PaymentMode varchar(50)
ALTER TABLE EduSphere.AccountTxs ADD ConfirmationString varchar(100)
ALTER TABLE EduSphere.AccountTxs ADD DocPath varchar(100)
drop table EduSphere.AccountTxs
truncate table EduSphere.AccountTxs
SELECT * FROM EduSphere.AccountTxs

DELETE FROM EduSphere.AccountTxs WHERE AccountTxID>=54

CREATE PROCEDURE spAccountTxStatement
@AccountTxTitleID INT,
@OrganizationID varchar(50),
@EmployeeID INT,
@AccountTxDetails varchar(200),
@PaymentMode varchar(50),
@ConfirmationString varchar(100),
@DebitAmount DECIMAL(19,2),
@CreditAmount DECIMAL(19,2),
@DocPath varchar(100)
AS
BEGIN
DECLARE @PrevTotalAccountTxAmount DECIMAL(19,2) = (SELECT TOP 1 TotalAccountTxAmount from EduSphere.AccountTxs  ORDER BY AccountTxID DESC)
	if(@PrevTotalAccountTxAmount is null)  set @PrevTotalAccountTxAmount=0 
	INSERT INTO EduSphere.AccountTxs (AccountTxTitleID,OrganizationID,EmployeeID,AccountTxDate,AccountTxDetails,PaymentMode,ConfirmationString,DebitAmount,CreditAmount,TotalAccountTxAmount,DocPath) values(@AccountTxTitleID,@OrganizationID,@EmployeeID,GETDATE(),@AccountTxDetails,@PaymentMode,@ConfirmationString,@DebitAmount,@CreditAmount,@PrevTotalAccountTxAmount-@DebitAmount+@CreditAmount,@DocPath)
END

drop procedure spAccountTxStatement