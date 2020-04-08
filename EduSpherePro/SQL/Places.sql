------------Indian States------------
CREATE TABLE EduSphere.States
(
CountryID INT,
StateID INT IDENTITY(100,1) CONSTRAINT cstStates PRIMARY KEY,
StateName VARCHAR(50)
)

DROP TABLE EduSphere.States
SELECT * FROM EduSphere.States
UPDATE EduSphere.States SET StateName='120' WHERE StateID=136

SELECT TOP 1000 * FROM EduSphere.RoleRequests r JOIN EduSphere.States p ON r.RequesterState=p.StateID  ORDER BY RequestID DESC
--------------------------------------------------------------------------------------
CREATE PROCEDURE spInsertStates
@CountryID INT=91
AS
BEGIN
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Andaman and Nicobar Islands')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Andhra Pradesh')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Arunachal Pradesh')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Assam')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Bihar')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Chhattisgarh')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Chandigarh')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Dadar and Nagar Haveli')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Daman and Diu')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Delhi')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Goa')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Gujarat')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Haryana')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Himachal Pradesh')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Jammu and Kashmir')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Jharkhand')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Karnataka')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Kerala')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Lakshadweep')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Madhya Pradesh')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Maharashtra')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Manipur')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Meghalaya')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Mizoram')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Nagaland')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Odisha')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Puducherry')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Punjab')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Rajasthan')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Sikkim')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Tamil Nadu')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Telangana')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Tripura')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Uttar Pradesh')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Uttarakhand')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'West Bengal')
  INSERT INTO EduSphere.States (CountryID,StateName) VALUES(@CountryID,'Other') 
END

EXEC spInsertStates

