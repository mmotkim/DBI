--Display all books liked by user with ID 1
select * from Book where (
	select bookId from Liked
	where userId = 1 and Liked.bookId = Book.bkId
)