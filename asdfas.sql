create database VinaBookDBver4
use VinaBookDBver4

create table UserAccount (
	userID int identity(1,1) primary key,
	userName nvarchar(100) not null,
	userEmail varchar(50),
	userphone varchar(50),
	userBirthDate date not null,
	userGender varchar(10),
	userPassword varchar(100) not null
	
)
go
--Account Default
ALTER TABLE UserAccount
ADD CONSTRAINT Default_Gender
DEFAULT 'Others' FOR userGender;
go

create table Author (
	authorId int identity(1,1) primary key,
	auName nvarchar(50),
	auGender bit
)
go
create table Publisher (
	pubId int identity(1,1) primary key,
	pubName nvarchar(50),
	pubAddress nvarchar(50),
	pubPhoneNo varchar(12)
)
go

create table Book (
	bkId  varchar(10) primary key,
	bkTitle nvarchar(50) not null,
	bkType nvarchar(50) not null,
	bkPrice money not null,
	bkAvailableQuantity int,
	bkPublisherId int, -- reference to Publisher
	bkAuthorId int, -- reference to Author 
)
go
--Book FK
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
	ordDate date,
	ordTotal money,
	ordVoucher int,
	ordStatus varchar(15) default 'processing',
	ordAccountEmail varchar(50)
)
go
--Orders FK
alter table Orders
add constraint FK_Orders_Account 
foreign key (ordAccountEmail) references UserAccount(userEmail) 
on delete cascade 
on update cascade
go

create table OrderDetail (
	ordtId int identity(1,1) primary key,
	ordtQuantity int,
	ordtPrice money,
	ordtBookId  varchar(10),
	ordtOrderId int, 
	ordtDis int,
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

create table Comment (
	UserID int,
	Rate int,
	content nvarchar(100),
	bookID varchar(10) 

)

alter table Comment 
add constraint FK_Feedback_Book 
foreign key (bookID) references Book(bkId) 
on delete cascade 
on update cascade
go
alter table Comment 
add constraint FK_Feedback_UserAccount
foreign key (UserID) references UserAccount(UserID) 
on delete cascade 
on update cascade



--INSERT VALUES
--Account
INSERT INTO UserAccount(userEmail ,userPassword,userName,userphone, userBirthDate,userGender)
VALUES('abcd@gmail.com', '123456',N'abcd', '09120312312', '2002-11-11', 'Male')
go
INSERT INTO UserAccount(userEmail ,userPassword,userName,userphone, userBirthDate,userGender)
VALUES('abcde@gmail.com', '123456',N'abcde', '09120312777', '2002-07-13', 'Male')
go
INSERT INTO UserAccount(userEmail ,userPassword,userName,userphone, userBirthDate,userGender)
VALUES('abcdef@gmail.com', '123456',N'abcdef', '09120312313', '2004-11-27', 'Male')

--Author
INSERT INTO Author(auName,auGender)
VALUES(N'Trần Ngọc Dũng',1)
go
INSERT INTO Author(auName,auGender)
VALUES(N'Camille Paris',1)
go
INSERT INTO Author(auName,auGender)
VALUES(N'Nguyễn Nhật Ánh',1)
go
INSERT INTO Author(auName,auGender)
VALUES(N'Trịnh Khắc Mạnh', 1)
--Publisher

INSERT INTO Publisher(pubName,pubAddress,pubPhoneNo)
VALUES(N'Nxb Khoa học xã hội', N'57 Đ. Sương Nguyệt Anh, Thành phố Hồ Chí Minh',' 02838394948')
go
INSERT INTO Publisher(pubName,pubAddress,pubPhoneNo)
VALUES(N'NXB Hồng Đức', N'65 Tràng Thi, Hàng Bông, Hoàn Kiếm, Hà Nội','02439260024')
go
INSERT INTO Publisher(pubName,pubAddress,pubPhoneNo)
VALUES(N'Nxb Trẻ', N'161B Lý Chính Thắng, Quận 3, Thành phố Hồ Chí Minh',' 02839316289')
go
INSERT INTO Publisher(pubName,pubAddress,pubPhoneNo)
VALUES(N'Nxb Đại Học Quốc Gia Hà Nội', N'16 P. Hàng Chuối, Hai Bà Trưng, Hà Nội',' 02439714896')


--Book
INSERT INTO Book (bkId,bkTitle,bkType,bkPrice,bkAvailableQuantity,bkPublisherId)
VALUES ('BK01',N'Quan Hệ Anh – Việt Nam (1614-1705)','History',254.000,100,1)
go
INSERT INTO Book (bkId,bkTitle,bkType,bkPrice,bkAvailableQuantity,bkPublisherId)
VALUES ('BK02',N'Du Ký Trung Kỳ Theo Đường Cái Quan','Documentory',200.000,100,2)
go
INSERT INTO Book (bkId,bkTitle,bkType,bkPrice,bkAvailableQuantity,bkPublisherId)
VALUES ('BK03',N'Ra Bờ Suối Ngắm Hoa Kèn Hồng','Literary',225.000,100,3)
go
INSERT INTO Book (bkId,bkTitle,bkType,bkPrice,bkAvailableQuantity,bkPublisherId)
VALUES ('BK04',N'Bảy Bước Tới Mùa Hè','Literary',102.000,100,3)
go
INSERT INTO Book (bkId,bkTitle,bkType,bkPrice,bkAvailableQuantity,bkPublisherId)
VALUES ('BK05',N'Văn Miếu Việt Nam Khảo Cứu','Culture And Art',304.000,100,4)
go
INSERT INTO Book (bkId,bkTitle,bkType,bkPrice,bkAvailableQuantity,bkPublisherId)
VALUES ('BK06',N'Chợ Truyền Thống Việt Nam Qua Tư Liệu Văn Bia','History and Geo',368.000,100,4)


--Comment 


INSERT INTO Comment(bookID, UserID, content, rate)
VALUES ('BK04', 1, N'good!', 4)
go
INSERT INTO Comment(bookID, UserID, content, rate)
VALUES ('BK04', 2, N'good!Nice', 3)
go
INSERT INTO Comment(bookID, UserID, content, rate)
VALUES ('BK04', 3, N'great!', 4)
go
INSERT INTO Comment(bookID, UserID, content, rate)
VALUES ('BK03', 3, N'nice!', 4)
go
INSERT INTO Comment(bookID, UserID, content, rate)
VALUES ('BK03', 2, N'nice!!!!', 3)
go
INSERT INTO Comment(bookID, UserID, content, rate)
VALUES ('BK01', 1, N'gud', 4)

ALTER DATABASE SCOPED CONFIGURATION 
  SET VERBOSE_TRUNCATION_WARNINGS = ON;

--Orders
INSERT INTO Orders(ordDate ,ordTotal ,ordVoucher ,ordAccountEmail)
VALUES ('2022-07-20', 1000.000, 20, 'abcd@gmail.com')
go
INSERT INTO Orders(ordDate ,ordTotal ,ordVoucher ,ordAccountEmail)
VALUES ('2022-07-20', 1200.000, 30, 'abcde@gmail.com')
go
INSERT INTO Orders(ordDate ,ordTotal ,ordVoucher ,ordAccountEmail)
VALUES ('2022-07-20', 1300.000, 20, 'abcdef@gmail.com')

--OrderDetail
INSERT INTO OrderDetail(ordtQuantity, ordtPrice, ordtBookId, ordtOrderId, ordtDis)
VALUES (5, 5*254.000, 'BK01', 1, 20000)
go
INSERT INTO OrderDetail(ordtQuantity, ordtPrice, ordtBookId, ordtOrderId, ordtDiscount)
VALUES (2, 2*200.000, 'BK02', 1, 30000)
go
INSERT INTO OrderDetail(ordtQuantity, ordtPrice, ordtBookId, ordtOrderId, ordtDiscount)
VALUES (3, 3*225.000, 'BK03', 1, 10000)

INSERT INTO OrderDetail(ordtQuantity, ordtPrice, ordtBookId, ordtOrderId, ordtDiscount)
VALUES (5, 5*368.000, 'BK06', 2, 5000)
go
INSERT INTO OrderDetail(ordtQuantity, ordtPrice, ordtBookId, ordtOrderId, ordtDiscount)
VALUES (2, 2*102.000, 'BK04', 2, 67000)
go
INSERT INTO OrderDetail(ordtQuantity, ordtPrice, ordtBookId, ordtOrderId, ordtDiscount)
VALUES (3, 3*225.000, 'BK03', 2, 12000)
go

INSERT INTO OrderDetail(ordtQuantity, ordtPrice, ordtBookId, ordtOrderId, ordtDiscount)
VALUES (6, 6*225.000, 'BK03', 3, 19000)
------------------------------
select * from Author
select * from Publisher
select * from Book
select * from UserAccount
select * from Orders
select * from OrderDetail
------------------------------


--1. Show pubId, pubName, pubAddress and pubPhoneNo with address in HCM
select pubId, pubName, pubAddress, pubPhoneNo 
from Publisher 
where pubAddress like N'%Thành phố Hồ Chí Minh'

--2. Show bkId, bkTitle, bkPrice, bkAvailableQuantity with price >= 150.000d and order by price desc
select bkId, bkTitle, bkPrice, bkAvailableQuantity 
from Book 
where bkPrice >= 150.000
order by bkPrice desc