SELECT SUM(DebitAmount) AS ServiceBill,SUM(CreditAmount) AS ServiceReceipts FROM EduSphere.MemberAccount WHERE CAST(TxDate AS DATE)='01-21-2020'
SELECT SUM(DebitAmount) AS MonthlyServiceBill,SUM(CreditAmount) AS MonthlyServiceReceipts FROM EduSphere.MemberAccount WHERE MONTH(TxDate)=MONTH(GETDATE())
SELECT SUM(DebitAmount) AS ProductBill,SUM(CreditAmount) AS ProductReceipt FROM EduSphere.ProductSaleTransaction WHERE CAST(dtOfPurchase AS DATE)='07-16-2017'
SELECT SUM(DebitAmount) AS MonthlyProductBill,SUM(CreditAmount) AS MonthlyProductReceipt FROM EduSphere.ProductSaleTransaction WHERE MONTH(TxDate)=MONTH(GETDATE())

SELECT SUM(DebitAmount) AS Expenses FROM EduSphere.AccountTxs WHERE CAST(AccountTxDate AS DATE)='01-21-2020'
SELECT SUM(DebitAmount) AS MonthlyExpense FROM EduSphere.AccountTxs WHERE MONTH(AccountTxDate)=MONTH(GETDATE())


CREATE PROCEDURE spIndicators
@IndicatorDate DateTime,
@OrganizationID INT,
@TodaysServiceBills INT OUTPUT,
@TodaysExpenseBills INT OUTPUT,
@TodaysServiceReceipts INT OUTPUT,
@MonthlyServiceBills INT OUTPUT,
@MonthlyServiceReceipts INT OUTPUT,
@MonthlyExpenseBills INT OUTPUT
AS
BEGIN
	SET @TodaysServiceBills		=(SELECT SUM(DebitAmount) FROM EduSphere.MemberAccount WHERE CAST(TxDate AS DATE)=CAST(@IndicatorDate AS DATE) AND TxLocation=@OrganizationID)
	IF( @TodaysServiceBills is NULL) 
		BEGIN  
			SET @TodaysServiceBills=0 
		END
	
	SET @TodaysExpenseBills		=(SELECT SUM(DebitAmount) TodaysExpense FROM EduSphere.AccountTxs WHERE CAST(AccountTxDate AS DATE)=CAST(@IndicatorDate AS DATE) AND OrganizationID=@OrganizationID)
	IF( @TodaysExpenseBills is NULL) 
		BEGIN  
			SET @TodaysExpenseBills=0 
		END
	SET @TodaysServiceReceipts	=(SELECT SUM(CreditAmount) FROM EduSphere.MemberAccount WHERE CAST(TxDate AS DATE)=CAST(@IndicatorDate AS DATE) AND TxLocation=@OrganizationID)
	IF(@TodaysServiceReceipts is NULL) 
		BEGIN  
			SET @TodaysServiceReceipts=0 
		END
	
	SET @MonthlyServiceBills		=(SELECT SUM(DebitAmount) FROM EduSphere.MemberAccount WHERE MONTH(TxDate)=MONTH(@IndicatorDate) AND TxLocation=@OrganizationID)
	IF(@MonthlyServiceBills is NULL) 
		BEGIN  
			SET @MonthlyServiceBills=0 
		END
	
	SET @MonthlyExpenseBills		=(SELECT SUM(DebitAmount) FROM EduSphere.AccountTxs WHERE MONTH(AccountTxDate)=MONTH(@IndicatorDate) AND OrganizationID=@OrganizationID)
	IF( @MonthlyExpenseBills is NULL) 
		BEGIN  
			SET  @MonthlyExpenseBills=0 
		END
	SET @MonthlyServiceReceipts	=(SELECT SUM(CreditAmount) FROM EduSphere.MemberAccount WHERE MONTH(TxDate)=MONTH(@IndicatorDate) AND TxLocation=@OrganizationID)
	IF(  @MonthlyServiceReceipts is NULL) 
		BEGIN  
			SET  @MonthlyServiceReceipts=0 
		END
	
END

drop procedure spIndicators
EXEC spIndicators