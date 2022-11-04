----Stored procedure to add author to book
create procedure proc_AddAuthor(
	@AuthorID int,
	@bkID int
)
as update Book 
	set
		bkAuthorId = @AuthorID
	where bkId = @bkID
go

----Stored procedure to add publisher to book
create procedure proc_AddPublisher(
	@pubID int,
	@bkID int
)
as update Book 
	set
		bkPublisherId = @pubID
	where bkId = @bkID
go

----Stored procedure to UPDATE book info
create procedure proc_UpdateBookInfo(
	@bkID int,
	@bkTitle nvarchar(50),
	@bkPrice money
	)
as update Book
	set 
		bkTitle = @bkTitle,
		bkPrice = @bkPrice
	where bkId = @bkID;
go
--test insert
insert into Book(bkId, bkTitle, bkPrice, bkGenreID, bkPublisherId, bkAuthorId)
values ('100','toUpdate',1,1,1,1)
go
--test update
exec proc_UpdateBookInfo 100,'Updated',2
select * from Book
go


	