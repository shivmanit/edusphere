create table EduSphere.CommunicationLog
(
logID int IDENTITY(1,1) constraint cstlogID PRIMARY KEY,
msgMedia varchar(10) constraint cstMedia CHECK(MsgMedia IN('SMS','MAIL')),
smsMsg varchar(200),
smsTo varchar(20),
smsDate DateTime,
FirstName varchar(50),
mailMsg varchar(200),
mailTo varchar(50),
mailDate DateTime,
)

truncate table EduSphere.CommunicationLog
alter table EduSphere.CommunicationLog add FirstName varchar(50) 
drop table EduSphere.CommunicationLog 
select * FROM  EduSphere.CommunicationLog

create procedure spInsertCommunicationLog
@msgMedia varchar(10),
@smsMsg varchar(200),
@smsTo varchar(20),
@mailMsg varchar(200),
@mailTo varchar(50),
@FirstName varchar(50)
AS 
BEGIN
if(@msgMedia='SMS')
   INSERT INTO EduSphere.CommunicationLog (msgMedia,smsMsg,smsTo,smsDate,FirstName) VALUES(@msgMedia,@smsMsg,@smsTo,GETDATE(),@FirstName)
if(@msgMedia='MAIL')
   INSERT INTO EduSphere.CommunicationLog (msgMedia,mailMsg,mailTo,mailDate,FirstName) VALUES(@msgMedia,@mailMsg,@mailTo,GETDATE(),@FirstName)
END

drop procedure spInsertCommunicationLog
truncate table 