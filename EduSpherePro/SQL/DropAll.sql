
--You have to disable all triggers and constraints first.

EXEC sp_MSforeachtable @command1="ALTER TABLE ? NOCHECK CONSTRAINT ALL"

EXEC sp_MSforeachtable @command1="ALTER TABLE ? DISABLE TRIGGER ALL"
---After that you can generate the scripts for deleting the objects as

SELECT 'Drop Table '+name FROM sys.tables WHERE type='U';

SELECT 'Drop Procedure '+name FROM  sys.procedures WHERE type='P';
---Execute the statements generated.

Drop Table EduSphere.Courses
Drop Table AspNetUserRoles
Drop Table AspNetUsers
Drop Table AspNetUserClaims
Drop Table EduSphere.CourseDocs
Drop Table AspNetUserLogins
Drop Table EduSphere.CO
Drop Table EduSphere.__MigrationHistory
Drop Table EduSphere.PlacementDrives
Drop Table EduSphere.Organizations
Drop Table EduSphere.StudentsPlacementDrives
Drop Table EduSphere.FinAccountDetails
Drop Table EduSphere.EduSphere.Staff
Drop Table EduSphere.ExpenseTitles
Drop Table EduSphere.Expenses
Drop Table EduSphere.StaffDocuments
Drop Table EduSphere.ProgramBatch
Drop Table EduSphere.BatchSchedule
Drop Table EduSphere.Assessments
Drop Table EduSphere.EmpAcademics
Drop Table EduSphere.StudentAssessments
Drop Table EduSphere.EmpExperience
Drop Table EduSphere.Students
Drop Table EduSphere.AttendanceSheets
Drop Table EduSphere.StudentAttendance
Drop Table EduSphere.FeeGroups
Drop Table EduSphere.Enquiries
Drop Table EduSphere.EnquiryStatusModifications
Drop Table EduSphere.TaxCodes
Drop Table EduSphere.StudentTaxInvoices
Drop Table Evaluations.ObjQuestions
Drop Table Evaluations.ObjAnswers
Drop Table EduSphere.Organizations
Drop Table Evaluations.ObjTestPaper
Drop Table Evaluations.OnlineTestResults
Drop Table EduSphere.EnquiryAge
Drop Table EduSphere.States
Drop Table EduSphere.StudentAccount
Drop Table EduSphere.FeeReminders
Drop Table EduSphere.ProgramGroups
Drop Table EduSphere.Programs
Drop Table AspNetUserAddresses
Drop Table AspNetRoles

----------------------------------------------------------------------------
Drop Procedure spInsertPrograms
Drop Procedure spAddCourse
Drop Procedure spUpdateCourse
Drop Procedure spInsertNewDocument
Drop Procedure spInsertCO
Drop Procedure spUpdateCO
Drop Procedure spAddDrive
Drop Procedure spInsertOrganization
Drop Procedure spUpdateOrganization
Drop Procedure spInsertFinAccountDetails
Drop Procedure spUpdateFinAccountDetails
Drop Procedure spAddStudentToDrive
Drop Procedure spUpdateStudentsDriveStatus
Drop Procedure spManageExpenseTitles
Drop Procedure spInsertStaff
Drop Procedure spUpdateStaff
Drop Procedure spExpenseStatement
Drop Procedure spInsertStaffDocument
Drop Procedure spAddBatch
Drop Procedure spFilterStaff
Drop Procedure spEmpSummary
Drop Procedure spCreateScheduleDates
Drop Procedure spUpdateBatchSchedule
Drop Procedure spCreateAssessment
Drop Procedure spInsertEmpDegree
Drop Procedure spUpdateEmpDegree
Drop Procedure spCreateStudentAssessments
Drop Procedure spUpdateStudentAssessments
Drop Procedure spGetBatchAssessments
Drop Procedure spInsertStudentDetails
Drop Procedure spCreateAttendanceSheet
Drop Procedure spUpdateStudentDetails
Drop Procedure spUpdateStudentPhoto
Drop Procedure spStudentsCount
Drop Procedure spInsertFeeGroups
Drop Procedure spUpdateStudentAttendance
Drop Procedure spGetBatchCourses
Drop Procedure spInsertEnquiry
Drop Procedure spInsertTaxCode
Drop Procedure spEnquiryModification
Drop Procedure spGenerateStudentInvoiceNumber
Drop Procedure spUpdateStudentTaxInvoiceTotal
Drop Procedure spManageObjQuestions
Drop Procedure spCreateTest
Drop Procedure spInsertOnlineTR
Drop Procedure spFranchiseeCount
Drop Procedure spVendorsCount
Drop Procedure spGetAge
Drop Procedure spInsertStates
Drop Procedure spStudentBalance
Drop Procedure spMemberFeeAccountTransaction
Drop Procedure spAddFeeReminders
Drop Procedure spFeeRemindersStatus