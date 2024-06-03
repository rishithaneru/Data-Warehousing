--Please run the following script inside of SSMS against your own initial table you created from the CaseStudy2023AllRecs_new table.

use SP23_ksmippili
go

--Stores 138, 9180, 35228, 40088 have duplicate addresses. Please correct them with the UPDATE statements below.
--Note that the dataset will repeat these addresses with different zip codes. Consider that a unique address.
--The addresses are not super relevant in what I'm asking you to do in your data warehouse. Yes, I realize that
--in the real world, you would want these cleaned. It would take much more investigating and neither you or I
--have any more time to devote to it.

UPDATE dbo.CaseStudy2023AllRecs_TeamIppiliKedasKoneru
SET StoreAddress = '1432 U Street, N.W.'
WHERE StoreNbr = 1380
go

UPDATE dbo.CaseStudy2023AllRecs_TeamIppiliKedasKoneru
SET StoreAddress = '4812 Georgia Avenue NW'
WHERE StoreNbr = 9180
go

UPDATE dbo.CaseStudy2023AllRecs_TeamIppiliKedasKoneru
SET StoreAddress = '316 Pennsylvania Avenue, S.E.'
WHERE StoreNbr = 35228
go

UPDATE dbo.CaseStudy2023AllRecs_TeamIppiliKedasKoneru
SET StoreAddress = '4315 South 2700 West'
WHERE StoreNbr = 40088
go

--I also missed one duplicate product and one procing problem. Please run the following UPDATE statement, again, on your initial database table
--before using SSIS.

UPDATE dbo.CaseStudy2023AllRecs_TeamIppiliKedasKoneru
	SET ProductDesc = 'Grilled chicken with our secret BBQ sauce served with lettuce, tomatoes, pickes and onions.'
	WHERE ProductNbr = 5005
GO

UPDATE dbo.CaseStudy2023AllRecs_TeamIppiliKedasKoneru
	SET DefaultProductPrice = 4.99
	WHERE ProductNbr = 3501
GO

--Verify store address dups fixed
select distinct storenbr, storeaddress, storecity, storestate, storezipcode, storestatus, [DateStore Opened]
from dbo.CaseStudy2023AllRecs_TeamIppiliKedasKoneru
where storenbr in (1380, 9180, 35228, 40088, 57111)
order by storenbr, [DateStore Opened]
go

--verifying 43 unique products
SELECT productnbr, DefaultProductPrice
from dbo.CaseStudy2023AllRecs_TeamIppiliKedasKoneru
group by productnbr, DefaultProductPrice
order by productnbr