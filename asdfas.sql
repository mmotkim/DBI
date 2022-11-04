create database VinaBook69


create table UserAccounts (
	userID int identity(1,1) primary key,
	userName nvarchar(100) not null,
	userEmail varchar(50),
	userBirthDate date not null,
	userGender varchar(10),
	userPassword varchar(100) not null
)	
go
--Account Default
ALTER TABLE UserAccounts
ADD CONSTRAINT Default_Gender
DEFAULT 'Others' FOR userGender;
go

create table Author (
	authorId int identity(1,1) primary key,
	auName nvarchar(50),
)
go
create table Publisher (
	pubId int identity(1,1) primary key,
	pubName nvarchar(50),
	pubCountry nvarchar(50)
)
go

create table Book (
	bkId  varchar(10) primary key,
	bkTitle nvarchar(50) not null,
	bkPrice money not null,
	bkGenreID int, -- references to Genre
	bkPublisherId int, -- reference to Publisher
	bkAuthorId int, -- reference to Author 
)
go

create table Genre (
	genreID int primary key,
	genreName nvarchar(50) not null,
)
go

--Book FK
alter table Book
add constraint FK_Book_Genre
foreign key (bkGenreID) references Genre(genreID)
on delete cascade
on update cascade
go

alter table Book
add constraint FK_Book_Publisher 
foreign key (bkPublisherId) references Publisher(pubId) 
on delete cascade 
on update cascade
go

alter table Book
add constraint FK_Book_Author 
foreign key (bkAuthorId) references Author(authorId) 
on delete cascade 
on update cascade
go

-- Book Default 
ALTER TABLE Book
ADD CONSTRAINT Default_bkPrice
DEFAULT 0 FOR bkPrice;
go
ALTER TABLE Book
ADD CONSTRAINT Default_bkAvailableQuantity
DEFAULT 0 FOR bkAvailableQuantity;
go


create table Orders (
	ordId int primary key,
	ordUserID int, -- references to UserID in UserAccounts
	ordDate date,
	ordShipDate date,
	ordStatus varchar(15) default 'Dang xu ly',
)
go

alter table Orders
add constraint FK_Orders_UserID
foreign key (ordUserID) references UserAccounts(userID)
on delete cascade 
on update cascade
go

create table OrderDetail (
	odId int identity(1,1) primary key,
	odQuantity int,
	odBookId  varchar(10),
	odOrderId int, 
	odDiscount int,
)
go

--OrderDetail FK
alter table OrderDetail
add constraint FK_OrderDetail_Orders 
foreign key (ordtOrderId) references Orders(ordId) 
on delete cascade 
on update cascade
go

alter table OrderDetail
add constraint FK_OrderDetail_Book 
foreign key (ordtBookId) references Book(bkId) 
on delete cascade 
on update cascade
go

--unique bookid and orderid
create unique nonclustered index UQ_OrderDetail 
on OrderDetail(ordtBookId,ordtOrderId)
go

create table Comments (
	UserID int,
	Rating int not null,
	content nvarchar(100),
	bookID varchar(10) 
)
go

alter table Comment 
add constraint FK_Feedback_Book 
foreign key (bookID) references Book(bkId) 
on delete cascade 
on update cascade
go

alter table Comment 
add constraint FK_Feedback_UserAccounts
foreign key (UserID) references UserAccounts(UserID) 
on delete cascade 
on update cascade
go

--1. Show pubId, pubName, pubAddress and pubPhoneNo with address in HCM
select pubId, pubName, pubAddress, pubPhoneNo 
from Publisher 
where pubAddress like N'%Thành phố Hồ Chí Minh'

--2. Show bkId, bkTitle, bkPrice, bkAvailableQuantity with price >= 150.000d and order by price desc
select bkId, bkTitle, bkPrice, bkAvailableQuantity 
from Book 
where bkPrice >= 150.000
order by bkPrice desc