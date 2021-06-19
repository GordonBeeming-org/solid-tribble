IF NOT EXISTS(SELECT 1 FROM [solid-tribble].[dbo].[tb_Contacts])
BEGIN
  INSERT INTO [solid-tribble].[dbo].[tb_Contacts] ([FirstName],[LastName],[EmailAddress]) 
  VALUES ('Gordon','Beeming','github@beeming.co.za')

  INSERT INTO [solid-tribble].[dbo].[tb_Contacts] ([FirstName],[LastName],[EmailAddress]) 
  VALUES ('Bob','Jones','bobby@beeming.co.za')

  INSERT INTO [solid-tribble].[dbo].[tb_Contacts] ([FirstName],[LastName],[EmailAddress]) 
  VALUES ('John','Doe','john@beeming.co.za')

  INSERT INTO [solid-tribble].[dbo].[tb_Contacts] ([FirstName],[LastName],[EmailAddress]) 
  VALUES ('Mary','','mary@beeming.co.za')
END