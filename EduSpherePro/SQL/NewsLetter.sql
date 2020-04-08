
CREATE TABLE Blog
(
BlogID INT IDENTITY(1000,1) CONSTRAINT cstBlogPK PRIMARY KEY,
BlogGroup VARCHAR(50) CONSTRAINT cstChkBG CHECK (BlogGroup IN('EVENT','TESTIMONIAL','TREATMENT')),
SubmittedByID VARCHAR(50),
SubmissionDate DATETIME,
PublishStatus VARCHAR(50),
ApprovedByID VARCHAR(50),
ApprovalDate DATETIME,
Title VARCHAR(100),
ParaOne VARCHAR(200),
ParaTwo VARCHAR(200),
ParaThree VARCHAR(200),
PhotoOnePath VARCHAR(100),
PhotoTwoPath VARCHAR(100),
PhotoThreePath VARCHAR(100),
VideoOnePath VARCHAR(100)
)

SELECT * FROM Blog b 
                                    JOIN EduSphere.Neurotherapists n ON b.SubmittedByID=n.Email 
                                    WHERE Email=shivmanit@yahoo.com
DROP TABLE Blog

CREATE PROCEDURE spCreateBlog
@operationCode VARCHAR(20),
@BlogID INT,
@SubmittedByID VARCHAR(50),
@SubmissionDate DATETIME,
@PublishStatus VARCHAR(50),
@ApprovedByID VARCHAR(50),
@ApprovalDate DATETIME,
@Title VARCHAR(100),
@BlogGroup VARCHAR(50),
@ParaOne VARCHAR(200),
@ParaTwo VARCHAR(200),
@ParaThree VARCHAR(200),
@PhotoOnePath VARCHAR(100),
@PhotoTwoPath VARCHAR(100),
@PhotoThreePath VARCHAR(100),
@VideoOnePath VARCHAR(100)
AS
BEGIN
IF(@operationCode='INSERT')
BEGIN	
	INSERT INTO Blog (SubmittedByID,SubmissionDate,PublishStatus,ApprovedByID,Title,BlogGroup,ParaOne,ParaTwo,ParaThree,PhotoOnePath,PhotoTwoPath,PhotoThreePath,VideoOnePath) 
			VALUES(@SubmittedByID,GETDATE(),@PublishStatus,@ApprovedByID,@Title,@BlogGroup,@ParaOne,@ParaTwo,@ParaThree,@PhotoOnePath,@PhotoTwoPath,@PhotoThreePath,@VideoOnePath)
END
IF(@operationCode='UPDATE')
BEGIN
	UPDATE Blog SET ApprovedByID=@ApprovedByID,PublishStatus=@PublishStatus,ApprovalDate=GETDATE()
END
END


UPDATE Blog SET PublishStatus='APPROVED'

EXEC spCreateBlog '100','11/20/2019','NEW','90','11/21/2019','Neurotherapy Awareness Camp','The event was organizaed by LMNT Mumbai on 20th Nov 2019',
'There wer more than 100 participants','It was a great success and was colcluded with vote of thannks','../Artifacts/Blogs/1.jpg','../Artifacts/Blogs/2.jpg','../Artifacts/Blogs/3.jpg','../Artifacts/Blogs/vid.mpeg'

UPDATE Blog SET PhotoOnePath='../Artifacts/Blogs/1.jpg'
UPDATE Blog SET PhotoTwoPath='../Artifacts/Blogs/2.jpg'
UPDATE Blog SET PhotoThreePath='../Artifacts/Blogs/3.jpg'

DROP PROCEDURE spCreateBlog
----------------------------------------------------------------------------------------------------
CREATE PROCEDURE spUpdateBlog
@BlogID INT,
@PublishStatus VARCHAR(50),
@ApprovedByID VARCHAR(50)
AS
BEGIN
	UPDATE Blog SET ApprovedByID=@ApprovedByID,PublishStatus=@PublishStatus,ApprovalDate=GETDATE()
END
