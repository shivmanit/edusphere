CREATE PROCEDURE spGetAge
@FromDate DATETIME,
@AgeYears INT OUTPUT,
@AgeMonths INT OUTPUT,
@AgeDays INT OUTPUT
AS
BEGIN
DECLARE @tmpdate datetime = @FromDate 
SET @AgeYears	= DATEDIFF(yy, @tmpdate, GETDATE()) - CASE WHEN (MONTH(@FromDate) > MONTH(GETDATE())) OR (MONTH(@FromDate) = MONTH(GETDATE()) AND DAY(@FromDate) > DAY(GETDATE())) THEN 1 ELSE 0 END
SET @tmpdate	= DATEADD(yy, @AgeYears, @tmpdate)
SET @AgeMonths	= DATEDIFF(m, @tmpdate, GETDATE()) - CASE WHEN DAY(@FromDate) > DAY(GETDATE()) THEN 1 ELSE 0 END

SELECT @tmpdate = DATEADD(m, @AgeMonths, @tmpdate)
SET @AgeDays = DATEDIFF(d, @tmpdate, GETDATE())
 
END

DROP PROCEDURE spGetAge
------------------------------------------------------------
CREATE PROCEDURE spFranchiseeCount
@Count INT OUTPUT
AS
BEGIN
 SET @Count = (SELECT COUNT(*) FROM EduSphere.Organizations WHERE OrganizationType='FRANCHISEE' AND OrganizationId>=100)
END

drop procedure spFranchiseeCount
execute spFranchiseeCount
-----------------------------------------------------------

CREATE PROCEDURE spEduCentreCount
@Count INT OUTPUT
AS
BEGIN
 SET @Count = (SELECT COUNT(*) FROM EduSphere.Organizations WHERE OrganizationType='EDUCATION-CENTRE' AND OrganizationId>=100)
END

drop procedure spEduCentreCount
execute spEduCentreCount 1
-----------------------------------------------------------

-----------------------------------------------------------------
CREATE PROCEDURE spVendorsCount
@Count INT OUTPUT
AS
BEGIN
 SET @Count = (SELECT COUNT(*) FROM EduSphere.Organizations WHERE OrganizationType='VENDOR' AND OrganizationId>=100)
END

drop procedure spVendorsCount
execute spVendorsCount

-------------------------------------Compute CSR Age------
CREATE TABLE EduSphere.EnquiryAge
(
CsrId INT,
CsrStatus VARCHAR(10),
RaisedOn DateTime,
AgeDays INT,
ComputedDate DateTime,
)

DROP TABLE EduSphere.EnquiryAge
SELECT * FROM EduSphere.EnquiryAge ORDER BY CsrId
