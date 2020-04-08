--------------COURSE MATERIAL---------
create table EduSphere.HelpDocuments
(
DocumentId INT IDENTITY(100,1) CONSTRAINT cstHelpPK PRIMARY KEY,
DocumentType VARCHAR(50) CONSTRAINT cstHelpDocType CHECK(DocumentType IN('HOWTO','MOM','CIRCULAR')),
UploadDate DATETIME,
DocumentTitle varchar(100),
DocumentPath  varchar(100),
)


drop table EduSphere.HelpDocuments 
select * from EduSphere.HelpDocuments
TRUNCATE TABLE EduSphere.HelpDocuments
-----------------------Add New Document----
create procedure spInsertHelpDocument
@UploadDate DATETIME,
@DocumentTitle varchar(100),
@DocumentPath  varchar(100)
AS
BEGIN
	INSERT INTO EduSphere.HelpDocuments (UploadDate,DocumentTitle,DocumentPath) values(@UploadDate,@DocumentTitle,@DocumentPath)
END

drop procedure spInsertHelpDocument