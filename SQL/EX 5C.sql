USE SD9DEMO;

-- 1. Create an appropriate table schema.
DROP TABLE IF EXISTS [US Presidents]
CREATE TABLE [US Presidents] (
	ID INT IDENTITY PRIMARY KEY,
	LastName NVARCHAR(50),
	FirstName NVARCHAR(50),
	MiddleName NVARCHAR(50),
	OrderOfPresidency INT,
	DateOfBirth DATE,
	DateOfDeath DATE,
	TownOrCountryOfBirth NVARCHAR(50),
	StateOfBirth NVARCHAR(50),
	HomeState NVARCHAR(50),
	PartyAffiliation NVARCHAR(50),
	DateTookOffice DATE,
	DateLeftOffice DATE,
	AssassinAttempt BIT,
	Assassinated BIT,
	ReligiousAffiliation NVARCHAR(50),
	ImagePath NVARCHAR(100)
);

-- 2. Insert the CSV data into the table you just created.
BULK INSERT [US Presidents]
FROM 'C:\Users\Wesle\OneDrive\Desktop\USPresidents.csv'
WITH
(
    DATAFILETYPE = 'char', 
    FIELDQUOTE = '"',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

-- 3. Delete the column that contains the path to the images.
ALTER TABLE [US Presidents]
DROP COLUMN ImagePath;

-- 4.  Delete the first record from your table using the output clause. This is the header.
-- DELETE FROM [US Presidents] OUTPUT DELETED.* WHERE ID = 1;

--5. Bring the data up to date by updating the last row. Use the output clause.
UPDATE [US Presidents] SET
	DateLeftOffice = '2017-01-20',
	AssassinAttempt = 0,
	Assassinated = 0
OUTPUT inserted.*
WHERE ID = (SELECT TOP 1 ID FROM [US Presidents] ORDER BY ID DESC);

INSERT INTO [US Presidents]
OUTPUT inserted.*
VALUES ('Trump', 'Donald', '', 45, '1946-05-14', NULL, 'New York City', 'New York', 'New York', 'Republican', '2017-01-20', '2021-01-20', 0, 0, 'non-denominational Christian');

-- 7. How many presidents from each state belonged to the various political parties? Aggregate by party and state. Note that this will in eect be a pivot table.
SELECT HomeState, COUNT(HomeState) AS AmountFromState FROM [US Presidents]
GROUP BY HomeState
SELECT PartyAffiliation, COUNT(PartyAffiliation) AS AmountOfParty FROM [US Presidents]
GROUP BY PartyAffiliation

-- 8. Create a report showing the number of days each president was in once.
SELECT FirstName, LastName, DATEDIFF(DAY, DateTookOffice, DateLeftOffice) AS DaysInOffice FROM [US Presidents]

-- 9. Create a report showing the age (in years) of each present when he took once.
SELECT FirstName, LastName, DATEDIFF(YEAR, DateOfBirth, DateTookOffice) AS AgeWhenTookOffice FROM [US Presidents]

-- 10. See if there is any correlation between a president's party and reported religion, or lack of reported religion.
SELECT PartyAffiliation, COUNT(PartyAffiliation) AS AmountOfParty FROM [US Presidents]
GROUP BY PartyAffiliation
UNION ALL
SELECT ReligiousAffiliation, COUNT(ReligiousAffiliation) AS AmountInReligiousAffiliation FROM [US Presidents]
GROUP BY ReligiousAffiliation;