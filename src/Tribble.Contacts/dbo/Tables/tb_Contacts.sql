CREATE TABLE [dbo].[tb_Contacts] 
(
  ContactId INT NOT NULL IDENTITY(1,1),
  FirstName NVARCHAR(150) NOT NULL,
  LastName NVARCHAR(150) NOT NULL,  
  EmailAddress NVARCHAR(150) NOT NULL,
  CONSTRAINT PK_tb_Contacts_EmailAddress
               PRIMARY KEY CLUSTERED (EmailAddress)
)