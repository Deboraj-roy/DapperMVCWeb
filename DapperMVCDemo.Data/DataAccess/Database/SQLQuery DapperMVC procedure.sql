--#stape 1
create database DapperMVC

--#stape 2 ---------------------------------------------------------
use DapperMVC

--#stape 3 ---------------------------------------------------------
create table dbo.Person(
Id int primary key identity,
Name nvarchar(100) not null,
Email nvarchar(100) not null,
[Address] nvarchar(200) not null
)

--#stape 4 ---------------------------------------------------------
INSERT INTO [DapperMVC].[dbo].[Person] ([Name], [Email], [Address])
VALUES 
('John Doe', 'johndoe@example.com', '123 Main St'),
('Jane Doe', 'janedoe@example.com', '456 Elm St'),
('Bob Smith', 'bobsmith@example.com', '789 Oak St'),
('Alice Johnson', 'alicejohnson@example.com', '321 Pine St'),
('Mike Brown', 'mikebrown@example.com', '901 Maple St'),
('Emily Davis', 'emilydavis@example.com', '234 Cedar St'),
('Sarah Taylor', 'sarahtaylor@example.com', '567 Spruce St'),
('Kevin White', 'kevinwhite@example.com', '890 Fir St'),
('Lisa Nguyen', 'lisanguyen@example.com', '345 Cypress St'),
('David Lee', 'davidlee@example.com', '678 Walnut St'),
('Olivia Martin', 'oliviamartin@example.com', '111 Hickory St'),
('Benjamin Hall', 'benjaminhall@example.com', '222 Beech St'),
('Samantha Walker', 'samanthawalker@example.com', '333 Ash St'),
('Alexander Brooks', 'alexanderbrooks@example.com', '444 Birch St'),
('Hannah Patel', 'hannahpatel@example.com', '555 Cherry St'),
('Michael Kim', 'michaelkim@example.com', '666 Chestnut St'),
('Sophia Rodriguez', 'sophiarodriguez@example.com', '777 Poplar St'),
('William Lewis', 'williamlewis@example.com', '888 Sycamore St'),
('Abigail Thompson', 'abigailthompson@example.com', '999 Tulip St'),
('Ethan Jackson', 'ethanjackson@example.com', '1010 Violet St'),
('Lily Harris', 'lilyharris@example.com', '1111 Willow St');

--#stape 5 ---------------------------------------------------------
SELECT TOP (1000) [Id]
      ,[Name]
      ,[Email]
      ,[Address]
  FROM [DapperMVC].[dbo].[Person]


  select * from dbo.person 

--#stape 6 Create Person ---------------------------------------------------------

--create store procedure 

CREATE PROCEDURE [dbo].[sp_Create_Person]
    @Name nvarchar(100),
    @Email nvarchar(100),
    @Address nvarchar(200)
AS
BEGIN
    INSERT INTO [dbo].[Person] ([Name], [Email], [Address])
    VALUES (@Name, @Email, @Address)

    SELECT SCOPE_IDENTITY() AS Id
END

--#stape 7  Update Person  ---------------------------------------------------------

CREATE PROCEDURE [dbo].[sp_Update_Person]
    @Id int,
    @Name nvarchar(100),
    @Email nvarchar(100),
    @Address nvarchar(200)
AS
BEGIN
    UPDATE [dbo].[Person]
    SET [Name] = @Name, [Email] = @Email, [Address] = @Address
    WHERE [Id] = @Id
END


--#stape 8  Read Person ---------------------------------------------------------

CREATE PROCEDURE [dbo].[sp_Get_People]
AS
BEGIN
    SELECT * FROM [dbo].[Person]
END


--#stape 9 ---------------------------------------------------------

CREATE PROCEDURE [dbo].[sp_Get_Person]
    @Id int
AS
BEGIN
    SELECT * FROM [dbo].[Person]
    WHERE [Id] = @Id
END


--#stape 10 Delete Person ---------------------------------------------------------
--never delete any record isated of deactivate

CREATE PROCEDURE [dbo].[sp_Delete_Person]
    @Id int
AS
BEGIN
    DELETE FROM [dbo].[Person]
    WHERE [Id] = @Id
END


----------------- another away -------

CREATE PROCEDURE sp_Delete_Person (@Id int)
AS
BEGIN
    DELETE FROM dbo.Person
    WHERE Id = @Id
END


-- delete a procedure----------
drop proc dbo.sp_Create_Person


-- search People a procedure----------

CREATE PROCEDURE [dbo].[sp_search_People]
    @Name nvarchar(100)
AS
BEGIN
    SELECT *
    FROM [DapperMVC].[dbo].[Person]
    WHERE Name LIKE '%' + @Name + '%'
END

EXEC [dbo].[sp_search_People] @Name = 'Doe'