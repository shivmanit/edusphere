

CREATE TABLE EduSphere.StaffAttendance
(
SwipeId uniqueidentifier NOT NULL DEFAULT newid() CONSTRAINT cstSwipeKey PRIMARY KEY,
AttendanceDate Date,
EmployeeId INT CONSTRAINT cstEmpIdFK FOREIGN  KEY REFERENCEs EduSphere.Staff(EmployeeID),
SwipeInById VARCHAR(50),
SwipeOutById VARCHAR(50),
SwipeInStatus VARCHAR(20) CONSTRAINT chkInStatus CHECK(SwipeInStatus IN('ENABLED','DISABLED')), 
SwipeOutStatus VARCHAR(20) CONSTRAINT chkOutStatus CHECK(SwipeOutStatus IN('ENABLED','DISABLED')),
SwipeInDateTime DATETIME,
SwipeOutDateTime DATETIME,
HoursPresentFor FLOAT,
DaysPresentFor FLOAT,
DayStatus VARCHAR(20) CONSTRAINT chkPstatus CHECK(DayStatus IN('REPORTED','PRESENT','ABSENT','HALFDAY','OUTDOOR')),
Remarks VARCHAR(200),
)

DROP TABLE EduSphere.StaffAttendance
SELECT * FROM EduSphere.StaffAttendance WHERE AttendanceDate=CAST(GETDATE() AS DATE)
SELECT * FROM EduSphere.StaffAttendance WHERE AttendanceDate='10-07-2017'
DELETE  FROM EduSphere.StaffAttendance WHERE DATEPART(MM,AttendanceDate)=9

SELECT DISTINCT EmployeeId,AttendanceDate,DaysPresentFor  FROM EduSphere.StaffAttendance  WHERE DATEPART(MM,AttendanceDate)=9  ORDER BY AttendanceDate

DELETE FROM EduSphere.StaffAttendance WHERE EmployeeId=104
SELECT COUNT(AttendanceDate) FROM  EduSphere.StaffAttendance WHERE CAST(AttendanceDate AS Date)=CAST(GETDATE() AS DATE)
INSERT INTO EduSphere.StaffAttendance (EmployeeId,AttendanceDate) (SELECT EmployeeId,GETDATE() FROM EduSphere.Staff)
SELECT DATEDIFF(hh,'2017-06-27 16:41:42.903','2017-06-27 20:41:42.903') AS Diffhrs

SELECT *,a.EmployeeId,s.FullName,s.PhoneOne,s.Email FROM EduSphere.StaffAttendance a JOIN EduSphere.Staff s ON a.EmployeeId=s.EmployeeId WHERE a.EmployeeId='101'
SELECT *,a.EmployeeId,s.FullName,s.PhoneOne,s.Email FROM EduSphere.StaffAttendance a JOIN EduSphere.Staff s ON a.EmployeeId=s.EmployeeId WHERE a.EmployeeId='101'
---------------------------------------------Attendance Dashboard---------------------------------
SELECT DISTINCT s.FullName AS Name, DayStatus AS Attendance,COUNT(DayStatus) AS Number FROM EduSphere.StaffAttendance a JOIN  EduSphere.Staff s ON a.EmployeeId=s.EmployeeId WHERE DATEPART(MM,AttendanceDate)=DATEPART(MM,'08-02-2018') AND DATEPART(YYYY,AttendanceDate)=DATEPART(YYYY,'08-02-2018') GROUP BY s.FullName,DayStatus ORDER BY s.FullName

UPDATE EduSphere.StaffAttendance SET DayStatus='ABSENT' WHERE EmployeeId=106
SELECT s.FullName AS Name,AttendanceDate,SwipeInDateTime,SwipeOutDateTime,CAST(HoursPresentFor AS NUMERIC(18,2)) AS HoursPresentFor, DayStatus,Remarks FROM EduSphere.StaffAttendance a JOIN  EduSphere.Staff s ON a.EmployeeId=s.EmployeeId WHERE DATEPART(MM,AttendanceDate)=DATEPART(MM,GETDATE()) AND a.EmployeeId=106 
-------------------------------PIVOT------------------

SELECT FullName  AS Name,[1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13],[14],[15],[16],[17],[18],[19],[20],[21],[22],[23],[24],[25],[26],[27],[28],[29],[30],[31]
       FROM(SELECT FullName,DAY(AttendanceDate) AS d1,DaysPresentFor FROM EduSphere.StaffAttendance a JOIN EduSphere.Staff e ON a.EmployeeID=e.EmployeeID WHERE DATEPART("month",AttendanceDate)=DATEPART("month",'10-01-2017'))  AS SOURCE_TBL
	   PIVOT
	   (
	   MAX(DaysPresentFor) 
	   FOR d1 IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13],[14],[15],[16],[17],[18],[19],[20],[21],[22],[23],[24],[25],[26],[27],[28],[29],[30],[31])
	   ) AS PIVOT_TABLE;


-- Getting all distinct dates into a temporary table monthDates
SELECT DISTINCT AttendanceDate INTO monthDates
FROM EduSphere.StaffAttendance WHERE DATEPART("month",AttendanceDate)=DATEPART("month",'10-01-2017')
ORDER BY AttendanceDate
-- The number of days will be dynamic. So building
-- a comma seperated value string from the dates in monthDates
DECLARE @cols NVARCHAR(4000)
SELECT  @cols = COALESCE(@cols + ',[' + CONVERT(varchar, AttendanceDate, 106) + ']','[' + CONVERT(varchar, AttendanceDate, 106) + ']')
FROM    monthDates ORDER BY AttendanceDate
DECLARE @sDate VARCHAR(10)
SET @sDate=10
DECLARE @qry NVARCHAR(4000)
SET @qry =
'SELECT FullName, ' + @cols + ' FROM
(SELECT FullName, AttendanceDate, DaysPresentFor
FROM EduSphere.StaffAttendance a JOIN EduSphere.Staff e ON a.EmployeeID=e.EmployeeID WHERE DATEPART("month",AttendanceDate)='+@sDate+')p
PIVOT (MAX(DaysPresentFor) FOR AttendanceDate IN (' + @cols + ')) AS Pvt'

EXEC(@qry)
DROP TABLE monthDates
SELECT * FROM monthDates

CREATE PROCEDURE spGetMonthDates
@selectedDate DATETIME,
@cols NVARCHAR(4000) OUTPUT
AS
BEGIN
  SELECT DISTINCT AttendanceDate INTO monthDates
                                 FROM EduSphere.StaffAttendance WHERE DATEPART(month,AttendanceDate)=DATEPART(month,@selectedDate)
                                 ORDER BY AttendanceDate
  DECLARE @retcols NVARCHAR(4000)
  SELECT @cols=COALESCE(@cols + ',[' + CONVERT(varchar, AttendanceDate, 106) + ']','[' + CONVERT(varchar, AttendanceDate, 106) + ']') FROM  monthDates ORDER BY AttendanceDate
  DROP TABLE monthDates
END

DROP PROCEDURE spGetMonthDates
EXEC spGetMonthDates '10-10-2017','@cols'


DECLARE @cols NVARCHAR(4000)
SELECT COALESCE(@cols + ',[' + CONVERT(varchar, AttendanceDate, 106) + ']','[' + CONVERT(varchar, AttendanceDate, 106) + ']')
                                           FROM    monthDates ORDER BY AttendanceDate






---------------------------------------------------------------------------------------------
CREATE PROCEDURE spCreateAttendanceDay
AS
BEGIN
   IF NOT EXISTS  (SELECT SwipeId FROM  EduSphere.StaffAttendance WHERE CAST(AttendanceDate AS Date)=CAST(GETDATE() AS DATE))
   BEGIN
       INSERT INTO EduSphere.StaffAttendance (EmployeeId,AttendanceDate,HoursPresentFor,DaysPresentFor,DayStatus) 
	                                        (SELECT EmployeeId,GETDATE(),0,0,'ABSENT' FROM EduSphere.Staff WHERE EmployeeId>=100 AND EmploymentStatus='Active')
   END
END

EXEC spCreateAttendanceDay
DROP PROCEDURE spCreateAttendanceDay

SELECT EmployeeId,GETDATE(),0,0,'ABSENT' FROM EduSphere.Staff
-------------------------------------------------------------------------------------------------
CREATE PROCEDURE spUpdateStaffInTime
@SwipeId uniqueidentifier,
@EmployeeId INT,
@SwipeInById VARCHAR(50),
@SwipeInStatus VARCHAR(20),
@SwipeInDateTime DATETIME,
@Remarks VARCHAR(200)
AS
BEGIN
   --UPDATE  EduSphere.StaffAttendance SET SwipeInById=@SwipeInById,SwipeInStatus=@SwipeInStatus,SwipeInDateTime=@SwipeInDateTime,Remarks=@Remarks WHERE EmployeeId=@EmployeeId AND (CAST(AttendanceDate AS DATE) =CAST(GETDATE() AS DATE))--
   UPDATE  EduSphere.StaffAttendance SET SwipeInById=@SwipeInById,SwipeInStatus=@SwipeInStatus,SwipeInDateTime=@SwipeInDateTime,Remarks=@Remarks WHERE SwipeId=@SwipeId
END

DROP PROCEDURE spUpdateStaffInTime
SELECT Remarks FROM EduSphere.StaffAttendance WHERE EmployeeId='103' AND (CAST(SwipeInDateTime AS DATE)=CAST(GETDATE() AS DATE))
------------------------------------------------------------------------------------------------------- 
CREATE PROCEDURE spUpdateStaffOutTime
@SwipeId uniqueidentifier,
@EmployeeId INT,
@SwipeOutById VARCHAR(50),
@SwipeOutStatus VARCHAR(20),
@SwipeOutDateTime DATETIME,
@HoursPresentFor FLOAT,
@DaysPresentFor FLOAT,
@DayStatus VARCHAR(20),
@Remarks VARCHAR(200)
AS
BEGIN
   --DECLARE @InRemarks VARCHAR(200) = (SELECT Remarks FROM EduSphere.StaffAttendance WHERE EmployeeId=@EmployeeId AND (CAST(AttendanceDate AS DATE)=CAST(GETDATE() AS DATE)))--
   --UPDATE  EduSphere.StaffAttendance SET SwipeOutById=@SwipeOutById,SwipeOutStatus=@SwipeOutStatus,SwipeOutDateTime=@SwipeOutDateTime,--
	--										HoursPresentFor=@HoursPresentFor,DaysPresentFor=@DaysPresentFor,DayStatus=@DayStatus, Remarks=@InRemarks+';'+@Remarks WHERE EmployeeId=@EmployeeId AND (CAST(AttendanceDate AS DATE) =CAST(GETDATE() AS DATE))--
    DECLARE @InRemarks VARCHAR(200) = (SELECT Remarks FROM EduSphere.StaffAttendance WHERE SwipeId=@SwipeId)
    UPDATE  EduSphere.StaffAttendance SET SwipeOutById=@SwipeOutById,SwipeOutStatus=@SwipeOutStatus,SwipeOutDateTime=@SwipeOutDateTime,
											HoursPresentFor=@HoursPresentFor,DaysPresentFor=@DaysPresentFor,DayStatus=@DayStatus, Remarks=@InRemarks+';'+@Remarks WHERE SwipeId=@SwipeId
                                                                                     
END

DROP PROCEDURE spUpdateStaffOutTime
