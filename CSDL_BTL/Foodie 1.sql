USE [master]
GO
/****** Object:  Database [Foodie]    Script Date: 20/11/2024 5:16:19 CH ******/
CREATE DATABASE [Foodie]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Foodie', FILENAME = N'D:\Sql sever\MSSQL16.SQLEXPRESS01\MSSQL\DATA\Foodie.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Foodie_log', FILENAME = N'D:\Sql sever\MSSQL16.SQLEXPRESS01\MSSQL\DATA\Foodie_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Foodie] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Foodie].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Foodie] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Foodie] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Foodie] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Foodie] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Foodie] SET ARITHABORT OFF 
GO
ALTER DATABASE [Foodie] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Foodie] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Foodie] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Foodie] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Foodie] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Foodie] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Foodie] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Foodie] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Foodie] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Foodie] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Foodie] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Foodie] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Foodie] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Foodie] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Foodie] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Foodie] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Foodie] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Foodie] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Foodie] SET  MULTI_USER 
GO
ALTER DATABASE [Foodie] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Foodie] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Foodie] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Foodie] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Foodie] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Foodie] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Foodie] SET QUERY_STORE = ON
GO
ALTER DATABASE [Foodie] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Foodie]
GO
/****** Object:  Table [dbo].[Booking]    Script Date: 20/11/2024 5:16:19 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Booking](
	[BookingId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](100) NOT NULL,
	[Date] [datetime] NOT NULL,
	[Number] [int] NOT NULL,
	[PhoneNumber] [nvarchar](15) NULL,
	[Email] [nvarchar](100) NULL
PRIMARY KEY CLUSTERED 
(
	[BookingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Carts]    Script Date: 20/11/2024 5:16:19 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carts](
	[CartId] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NULL,
	[Quantity] [int] NULL,
	[UserId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CartId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 20/11/2024 5:16:19 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[ImageUrl] [nvarchar](max) NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contact]    Script Date: 20/11/2024 5:16:19 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contact](
	[ContactId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Subject] [varchar](200) NULL,
	[Message] [varchar](max) NULL,
	[CreatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ContactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 20/11/2024 5:16:19 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderDetailsId] [int] IDENTITY(1,1) NOT NULL,
	[OrderNo] [nvarchar](max) NULL,
	[ProductId] [int] NULL,
	[Quantity] [int] NULL,
	[UserId] [int] NULL,
	[ToTalBill] [decimal](18, 0) NULL,
	[Status] [nvarchar](50) NULL,
	[PaymentId] [int] NULL,
	[OrderDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderDetailsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment]    Script Date: 20/11/2024 5:16:19 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment](
	[PaymentId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[CardNo] [nvarchar](50) NULL,
	[ExpiryDate] [nvarchar](50) NULL,
	[CvvNo] [int] NULL,
	[Address] [varchar](max) NULL,
	[PaymentMode] [nvarchar](50) NULL,
	[ToTalBill] [decimal](18, 0) NULL,
	[UserId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 20/11/2024 5:16:19 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Description] [nvarchar](max) NULL,
	[Price] [decimal](18, 2) NULL,
	[Quantity] [int] NULL,
	[ImageUrl] [nvarchar](max) NULL,
	[CategoryId] [int] NULL,
	[IsActive] [bit] NULL,
	[CreateDate] [datetime] NULL,
	[Review] [nvarchar](500) NULL,
	[idReview] [int] NULL,
	[Rating] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reviews]    Script Date: 20/11/2024 5:16:19 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviews](
	[ReviewId] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[Rating] [int] NOT NULL,
	[Comment] [nvarchar](500) NULL,
	[CreatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ReviewId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 20/11/2024 5:16:19 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Username] [nvarchar](50) NULL,
	[Mobile] [nvarchar](60) NULL,
	[Email] [nvarchar](60) NULL,
	[Address] [nvarchar](max) NULL,
	[PostCode] [nvarchar](60) NULL,
	[Password] [nvarchar](60) NULL,
	[ImageUrl] [nvarchar](max) NULL,
	[CreateDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Carts] ON 

INSERT [dbo].[Carts] ([CartId], [ProductId], [Quantity], [UserId]) VALUES (2, 1, 5, 2)
SET IDENTITY_INSERT [dbo].[Carts] OFF
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CategoryId], [Name], [ImageUrl], [IsActive], [CreatedDate]) VALUES (1, N'Món khai vị', NULL, 1, CAST(N'2024-11-17T22:54:05.103' AS DateTime))
INSERT [dbo].[Categories] ([CategoryId], [Name], [ImageUrl], [IsActive], [CreatedDate]) VALUES (2, N'Món chính', NULL, 1, CAST(N'2024-11-17T22:54:05.103' AS DateTime))
INSERT [dbo].[Categories] ([CategoryId], [Name], [ImageUrl], [IsActive], [CreatedDate]) VALUES (3, N'Món chay', NULL, 1, CAST(N'2024-11-17T22:54:05.103' AS DateTime))
INSERT [dbo].[Categories] ([CategoryId], [Name], [ImageUrl], [IsActive], [CreatedDate]) VALUES (4, N'Món tráng miệng', NULL, 1, CAST(N'2024-11-17T22:54:05.103' AS DateTime))
INSERT [dbo].[Categories] ([CategoryId], [Name], [ImageUrl], [IsActive], [CreatedDate]) VALUES (5, N'Món đặc biệt', NULL, 1, CAST(N'2024-11-17T22:54:05.103' AS DateTime))
INSERT [dbo].[Categories] ([CategoryId], [Name], [ImageUrl], [IsActive], [CreatedDate]) VALUES (6, N'Đồ uống', NULL, 1, CAST(N'2024-11-17T22:54:05.103' AS DateTime))
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[Contact] ON 

INSERT [dbo].[Contact] ([ContactId], [Name], [Email], [Subject], [Message], [CreatedDate]) VALUES (1, N'Nguy?n Th? Minh Anh', N'minhanh@gmail.com', N'H?i v? th?c don', N'Tôi mu?n bi?t thêm thông tin v? các món chay.', CAST(N'2024-11-17T22:54:05.100' AS DateTime))
INSERT [dbo].[Contact] ([ContactId], [Name], [Email], [Subject], [Message], [CreatedDate]) VALUES (2, N'Lê Van H?u', N'huu.le@gmail.com', N'Góp ý', N'Tôi d? xu?t b? sung thêm món tráng mi?ng vào th?c don.', CAST(N'2024-11-17T22:54:05.100' AS DateTime))
INSERT [dbo].[Contact] ([ContactId], [Name], [Email], [Subject], [Message], [CreatedDate]) VALUES (3, N'Tr?n Th? Ng?c Lan', N'ngoclan@gmail.com', N'Yêu c?u d?t ch?', N'Tôi c?n d?t bàn cho 6 ngu?i vào trua Ch? nh?t.', CAST(N'2024-11-17T22:54:05.100' AS DateTime))
INSERT [dbo].[Contact] ([ContactId], [Name], [Email], [Subject], [Message], [CreatedDate]) VALUES (4, N'Ph?m Qu?c Ð?t', N'dat.pham@gmail.com', N'Khi?u n?i', N'Tôi không nh?n du?c hóa don sau khi thanh toán.', CAST(N'2024-11-17T22:54:05.100' AS DateTime))
INSERT [dbo].[Contact] ([ContactId], [Name], [Email], [Subject], [Message], [CreatedDate]) VALUES (5, N'Hu?nh Thanh Phong', N'phong.huynh@gmail.com', N'Ph?n h?i d?ch v?', N'D?ch v? r?t nhanh và thân thi?n. C?m on!', CAST(N'2024-11-17T22:54:05.100' AS DateTime))
INSERT [dbo].[Contact] ([ContactId], [Name], [Email], [Subject], [Message], [CreatedDate]) VALUES (6, N'Doãn Thu Hà', N'thuha@gmail.com', N'Yêu c?u h? tr?', N'Tôi mu?n bi?t cách d?t bàn tr?c tuy?n.', CAST(N'2024-11-17T22:54:05.100' AS DateTime))
INSERT [dbo].[Contact] ([ContactId], [Name], [Email], [Subject], [Message], [CreatedDate]) VALUES (7, N'Vu Th? Th?o', N'thithao.vu@gmail.com', N'Khi?u n?i', N'Món an có v? l? và không gi?ng nhu l?n tru?c.', CAST(N'2024-11-17T22:54:05.100' AS DateTime))
INSERT [dbo].[Contact] ([ContactId], [Name], [Email], [Subject], [Message], [CreatedDate]) VALUES (8, N'Bùi Van Nam', N'nam.bui@gmail.com', N'H?i v? khuy?n mãi', N'Hi?n t?i có chuong trình khuy?n mãi nào không?', CAST(N'2024-11-17T22:54:05.100' AS DateTime))
INSERT [dbo].[Contact] ([ContactId], [Name], [Email], [Subject], [Message], [CreatedDate]) VALUES (9, N'Tôn N? Mai Huong', N'maihuong@gmail.com', N'Ph?n h?i món an', N'Món an r?t ngon, d?c bi?t là các món chay.', CAST(N'2024-11-17T22:54:05.100' AS DateTime))
INSERT [dbo].[Contact] ([ContactId], [Name], [Email], [Subject], [Message], [CreatedDate]) VALUES (10, N'Hoàng Ng?c B?o', N'baongoc@gmail.com', N'H?i v? gi? m? c?a', N'Nhà hàng có m? c?a vào ngày l? không?', CAST(N'2024-11-17T22:54:05.100' AS DateTime))
SET IDENTITY_INSERT [dbo].[Contact] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderDetailsId], [OrderNo], [ProductId], [Quantity], [UserId], [ToTalBill], [Status], [PaymentId], [OrderDate]) VALUES (1, N'ORD001', 1, 2, 1, CAST(130000 AS Decimal(18, 0)), N'Đang xử lý', 1, CAST(N'2024-11-17T22:54:05.117' AS DateTime))
INSERT [dbo].[Orders] ([OrderDetailsId], [OrderNo], [ProductId], [Quantity], [UserId], [ToTalBill], [Status], [PaymentId], [OrderDate]) VALUES (2, N'ORD002', 2, 1, 2, CAST(135000 AS Decimal(18, 0)), N'Hoàn tất', 2, CAST(N'2024-11-17T22:54:05.117' AS DateTime))
INSERT [dbo].[Orders] ([OrderDetailsId], [OrderNo], [ProductId], [Quantity], [UserId], [ToTalBill], [Status], [PaymentId], [OrderDate]) VALUES (3, N'ORD003', 3, 5, 3, CAST(325000 AS Decimal(18, 0)), N'Đang giao', 3, CAST(N'2024-11-17T22:54:05.117' AS DateTime))
INSERT [dbo].[Orders] ([OrderDetailsId], [OrderNo], [ProductId], [Quantity], [UserId], [ToTalBill], [Status], [PaymentId], [OrderDate]) VALUES (4, N'ORD004', 4, 3, 4, CAST(195000 AS Decimal(18, 0)), N'Hoàn tất', 4, CAST(N'2024-11-17T22:54:05.117' AS DateTime))
INSERT [dbo].[Orders] ([OrderDetailsId], [OrderNo], [ProductId], [Quantity], [UserId], [ToTalBill], [Status], [PaymentId], [OrderDate]) VALUES (5, N'ORD005', 5, 4, 5, CAST(260000 AS Decimal(18, 0)), N'Đã hủy', 5, CAST(N'2024-11-17T22:54:05.117' AS DateTime))
INSERT [dbo].[Orders] ([OrderDetailsId], [OrderNo], [ProductId], [Quantity], [UserId], [ToTalBill], [Status], [PaymentId], [OrderDate]) VALUES (6, N'ORD006', 6, 1, 6, CAST(85000 AS Decimal(18, 0)), N'Đang xử lý', 6, CAST(N'2024-11-17T22:54:05.117' AS DateTime))
INSERT [dbo].[Orders] ([OrderDetailsId], [OrderNo], [ProductId], [Quantity], [UserId], [ToTalBill], [Status], [PaymentId], [OrderDate]) VALUES (7, N'ORD007', 7, 2, 7, CAST(170000 AS Decimal(18, 0)), N'Hoàn tất', 7, CAST(N'2024-11-17T22:54:05.117' AS DateTime))
INSERT [dbo].[Orders] ([OrderDetailsId], [OrderNo], [ProductId], [Quantity], [UserId], [ToTalBill], [Status], [PaymentId], [OrderDate]) VALUES (8, N'ORD008', 8, 1, 8, CAST(75000 AS Decimal(18, 0)), N'Đang giao', 8, CAST(N'2024-11-17T22:54:05.117' AS DateTime))
INSERT [dbo].[Orders] ([OrderDetailsId], [OrderNo], [ProductId], [Quantity], [UserId], [ToTalBill], [Status], [PaymentId], [OrderDate]) VALUES (9, N'ORD009', 9, 2, 9, CAST(140000 AS Decimal(18, 0)), N'Hoàn tất', 9, CAST(N'2024-11-17T22:54:05.117' AS DateTime))
INSERT [dbo].[Orders] ([OrderDetailsId], [OrderNo], [ProductId], [Quantity], [UserId], [ToTalBill], [Status], [PaymentId], [OrderDate]) VALUES (10, N'ORD010', 10, 1, 10, CAST(35000 AS Decimal(18, 0)), N'Đã hủy', 10, CAST(N'2024-11-17T22:54:05.117' AS DateTime))
INSERT [dbo].[Orders] ([OrderDetailsId], [OrderNo], [ProductId], [Quantity], [UserId], [ToTalBill], [Status], [PaymentId], [OrderDate]) VALUES (11, N'ORD011', 11, 3, 11, CAST(405000 AS Decimal(18, 0)), N'Đang xử lý', 11, CAST(N'2024-11-17T22:54:05.117' AS DateTime))
INSERT [dbo].[Orders] ([OrderDetailsId], [OrderNo], [ProductId], [Quantity], [UserId], [ToTalBill], [Status], [PaymentId], [OrderDate]) VALUES (12, N'ORD012', 12, 2, 12, CAST(270000 AS Decimal(18, 0)), N'Hoàn tất', 12, CAST(N'2024-11-17T22:54:05.117' AS DateTime))
INSERT [dbo].[Orders] ([OrderDetailsId], [OrderNo], [ProductId], [Quantity], [UserId], [ToTalBill], [Status], [PaymentId], [OrderDate]) VALUES (13, N'ORD013', 13, 1, 13, CAST(135000 AS Decimal(18, 0)), N'Đang giao', 13, CAST(N'2024-11-17T22:54:05.117' AS DateTime))
INSERT [dbo].[Orders] ([OrderDetailsId], [OrderNo], [ProductId], [Quantity], [UserId], [ToTalBill], [Status], [PaymentId], [OrderDate]) VALUES (14, N'ORD014', 14, 4, 14, CAST(340000 AS Decimal(18, 0)), N'Hoàn tất', 14, CAST(N'2024-11-17T22:54:05.117' AS DateTime))
INSERT [dbo].[Orders] ([OrderDetailsId], [OrderNo], [ProductId], [Quantity], [UserId], [ToTalBill], [Status], [PaymentId], [OrderDate]) VALUES (15, N'ORD015', 15, 1, 15, CAST(95000 AS Decimal(18, 0)), N'Đã hủy', 15, CAST(N'2024-11-17T22:54:05.117' AS DateTime))
INSERT [dbo].[Orders] ([OrderDetailsId], [OrderNo], [ProductId], [Quantity], [UserId], [ToTalBill], [Status], [PaymentId], [OrderDate]) VALUES (16, N'ORD016', 16, 5, 16, CAST(325000 AS Decimal(18, 0)), N'Đang xử lý', 16, CAST(N'2024-11-17T22:54:05.117' AS DateTime))
INSERT [dbo].[Orders] ([OrderDetailsId], [OrderNo], [ProductId], [Quantity], [UserId], [ToTalBill], [Status], [PaymentId], [OrderDate]) VALUES (17, N'ORD017', 17, 2, 17, CAST(170000 AS Decimal(18, 0)), N'Hoàn tất', 17, CAST(N'2024-11-17T22:54:05.117' AS DateTime))
INSERT [dbo].[Orders] ([OrderDetailsId], [OrderNo], [ProductId], [Quantity], [UserId], [ToTalBill], [Status], [PaymentId], [OrderDate]) VALUES (18, N'ORD018', 18, 1, 18, CAST(70000 AS Decimal(18, 0)), N'Đang giao', 18, CAST(N'2024-11-17T22:54:05.117' AS DateTime))
INSERT [dbo].[Orders] ([OrderDetailsId], [OrderNo], [ProductId], [Quantity], [UserId], [ToTalBill], [Status], [PaymentId], [OrderDate]) VALUES (19, N'ORD019', 19, 3, 19, CAST(195000 AS Decimal(18, 0)), N'Hoàn tất', 19, CAST(N'2024-11-17T22:54:05.117' AS DateTime))
INSERT [dbo].[Orders] ([OrderDetailsId], [OrderNo], [ProductId], [Quantity], [UserId], [ToTalBill], [Status], [PaymentId], [OrderDate]) VALUES (20, N'ORD020', 20, 2, 20, CAST(180000 AS Decimal(18, 0)), N'Đã hủy', 20, CAST(N'2024-11-17T22:54:05.117' AS DateTime))
INSERT [dbo].[Orders] ([OrderDetailsId], [OrderNo], [ProductId], [Quantity], [UserId], [ToTalBill], [Status], [PaymentId], [OrderDate]) VALUES (21, NULL, 2, 999, 2, CAST(54945000 AS Decimal(18, 0)), N'Pending', NULL, CAST(N'2024-11-18T00:43:20.453' AS DateTime))
INSERT [dbo].[Orders] ([OrderDetailsId], [OrderNo], [ProductId], [Quantity], [UserId], [ToTalBill], [Status], [PaymentId], [OrderDate]) VALUES (22, NULL, 1, 1, 2, CAST(155000 AS Decimal(18, 0)), N'Pending', NULL, CAST(N'2024-11-18T00:43:20.470' AS DateTime))
INSERT [dbo].[Orders] ([OrderDetailsId], [OrderNo], [ProductId], [Quantity], [UserId], [ToTalBill], [Status], [PaymentId], [OrderDate]) VALUES (23, NULL, 1, 1, 2, CAST(155000 AS Decimal(18, 0)), N'Pending', NULL, CAST(N'2024-11-18T00:53:44.123' AS DateTime))
INSERT [dbo].[Orders] ([OrderDetailsId], [OrderNo], [ProductId], [Quantity], [UserId], [ToTalBill], [Status], [PaymentId], [OrderDate]) VALUES (24, NULL, 2, 15345, 2, CAST(843975000 AS Decimal(18, 0)), N'Pending', NULL, CAST(N'2024-11-18T00:53:44.137' AS DateTime))
INSERT [dbo].[Orders] ([OrderDetailsId], [OrderNo], [ProductId], [Quantity], [UserId], [ToTalBill], [Status], [PaymentId], [OrderDate]) VALUES (25, NULL, 1, 9999, 2, CAST(1549845000 AS Decimal(18, 0)), N'Pending', NULL, CAST(N'2024-11-18T01:13:20.893' AS DateTime))
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Payment] ON 

INSERT [dbo].[Payment] ([PaymentId], [Name], [CardNo], [ExpiryDate], [CvvNo], [Address], [PaymentMode], [ToTalBill], [UserId]) VALUES (1, N'Nguyễn Thị Minh Anh', N'1111-2222-3333-4444', N'01/26', 321, N'123 Ðu?ng Láng, Hà N?i', N'Thẻ tín dụng', NULL, 1)
INSERT [dbo].[Payment] ([PaymentId], [Name], [CardNo], [ExpiryDate], [CvvNo], [Address], [PaymentMode], [ToTalBill], [UserId]) VALUES (2, N'Lê Văn Hữu', N'2222-3333-4444-5555', N'02/27', 654, N'456 Nguy?n Hu?, TP. H? Chí Minh', N'Thẻ ghi nợ', NULL, 2)
INSERT [dbo].[Payment] ([PaymentId], [Name], [CardNo], [ExpiryDate], [CvvNo], [Address], [PaymentMode], [ToTalBill], [UserId]) VALUES (3, N'Trần Thị Ngọc Lan', N'3333-4444-5555-6666', N'03/28', 987, N'789 Tr?n Hung Ð?o, Ðà N?ng', N'Thẻ tín dụng', NULL, 3)
INSERT [dbo].[Payment] ([PaymentId], [Name], [CardNo], [ExpiryDate], [CvvNo], [Address], [PaymentMode], [ToTalBill], [UserId]) VALUES (4, N'Phạm Quốc Đạt', N'4444-5555-6666-7777', N'04/29', 543, N'12 Lê L?i, Hu?', N'Thẻ ghi nợ', NULL, 4)
INSERT [dbo].[Payment] ([PaymentId], [Name], [CardNo], [ExpiryDate], [CvvNo], [Address], [PaymentMode], [ToTalBill], [UserId]) VALUES (5, N'Huỳnh Thanh Phong', N'5555-6666-7777-8888', N'05/25', 210, N'34 Nguy?n Trãi, H?i Phòng', N'Thẻ tín dụng', NULL, 5)
INSERT [dbo].[Payment] ([PaymentId], [Name], [CardNo], [ExpiryDate], [CvvNo], [Address], [PaymentMode], [ToTalBill], [UserId]) VALUES (6, N'Doãn Thu Hà', N'6666-7777-8888-9999', N'06/24', 345, N'56 Lý Thu?ng Ki?t, C?n Tho', N'Thẻ ghi nợ', NULL, 6)
INSERT [dbo].[Payment] ([PaymentId], [Name], [CardNo], [ExpiryDate], [CvvNo], [Address], [PaymentMode], [ToTalBill], [UserId]) VALUES (7, N'Vũ Thị Thảo', N'7777-8888-9999-1111', N'07/26', 678, N'78 Ph?m Van Ð?ng, Nha Trang', N'Thẻ tín dụng', NULL, 7)
INSERT [dbo].[Payment] ([PaymentId], [Name], [CardNo], [ExpiryDate], [CvvNo], [Address], [PaymentMode], [ToTalBill], [UserId]) VALUES (8, N'Bùi Văn Nam', N'8888-9999-1111-2222', N'08/27', 901, N'90 Tr?n Phú, Vung Tàu', N'Thẻ ghi nợ', NULL, 8)
INSERT [dbo].[Payment] ([PaymentId], [Name], [CardNo], [ExpiryDate], [CvvNo], [Address], [PaymentMode], [ToTalBill], [UserId]) VALUES (9, N'Tôn Nữ Mai Hương', N'9999-1111-2222-3333', N'09/28', 234, N'123 Nguy?n Khuy?n, Ðà L?t', N'Thẻ tín dụng', NULL, 9)
INSERT [dbo].[Payment] ([PaymentId], [Name], [CardNo], [ExpiryDate], [CvvNo], [Address], [PaymentMode], [ToTalBill], [UserId]) VALUES (10, N'Hoàng Ngọc Bảo', N'1010-1111-2222-3333', N'10/29', 567, N'456 Hai Bà Trung, Bình Duong', N'Thẻ ghi nợ', NULL, 10)
INSERT [dbo].[Payment] ([PaymentId], [Name], [CardNo], [ExpiryDate], [CvvNo], [Address], [PaymentMode], [ToTalBill], [UserId]) VALUES (11, N'Tạ Quốc Bảo', N'2020-1111-2222-3333', N'11/25', 890, N'789 L?c Long Quân, Ð?ng Nai', N'Thẻ tín dụng', NULL, 11)
INSERT [dbo].[Payment] ([PaymentId], [Name], [CardNo], [ExpiryDate], [CvvNo], [Address], [PaymentMode], [ToTalBill], [UserId]) VALUES (12, N'Lý Thị Hoài Thương', N'3030-1111-2222-3333', N'12/26', 123, N'12 Hoàng Hoa Thám, Qu?ng Ninh', N'Thẻ ghi nợ', NULL, 12)
INSERT [dbo].[Payment] ([PaymentId], [Name], [CardNo], [ExpiryDate], [CvvNo], [Address], [PaymentMode], [ToTalBill], [UserId]) VALUES (13, N'Phan Thị Kim Yến', N'4040-1111-2222-3333', N'01/27', 456, N'34 Cách M?ng Tháng 8, Bình Phu?c', N'Thẻ tín dụng', NULL, 13)
INSERT [dbo].[Payment] ([PaymentId], [Name], [CardNo], [ExpiryDate], [CvvNo], [Address], [PaymentMode], [ToTalBill], [UserId]) VALUES (14, N'Doãn Văn Khôi', N'5050-1111-2222-3333', N'02/28', 789, N'56 Phan Ðang Luu, Thanh Hóa', N'Thẻ ghi nợ', NULL, 14)
INSERT [dbo].[Payment] ([PaymentId], [Name], [CardNo], [ExpiryDate], [CvvNo], [Address], [PaymentMode], [ToTalBill], [UserId]) VALUES (15, N'Nguyễn Bảo Trâm', N'6060-1111-2222-3333', N'03/29', 101, N'78 Lê Quý Ðôn, Hà Nam', N'Thẻ tín dụng', NULL, 15)
INSERT [dbo].[Payment] ([PaymentId], [Name], [CardNo], [ExpiryDate], [CvvNo], [Address], [PaymentMode], [ToTalBill], [UserId]) VALUES (16, N'Lê Quang Huy', N'7070-1111-2222-3333', N'04/25', 212, N'123 Phan Châu Trinh, Qu?ng Nam', N'Thẻ ghi nợ', NULL, 16)
INSERT [dbo].[Payment] ([PaymentId], [Name], [CardNo], [ExpiryDate], [CvvNo], [Address], [PaymentMode], [ToTalBill], [UserId]) VALUES (17, N'Trần Thu Trang', N'8080-1111-2222-3333', N'05/26', 345, N'456 B?ch Ð?ng, H?i Duong', N'Thẻ tín dụng', NULL, 17)
INSERT [dbo].[Payment] ([PaymentId], [Name], [CardNo], [ExpiryDate], [CvvNo], [Address], [PaymentMode], [ToTalBill], [UserId]) VALUES (18, N'Ngô Quang Huy', N'9090-1111-2222-3333', N'06/27', 678, N'789 Nguy?n Chí Thanh, B?n Tre', N'Thẻ ghi nợ', NULL, 18)
INSERT [dbo].[Payment] ([PaymentId], [Name], [CardNo], [ExpiryDate], [CvvNo], [Address], [PaymentMode], [ToTalBill], [UserId]) VALUES (19, N'Tôn Thất Hòa', N'0101-2222-3333-4444', N'07/28', 901, N'12 Võ Van T?n, Lâm Ð?ng', N'Thẻ tín dụng', NULL, 19)
INSERT [dbo].[Payment] ([PaymentId], [Name], [CardNo], [ExpiryDate], [CvvNo], [Address], [PaymentMode], [ToTalBill], [UserId]) VALUES (20, N'Bùi Ngọc Dung', N'1111-3333-4444-5555', N'08/29', 234, N'34 Nguy?n Van Tr?i, Tây Ninh', N'Thẻ ghi nợ', NULL, 20)
INSERT [dbo].[Payment] ([PaymentId], [Name], [CardNo], [ExpiryDate], [CvvNo], [Address], [PaymentMode], [ToTalBill], [UserId]) VALUES (21, N'Lê Văn Hữu', NULL, NULL, NULL, N'456 Nguy?n Hu?, TP. H? Chí Minh', N'Online', CAST(54945005 AS Decimal(18, 0)), 2)
INSERT [dbo].[Payment] ([PaymentId], [Name], [CardNo], [ExpiryDate], [CvvNo], [Address], [PaymentMode], [ToTalBill], [UserId]) VALUES (22, N'Lê Văn Hữu', NULL, NULL, NULL, N'456 Nguy?n Hu?, TP. H? Chí Minh', N'Online', CAST(55100005 AS Decimal(18, 0)), 2)
INSERT [dbo].[Payment] ([PaymentId], [Name], [CardNo], [ExpiryDate], [CvvNo], [Address], [PaymentMode], [ToTalBill], [UserId]) VALUES (23, N'Lê Văn Hữu', NULL, NULL, NULL, N'456 Nguy?n Hu?, TP. H? Chí Minh', N'Online', CAST(55100005 AS Decimal(18, 0)), 2)
INSERT [dbo].[Payment] ([PaymentId], [Name], [CardNo], [ExpiryDate], [CvvNo], [Address], [PaymentMode], [ToTalBill], [UserId]) VALUES (24, N'Lê Văn Hữu', NULL, NULL, NULL, N'456 Nguy?n Hu?, TP. H? Chí Minh', N'Online', CAST(55100005 AS Decimal(18, 0)), 2)
INSERT [dbo].[Payment] ([PaymentId], [Name], [CardNo], [ExpiryDate], [CvvNo], [Address], [PaymentMode], [ToTalBill], [UserId]) VALUES (25, N'Lê Văn Hữu', NULL, NULL, NULL, N'456 Nguy?n Hu?, TP. H? Chí Minh', N'Online', CAST(844130005 AS Decimal(18, 0)), 2)
INSERT [dbo].[Payment] ([PaymentId], [Name], [CardNo], [ExpiryDate], [CvvNo], [Address], [PaymentMode], [ToTalBill], [UserId]) VALUES (26, N'Lê Văn Hữu', NULL, NULL, NULL, N'456 Nguy?n Hu?, TP. H? Chí Minh', N'Online', CAST(1549845005 AS Decimal(18, 0)), 2)
SET IDENTITY_INSERT [dbo].[Payment] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (1, N'Chạo tôm cuốn dừa', N'Tựa một cuốn hồi ký về ẩm thực độc đáo của vùng đất Hà Thành. Nguyên liệu chính gồm bì lợn, thịt lợn, cùi dừa, tôm và bánh đa nem. Bì lợn, thịt lợn và cùi dừa được cắt mỏng và cuốn trong bánh đa nem, sau đó trang trí với lát tôm tươi ngon.', CAST(155000.00 AS Decimal(18, 2)), 100, N'MonAn(01).jpg', 1, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, 5, 4)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (2, N'Súp Cua', N'Súp cua là món khai vị thơm ngon với sự kết hợp tinh tế giữa thịt cua tươi, trứng cút, và nước dùng đậm đà. Món này không chỉ bổ dưỡng mà còn mang lại cảm giác ấm áp, rất thích hợp trong các bữa tiệc hay những ngày se lạnh.', CAST(55000.00 AS Decimal(18, 2)), 15, N'MonAn(02).jpg', 1, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, 4, 3)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (3, N'Rau diếp cuốn tôm đồng', N'Được chế biến từ rau diếp cuốn cùng tôm đồng tươi ngon. Món ăn này mang hương vị ngọt tự nhiên của tôm kết hợp với vị xanh mát và giòn của rau diếp cuốn. Đây thực sự là một món ngon, dinh dưỡng và tươi ngon, thường được ưa chuộng trong các bữa ăn gia đình và những dịp lễ tết các vùng quê miền Bắc Việt Nam.', CAST(155000.00 AS Decimal(18, 2)), 50, N'MonAn(03).jpg', 1, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (4, N'Chạo su hào sợi', N'Là món ăn truyền thống với nguyên liệu chính là su hào được thái thành sợi và thính gạo rang, cùng với gia vị đặc biệt. Món ăn này có hương vị giòn giòn, thơm ngon và dinh dưỡng từ su hào, cùng với lớp thính gạo thơm béo, tạo cảm giác ăn hấp dẫn.', CAST(85000.00 AS Decimal(18, 2)), 30, N'MonAn(04).jpg', 1, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (5, N'Rau muống chẻ muối vừng', N'Rau muống tươi ngon được chẻ nhỏ và kết hợp với muối vừng thơm ngon. Món ăn đơn giản trong cách chế biến, nhưng lại độc đáo trong hương vị. Rau muống cung cấp chất xơ và dinh dưỡng, trong khi muối vừng làm cho món ăn thêm hấp dẫn.', CAST(125000.00 AS Decimal(18, 2)), 70, N'MonAn(05).jpg', 1, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (6, N'Hoa chuối xào mẻ', N'Một món ngon của miền Bắc, được làm từ hoa chuối tươi ngon, giữ độ tươi mềm và màu sắc tươi sáng khi xào chín. Mùi vị độc đáo và dinh dưỡng đậm đà của món ăn này thường xuất hiện trong các bữa cơm gia đình, thể hiện bản sắc ẩm thực truyền thống của Việt Nam.', CAST(150000.00 AS Decimal(18, 2)), 80, N'MonAn(06).jpg', 1, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (7, N'Nộm măng tai lợn', N'Món ngon truyền thống được chế biến từ măng tre và tai lợn luộc, hấp dẫn và đậm đà. Món này cung cấp cả sự tươi ngon và bổ dưỡng với măng giàu chất xơ và vitamin cùng với protein từ tai lợn, tạo nên một bữa ăn cân đối và ngon miệng.', CAST(135000.00 AS Decimal(18, 2)), 60, N'MonAn(07).jpg', 1, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (8, N'Lươn cuốn mỡ chài', N'Lươn cuốn mỡ chài là một hương vị độc đáo xuất phát từ vùng Bắc Việt Nam. Lươn tươi ngon, sau khi ướp gia vị, được cuốn bọc trong lớp mỡ chài mỏng và trong suốt. Nướng chín đều trên lửa than, món ăn tạo ra lớp vỏ vàng óng kết hợp với mùi thơm quyến rũ, vị béo gậy từ lươn và mỡ chài tạo nên sự đặc biệt cho món ăn.', CAST(185000.00 AS Decimal(18, 2)), 60, N'MonAn(08).jpg', 1, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (9, N'Gỏi bò bóp thấu', N'Món ẩm thực độc đáo của Việt Nam, thể hiện sự kết hợp tinh tế giữa thịt bò thăn, khế chua, quả chuối xanh, hành tây, cá rau thơm và gia vị. Thịt bò thăn tươi ngon đem lại hương vị ngọt, khế chua thêm vị chua chua và chát, trong khi quả chuối xanh và hành tây giòn giòn. Điểm đặc biệt của món ăn này chính là sự hòa quyện độc đáo của vị chua và vị ngọt, tạo nên một trải nghiệm ẩm thực thú vị.', CAST(155000.00 AS Decimal(18, 2)), 60, N'MonAn(09).jpg', 1, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (10, N'Chả ốc xưa nướng lá chuối', N'Một món ăn độc đáo, chế biến từ ốc nhồi tự nhiên, kết hợp cùng thịt băm, và sau đó bọc trong lá chuối trước khi nướng trên than hoa. Món ăn này mang trong mình hương vị truyền thống với sự khác biệt là cách chế biến nguyên bản từ thời xưa, không kết hợp với nguyên liệu hiện đại và được bọc lá chuối rồi nướng trên than hoa.', CAST(185000.00 AS Decimal(18, 2)), 60, N'MonAn(10).jpg', 1, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (11, N'Cá trắm kho chuối xanh', N'Một món ăn truyền thống của Việt Nam, nổi tiếng với sự kết hợp hương vị tuyệt vời giữa cá trắm tươi ngon và chuối xanh mềm mại. Cá trắm được kho trong gia vị trong hơn 10 giờ, giữ được hương thơm của chuối xanh và gia vị, tạo ra một món ăn độc đáo, bắt mắt và thơm ngon. Món ăn này thường được thưởng thức cùng với cơm trắng, tạo nên một trải nghiệm ẩm thực đặc biệt.', CAST(315000.00 AS Decimal(18, 2)), 60, N'MonAn(11).jpg', 2, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (12, N'Cá rô đồng kho khế', N'Món ăn làm từ cá rô đồng và quả khế chua. Món ăn này là sự kết hợp hài hòa giữa vị ngọt và chua của khế và hương vị thơm ngon của cá. Trong quá khứ, quả khế thường được hái từ vườn nhà và được sử dụng rộng rãi trong các gia đình ở phía Bắc Việt Nam. “Cá rô đồng kho khế” không chỉ là một món ăn ngon mà còn là biểu hiện của sự sáng tạo và tận dụng nguyên liệu địa phương trong ẩm thực Việt Nam.', CAST(185000.00 AS Decimal(18, 2)), 60, N'MonAn(12).jpg', 2, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (13, N'Cá diếc kho tương', N'Là một món ăn ngon của Việt Nam, được nấu từ cá diếc và tương bần, một loại tương đặc biệt từ đậu tương ủ lên men. Món ăn này không chỉ thơm ngon với vị đậm đà của tương và cá, mà còn mang theo mình những ký ức về gia đình và thời thơ ấu khi cuộc sống còn khó khăn. Khi nếm món “Cá diếc kho tương”, người ta không chỉ cảm nhận hương vị ngon mà còn nhớ về tình yêu thương và sự quan tâm từ người thân.', CAST(165000.00 AS Decimal(18, 2)), 60, N'MonAn(13).jpg', 2, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (14, N'Chạch đồng kho tiêu', N'Chạch, một loại cá dưới nước còn được gọi là Thu Ngư. Món ăn này kết hợp Chạch với tiêu, tạo nên hương vị độc đáo. Thức ăn này có tác dụng bổ khí huyết, giúp tăng cường sức kháng và thanh nhiệt, đồng thời hỗ trợ trong việc điều trị các bệnh về mật, tụy. Món “Chạch đồng kho tiêu” không chỉ ngon miệng mà còn mang lại nhiều lợi ích đối với sức khỏe và đã trở thành một phần quan trọng trong ẩm thực đa dạng của Việt Nam.', CAST(195000.00 AS Decimal(18, 2)), 60, N'MonAn(14).jpg', 2, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (15, N'Cá trắm kho riềng', N'Món ăn gợi nhớ ký ức sâu sắc của miền đồng bằng Bắc Bộ. Trong những ngày mưa lạnh, thưởng thức một bữa cơm nóng với cá kho là điều tuyệt vời. Cá trắm kho riềng thơm ngon và đặc biệt, khi ăn, bạn sẽ cảm nhận từng miếng thịt cá thấm đẫm gia vị kết hợp với mùi thơm hấp dẫn của riềng. Món ăn này cung cấp cả hương vị và dưỡng chất tốt cho cơ thể. Điều đặc biệt, theo Đông y, cá trắm còn có tác dụng bổ tỳ vị, khí huyết, thích hợp cho những người có triệu chứng biếng ăn, mệt mỏi.', CAST(365000.00 AS Decimal(18, 2)), 60, N'MonAn(15).jpg', 2, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (16, N'Cá trắm đen kho cúc tần', N'Là một món ăn độc đáo được làm từ khúc cá trắm đen, loài cá sống sâu dưới nước và ưa ăn cỏ. Chúng được kho cùng với rau cúc tần, một loại cây chỉ mọc tự nhiên và có giá trị trong y học cổ truyền. Món ăn này yêu cầu thời gian nấu lâu dưới lửa nhỏ, thường kéo dài hơn 10 giờ. Sự kết hợp độc đáo giữa cá trắm đen và rau cúc tần không chỉ tạo ra một trải nghiệm ẩm thực đặc biệt mà còn mang lại nhiều lợi ích cho sức khỏe, đặc biệt là cho những người có vấn đề về sức khỏe như cảm lạnh, đau đầu và các tình trạng tương tự.', CAST(225000.00 AS Decimal(18, 2)), 60, N'MonAn(16).jpg', 2, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (17, N'Cá quả kho tộ', N'Món ăn nổi tiếng với việc sử dụng cá quả đồng, thịt ngon và chắc chắn, được nấu trong niêu đất. Quá trình nấu món này cầu kỳ và đòi hỏi kiên nhẫn. Thịt cá quả được ướp gia vị và nấu lên bằng lửa nhỏ trong thời gian dài để thịt trở nên mềm mịn và thơm ngon.', CAST(185000.00 AS Decimal(18, 2)), 60, N'MonAn(17).jpg', 2, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (18, N'Cá trê đồng om mẻ', N'Một món ăn truyền thống với nguyên liệu chính là cá trê đồng, một loại cá tự nhiên vẻ ngoại hình vàng óng. Món ăn này đặc trưng với việc om cá trê bằng mẻ, một loại gia vị truyền thống có lịch sử lâu đời ở miền Bắc Việt Nam. Sự kết hợp này tạo nên một hương vị đặc trưng với sự thơm ngon, béo ngậy từ thịt cá trê và vị thanh chua từ mẻ, mang đến một trải nghiệm ẩm thực độc đáo và lạ miệng.', CAST(185000.00 AS Decimal(18, 2)), 60, N'MonAn(18).jpg', 2, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (19, N'Đậu que xào ruốc tôm', N'Món ăn này thường là một phần không thể thiếu trong văn hóa ẩm thực của người Bắc Việt Nam, nó mang đến những hồi ức sâu sắc và những trải nghiệm đáng nhớ. Đậu que giòn và ruốc tôm tươi ngon, cùng với hương vị đặc biệt, tạo nên một hương vị độc đáo và lôi cuốn.', CAST(125000.00 AS Decimal(18, 2)), 60, N'MonAn(19).jpg', 3, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (20, N'Bầu luộc chấm muối vừng', N'Là món ăn đơn giản của Việt Nam. Bầu tươi ngon luộc chín vừa, giữ độ giòn tự nhiên và kèm theo muối vừng thơm ngon. Món này thường mang lại cảm giác thanh mát và thường xuất hiện trong những bữa cơm gia đình, là biểu tượng của hương vị quê hương.', CAST(75000.00 AS Decimal(18, 2)), 60, N'MonAn(20).jpg', 3, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (21, N'Cà tím om nồi đất', N'Món ăn truyền thống, thường được nấu trong nồi đất để bắt kịp hương vị tự nhiên của cà tím và các nguyên liệu khác. Cà tím được ướp gia vị và hấp thụ hương vị từ nồi đất, tạo ra một món ăn độc đáo và thơm ngon. Món này thường được thưởng thức trong các bữa cơm gia đình và dịp đặc biệt, mang lại cảm giác ấm áp và thú vị.', CAST(155000.00 AS Decimal(18, 2)), 60, N'MonAn(21).jpg', 3, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (22, N'Rau muống xào tỏi', N'Rau muống tươi ngon được xào cùng tỏi thơm, mang đến hương vị đơn giản và ngon miệng. Món ăn này cung cấp chất xơ và dinh dưỡng từ rau muống, tạo cảm giác thanh mát và ngon lành.', CAST(85000.00 AS Decimal(18, 2)), 60, N'MonAn(22).jpg', 3, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (23, N'Rau muống luộc chấm tương bần', N'Một món ăn đơn giản nhưng ngon miệng trong ẩm thực Việt Nam. Rau muống tươi ngon được luộc chín tới, giữ nguyên độ xanh giòn, và đi kèm với tương bần đậm đà.', CAST(75000.00 AS Decimal(18, 2)), 60, N'MonAn(23).jpg', 3, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (24, N'Củ cải xào trứng', N'Là món ăn truyền thống phổ biến ở phía Bắc Việt Nam. Món này sử dụng củ cải tươi ngon kết hợp với trứng gà. Chế biến đơn giản, mang đến hương vị độc đáo và dinh dưỡng.', CAST(85000.00 AS Decimal(18, 2)), 60, N'MonAn(24).jpg', 3, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (25, N'Mướp hương xào mề gà', N'Hòa quyện hương vị tươi ngon của mướp hương và thịt mề gà, món ăn này là điểm nhấn đầy dinh dưỡng trong ẩm thực Bắc Việt. Chất ngọt tự nhiên, sự mềm mịn của thịt gà làm nổi bật bữa cơm gia đình và những bữa tiệc truyền thống.', CAST(115000.00 AS Decimal(18, 2)), 60, N'MonAn(25).jpg', 3, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (26, N'Dưa chua xào tóp mỡ', N'Món này thường được làm từ dưa chua tự nhiên phối hợp cùng tóp mỡ, một loại thịt thường được chế biến từ bụng lợn. Dưa chua xào tóp mỡ mang hương vị độc đáo, vừa chua, vừa ngọt, và có sự thêm vào từ mỡ béo. Món ăn này thường được thưởng thức làm món ăn nhẹ trong các bữa ăn truyền thống và bữa nhậu tại Việt Nam, mang lại trải nghiệm vị giác thú vị và ngon miệng.', CAST(115000.00 AS Decimal(18, 2)), 60, N'MonAn(26).jpg', 3, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (27, N'Rau lang xào tỏi', N'Nguyên liệu chính của món này là rau lang tươi ngon, thường được chế biến từ các loại rau lang phổ biến ở Việt Nam. Rau lang được xào chín tới với mùi tỏi thơm phức, tạo ra một món ăn độc đáo và hấp dẫn. Món này là nguồn cung cấp chất xơ và vitamin cần thiết cho sức khỏe và thường được ưa chuộng trong bữa ăn gia đình Việt Nam.', CAST(85000.00 AS Decimal(18, 2)), 60, N'MonAn(27).jpg', 3, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (28, N'Rau lang luộc chấm tương', N'Món ăn gợi lên hương vị quê hương với rau lang tươi ngon và tương đậm đà. Món ăn đơn giản này kết nối với ký ức ấm áp và hoài niệm của tuổi thơ. Rau lang mềm mại và tương thơm ngon tạo nên sự kết hợp ngon lành, đánh thức ký ức và cảm xúc của quê hương.', CAST(75000.00 AS Decimal(18, 2)), 60, N'MonAn(28).jpg', 3, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (29, N'Bánh Bao Chay', N'Bánh bao chay là món ăn đơn giản nhưng vô cùng hấp dẫn, với nhân đậu xanh, nấm, và rau củ được làm từ nguyên liệu hoàn toàn tự nhiên. Bánh bao mềm, mịn, kết hợp với hương vị ngọt dịu của nhân tạo cảm giác dễ chịu khi thưởng thức.', CAST(40000.00 AS Decimal(18, 2)), 80, N'MonAn(29).jpg', 3, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (30, N'Súp Nấm Chay', N'Súp nấm chay là món súp thanh mát, nhẹ nhàng nhưng đầy hương vị. Nấm tươi được nấu cùng với nước dùng từ rau củ, mang lại một hương vị đậm đà mà không hề béo ngậy. Đây là lựa chọn lý tưởng cho những ai yêu thích các món ăn nhẹ và thanh đạm.', CAST(50000.00 AS Decimal(18, 2)), 60, N'MonAn(30).jpg', 5, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (31, N'Chè Sắn Nóng', N'Chè sắn nóng là món tráng miệng truyền thống, làm từ miếng sắn nhỏ thái vuông. Món ăn kết hợp sự mềm mịn của khoai sắn, vị ngọt tự nhiên, và hương thơm của đường nâu. Chè sắn nóng là lựa chọn ấm áp, mang lại cảm giác gần gũi cho những ngày lạnh.', CAST(65000.00 AS Decimal(18, 2)), 60, N'MonAn(31).jpg', 4, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (32, N'Cốm xào dừa', N'Là một món ăn truyền thống đậm đà hương vị Việt. Với cốm mộc và nước dừa tươi ngon, món ăn tạo nên hương vị ngọt ngào, dẻo, và đượm đà vị cốm. Sự tâm huyết và công phu trong quá trình chế biến khiến “cốm xào dừa” trở thành món ăn vừa thi vị vừa độc đáo.', CAST(135000.00 AS Decimal(18, 2)), 60, N'MonAn(32).jpg', 4, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (33, N'Chè Ba Màu', N'Món chè gồm ba màu sắc đẹp mắt được làm từ các nguyên liệu tự nhiên như đậu xanh, đậu đỏ và bột báng. Chè ba màu không chỉ ngon mà còn rất bắt mắt, tạo cảm giác hấp dẫn ngay từ cái nhìn đầu tiên. Đây là món ăn phổ biến trong các dịp lễ hội hoặc tiệc tùng.', CAST(80000.00 AS Decimal(18, 2)), 50, N'MonAn(33).jpg', 4, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (34, N'Chè Khúc Bạch', N'Chè Khúc Bạch là món chè nổi tiếng với những viên chè trắng, mềm mịn kết hợp với hạnh nhân và vải tươi. Món chè này mang đến hương vị thanh tao, ngọt nhẹ, rất thích hợp cho những ngày hè nóng nực.', CAST(100000.00 AS Decimal(18, 2)), 50, N'MonAn(34).jpg', 4, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (35, N'Chè Bưởi', N'Món chè với thành phần chủ yếu là cùi bưởi, đường và nước cốt dừa, chè bưởi mang lại vị ngọt mát, thơm ngon và rất dễ ăn. Món này nổi tiếng trong các khu vực miền Nam Việt Nam, là sự kết hợp hoàn hảo giữa vị ngọt của đường và vị thơm đặc trưng của bưởi.', CAST(90000.00 AS Decimal(18, 2)), 50, N'MonAn(35).jpg', 4, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (36, N'Chè Sen', N'Món chè sen được chế biến từ hạt sen tươi, kết hợp với nước cốt dừa béo ngậy, mang đến một hương vị thanh mát, nhẹ nhàng. Chè sen không quá ngọt, rất thích hợp cho những ai yêu thích sự tinh tế của món tráng miệng.', CAST(75000.00 AS Decimal(18, 2)), 60, N'MonAn(36).jpg', 4, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (37, N'Chè Đỗ Đen', N'Món tráng miệng truyền thống trong mùa đông Việt. Hạt đỗ đen trồng tại nhà sau khi ninh kỹ và kết hợp cùng đường nâu tạo ra hương vị độc đáo. Với màu đen đặc trưng và hương thơm đặc biệt, chè đem lại cảm giác ấm áp và dịu dàng, phản ánh tình yêu cho ẩm thực truyền thống và gia đình.', CAST(65000.00 AS Decimal(18, 2)), 60, N'MonAn(37).jpg', 4, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (38, N'Lẩu Ếch', N'Lẩu ếch là món ăn đặc biệt với sự kết hợp hoàn hảo giữa thịt ếch dai ngon và nước lẩu chua cay đậm đà. Thịt ếch được tẩm ướp kỹ lưỡng, nấu cùng các loại rau và nấm tươi, mang lại trải nghiệm ẩm thực phong phú và ấm áp, phù hợp cho những bữa ăn gia đình hoặc bạn bè.', CAST(350000.00 AS Decimal(18, 2)), 90, N'MonAn(38).jpg', 5, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (39, N'Phở Bò Đặc Biệt', N'Món ăn quốc hồn quốc túy của Việt Nam, phở bò với nước dùng thơm ngon từ xương hầm, kết hợp cùng bánh phở mềm và thịt bò tươi. Món ăn mang đậm hương vị truyền thống, phù hợp cho mọi bữa ăn.', CAST(65000.00 AS Decimal(18, 2)), 30, N'MonAn(39).jpg', 5, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (40, N'Gỏi Cuốn', N'Món ăn thanh mát và lành mạnh với bánh tráng cuốn tôm, thịt luộc, bún, và rau sống. Gỏi cuốn được ăn kèm nước chấm đậm đà, mang lại hương vị nhẹ nhàng và tươi ngon.', CAST(40000.00 AS Decimal(18, 2)), 10, N'MonAn(40).jpg', 5, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (41, N'Gà Nướng Lu', N'Món ăn độc đáo với gà được nướng trong lu đất, giữ nguyên độ mềm ngọt và thơm lừng. Gà được tẩm ướp gia vị truyền thống, nướng đến khi lớp da giòn rụm, thịt bên trong vẫn mềm mọng. Đây là món ăn lý tưởng cho các buổi tiệc hoặc họp mặt gia đình.', CAST(320000.00 AS Decimal(18, 2)), 90, N'MonAn(41).jpg', 5, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (42, N'Cơm Lam Tây Nguyên', N'Món cơm lam được nấu trong ống tre, thơm mùi nếp và tre nứa. Cơm lam thường ăn kèm thịt nướng, mang lại trải nghiệm ẩm thực độc đáo của vùng cao nguyên Việt Nam.', CAST(65000.00 AS Decimal(18, 2)), 50, N'MonAn(42).jpg', 5, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (43, N'Trà Khói', N'Sự hòa quyện giữa trà mạn và hương vị khói đặc biệt từ sao tạo. Vị đắng của trà mạn và vị khói độc đáo kết hợp hoàn hảo, tạo nên một trải nghiệm hương vị độc lạ và thú vị.', CAST(75000.00 AS Decimal(18, 2)), 60, N'MonAn(43).jpg', 6, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (44, N'Tía Tô Thiên Hương', N'Kết hợp giản dị của lá tía tô tím, chanh vàng và mật ong, tạo nên một hương vị tươi mát và độc đáo. Món đồ uống này thể hiện sự tinh tế trong sự giản dị, và mang đến một trải nghiệm thú vị cho vị giác của bạn.', CAST(75000.00 AS Decimal(18, 2)), 60, N'MonAn(44).jpg', 6, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (45, N'Nước đỗ đen rang hạt sen hương chuối', N'Nước đỗ đen rang hạt sen hương chuối là một thức uống truyền thống độc đáo. Trong ly nước, bạn sẽ thấy màu đen của đỗ đen hòa quyện với màu vàng của hạt sen, tạo nên một sự kết hợp màu sắc đẹp mắt. Hương thơm của hạt sen và hương chuối kết hợp với vị đặc trưng của đỗ đen tạo nên một hương vị thanh mát. Nước đỗ đen rang hạt sen hương chuối mang đến cảm giác tươi mát, là lựa chọn tuyệt vời để thưởng thức một thức uống truyền thống và thư giãn sau một ngày dài.', CAST(75000.00 AS Decimal(18, 2)), 60, N'MonAn(45).jpg', 6, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (46, N'Nước cóc muối tôm', N'Nước cóc tươi ngon, ngọt mát, thêm một chút muối tôm quanh miệng cốc. Món này kết hợp giữa hương vị ngọt ngon và mặn, tạo ra trải nghiệm vị giác độc đáo. Muối tôm tạo thêm hương vị đậm đà và hấp dẫn cho nước cóc, khiến nó trở nên tươi mát và thú vị hơn, là lựa chọn hoàn hảo trong ngày nắng nóng.', CAST(85000.00 AS Decimal(18, 2)), 60, N'MonAn(46).jpg', 6, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (47, N'Mía Muối Hương Việt', N'Hòa quyện vị ngọt tự nhiên và hậu vị muối. Được chế biến từ nước ép cây mía tươi ngon và omai muối nhẹ, đồ uống này đem đến trải nghiệm vị giác tinh tế. Vị ngọt tự nhiên của mía kết hợp hoàn hảo với hậu vị muối mặn mà, mang lại sự hài lòng và sảng khoái cho mỗi giọt nước uống.', CAST(70000.00 AS Decimal(18, 2)), 60, N'MonAn(47).jpg', 6, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (48, N'Bia Hà Nội Sấu Non', N'Là một sự kết hợp tinh tế giữa bia Hà Nội và quả sấu non. Màu xanh của sấu non kết hợp với lớp bọt mịn của bia tạo ra một hình ảnh đẹp mắt. Mùi hương của sấu non thoang thoảng, khiến bạn cảm nhận sự tươi mát từ quả sấu. Bia Hà Nội Sấu Non là sự hòa quyện tinh tế giữa truyền thống và sáng tạo, là lựa chọn tuyệt vời để thư giãn và tận hưởng trong những buổi hẹn hò hay buổi tiệc cùng bạn bè.', CAST(95000.00 AS Decimal(18, 2)), 60, N'MonAn(48).jpg', 6, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (49, N'Trà Tắc', N'Trà tắc là thức uống thanh mát với sự hòa quyện giữa trà xanh thơm nhẹ và vị chua ngọt tự nhiên của trái tắc. Đây là lựa chọn hoàn hảo để giải nhiệt và bổ sung năng lượng cho những ngày nóng bức.', CAST(35000.00 AS Decimal(18, 2)), 5, N'MonAn(49).jpg', 6, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (50, N'Nước ép dứa', N'Nước ép dứa tươi là thức uống giải nhiệt tuyệt vời với hương vị ngọt thanh, chua nhẹ, mang lại cảm giác mát lạnh, sảng khoái. Đây là lựa chọn lý tưởng cho những ngày hè oi bức, giúp bổ sung vitamin C và làm dịu cơ thể.', CAST(50000.00 AS Decimal(18, 2)), 80, N'MonAn(50).jpg', 6, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductId], [Name], [Description], [Price], [Quantity], [ImageUrl], [CategoryId], [IsActive], [CreateDate], [Review], [idReview], [Rating]) VALUES (51, N'Nước ép cà rốt', N'Nước ép cà rốt tươi chứa nhiều vitamin A, giúp sáng mắt và đẹp da. Vị ngọt tự nhiên của cà rốt kết hợp với một chút chua của chanh tạo nên thức uống thanh mát, bổ dưỡng và cực kỳ tốt cho sức khỏe.', CAST(45000.00 AS Decimal(18, 2)), 100, N'MonAn(51).jpg', 6, 1, CAST(N'2024-11-17T22:54:05.113' AS DateTime), NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[Reviews] ON 

INSERT [dbo].[Reviews] ([ReviewId], [ProductId], [UserId], [Rating], [Comment], [CreatedDate]) VALUES (1, 2, 2, 4, N'đ', CAST(N'2024-11-20T01:33:56.887' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewId], [ProductId], [UserId], [Rating], [Comment], [CreatedDate]) VALUES (2, 2, 2, 2, N'dfg', CAST(N'2024-11-20T01:42:54.957' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewId], [ProductId], [UserId], [Rating], [Comment], [CreatedDate]) VALUES (3, 1, 2, 2, N'fsdfs', CAST(N'2024-11-20T01:46:06.643' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewId], [ProductId], [UserId], [Rating], [Comment], [CreatedDate]) VALUES (4, 1, 2, 2, N'đfsdfsdf', CAST(N'2024-11-20T01:49:10.310' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewId], [ProductId], [UserId], [Rating], [Comment], [CreatedDate]) VALUES (5, 2, 2, 3, N'dâsd', CAST(N'2024-11-20T01:51:45.893' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewId], [ProductId], [UserId], [Rating], [Comment], [CreatedDate]) VALUES (6, 2, 2, 4, N'fsdfsdfsđfssd', CAST(N'2024-11-20T02:06:12.453' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewId], [ProductId], [UserId], [Rating], [Comment], [CreatedDate]) VALUES (7, 1, 2, 5, N'gggg', CAST(N'2024-11-20T02:11:49.183' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewId], [ProductId], [UserId], [Rating], [Comment], [CreatedDate]) VALUES (8, 1, 2, 4, N'gfdgdg', CAST(N'2024-11-20T02:15:01.883' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewId], [ProductId], [UserId], [Rating], [Comment], [CreatedDate]) VALUES (9, 1, 2, 5, N'ngpn vcllll', CAST(N'2024-11-20T02:20:38.813' AS DateTime))
SET IDENTITY_INSERT [dbo].[Reviews] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserId], [Name], [Username], [Mobile], [Email], [Address], [PostCode], [Password], [ImageUrl], [CreateDate]) VALUES (1, N'Nguyễn Thị Minh Anh', N'nguyenminhanh', N'0912345678', N'minhanh@gmail.com', N'123 Đường Láng, Hà Nội', N'100000', N'password123', N'NguoiDung(01).jpg', CAST(N'2024-11-17T22:54:05.097' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Name], [Username], [Mobile], [Email], [Address], [PostCode], [Password], [ImageUrl], [CreateDate]) VALUES (2, N'Lê Văn Hữu', N'levanhuu', N'0987654321', N'huu.le@gmail.com', N'456 Nguyễn Huệ, TP. Hồ Chí Minh', N'700000', N'password123', N'NguoiDung(02).jpg', CAST(N'2024-11-17T22:54:05.097' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Name], [Username], [Mobile], [Email], [Address], [PostCode], [Password], [ImageUrl], [CreateDate]) VALUES (3, N'Trần Thị Ngọc Lan', N'tranngoclan', N'0909123456', N'ngoclan@gmail.com', N'789 Trần Hưng Đạo, Đà Nẵng', N'550000', N'password123', N'NguoiDung(03).jpg', CAST(N'2024-11-17T22:54:05.097' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Name], [Username], [Mobile], [Email], [Address], [PostCode], [Password], [ImageUrl], [CreateDate]) VALUES (4, N'Phạm Quốc Đạt', N'phamquocdat', N'0934567890', N'dat.pham@gmail.com', N'12 Lê Lợi, Huế', N'530000', N'password123', N'NguoiDung(04).jpg', CAST(N'2024-11-17T22:54:05.097' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Name], [Username], [Mobile], [Email], [Address], [PostCode], [Password], [ImageUrl], [CreateDate]) VALUES (5, N'Huỳnh Thanh Phong', N'huynhphong', N'0961234567', N'phong.huynh@gmail.com', N'34 Nguyễn Trãi, Hải Phòng', N'180000', N'password123', N'NguoiDung(05).jpg', CAST(N'2024-11-17T22:54:05.097' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Name], [Username], [Mobile], [Email], [Address], [PostCode], [Password], [ImageUrl], [CreateDate]) VALUES (6, N'Doãn Thu Hà', N'doanthuha', N'0919876543', N'thuha@gmail.com', N'56 Lý Thường Kiệt, Cần Thơ', N'900000', N'password123', N'NguoiDung(06).jpg', CAST(N'2024-11-17T22:54:05.097' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Name], [Username], [Mobile], [Email], [Address], [PostCode], [Password], [ImageUrl], [CreateDate]) VALUES (7, N'Vũ Thị Thảo', N'vuthithao', N'0981234567', N'thithao.vu@gmail.com', N'78 Phạm Văn Đồng, Nha Trang', N'570000', N'password123', N'NguoiDung(07).jpg', CAST(N'2024-11-17T22:54:05.097' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Name], [Username], [Mobile], [Email], [Address], [PostCode], [Password], [ImageUrl], [CreateDate]) VALUES (8, N'Bùi Văn Nam', N'buivannam', N'0976543210', N'nam.bui@gmail.com', N'90 Trần Phú, Vũng Tàu', N'790000', N'password123', N'NguoiDung(08).jpg', CAST(N'2024-11-17T22:54:05.097' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Name], [Username], [Mobile], [Email], [Address], [PostCode], [Password], [ImageUrl], [CreateDate]) VALUES (9, N'Tôn Nữ Mai Hương', N'tonnuuhuong', N'0923456789', N'maihuong@gmail.com', N'123 Nguyễn Khuyến, Đà Lạt', N'670000', N'password123', N'NguoiDung(09).jpg', CAST(N'2024-11-17T22:54:05.097' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Name], [Username], [Mobile], [Email], [Address], [PostCode], [Password], [ImageUrl], [CreateDate]) VALUES (10, N'Hoàng Ngọc Bảo', N'hoangngocbao', N'0932345678', N'baongoc@gmail.com', N'456 Hai Bà Trưng, Bình Dương', N'820000', N'password123', N'NguoiDung(10).jpg', CAST(N'2024-11-17T22:54:05.097' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Name], [Username], [Mobile], [Email], [Address], [PostCode], [Password], [ImageUrl], [CreateDate]) VALUES (11, N'Tạ Quốc Bảo', N'taquocbao', N'0918765432', N'quoctbao@gmail.com', N'789 Lạc Long Quân, Đồng Nai', N'810000', N'password123', N'NguoiDung(11).jpg', CAST(N'2024-11-17T22:54:05.097' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Name], [Username], [Mobile], [Email], [Address], [PostCode], [Password], [ImageUrl], [CreateDate]) VALUES (12, N'Lý Thị Hoài Thương', N'lyhoaithuong', N'0907654321', N'hoaithuong@gmail.com', N'12 Hoàng Hoa Thám, Quảng Ninh', N'200000', N'password123', N'NguoiDung(12).jpg', CAST(N'2024-11-17T22:54:05.097' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Name], [Username], [Mobile], [Email], [Address], [PostCode], [Password], [ImageUrl], [CreateDate]) VALUES (13, N'Phan Thị Kim Yến', N'phankimyen', N'0988765432', N'kimyen@gmail.com', N'34 Cách Mạng Tháng 8, Bình Phước', N'830000', N'password123', N'NguoiDung(13).jpg', CAST(N'2024-11-17T22:54:05.097' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Name], [Username], [Mobile], [Email], [Address], [PostCode], [Password], [ImageUrl], [CreateDate]) VALUES (14, N'Doãn Văn Khôi', N'doanvankhoi', N'0929876543', N'khoi.doan@gmail.com', N'56 Phan Đăng Lưu, Thanh Hóa', N'440000', N'password123', N'NguoiDung(14).jpg', CAST(N'2024-11-17T22:54:05.097' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Name], [Username], [Mobile], [Email], [Address], [PostCode], [Password], [ImageUrl], [CreateDate]) VALUES (15, N'Nguyễn Bảo Trâm', N'nguyenbaotram', N'0912346789', N'baotram@gmail.com', N'78 Lê Quý Đôn, Hà Nam', N'300000', N'password123', N'NguoiDung(15).jpg', CAST(N'2024-11-17T22:54:05.097' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Name], [Username], [Mobile], [Email], [Address], [PostCode], [Password], [ImageUrl], [CreateDate]) VALUES (16, N'Kiều Minh Đức', N'kieuminhduc', N'0945678901', N'minhduc@gmail.com', N'90 Võ Thị Sáu, Bắc Ninh', N'220000', N'password123', N'NguoiDung(16).jpg', CAST(N'2024-11-17T22:54:05.097' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Name], [Username], [Mobile], [Email], [Address], [PostCode], [Password], [ImageUrl], [CreateDate]) VALUES (17, N'Dương Thanh Tùng', N'duongthanhtung', N'0902345678', N'thanhtung@gmail.com', N'123 Bạch Đằng, Thái Nguyên', N'250000', N'password123', N'NguoiDung(17).jpg', CAST(N'2024-11-17T22:54:05.097' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Name], [Username], [Mobile], [Email], [Address], [PostCode], [Password], [ImageUrl], [CreateDate]) VALUES (18, N'Hồ Ngọc Hiếu', N'hongochieu', N'0933456789', N'ngochieu@gmail.com', N'456 Nguyễn Văn Cừ, Bến Tre', N'930000', N'password123', N'NguoiDung(18).jpg', CAST(N'2024-11-17T22:54:05.097' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Name], [Username], [Mobile], [Email], [Address], [PostCode], [Password], [ImageUrl], [CreateDate]) VALUES (19, N'Châu Thị Bích Ngọc', N'chaubichngoc', N'0971234567', N'bichngoc@gmail.com', N'789 Tô Hiến Thành, Phú Quốc', N'920000', N'password123', N'NguoiDung(19).jpg', CAST(N'2024-11-17T22:54:05.097' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Name], [Username], [Mobile], [Email], [Address], [PostCode], [Password], [ImageUrl], [CreateDate]) VALUES (20, N'Võ Hữu Phúc', N'vohuuphuc', N'0915678902', N'huuphuc@gmail.com', N'12 Phan Chu Trinh, Quảng Nam', N'510000', N'password123', N'NguoiDung(20).jpg', CAST(N'2024-11-17T22:54:05.097' AS DateTime))
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__536C85E4CB5C9ED8]    Script Date: 20/11/2024 5:16:19 CH ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__A9D105344F5BA611]    Script Date: 20/11/2024 5:16:19 CH ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Reviews] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([ProductId])
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD CHECK  (([Rating]>=(1) AND [Rating]<=(5)))
GO
USE [master]
GO
ALTER DATABASE [Foodie] SET  READ_WRITE 
GO
