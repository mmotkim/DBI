use segg;

create table UserAccounts (
	userID int primary key,
	userName nvarchar(100) not null,
	userEmail varchar(50),
	userBirthDate date not null,
	userGender nvarchar(10),
	userPassword varchar(100) not null
)	
go
--Account Default
ALTER TABLE UserAccounts
ADD CONSTRAINT Default_Gender
DEFAULT 'Others' FOR userGender;
go

create table Book (
	bookId  varchar(10) primary key,
	bkTitle nvarchar(100) not null,
	PriceAfter money not null, -- Gia sau khi giam gia mac dinh
	defaultDiscount int not null, -- Giam gia mac dinh 
	cover varchar not null, -- bao gom dich vu boc sach
	bkStock int, -- So luong ton kho
	[weight] int,  -- Khoi luong sach
	[format] nvarchar, -- Dinh dang
	numberOfPages int, -- So trang
	size varchar, -- Kick thuoc trang
	datePublished date, -- Ngay phat hanh
	[language] nvarchar, -- Ngon ngu sach
	paperQuality varchar, -- Chat luong sach
	bookSubGenreID int, -- references to SubGenre
	bookPublisherId int, -- reference to Publisher
	bookAuthorId int -- reference to Author 
)
go

--Book Default
alter table Book
add constraint Default_cover
Default 'Khong' FOR cover;
go

--Book Check
alter table Book
add constraint CHK_cover
CHECK (cover like 'Khong' or cover like 'Co')
go

create table Author (
	authorId int primary key,
	auName nvarchar(50),
	auDescription nvarchar,
)
go
create table Publisher (
	pubId int primary key,
	pubName nvarchar(50),
)
go

CREATE TABLE SubGenre(
	SubGenreID int primary key,
	SubGenreName nvarchar(50) not null,
	genreID int, -- reference to Genre 
)
go

create table Genre (
	genreID int primary key,
	genreName nvarchar(50) not null,
)
go

--Genre FK
alter table SubGenre
add constraint FK_SubGenre_Genre 
foreign key (genreID) references Genre(genreID) 
on delete cascade 
on update cascade
go

--Book FK
alter table Book
add constraint FK_Book_SubGenre
foreign key (bookSubGenreID) references SubGenre(SubGenreID)
on delete cascade
on update cascade
go

alter table Book
add constraint FK_Book_Publisher 
foreign key (bookPublisherId) references Publisher(pubId) 
on delete cascade 
on update cascade
go

alter table Book
add constraint FK_Book_Author 
foreign key (bookAuthorId) references Author(authorId) 
on delete cascade 
on update cascade
go

-- Book Default 
ALTER TABLE Book
ADD CONSTRAINT Default_bkPrice
DEFAULT 0 FOR bkPrice;
go


create table Orders (
	ordId int primary key,
	ordUserID int, -- references to UserID in UserAccounts
	ordDate date,
	ordShipDate date,
	ordStatus varchar(15) default 'Dang xu ly',
	ordAsGift varchar not null, -- 0 = khong goi qua, 1 = goi qua + 10k,
	ordAddress nvarchar not null,
	ordPhoneNumber int not null,
	ordShipPrice money not null,
	ordDiscount int
)
go

-- Order Default 
alter table Orders
add constraint Default_ordAsGift
DEFAULT 'Khong' for ordAsGift
go

alter table Orders
add constraint Default_ordShipPrice
default 50000 for ordShipPrice
go
 
-- Order constraints
alter table Orders
add constraint CHK_Orders_Gift
CHECK (ordAsGift like 'Khong' or ordAsGift like 'Co')
go

alter table Orders
add constraint FK_Orders_UserID
foreign key (ordUserID) references UserAccounts(userID)
on delete cascade 
on update cascade
go

create table OrderDetail (
	odQuantity int,
	odBookId  varchar(10),
	odOrderId int, 
	odIncludeCover varchar -- Co dich vu boc sach -> + 3k/quyen
)
go

--OrderDetail FK
alter table OrderDetail
add constraint FK_OrderDetail_Orders 
foreign key (odOrderId) references Orders(ordId) 
on delete cascade 
on update cascade
go

alter table OrderDetail
add constraint FK_OrderDetail_Book 
foreign key (odBookId) references Book(bkId) 
on delete cascade 
on update cascade
go

--unique bookid and orderid
create unique nonclustered index UQ_OrderDetail 
on OrderDetail(odBookId,odOrderId)
go

create table Comments (
	UserID int,
	Rating tinyint not null,
	content nvarchar(100),
	bookID varchar(10) 
)
go

alter table Comments
add constraint CHK_Rating
CHECK (Rating >= 0 AND Rating <= 5)
go

alter table Comments
add constraint FK_Feedback_Book 
foreign key (bookID) references Book(bkId) 
on delete cascade 
on update cascade
go

alter table Comments 
add constraint FK_Feedback_UserAccounts
foreign key (UserID) references UserAccounts(userID) 
on delete cascade 
on update cascade
go

create table Liked (
	userId int,
	bookId varchar(10)
)

alter table Liked
add constrant FK_Liked_UserAccounts
foreign key (userId) references UserAccounts(userID)
on delete cascade
on update cascade
go

alter table Liked
add constraint FK_Liked_Book
foreign key (bookId) references Book(bkId)
on delete cascade
on update cascade
go


