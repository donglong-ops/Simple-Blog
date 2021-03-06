USE [master]
GO
/****** Object:  Database [lab2_simple_blog]    Script Date: 9/30/2021 7:10:13 PM ******/
CREATE DATABASE [lab2_simple_blog]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'lab2_simple_blog', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\lab2_simple_blog.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'lab2_simple_blog_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\lab2_simple_blog_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [lab2_simple_blog] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [lab2_simple_blog].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [lab2_simple_blog] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [lab2_simple_blog] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [lab2_simple_blog] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [lab2_simple_blog] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [lab2_simple_blog] SET ARITHABORT OFF 
GO
ALTER DATABASE [lab2_simple_blog] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [lab2_simple_blog] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [lab2_simple_blog] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [lab2_simple_blog] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [lab2_simple_blog] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [lab2_simple_blog] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [lab2_simple_blog] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [lab2_simple_blog] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [lab2_simple_blog] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [lab2_simple_blog] SET  DISABLE_BROKER 
GO
ALTER DATABASE [lab2_simple_blog] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [lab2_simple_blog] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [lab2_simple_blog] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [lab2_simple_blog] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [lab2_simple_blog] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [lab2_simple_blog] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [lab2_simple_blog] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [lab2_simple_blog] SET RECOVERY FULL 
GO
ALTER DATABASE [lab2_simple_blog] SET  MULTI_USER 
GO
ALTER DATABASE [lab2_simple_blog] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [lab2_simple_blog] SET DB_CHAINING OFF 
GO
ALTER DATABASE [lab2_simple_blog] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [lab2_simple_blog] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [lab2_simple_blog] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [lab2_simple_blog] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'lab2_simple_blog', N'ON'
GO
ALTER DATABASE [lab2_simple_blog] SET QUERY_STORE = OFF
GO
USE [lab2_simple_blog]
GO
/****** Object:  Table [dbo].[Articles]    Script Date: 9/30/2021 7:10:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Articles](
	[PostID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](300) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[Image] [nvarchar](50) NOT NULL,
	[Date] [datetime] NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[StatusId] [int] NOT NULL,
 CONSTRAINT [PK_Articles] PRIMARY KEY CLUSTERED 
(
	[PostID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comments]    Script Date: 9/30/2021 7:10:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[CommentID] [int] IDENTITY(1,1) NOT NULL,
	[PostId] [int] NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Date] [datetime] NOT NULL,
 CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED 
(
	[CommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 9/30/2021 7:10:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Status]    Script Date: 9/30/2021 7:10:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 9/30/2021 7:10:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Email] [nvarchar](50) NOT NULL,
	[FullName] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](100) NOT NULL,
	[RoleId] [int] NOT NULL,
	[StatusId] [int] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Articles] ON 

INSERT [dbo].[Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [StatusId]) VALUES (1, N'Cafe: Good or bad?', N'The health effects of coffee consumption are controversial. In fact, coffee offers a lot of health benefits, coffee is rich in antioxidants and can reduce the risk of many diseases. However, it also contains caffeine, a stimulant that can cause problems in some people and disrupt sleep. Although the nutritional value of a cup of coffee is not much, try multiplying it by the number of cups you drink each day, it can add a significant part of the daily nutritional needs of the body.

But the most important thing is that coffee contains high levels of antioxidants.

In fact, the typical Western-style diet provides more antioxidants from coffee than from fruits and vegetables combined.', N'img/anh1.png', CAST(N'2021-09-23T00:00:00.000' AS DateTime), N'lethanhvan@fpt.com', 2)
INSERT [dbo].[Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [StatusId]) VALUES (3, N'What are sign of psychosis?', N'Hello doctor! I smoked Tobacco (weed) and now I have stopped using it, but my head often has miscellaneous thoughts, trouble sleeping, anxiety, sadness, difficulty concentrating. So the doctor asked me if this is a sign of psychosis or not?. Weed is a narcotic that affects the brain, so when you stop using it, depending on the time, dose, and effect, it will produce side effects. Therefore, to find out the exact cause, you need to see a neuropsychologist, from which the doctors will advise and have timely treatment.', N'img/anh6.jpg', CAST(N'2021-09-15T00:00:00.000' AS DateTime), N'trangcaoquynh@gmail.com', 2)
INSERT [dbo].[Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [StatusId]) VALUES (4, N'UFO appeared at the prison!', N'Recently, many inmates at HMP Verne prison have reported seeing a UFO directly above the prison. After the encounter with the foreign object, one inmate claimed he and several others developed a red rash. "I was working out, everyone else was doing their own thing, and suddenly something really weird happened."

"I spotted a hawk hovering, like it was looking for a mouse or something."', N'img/anh5.jpg', CAST(N'2021-09-16T00:00:00.000' AS DateTime), N'nhumap@gmail.com', 2)
INSERT [dbo].[Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [StatusId]) VALUES (7, N'Xu hướng đơn sắc trong thiết kế nội thất', N'Các khối màu đơn sắc kết hợp với nhau tạo cá tính cho không gian nội thất, được nhiều gia chủ, nhất là giới trẻ yêu thích.

Nội thất dành cho người trẻ thường có nhiều yếu tố sáng tạo, thông minh. Màu sắc cũng không nằm ngoài quy luật này với những cách phối màu vô cùng ấn tượng. Vậy xu hướng đơn sắc trong thiết kế nội thất dành cho người trẻ hiện tại như thế nào?

Chọn tông màu cá tính làm điểm nhấn

Trong nội thất, cùng với tư vấn của kiến trúc sư, các bạn trẻ thường chủ động quyết định màu sắc cũng như phong cách thiết kế. Quy tắc màu sắc 60 - 30 - 10 vẫn được áp dụng, tức là màu chủ đạo chiếm 60%, màu trang trí chiếm 30% và 10% còn lại là các màu làm điểm nhấn. Theo đó, đa số các chủ nhân không gian lựa chọn những tông màu đơn sắc để lấp đầy 30% màu trang trí, khiến cho căn nhà trở nên sống động và có cá tính.

Họ mạnh dạn sử dụng những tông màu mới đầy cá tính và nổi bật như vàng hay màu san hô (Coral). Bên cạnh đó, màu trung tính như ghi vẫn được yêu thích bởi mang lại cảm giác điềm tĩnh và hài hòa.', N'img/anh15.png', CAST(N'2021-09-20T00:00:00.000' AS DateTime), N'lethanhvan@fpt.com', 2)
INSERT [dbo].[Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [StatusId]) VALUES (8, N'Dinh thự đá! Gia chủ mê kiến trúc Pháp', N'Ngôi nhà tọa lạc trên khuôn viên rộng gần 17.000 m2 nằm cách trung tâm TP Đà Nẵng khoảng 10 km, được hoàn thiện năm 2019, trở thành nơi ở trốn không khí náo nhiệt của phố thị cho gia chủ. Căn nhà lấy cảm hứng từ kiến trúc Pháp, cũng là đam mê của chủ nhà. Các chi tiết như cửa vòm, tường đá, trần gỗ, đèn chùm... gợi nhớ đến những tòa lâu đài cổ. Bên trong, phòng khách là điểm nhấn quan trọng nhất. Tại đây, gia chủ bày những món đồ trang trí mang phong cách Pháp như đèn lồng, gốm sứ do chính mình sưu tầm qua nhiều năm. Một trong những điểm đặc biệt của công trình là vật liệu. Các bức tường đều được xây bằng đá núi Hòa Sơn, ốp dày từ 40 đến 50 cm. Nền nhà được đúc bằng đá vàng Thanh Hoá. Một điều đặc biệt khác là các phòng ngủ đều được bố trí cửa trượt mở về hướng Đông, nơi có một con suối chảy. Cốt nền nhà chính cao hơn nền đất tự nhiên 1,5 m vừa đem lại sự thông thoáng vừa giúp gia chủ ngắm cảnh xung quanh. Để tăng độ mát cho căn nhà, gia chủ và kiến trúc sư trồng thêm giàn dây leo tại các hành lang hướng Tây. Khu vực này cũng được tận dụng làm khu ăn uống ngoài trời. Trên khu đất còn có một hồ nuôi cá Koi. Giữa hồ là mái nhà tranh bằng khung sắt chịu lực, tre nứa cùng lá dừa và chiếc cầu tre bắc qua. Ánh sáng cũng được chăm chút. Các loại thiết bị khác nhau trải từ ngoài vào trong và từ trên xuống dưới tạo nên hiệu ứng long lanh, nhất là khi đêm xuống.', N'img/anh17.jpg', CAST(N'2021-09-17T00:00:00.000' AS DateTime), N'lethanhvan@fpt.com', 2)
INSERT [dbo].[Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [StatusId]) VALUES (9, N'Cách bày tivi đúng', N'Để xem tivi thoải mái, gia chủ cần tính toán chỗ đặt thiết bị dựa trên các yếu tố chính như kích thước, độ phân giải và ánh sáng trong phòng.

Yếu tố đầu tiên gia chủ cần xem xét là kích thước màn hình. Khoảng cách từ mắt người xem đến tivi thay đổi dựa trên chỉ số này. Màn hình tivi càng lớn, bạn càng cần ngồi xa hơn, ví dụ, tivi 32 inch nên cách 1,8 mét, tivi 60 inch con số này là 3,4 mét....

Ngoài kích thước màn hình, bạn cần biết độ phân giải của tivi. Độ phân giải càng cao, mật độ điểm ảnh càng dày, nghĩa là độ sắc nét và độ chi tiết của màn hình được cải thiện, cho phép bạn ngồi gần tivi hơn dù kích thước màn hình không thay đổi. Ánh sáng và thời gian trong ngày cũng ảnh hưởng đến việc lựa chọn vị trí lắp đặt tivi. Bạn nên để tivi ở phía tường vuông góc với cửa sổ và tuyệt đối tránh chỗ trước các khe, cửa. Mục đích là giảm hiện tượng phản xạ và đảm bảo chất lượng hình ảnh.

Góc nhìn cũng là yếu tố cần được xem xét. Theo hướng dẫn của Hiệp hội Kỹ sư Điện ảnh & Truyền hình Mỹ (SMPTE), gia chủ nên chọn chỗ ngồi sao cho màn hình tivi nên chiếm ít nhất 30 độ trong tầm nhìn.', N'img/anh14.jpg', CAST(N'2021-09-18T00:00:00.000' AS DateTime), N'hienhuynhvag@gmail.com', 2)
INSERT [dbo].[Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [StatusId]) VALUES (10, N'2 billion dollar bomber crashes', N'Satellite images show a B-2 bomber collapsing its left arm, sweeping its wings onto the grass next to the runway at Whiteman Air Force Base after an emergency landing.

The US Air Force Global Strike Command (AFGSC) on September 14 confirmed that a B-2 stealth bomber had a problem during a training flight and had to make an emergency landing at Whiteman Air Force Base in the US state. Missouri and damaged on the runway. However, the AFGSC did not specify the extent of the damage to the $2 billion stealth aircraft.

Planet Labs today released commercial satellite images taken on the morning of September 15 at Whiteman Air Force Base, showing the B-2 stealth bomber lying on its side on the grass next to the only runway of Whiteman Airport. ', N'img/anh8.jpg', CAST(N'2021-09-19T00:00:00.000' AS DateTime), N'trangcaoquynh@gmail.com', 2)
INSERT [dbo].[Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [StatusId]) VALUES (11, N'The row over vaccine mandates', N'ON SEPTEMBER 11TH 2001, when al-Qaeda attacked America, almost 3,000 people died. In response the government overhauled national security and, for better or worse, struck a new balance between liberty and security. On the 20th anniversary of 9/11 roughly 3,100 people in America died because of covid-19. Another 3,100 died on September 12th. And again on the 13th.

By our estimates, based on excess deaths, the pandemic has claimed 860,000 lives in America. Yet measures to curb the virus by mandating vaccination, which the Biden administration announced on September 9th, are being treated by senior Republicans as a terrifying affront to liberty. “This is still America,” tweeted Tate Reeves, the governor of Mississippi, “and we still believe in freedom from tyrants.” That is fatally wrong-headed. The details of the Biden mandate could be improved on, but in democracies public health sometimes requires some coercion.

', N'img/anh7.jpg', CAST(N'2021-09-17T00:00:00.000' AS DateTime), N'hienhuynhvag@gmail.com', 2)
INSERT [dbo].[Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [StatusId]) VALUES (12, N'What are sign of psychosis?', N'Hello doctor! I smoked Tobacco (weed) and now I have stopped using it, but my head often has miscellaneous thoughts, trouble sleeping, anxiety, sadness, difficulty concentrating. So the doctor asked me if this is a sign of psychosis or not?. Weed is a narcotic that affects the brain, so when you stop using it, depending on the time, dose, and effect, it will produce side effects. Therefore, to find out the exact cause, you need to see a neuropsychologist, from which the doctors will advise and have timely treatment.', N'img/anh6.jpg', CAST(N'2021-09-17T00:00:00.000' AS DateTime), N'trangcaoquynh@gmail.com', 2)
INSERT [dbo].[Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [StatusId]) VALUES (13, N'The American man tattooed more than 200 signatures on his back', N'Funky, real name Juan Matas, is a former tattoo artist, famous on social media for his pictures of his back covered with tattoos.

According to Oddity Central, Funky has at least 225 signature tattoos on his back, a recognized world record.

Initially, the man tattooed the signatures of family members, acquaintances, and friends. Later, he began to have the signatures of tattoo artists, famous actors and television personalities such as Elijah Wood, Michael J. Fox, Christopher Lloyd, Steve-O... ', N'img/anh9.jpg', CAST(N'2021-09-17T00:00:00.000' AS DateTime), N'ngoc765@gmail.com', 2)
INSERT [dbo].[Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [StatusId]) VALUES (14, N'Mẹo trang trí để đưa mùa thu vào nhà', N'Đầu tiên là khai thác và tận hưởng thiên nhiên bởi mùa thu không còn nắng chói gắt, nóng hầm hập của mùa hè.

Nếu ở nhà căn hộ trên tầng cao hoặc trên những tầng lầu, hãy kéo rèm lên cho nắng chiếu vào phòng, làm ấm lên căn phòng vốn hơi lạnh của khí thu. Nắng sẽ mang lại cảm giác vui vẻ, tràn đầy sức sống và cũng lãng mạn.

Nếu ở tầng thấp, tầng trệt và xung quanh có vườn, hay mở cửa. Những khuôn cửa được mở rộng sẽ giải phóng tầm nhìn, giúp con người gần gũi thiên nhiên, cây cỏ và thư thái, bình an. Mùa thu thường nắng ban ngày nhưng lạnh về đêm và sáng sớm nên gia chủ cần chú ý tới việc giữ ấm.

Hãy đặt những tấm thảm ở dưới bộ sofa để đỡ bị lạnh chân hay bày những chiếc gối vốn được cất đi trong mùa hè cho phòng khách. Một số loại ghế gỗ như ghế bàn ăn có thể bổ sung thêm đệm rời và việc lựa chọn hoa văn hay màu sắc đệm cũng là một cơ hội để tự trang trí nội thất cho nhà của mình. Những chỗ ngồi khác cũng có thể đặt đệm ngồi cho đỡ lạnh.', N'img/anh13.jpg', CAST(N'2021-09-17T00:00:00.000' AS DateTime), N'nhumap@gmail.com', 2)
INSERT [dbo].[Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [StatusId]) VALUES (15, N'16 năm Merkel dẫn dắt châu Âu', N'Sau 16 năm nắm quyền Thủ tướng Đức và ba thập kỷ tham gia chính trị, Anglela Merkel được xem như một "tượng đài" của châu Âu.

Cử tri Đức cuối tuần này sẽ đi bỏ phiếu bầu quốc hội liên bang (Bundestag), đánh dấu kỷ nguyên của Thủ tướng Angela Merkel sắp khép lại. Khi quyết định không tham gia cuộc bầu cử toàn quốc ngày 26/9, bà trở thành thủ tướng Đức đầu tiên rời nhiệm sở theo nguyện vọng cá nhân.

Bundestag sẽ bầu tân Thủ tướng của nước Đức. Nếu các cuộc đàm phán thành lập chính phủ mới kéo dài sau cuộc bầu cử ngày 26/9, Merkel có thể vượt qua Helmut Kohl để trở thành lãnh đạo có thời gian tại nhiệm lâu nhất của Đức.

Những người hâm mộ đã dành nhiều lời ca ngợi Merkel, từ lãnh đạo của thế giới tự do đến "thánh nữ Jeanne d''Arc đương đại", dù bà luôn từ chối nhận những danh hiệu này. Bà cũng nhiều lần được vinh danh là một trong số phụ nữ quyền lực nhất thế giới. Cựu tổng thống Mỹ Barack Obama từng mô tả Merkel là nhà lãnh đạo chính trị toàn cầu xuất sắc.

Trong sự nghiệp chính trị lâu dài của mình, Thủ tướng Merkel đã để lại một di sản phức tạp. Một số người ủng hộ phong cách chính trị khiêm tốn, đồng thuận của bà, trong khi những người khác cảm thấy bà thiếu sự táo bạo, đặc biệt là trong mối quan hệ với Nga và Trung Quốc.

Các sử gia sẽ tranh luận về ảnh hưởng của Merkel trong nhiều năm tới, nhưng có một điều chắc chắn là khi rút khỏi chính trường, bà sẽ để lại khoảng trống lớn sau một sự nghiệp chính trị kéo dài ba thập kỷ, bắt đầu từ cuối Chiến tranh Lạnh.', N'img/anh12.jpg', CAST(N'2021-09-12T00:00:00.000' AS DateTime), N'lethanhvan@fpt.com', 2)
INSERT [dbo].[Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [StatusId]) VALUES (1002, N'The North American black bear', N'The North American black bear (Ursus americanus) is a medium-sized bear native to North America. It is the continent''s smallest and most common bear species. North American black bears are omnivores with diets that vary considerably depending on the season and location. They usually live in predominantly forested areas, but leave the forest in search of food. They sometimes infiltrate communities because of the availability of food for them. Black bears often mark trees using their teeth and claws as a form of communication with other bears, a behavior common to many bear species.', N'img/anh1.jpg', CAST(N'2021-09-20T00:00:00.000' AS DateTime), N'thinhle@675@gmail.com', 2)
INSERT [dbo].[Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [StatusId]) VALUES (1003, N'Bức tranh xương cốt kỳ dị 800 năm', N'Tại Bảo tàng Cố cung (Bắc Kinh) - nơi lưu giữ hàng loạt bảo vật, tài liệu có giá trị lịch sử của Trung Quốc có một bức tranh rất nổi tiếng tên "Khô Lâu huyễn hí đồ". Bức tranh này có nguồn gốc từ thời Nam Tống, tức được vẽ cách đây khoảng 800 năm. Tác giả của bức tranh là một danh họa rất nổi tiếng thời bấy giờ là Lý Tung. 

"Khô Lâu huyễn hí đồ" được vẽ trên nền vải của một cây quạt tròn, kích cỡ không quá lớn nhưng được lưu truyền và khiến hậu thế quan tâm, vì cho đến nay, ẩn ý đằng sau bức tranh có phần kỳ dị này vẫn chưa thể giải mã. Tranh vẽ lại khung cảnh sinh hoạt, vui chơi của phụ nữ và trẻ nhỏ thời Nam Tống. Tất cả trông đều vui vẻ, yên bình, chỉ trừ bộ xương người nằm ở phía bên trái. Bộ hài cốt này đang chơi múa rối với chính một bộ hài cốt nhỏ nữa. Chi tiết trông rất đáng sợ, quỷ quái này hoàn toàn không ăn nhập với hình ảnh trẻ nhỏ nô đùa hay người mẹ đang đứng cho con bú đằng sau hài cốt. Đứa trẻ còn có vẻ như đang háo hức tiến đến để cùng chơi đùa với bộ xương.', N'img/anh10.jpg', CAST(N'2021-09-24T00:00:00.000' AS DateTime), N'thinhle@675@gmail.com', 2)
INSERT [dbo].[Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [StatusId]) VALUES (1004, N'Đà Nẵng chi 1.000 tỷ cho các gói an sinh', N'Thành phố Đà Nẵng đã ban hành 10 gói an sinh và sẽ chi thêm hơn 200 tỷ đồng để giúp đỡ hộ kinh doanh cá thể, người mất việc làm.

Ngày 24/9, ông Lương Nguyễn Minh Triết, Chủ tịch HĐND TP Đà Nẵng, cho biết đến nay thành phố đã triển khai tổng cộng 10 chính sách hỗ trợ người dân, như hỗ trợ 40.000 đồng/người/ngày cho người trong vùng cách ly y tế (trước thời điểm ngày 15/8); miễn 100% học phí cho học sinh các cấp; miễn tiền thuê mặt bằng tại các chợ truyền thống cho hơn 19.700 tiểu thương...

Trong 20 ngày người dân không ra khỏi nhà (từ 16/8 đến ngày 5/9), ngoài rau, củ, quả, mỗi hộ dân đều được nhận ít nhất 500.000 đồng (nhu yếu phẩm hoặc tiền mặt). Bao gồm 301.000 hộ dân của Đà Nẵng và 161.000 hộ dân thuê nhà, phòng trọ (người lao động, sinh viên).

"Nhờ nguồn lực tích lũy từ các giai đoạn trước nên, thành phố có nguồn dự phòng ngân sách để chống dịch và triển khai các gói an sinh xã hội, chưa phải xin ngân sách từ Trung ương", ông Triết nói, cho biết đến nay địa phương đã chi 2.500 tỷ đồng chống dịch Covid-19 (bao gồm 790 tỷ đồng cho các gói an sinh nêu trên).', N'img/anh11.jpg', CAST(N'2021-09-27T00:00:00.000' AS DateTime), N'ngoc765@gmail.com', 2)
INSERT [dbo].[Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [StatusId]) VALUES (1005, N'Những lưu ý an toàn cho bếp', N'Bếp là nơi quan trọng trong nhà, thường được chú trọng đầu tư nhưng cũng tiềm ẩn nhiều mối nguy.

Bếp là nơi dễ xảy ra hỏa hoạn, dù hầu hết các gia đình ở thành thị không dùng rơm, củi.

Điều đầu tiên các thành viên của gia đình cần nhớ là thiết bị trục trặc hoặc sơ ý trong sử dụng hoàn toàn có thể gây hỏa hoạn cho căn bếp và cả ngôi nhà. Ở mức độ nhẹ hơn, lửa và nguồn nhiệt (từ bếp, thức ăn) có thể gây bỏng cho người nấu bếp và người sử dụng không gian đó. Nhiên liệu khí gas, thứ phổ biến trong nhiều gia đình thành thị có nguy cơ cháy nổ rất cao.

Tiếp theo, căn bếp hiện đại thường quy tụ nhiều thiết bị điện. Chúng thường có công suất lớn nên việc quá tải nguồn điện trong sử dụng rất dễ xảy ra, từ đó dẫn tới chập cháy. Chưa kể, nước và độ ẩm cao hơn bình thường ở bếp có thể gây rò điện, gây nguy hiểm cho người sử dụng.

Ngoài ra, trong bếp còn có những mối nguy hiểm khác như sàn trơn trượt, các tủ treo cao dễ làm người sử dụng ngã. Nếu gia chủ không bảo quản tốt thực phẩm, bếp còn trở thành ổ côn trùng, chuột, bọ. Sử dụng nồi áp suất hay thao tác bất cẩn như làm đổ, vỡ bát đĩa... cũng có thể gây nguy hiểm trong không gian bếp.', N'img/anh16.jpg', CAST(N'2021-09-30T00:00:00.000' AS DateTime), N'ngoc765@gmail.com', 2)
INSERT [dbo].[Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [StatusId]) VALUES (1006, N'Thế Giới Di Động chạm đáy', N'Công ty cổ phần Đầu tư Thế Giới Di Động (MWG) báo cáo kết quả kinh doanh tháng 8 thấp nhất kể từ đầu năm khi hàng nghìn điểm bán đóng cửa.

Trong tháng 8, MWG có hơn 6.500 tỷ đồng doanh thu và 222 tỷ đồng lợi nhuận sau thuế. So với tháng trước, doanh thu giảm gần một phần ba trong khi lợi nhuận lùi nhẹ. Đây là tháng "đế chế" bán lẻ của ông Nguyễn Đức Tài có kết quả kinh doanh thấp nhất kể từ đầu năm. Tính từ tháng 5, doanh nghiệp này đã có 4 tháng liên tiếp sụt giảm doanh thu và lợi nhuận.

MWG gọi tháng 8 là giai đoạn "thử thách chưa từng có". Do tác động của việc giãn cách xã hội nghiêm ngặt hơn tại nhiều tỉnh, thành, khoảng 2.000 điểm bán của Thế Giới Di Động và Điện Máy Xanh trên toàn quốc phải tạm đóng cửa hoặc hạn chế bán hàng. Các cửa hàng này chiếm 70% về số lượng và đóng góp hơn 80% giá trị doanh thu của hai chuỗi trong điều kiện bình thường. Do đó, tháng 8 cũng là tháng kinh doanh thấp điểm nhất của Thế Giới Di Động và Điện Máy Xanh từ đầu năm đến nay.

Giai đoạn trước, dù hai chuỗi bán lẻ này gặp khó nhưng MWG vẫn có thể dựa vào Bách Hóa Xanh để duy trì kết quả kinh doanh ổn định. Nhưng trong tuần cuối tháng 8, một nửa số cửa hàng tại TP HCM và các tỉnh Nam bộ không được phép bán trực tiếp đã ảnh hưởng lớn đến tình hình chung toàn doanh nghiệp.

Tuy nhiên, khi so sánh lũy kế với tình hình 8 tháng năm ngoái, cả doanh thu và lợi nhuận đều có sự tăng trưởng. MWG vẫn hoàn thành 63% kế hoạch kinh doanh cả năm. Động lực đến từ việc áp dụng giải pháp công nghệ và tiết giảm nhiều chi phí để bảo vệ dòng tiền.

Hai chuỗi bán lẻ truyền thống của doanh nghiệp này chọn cách tập trung bán hàng tại các thị trường ít bị ảnh hưởng bởi dịch bệnh. Trong đó, chuỗi Điện Máy Xanh Supermini triển khai chương trình khuyến mãi trên kênh online. Các giao dịch trực tuyến đem lại hơn 1.000 tỷ đồng doanh thu trong tháng 8, tăng 26% so với cùng kỳ.', N'img/anh18.jpg', CAST(N'2021-09-30T00:00:00.000' AS DateTime), N'lethanhvan@fpt.com', 2)
INSERT [dbo].[Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [StatusId]) VALUES (1009, N'Loạt cổ phiếu ''vịt trời'' hóa ''thiên nga''', N'Hiệu ứng "Louis" giúp một loạt cổ phiếu, từ mức giá khởi điểm chỉ ngang cốc trà đá, mớ rau, vọt lên trở thành hiện tượng của sàn chứng khoán.

"Louis" không phải một thuật ngữ trong lĩnh vực chứng khoán. Cụm từ này đơn thuần là tiền tố xuất hiện trong tên một loạt doanh nghiệp, được đổi lại sau những thương vụ M&A liên quan tới Công ty cổ phần Louis Holdings (tên cũ là Công ty cổ phần Tập đoàn Louis Rice) - một doanh nghiệp hoạt động trong lĩnh vực xuất khẩu nông sản.

M&A là hoạt động thông thường trên sàn chứng khoán, nhưng điểm đặc biệt với các thương vụ liên quan tới Louis Holdings là cổ phiếu các doanh nghiệp bị thâu tóm đều tăng phi mã. Dù trước đó, những mã này thuộc nhóm penny, thị giá chỉ ngang cốc trà đá, mớ rau. Công ty cổ phần Louis Land (BII) và Công ty cổ phần Louis Capital (TGG) là ví dụ.

TGG có tên cũ là Công ty cổ phần Xây dựng và Đầu tư Trường Giang, hoạt động chính là thi công, xây lắp các công trình xây dựng. Còn BII tên ban đầu là Công ty Đầu tư và Phát triển Công nghiệp Bảo Thư, kinh doanh bất động sản khu công nghiệp. Cuối năm 2020, thị giá TGG trên sàn chứng khoán chỉ loanh quanh vùng 1.200-1.400 đồng, trong khi BII cũng không khá hơn, giao dịch ở ngưỡng 2.000-3.000 đồng.

Tuy nhiên, sự thay đổi đã diễn ra khi ông Đỗ Thành Nhân và nhóm cổ đông liên quan tới Louis Holdings xuất hiện tại những doanh nghiệp này. Chỉ trong nửa đầu năm, TGG trở lại mệnh giá còn BII tăng gấp ba lần. Nhưng con số này chưa là gì nếu so với thay đổi giá các mã này trong ba tháng gần đây.

TGG trở thành cổ phiếu tăng ấn lượng nhất HoSE khi vọt từ vùng giá 10.000 đồng lên hơn 60.000 đồng bằng một chuỗi phiên tăng trần liên tiếp, BII cũng tương tự, tăng lên mức đỉnh hơn 31.000 đồng trước khi điều chỉnh. Tính chung từ đầu năm, thị giá TGG đã tăng hơn 50 lần, còn BII tăng hơn 10 lần.', N'img/anh19.png', CAST(N'2021-09-30T00:00:00.000' AS DateTime), N'lethanhvan@fpt.com', 2)
INSERT [dbo].[Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [StatusId]) VALUES (1010, N'Ngã rẽ Logistics của cựu lãnh đạo google', N'Trước thềm 19/9 - ngày kỷ niệm 14 năm thành lập BEST Inc., đội ngũ lãnh đạo lẫn đội ngũ nhân viên đều hào hứng, quyết tâm duy trì hoạt động giao vận, đảm bảo thông suốt hàng hóa và hỗ trợ đắc lực người mua lẫn nhà bán hàng trong dịch cao điểm. Ông Johnny Chou - nhà sáng lập, Chủ tịch kiêm Giám đốc điều hành tập đoàn - được đa số nhân viên ví như "thuyền trưởng", tầm nhìn sâu rộng, lèo lái "con thuyền" BEST ra khơi, vượt mọi bão tố.

Johnny Chou khởi nghiệp từ lúc còn học ở Mỹ, có bằng Thạc sĩ liên ngành Kỹ thuật - Khoa học, Đại học Princeton. Giai đoạn 1985-1995, ông đầu quân cho phòng thí nghiệm Alcatel - Lucent Bell, giữ chức Giám đốc Cấp cao Hệ thống không dây và Kỹ thuật phần mềm. Tiếp đó ông gia nhập công ty viễn thông UTStarcom (1996-2005) tại California và trở thành chủ tịch của UTStarcom Trung Quốc.

Năm 2005-2006, ông làm việc cho Google với tư cách là Phó chủ tịch Toàn cầu và Chủ tịch khu vực Trung Quốc. Năm 2007, Johnny quyết định tạo dựng sự nghiệp riêng, tự mình làm chủ, đặt mục tiêu cụ thể trong lần đầu chạm ngõ logistics.', N'img/anh20.jpg', CAST(N'2021-10-05T00:00:00.000' AS DateTime), N'trangcaoquynh@gmail.com', 2)
INSERT [dbo].[Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [StatusId]) VALUES (1011, N'Con tàu khổng lồ có thể nâng cả tàu du lịch', N'Boka Vanguard là tàu vận tải hạng nặng bán chìm, có thể chở cả tàu du lịch nặng hơn 100.000 tấn. Xây dựng vào năm 2012, tàu Boka Vanguard dài 275 m là tàu lớn nhất loại này. Thông thường, con tàu vận chuyển các công trình dầu khí lớn ngoài khơi, nhưng đôi khi phương tiện được huy động để chở những con tàu khác như tàu du lịch Carnival Vista.

Carnival Vista là tàu lớn thứ hai trong đội tàu của công ty Carnival, có thể chở 4.000 hành khách và thủy thủ đoàn 1.500 người. Hồi tháng 7/2019, con tàu cần cứu hộ sau khi gặp trục trặc ở vùng biển Caribe. Cần trục không phải lựa chọn thích hợp khi cần nâng tàu nặng 133.500 tấn khỏi mặt nước. Cần trục lớn nhất thế giới chỉ có thể nâng khoảng 20.000 tấn, vì vậy Boka Vanguard sử dụng một phương pháp khác.

Boka Vanguard có hình dáng kỳ lạ với phần boong trung tâm dẹt và để trống hoàn toàn với 5 cấu trúc lớn giống bức tường thẳng đứng nhô lên từ bên sườn. Phòng chỉ huy và nơi sinh hoạt của thủy thủ đoàn nằm ở một cấu trúc trong số đó. Hình dáng khác thường của tàu giấu đi hệ thống két dằn phức tạp giúp tàu chìm một phần dưới nước, chỉ có phần đỉnh của các cấu trúc thẳng đứng nhô lên mặt biển. Các loại hàng hóa nổi khác nhau bao gồm cả tàu du lịch, có thể trượt lên boong tàu Boka Vanguard.', N'img/anh21.jpg', CAST(N'2021-10-01T00:00:00.000' AS DateTime), N'hienhuynhvag@gmail.com', 2)
INSERT [dbo].[Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [StatusId]) VALUES (1012, N'Trọng Hiếu tập ăn chay', N'Ca sĩ Trọng Hiếu làm quen chế độ ăn chay gần một năm qua, kết hợp chạy bộ và tập gym để duy trì thể lực.

Nam ca sĩ cho biết chuyển sang chế độ thuần chay từ tháng 10 năm ngoái đến nay. Anh nói: "Trước hết, tôi ăn chay để góp phần bảo vệ môi trường, vì tôi cho rằng ngành chăn nuôi, giết mổ gia súc, gia cầm đang phát thải một lượng khí CO2 khổng lồ. Thời gian đầu, đôi khi tôi bị chóng mặt vì cơ thể chưa quen. Tuy nhiên, khi đã thích ứng và biết điều chỉnh chế độ ăn uống hợp lý, tôi thấy sức khỏe tốt lên, thoải mái khi kết nối với thiên nhiên và trân trọng cuộc sống hơn". Theo Trọng Hiếu, để theo đuổi chế độ thuần chay cần lưu ý ăn đúng giờ, đủ chất dinh dưỡng, nạp đủ năng lượng, bổ sung chất đạm qua các thực phẩm như nấm, đậu phụ, các loại hạt và ăn nhiều bữa trong ngày. Anh cho rằng khi ăn chay, mỗi người cần "lắng nghe" cơ thể để có những lựa chọn và điều chỉnh phù hợp.

Thời dịch, sống ở Đức, ngoài ăn uống, ca sĩ tạo thói quen dậy sớm và chạy bộ 3 km mỗi ngày. Anh đặt mục tiêu chạy không quá dài để tránh hấy nản. Khi quen, anh tăng dần quãng đường. Sau khi chạy, Trọng Hiếu tập các bài tập nhỏ tại nhà, gồm 100 lần chống đẩy, 50 lần squats, 100 lần gập bụng... Theo anh, những bài tập này thúc đẩy năng lượng và tâm trạng tích cực đồng thời có thể thực hiện cả khi đi lưu diễn hoặc du lịch. Anh cũng lắp đặt một chiếc xà đơn trước cửa phòng, hàng ngày sẽ thực hiện ít nhất 40 lần đu xà.

Theo trang Healthline, cơ thể tiêu hóa thực phẩm chay nhanh hơn các món ăn có nguồn gốc động vật, vì thế các bữa ăn nhẹ là cần thiết để đáp ứng nhu cầu năng lượng, đồng thời bổ sung thêm vitamin và vi chất. Ngoài trái cây và rau củ tươi, một số loại hạt khô hay hoa quả sấy, mứt, bánh ít kcal cũng là gợi ý ăn vặt lành mạnh và tiện lợi cho người ăn chay.', N'img/anh22.jpg', CAST(N'2021-10-01T00:00:00.000' AS DateTime), N'thinhle@675@gmail.com', 2)
INSERT [dbo].[Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [StatusId]) VALUES (2007, N'The 2021 German election results', N'The centre-left Social Democrats narrowly took first place in Germanyâs federal election, with just over a quarter of the votes. Now fraught and perhaps lengthy coalition negotiations loom before a new government can be formed. In a subscriber-only live event, Zanny Minton Beddoes, The Economistâs editor-in-chief, Tom Nuttall, our Berlin bureau chief, and Joerg Lau, Die Zeitâs Foreign Policy Co-ordinator, reflect on the fragmented result and what it means for the country and its position as a leading power in Europe. You can watch the conversation in full below.', N'img/O7U3H2G2OBSV9T8.jpg', CAST(N'2021-09-30T14:04:38.607' AS DateTime), N'lanlnhse140961@fpt.edu.vn', 2)
INSERT [dbo].[Articles] ([PostID], [Title], [Description], [Image], [Date], [Email], [StatusId]) VALUES (2008, N'Reading books and its benefits?', N'Books are an inexhaustible treasure of knowledge about all areas of the lives of their predecessors, written down, told and passed on to the next generation.

Thick novels are not useless, they tell us about a character''s life, events or events, which can be a valuable lesson for us in real life.

The time to read this book will certainly be much less than the time to live and experience reality like the characters in the book. The lesson they have to go through a lifetime to learn, you can absorb through the turns of each page. So is it worth it? Not to mention books about science, domestic and foreign literature books, books about family, love, books about entrepreneurs, business, a lot.

All contain the cultural quintessence of humanity. Reading books, no matter how much or how much you read about any field, you will get experiences, no one is sure that reading a book is not necessarily successful, but great people are eager to read books. Gaining new knowledge is one of the benefits of reading.', N'img/318YC66VPISVUDD.jpg', CAST(N'2021-09-30T16:41:37.750' AS DateTime), N'lanlnhse140961@fpt.edu.vn', 2)
SET IDENTITY_INSERT [dbo].[Articles] OFF
GO
SET IDENTITY_INSERT [dbo].[Comments] ON 

INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (1, 1, N'ngon ma', N'trangcaoquynh@gmail.com', CAST(N'2021-09-25T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (2, 1, N'tot, toi uong hang ngay', N'nhumap@gmail.com', CAST(N'2021-09-16T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (3, 4, N'Toi nay quay de', N'danghuy@gmail.com', CAST(N'2021-09-16T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (4, 9, N'không có thật', N'lanlnhse140961@fpt.edu.vn', CAST(N'2021-09-16T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (5, 9, N'xạo xạo', N'nhumap@gmail.com', CAST(N'2021-09-16T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (7, 9, N'minh có thay roi', N'lethanhvan@fpt.com', CAST(N'2021-09-16T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (8, 7, N'ok nhé', N'danghuy@gmail.com', CAST(N'2021-09-16T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (9, 3, N'do tram cam ae a', N'nhumap@gmail.com', CAST(N'2021-09-16T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (10, 3, N'your article very good', N'trangcaoquynh@gmail.com', CAST(N'2021-09-16T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (11, 3, N'so.. ;))', N'levan0105@gmail.com', CAST(N'2021-09-16T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (12, 4, N'khong tin ;))', N'levan0105@gmail.com', CAST(N'2021-09-15T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (13, 4, N'so chet the a !!', N'thuxinhgai@gmail.com', CAST(N'2021-09-14T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (14, 4, N'may anh tu noi gi ge qua z', N'thinhle@675@gmail.com', CAST(N'2021-09-16T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (15, 8, N'oppp, i see that', N'levan0105@gmail.com', CAST(N'2021-09-16T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (1006, 11, N'OMG', N'lethanhvan@fpt.com', CAST(N'2021-09-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (1007, 15, N'so scare', N'lethanhvan@fpt.com', CAST(N'2021-09-21T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (1008, 15, N'dell tin', N'thinhle@675@gmail.com', CAST(N'2021-09-21T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (1009, 8, N'hay qua key oi', N'thinhle@675@gmail.com', CAST(N'2021-09-21T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (1010, 8, N'thich doc tin kieu nay', N'lanlnhse140961@fpt.edu.vn', CAST(N'2021-09-21T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (1011, 3, N'ok', N'thinhle@675@gmail.com', CAST(N'2021-09-21T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (1012, 3, N'hmmm', N'danghuy@gmail.com', CAST(N'2021-09-21T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (1013, 15, N'hai ge a', N'lethanhvan@fpt.com', CAST(N'2021-09-21T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (1014, 8, N'buon lam', N'lanlnhse140961@fpt.edu.vn', CAST(N'2021-09-21T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (1015, 11, N'tui dc tiem 2 mui roi =))', N'ngoc765@gmail.com', CAST(N'2021-09-25T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (1016, 13, N'that la nghe thuat qua =))', N'lanlnhse140961@fpt.edu.vn', CAST(N'2021-09-25T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (1017, 14, N'đẹp quá', N'lanlnhse140961@fpt.edu.vn', CAST(N'2021-09-25T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (1018, 14, N'Mình thích màu này gê <3', N'lanlnhse140961@fpt.edu.vn', CAST(N'2021-09-25T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (1019, 7, N'mau xac qua dep <3', N'lanlnhse140961@fpt.edu.vn', CAST(N'2021-09-25T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (2015, 1004, N'cam on cac anh', N'ngoc765@gmail.com', CAST(N'2021-09-30T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (2016, 1003, N'wuao', N'lanlnhse140961@fpt.edu.vn', CAST(N'2021-09-30T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (2017, 1003, N'bai hay lam', N'ngoc765@gmail.com', CAST(N'2021-09-30T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (2018, 13, N'cung dep day', N'ngoc765@gmail.com', CAST(N'2021-09-30T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (2019, 1003, N'au', N'ngoc765@gmail.com', CAST(N'2021-09-30T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (2020, 1003, N'so qua', N'nhumap@gmail.com', CAST(N'2021-09-30T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (2021, 1003, N'ma bai hay', N'nhumap@gmail.com', CAST(N'2021-09-30T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (2022, 1003, N'hello ae', N'lethanhvan@fpt.com', CAST(N'2021-09-30T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (2023, 1004, N'tot qua', N'lethanhvan@fpt.com', CAST(N'2021-09-30T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (2024, 2007, N'ok good', N'lanlnhse140961@fpt.edu.vn', CAST(N'2021-09-30T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (2025, 1005, N'hay qua', N'lethanhvan@fpt.com', CAST(N'2021-09-30T00:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostId], [Content], [Email], [Date]) VALUES (2026, 13, N'ma nhin hoi so', N'lethanhvan@fpt.com', CAST(N'2021-09-30T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Comments] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([Id], [Name]) VALUES (1, N'Admin')
INSERT [dbo].[Role] ([Id], [Name]) VALUES (2, N'Member')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[Status] ON 

INSERT [dbo].[Status] ([Id], [Name]) VALUES (1, N'New')
INSERT [dbo].[Status] ([Id], [Name]) VALUES (2, N'Active')
INSERT [dbo].[Status] ([Id], [Name]) VALUES (3, N'Deleted')
SET IDENTITY_INSERT [dbo].[Status] OFF
GO
INSERT [dbo].[Users] ([Email], [FullName], [Password], [RoleId], [StatusId]) VALUES (N'danghuy@gmail.com', N'Trần Trịnh Đăng Huy', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 2, 2)
INSERT [dbo].[Users] ([Email], [FullName], [Password], [RoleId], [StatusId]) VALUES (N'hienhuynhvag@gmail.com', N'Huỳnh Thế Hiển', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 2, 2)
INSERT [dbo].[Users] ([Email], [FullName], [Password], [RoleId], [StatusId]) VALUES (N'lanlnhse140961@fpt.edu.vn', N'Le Lan Anh', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 2, 2)
INSERT [dbo].[Users] ([Email], [FullName], [Password], [RoleId], [StatusId]) VALUES (N'lethanhvan@fpt.com', N'Thanh van', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 2, 2)
INSERT [dbo].[Users] ([Email], [FullName], [Password], [RoleId], [StatusId]) VALUES (N'levan0105@gmail.com', N'Lê Thanh Vân', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 2, 2)
INSERT [dbo].[Users] ([Email], [FullName], [Password], [RoleId], [StatusId]) VALUES (N'long', N'Đồng Hữu Long', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 1, 2)
INSERT [dbo].[Users] ([Email], [FullName], [Password], [RoleId], [StatusId]) VALUES (N'longdhse130623@fpt.edu.vn', N'Dong Huu Long', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 2, 2)
INSERT [dbo].[Users] ([Email], [FullName], [Password], [RoleId], [StatusId]) VALUES (N'ngoc765@gmail.com', N'Phung Van Ngoc', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 2, 2)
INSERT [dbo].[Users] ([Email], [FullName], [Password], [RoleId], [StatusId]) VALUES (N'nhumap@gmail.com', N'Nguyễn Ngọc Quỳnh Như', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 2, 2)
INSERT [dbo].[Users] ([Email], [FullName], [Password], [RoleId], [StatusId]) VALUES (N'thinhle@675@gmail.com', N'Lê Đức Thịnh', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 2, 2)
INSERT [dbo].[Users] ([Email], [FullName], [Password], [RoleId], [StatusId]) VALUES (N'thuxinhgai@gmail.com', N'Nguyễn Minh Thư', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 2, 2)
INSERT [dbo].[Users] ([Email], [FullName], [Password], [RoleId], [StatusId]) VALUES (N'trangcaoquynh@gmail.com', N'Cao Quỳnh Trang', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 2, 2)
GO
ALTER TABLE [dbo].[Articles]  WITH CHECK ADD  CONSTRAINT [FK_Articles_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Status] ([Id])
GO
ALTER TABLE [dbo].[Articles] CHECK CONSTRAINT [FK_Articles_Status]
GO
ALTER TABLE [dbo].[Articles]  WITH CHECK ADD  CONSTRAINT [FK_Articles_Users] FOREIGN KEY([Email])
REFERENCES [dbo].[Users] ([Email])
GO
ALTER TABLE [dbo].[Articles] CHECK CONSTRAINT [FK_Articles_Users]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Articles] FOREIGN KEY([PostId])
REFERENCES [dbo].[Articles] ([PostID])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_Articles]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Users] FOREIGN KEY([Email])
REFERENCES [dbo].[Users] ([Email])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_Users]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([Id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Role]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Status] ([Id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Status]
GO
USE [master]
GO
ALTER DATABASE [lab2_simple_blog] SET  READ_WRITE 
GO
