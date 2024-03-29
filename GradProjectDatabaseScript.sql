
--some edits2
USE [master]
GO
/****** Object:  Database [GradProject]    Script Date: 2023-02-14 10:16:45 PM ******/
CREATE DATABASE [GradProject]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'GradProject', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\GradProject.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'GradProject_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\GradProject_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [GradProject] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GradProject].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GradProject] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GradProject] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GradProject] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GradProject] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GradProject] SET ARITHABORT OFF 
GO
ALTER DATABASE [GradProject] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [GradProject] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GradProject] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GradProject] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GradProject] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GradProject] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GradProject] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GradProject] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GradProject] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GradProject] SET  DISABLE_BROKER 
GO
ALTER DATABASE [GradProject] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GradProject] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GradProject] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GradProject] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GradProject] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GradProject] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GradProject] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GradProject] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [GradProject] SET  MULTI_USER 
GO
ALTER DATABASE [GradProject] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GradProject] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GradProject] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GradProject] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [GradProject] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [GradProject] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'GradProject', N'ON'
GO
ALTER DATABASE [GradProject] SET QUERY_STORE = OFF
GO
USE [GradProject]
GO
/****** Object:  Table [dbo].[PermittedUsers]    Script Date: 2023-02-14 10:16:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PermittedUsers](
	[ID] [int] NOT NULL,
	[PublicKey] [nvarchar](66) NULL,
	[RegisterationDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 2023-02-14 10:16:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NationalID] [char](10) NOT NULL,
	[Fname] [nvarchar](20) NULL,
	[Lname] [nvarchar](20) NULL,
	[DOB] [datetime] NULL,
	[AllowedToVote] [bit] NULL,
	[Password] [nvarchar](max) NULL,
	[Salt] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[PermittedUsers] ([ID], [PublicKey], [RegisterationDate]) VALUES (10, N'0x5c4db1c5cf4a9c6321f3fdbca1eb906384e6c49f', CAST(N'2023-01-22T13:53:43.740' AS DateTime))
INSERT [dbo].[PermittedUsers] ([ID], [PublicKey], [RegisterationDate]) VALUES (11, N'0x7e6691341dfa612b3e1554f409f5004685e4df39', CAST(N'2023-01-22T13:55:18.133' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([ID], [NationalID], [Fname], [Lname], [DOB], [AllowedToVote], [Password], [Salt]) VALUES (10, N'2000198040', N'Aws', N'Rayyan', CAST(N'2000-11-02T00:00:00.000' AS DateTime), 1, N'ᶽ驪낍¸�ю糁趮壇釁၂⠼', N'|zAp\5&Tzf_\Y*S&D@9os<_=V')
INSERT [dbo].[Users] ([ID], [NationalID], [Fname], [Lname], [DOB], [AllowedToVote], [Password], [Salt]) VALUES (11, N'2000198041', N'Mahmoud', N'Atari', CAST(N'2000-11-10T00:00:00.000' AS DateTime), 1, N'ꘪ퍑骋䄸忚쐍ꦖ㟷ⷔฝ�誐蝞儏�', N'11adKj)iw[/7u<gB/m"t4Ks^}')
INSERT [dbo].[Users] ([ID], [NationalID], [Fname], [Lname], [DOB], [AllowedToVote], [Password], [Salt]) VALUES (12, N'2000198042', N'Aws', N'Almasri', CAST(N'2000-11-03T00:00:00.000' AS DateTime), 1, N'圸J辈⹮洍ⶒꇺ鸕랍圊僩饃ᅲ䮔컼', N's.3?_3umWZO*S<uE#KWca0|ZJ')
INSERT [dbo].[Users] ([ID], [NationalID], [Fname], [Lname], [DOB], [AllowedToVote], [Password], [Salt]) VALUES (13, N'2000198043', N'Ahmed', N'Rayyan', CAST(N'2000-11-02T00:00:00.000' AS DateTime), 1, N'ꏥ뮬ꩭ㣍䐢혱鉶䆏⻟⌦ക䑧둧⺿掯', N'GHX7R2al( {BfdmQq''2KS''Z+@')
INSERT [dbo].[Users] ([ID], [NationalID], [Fname], [Lname], [DOB], [AllowedToVote], [Password], [Salt]) VALUES (14, N'2000198044', N'John', N'White', CAST(N'1995-01-17T00:00:00.000' AS DateTime), 0, N'ᘠ먂擈糞鳈銓ㆦ�酥隶䊬⻛㋳ா', N'EN,[WEE"7VPj!hii,RwqO5Bzc')
INSERT [dbo].[Users] ([ID], [NationalID], [Fname], [Lname], [DOB], [AllowedToVote], [Password], [Salt]) VALUES (15, N'2000198045', N'Qusai', N'Said', CAST(N'2000-11-02T00:00:00.000' AS DateTime), 1, N'鞭癪㠛ꬴᆈ�畈�虺Ⰺᇎ먤螓朚', N'D^}Yk"])G\x!iNQJCEKfP9/qo')
INSERT [dbo].[Users] ([ID], [NationalID], [Fname], [Lname], [DOB], [AllowedToVote], [Password], [Salt]) VALUES (16, N'2000198046', N'Josheph', N'Star', CAST(N'2000-11-02T00:00:00.000' AS DateTime), 1, N'뽕狂떰컜쵴젷㡡谡쬦⭻絟⟣鳑', N'GE#],{az0r%a.djDY^BFi!PCF')
INSERT [dbo].[Users] ([ID], [NationalID], [Fname], [Lname], [DOB], [AllowedToVote], [Password], [Salt]) VALUES (17, N'2000198047', N'Hamza', N'Zaid', CAST(N'2000-02-23T00:00:00.000' AS DateTime), 1, N'쒙ૢ㡽຤뭼킙獋缒ሚ㱲ꏚﴽ骓혫', N')9"^wI7<EQ\wX9cGT)tSBp2$c')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
/****** Object:  Index [UniqueID]    Script Date: 2023-02-14 10:16:45 PM ******/
ALTER TABLE [dbo].[PermittedUsers] ADD  CONSTRAINT [UniqueID] UNIQUE NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UniquePublicKey]    Script Date: 2023-02-14 10:16:45 PM ******/
ALTER TABLE [dbo].[PermittedUsers] ADD  CONSTRAINT [UniquePublicKey] UNIQUE NONCLUSTERED 
(
	[PublicKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PermittedUsers]  WITH CHECK ADD  CONSTRAINT [FK_Users] FOREIGN KEY([ID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[PermittedUsers] CHECK CONSTRAINT [FK_Users]
GO
/****** Object:  StoredProcedure [dbo].[SP_Register_User]    Script Date: 2023-02-14 10:16:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_Register_User] @Fname nvarchar(20), @Lname nvarchar(20),
@NationalID char(10), @DOB datetime,@User_password nvarchar(100) , 

@Status int out  

as
begin

declare @NationalIdUsed int;


select @NationalIdUsed = Count(NationalID)
from Users 
where @NationalID = NationalID;

IF(@NationalIdUsed > 0) BEGIN
set @Status = 2  --User Already Registered 
END
ELSE BEGIN

  DECLARE @Salt VARCHAR(25);
  DECLARE @PwdWithSalt VARCHAR(125);

  -- Generate the salt
  DECLARE @Seed int;
  DECLARE @LCV tinyint;
  DECLARE @CTime DATETIME;

  SET @CTime = GETDATE();
  SET @Seed = (DATEPART(hh, @Ctime) * 10000000) + (DATEPART(n, @CTime) * 100000)
      + (DATEPART(s, @CTime) * 1000) + DATEPART(ms, @CTime);
  SET @LCV = 1;
  SET @Salt = CHAR(ROUND((RAND(@Seed) * 94.0) + 32, 3));

  WHILE (@LCV < 25)
  BEGIN
    SET @Salt = @Salt + CHAR(ROUND((RAND() * 94.0) + 32, 3));
    SET @LCV = @LCV + 1;
  END;

  SET @PwdWithSalt = @Salt + @User_password;


Insert into [dbo].[Users] 
(NationalID,Fname,Lname,DOB,AllowedToVote,Password,Salt)
	Values(
	@NationalID,
	@Fname,
	@Lname,
	@DOB,
	1,
	HASHBYTES('SHA2_256', @PwdWithSalt),
	@Salt
	);

set @Status = 1; -- registered successfully

END

end


GO
/****** Object:  StoredProcedure [dbo].[SP_Revert_Registeration]    Script Date: 2023-02-14 10:16:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  create Procedure [dbo].[SP_Revert_Registeration] @publicKey nvarchar(max)
  as begin

  delete from PermittedUsers where PublicKey=@publicKey
  end
GO
/****** Object:  StoredProcedure [dbo].[SP_User_Validate]    Script Date: 2023-02-14 10:16:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[SP_User_Validate] @Fname nvarchar(20), @Lname nvarchar(20),
@NationalID char(10), @DOB datetime,@User_password nvarchar(100) , 
@PublicKey nvarchar(66), 
@Status int out

AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Salt CHAR(25);
	DECLARE @PwdWithSalt VARCHAR(125);
	DECLARE @NewHashedPwd varbinary(8000);

	SELECT @Salt = Salt 
	 FROM  Users AS u	
	 WHERE NationalID = @NationalID;
  
	 SET @PwdWithSalt = @Salt + @User_password;

	SET @NewHashedPwd = HASHBYTES('SHA2_256', @PwdWithSalt)
	  

	IF EXISTS(SELECT *
			FROM  Users 			
			where NationalID=@NationalID and Password=@NewHashedPwd and
			Fname=@Fname and Lname = @Lname and
			DOB = @DOB )
	BEGIN
  
	declare @NationalIdUsed int;
	declare @AllowedToVote bit;
	declare @publicKeyUsed int;


	select @NationalIdUsed = Count(NationalID)
	from Users as u  join PermittedUsers as pu
	on u.ID = pu.ID
	where @NationalID = NationalID;

	select @AllowedToVote=AllowedToVote
	from Users 
	where @NationalID = NationalID;

	select @publicKeyUsed = count(PublicKey)
	from [dbo].[PermittedUsers]
	where PublicKey=@PublicKey

	IF(@NationalIdUsed > 0) BEGIN
	set @Status = 2  --User Already Registered 
	END
	ELSE IF(@AllowedToVote = 0) BEGIN
	set @Status = 4  --User Is Not Eligable To Vote
	END
	ELSE IF(@publicKeyUsed > 0)BEGIN
	set @Status = 5  --Public key is already used for another account
	END
	ELSE BEGIN

	declare @ID int;

	select @ID = ID 
	from Users 
	where NationalID=@NationalID

	Insert into [dbo].[PermittedUsers]
	(ID,PublicKey,RegisterationDate)
	Values(
	@ID,
	@PublicKey,
	GETDATE()
	);

	set @Status = 1; -- registered successfully

	END

	END
	ELSE
    set @Status = 0 --Wrong Information
	END


GO
USE [master]
GO
ALTER DATABASE [GradProject] SET  READ_WRITE 
GO
