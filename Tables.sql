USE [VBSAPP]
GO
/****** Object:  Table [support].[TblBrand]    Script Date: 1/30/2025 1:10:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [support].[TblBrand](
	[BrandId] [smallint] IDENTITY(1,1) NOT NULL,
	[BrandName] [varchar](50) NULL,
	[IsDelete] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[BrandId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [support].[TblModels]    Script Date: 1/30/2025 1:10:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [support].[TblModels](
	[ModelId] [int] IDENTITY(1,1) NOT NULL,
	[ModelName] [varchar](100) NOT NULL,
	[BrandId] [smallint] NOT NULL,
	[IsDelete] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ModelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [support].[TblPaymentType]    Script Date: 1/30/2025 1:10:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [support].[TblPaymentType](
	[PaymentTypeId] [smallint] IDENTITY(1,1) NOT NULL,
	[PaymentTypeName] [varchar](50) NOT NULL,
	[IsDelete] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedBy] [int] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
 CONSTRAINT [PK_TblPaymentType] PRIMARY KEY CLUSTERED 
(
	[PaymentTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [support].[TblRole]    Script Date: 1/30/2025 1:10:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [support].[TblRole](
	[RoleId] [smallint] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](100) NOT NULL,
	[IsDelete] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedBy] [int] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [support].[TblServiceType]    Script Date: 1/30/2025 1:10:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [support].[TblServiceType](
	[ServiceTypeId] [smallint] IDENTITY(1,1) NOT NULL,
	[ServiceTypeName] [varchar](50) NOT NULL,
	[IsDelete] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ServiceTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [support].[TblStatus]    Script Date: 1/30/2025 1:10:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [support].[TblStatus](
	[StatusId] [smallint] IDENTITY(1,1) NOT NULL,
	[StatusName] [varchar](50) NULL,
	[IsDelete] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[StatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [vbs].[TblAllotment]    Script Date: 1/30/2025 1:10:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [vbs].[TblAllotment](
	[AllotmentId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[CarId] [int] NOT NULL,
	[StatusId] [smallint] NOT NULL,
	[IsDelete] [bit] NULL,
	[BookingDate] [datetime] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](100) NULL,
	[ModifiedBy] [nvarchar](100) NULL,
 CONSTRAINT [PK__TblAllot__E9FEF60FE3916908] PRIMARY KEY CLUSTERED 
(
	[AllotmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [vbs].[TblCarDetails]    Script Date: 1/30/2025 1:10:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [vbs].[TblCarDetails](
	[CarId] [int] IDENTITY(1,1) NOT NULL,
	[CarName] [varchar](50) NOT NULL,
	[BrandId] [smallint] NOT NULL,
	[ModelId] [int] NOT NULL,
	[ExShowroomPrice] [decimal](10, 2) NOT NULL,
	[OnRoadPrice] [decimal](10, 2) NOT NULL,
	[InsurancePrice] [decimal](10, 2) NOT NULL,
	[Colour] [varchar](50) NULL,
	[FuelType] [varchar](50) NULL,
	[HorsePower] [int] NOT NULL,
	[EngineType] [varchar](50) NOT NULL,
	[TransmissionType] [varchar](50) NULL,
	[Mileage] [decimal](5, 2) NOT NULL,
	[IsDelete] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedBy] [int] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[CarImagePath] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[CarId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [vbs].[TblInventoryDetails]    Script Date: 1/30/2025 1:10:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [vbs].[TblInventoryDetails](
	[InventoryId] [int] IDENTITY(1,1) NOT NULL,
	[CarId] [int] NOT NULL,
	[StockQuantity] [int] NOT NULL,
	[AvailableQuantity] [int] NOT NULL,
	[IsAvailable] [bit] NULL,
	[IsDelete] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedBy] [int] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[BrandId] [int] NOT NULL,
	[ModelId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[InventoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [vbs].[TblOrder]    Script Date: 1/30/2025 1:10:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [vbs].[TblOrder](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[OrderNumber] [varchar](100) NULL,
	[UserId] [int] NULL,
	[CarId] [int] NULL,
	[PaymentTypeId] [smallint] NOT NULL,
	[StatusId] [smallint] NULL,
	[OrderDate] [date] NULL,
	[ExpectDeliverDate] [date] NULL,
	[ActualDeliverDate] [date] NULL,
	[BookingAmount] [decimal](10, 2) NOT NULL,
	[TotalAmount] [decimal](10, 2) NULL,
	[IsDelete] [bit] NULL,
	[CreatedDate] [date] NULL,
	[ModifiedDate] [date] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK__TblOrder__C3905BCF70DCD680] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [vbs].[TblServiceDetails]    Script Date: 1/30/2025 1:10:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [vbs].[TblServiceDetails](
	[ServiceId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[CarId] [int] NULL,
	[ServiceTypeId] [smallint] NOT NULL,
	[ServiceDate] [datetime] NOT NULL,
	[ServiceCost] [decimal](10, 2) NOT NULL,
	[ServiceDescription] [varchar](255) NOT NULL,
	[IsUnderWarrenty] [bit] NOT NULL,
	[NextServiceDate] [datetime] NOT NULL,
	[IsDelete] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedBy] [int] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[StatusId] [smallint] NULL,
 CONSTRAINT [PK__TblServi__C51BB00ACBB0A034] PRIMARY KEY CLUSTERED 
(
	[ServiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [vbs].[TblUsers]    Script Date: 1/30/2025 1:10:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [vbs].[TblUsers](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NULL,
	[DateOfBirth] [date] NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[Password] [varchar](100) NOT NULL,
	[Gender] [bit] NULL,
	[PhoneNumber] [varchar](11) NOT NULL,
	[RoleId] [smallint] NULL,
	[Address] [varchar](200) NULL,
	[AadharNumber] [varchar](12) NULL,
	[IsDelete] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedBy] [int] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[UserImage] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [support].[TblBrand] ON 

INSERT [support].[TblBrand] ([BrandId], [BrandName], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (1, N'Toyota', 0, CAST(N'2024-08-22T10:10:00.440' AS DateTime), CAST(N'2024-08-22T10:10:00.440' AS DateTime), 1, 1)
INSERT [support].[TblBrand] ([BrandId], [BrandName], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (2, N'Honda', 0, CAST(N'2024-08-22T10:10:00.440' AS DateTime), CAST(N'2024-08-22T10:10:00.440' AS DateTime), 1, 1)
INSERT [support].[TblBrand] ([BrandId], [BrandName], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (3, N'Ford', 0, CAST(N'2024-08-22T10:10:00.440' AS DateTime), CAST(N'2024-08-22T10:10:00.440' AS DateTime), 1, 1)
INSERT [support].[TblBrand] ([BrandId], [BrandName], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (4, N'BMW', 0, CAST(N'2024-08-22T10:10:00.440' AS DateTime), CAST(N'2024-08-22T10:10:00.440' AS DateTime), 1, 1)
INSERT [support].[TblBrand] ([BrandId], [BrandName], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (5, N'Mercedes-Benz', 0, CAST(N'2024-08-22T10:10:00.440' AS DateTime), CAST(N'2024-08-22T10:10:00.440' AS DateTime), 1, 1)
INSERT [support].[TblBrand] ([BrandId], [BrandName], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (6, N'Audi', 0, CAST(N'2024-08-22T10:10:00.440' AS DateTime), CAST(N'2024-08-22T10:10:00.440' AS DateTime), 1, 1)
INSERT [support].[TblBrand] ([BrandId], [BrandName], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (7, N'Tesla', 0, CAST(N'2024-08-22T10:10:00.440' AS DateTime), CAST(N'2024-08-22T10:10:00.440' AS DateTime), 1, 1)
INSERT [support].[TblBrand] ([BrandId], [BrandName], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (8, N'Chevrolet', 0, CAST(N'2024-08-22T10:10:00.440' AS DateTime), CAST(N'2024-08-22T10:10:00.440' AS DateTime), 1, 1)
INSERT [support].[TblBrand] ([BrandId], [BrandName], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (9, N'Nissan', 0, CAST(N'2024-08-22T10:10:00.440' AS DateTime), CAST(N'2024-08-22T10:10:00.440' AS DateTime), 1, 1)
INSERT [support].[TblBrand] ([BrandId], [BrandName], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (10, N'Hyundai', 0, CAST(N'2024-08-22T10:10:00.440' AS DateTime), CAST(N'2024-08-22T10:10:00.440' AS DateTime), 1, 1)
SET IDENTITY_INSERT [support].[TblBrand] OFF
SET IDENTITY_INSERT [support].[TblModels] ON 

INSERT [support].[TblModels] ([ModelId], [ModelName], [BrandId], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (1, N'Corolla', 1, 0, CAST(N'2024-08-22T00:00:00.000' AS DateTime), CAST(N'2024-08-22T00:00:00.000' AS DateTime), 1, 1)
INSERT [support].[TblModels] ([ModelId], [ModelName], [BrandId], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (2, N'Camry', 1, 0, CAST(N'2024-08-22T00:00:00.000' AS DateTime), CAST(N'2024-08-22T00:00:00.000' AS DateTime), 1, 1)
INSERT [support].[TblModels] ([ModelId], [ModelName], [BrandId], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (3, N'Civic', 2, 0, CAST(N'2024-08-22T00:00:00.000' AS DateTime), CAST(N'2024-08-22T00:00:00.000' AS DateTime), 1, 1)
INSERT [support].[TblModels] ([ModelId], [ModelName], [BrandId], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (4, N'Accord', 2, 0, CAST(N'2024-08-22T00:00:00.000' AS DateTime), CAST(N'2024-08-22T00:00:00.000' AS DateTime), 1, 1)
INSERT [support].[TblModels] ([ModelId], [ModelName], [BrandId], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (5, N'Focus', 3, 0, CAST(N'2024-08-22T00:00:00.000' AS DateTime), CAST(N'2024-08-22T00:00:00.000' AS DateTime), 1, 1)
INSERT [support].[TblModels] ([ModelId], [ModelName], [BrandId], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (6, N'Mustang', 3, 0, CAST(N'2024-08-22T00:00:00.000' AS DateTime), CAST(N'2024-08-22T00:00:00.000' AS DateTime), 1, 1)
INSERT [support].[TblModels] ([ModelId], [ModelName], [BrandId], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (7, N'3 Series', 4, 0, CAST(N'2024-08-22T00:00:00.000' AS DateTime), CAST(N'2024-08-22T00:00:00.000' AS DateTime), 1, 1)
INSERT [support].[TblModels] ([ModelId], [ModelName], [BrandId], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (8, N'5 Series', 4, 0, CAST(N'2024-08-22T00:00:00.000' AS DateTime), CAST(N'2024-08-22T00:00:00.000' AS DateTime), 1, 1)
INSERT [support].[TblModels] ([ModelId], [ModelName], [BrandId], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (9, N'C-Class', 5, 0, CAST(N'2024-08-22T00:00:00.000' AS DateTime), CAST(N'2024-08-22T00:00:00.000' AS DateTime), 1, 1)
INSERT [support].[TblModels] ([ModelId], [ModelName], [BrandId], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (10, N'E-Class', 5, 0, CAST(N'2024-08-22T00:00:00.000' AS DateTime), CAST(N'2024-08-22T00:00:00.000' AS DateTime), 1, 1)
INSERT [support].[TblModels] ([ModelId], [ModelName], [BrandId], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (11, N'A4', 6, 0, CAST(N'2024-08-22T00:00:00.000' AS DateTime), CAST(N'2024-08-22T00:00:00.000' AS DateTime), 1, 1)
INSERT [support].[TblModels] ([ModelId], [ModelName], [BrandId], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (12, N'Q5', 6, 0, CAST(N'2024-08-22T00:00:00.000' AS DateTime), CAST(N'2024-08-22T00:00:00.000' AS DateTime), 1, 1)
INSERT [support].[TblModels] ([ModelId], [ModelName], [BrandId], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (13, N'Model S', 7, 0, CAST(N'2024-08-22T00:00:00.000' AS DateTime), CAST(N'2024-08-22T00:00:00.000' AS DateTime), 1, 1)
INSERT [support].[TblModels] ([ModelId], [ModelName], [BrandId], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (14, N'Model 3', 7, 0, CAST(N'2024-08-22T00:00:00.000' AS DateTime), CAST(N'2024-08-22T00:00:00.000' AS DateTime), 1, 1)
INSERT [support].[TblModels] ([ModelId], [ModelName], [BrandId], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (15, N'Impala', 8, 0, CAST(N'2024-08-22T00:00:00.000' AS DateTime), CAST(N'2024-08-22T00:00:00.000' AS DateTime), 1, 1)
INSERT [support].[TblModels] ([ModelId], [ModelName], [BrandId], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (16, N'Malibu', 8, 0, CAST(N'2024-08-22T00:00:00.000' AS DateTime), CAST(N'2024-08-22T00:00:00.000' AS DateTime), 1, 1)
INSERT [support].[TblModels] ([ModelId], [ModelName], [BrandId], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (17, N'Altima', 9, 0, CAST(N'2024-08-22T00:00:00.000' AS DateTime), CAST(N'2024-08-22T00:00:00.000' AS DateTime), 1, 1)
INSERT [support].[TblModels] ([ModelId], [ModelName], [BrandId], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (18, N'Maxima', 9, 0, CAST(N'2024-08-22T00:00:00.000' AS DateTime), CAST(N'2024-08-22T00:00:00.000' AS DateTime), 1, 1)
INSERT [support].[TblModels] ([ModelId], [ModelName], [BrandId], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (19, N'Elantra', 10, 0, CAST(N'2024-08-22T00:00:00.000' AS DateTime), CAST(N'2024-08-22T00:00:00.000' AS DateTime), 1, 1)
INSERT [support].[TblModels] ([ModelId], [ModelName], [BrandId], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (20, N'Sonata', 10, 0, CAST(N'2024-08-22T00:00:00.000' AS DateTime), CAST(N'2024-08-22T00:00:00.000' AS DateTime), 1, 1)
SET IDENTITY_INSERT [support].[TblModels] OFF
SET IDENTITY_INSERT [support].[TblPaymentType] ON 

INSERT [support].[TblPaymentType] ([PaymentTypeId], [PaymentTypeName], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (1, N'Not Paid', 0, CAST(N'2024-08-22T11:04:19.667' AS DateTime), CAST(N'2024-08-22T11:04:19.667' AS DateTime), 1, 1)
INSERT [support].[TblPaymentType] ([PaymentTypeId], [PaymentTypeName], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (2, N'Partially Paid', 0, CAST(N'2024-08-22T11:04:19.667' AS DateTime), CAST(N'2024-08-22T11:04:19.667' AS DateTime), 1, 1)
INSERT [support].[TblPaymentType] ([PaymentTypeId], [PaymentTypeName], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (3, N'Paid', 0, CAST(N'2024-08-22T11:04:19.667' AS DateTime), CAST(N'2024-08-22T11:04:19.667' AS DateTime), 1, 1)
INSERT [support].[TblPaymentType] ([PaymentTypeId], [PaymentTypeName], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (4, N'Paid Option', 1, CAST(N'2024-08-22T20:05:13.450' AS DateTime), CAST(N'2024-08-22T20:05:23.260' AS DateTime), 1, 1)
SET IDENTITY_INSERT [support].[TblPaymentType] OFF
SET IDENTITY_INSERT [support].[TblRole] ON 

INSERT [support].[TblRole] ([RoleId], [RoleName], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (1, N'Admin', 0, CAST(N'2024-08-21T15:36:43.913' AS DateTime), CAST(N'2024-08-21T15:36:43.913' AS DateTime), 1, 1)
INSERT [support].[TblRole] ([RoleId], [RoleName], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (2, N'Customer', 0, CAST(N'2024-08-21T15:36:43.917' AS DateTime), CAST(N'2024-08-21T15:36:43.917' AS DateTime), 1, 1)
SET IDENTITY_INSERT [support].[TblRole] OFF
SET IDENTITY_INSERT [support].[TblServiceType] ON 

INSERT [support].[TblServiceType] ([ServiceTypeId], [ServiceTypeName], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (1, N'Free Service', 0, CAST(N'2024-08-22T10:48:53.553' AS DateTime), CAST(N'2024-08-22T10:48:53.553' AS DateTime), 1, 1)
INSERT [support].[TblServiceType] ([ServiceTypeId], [ServiceTypeName], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (2, N'Paid Service', 0, CAST(N'2024-08-22T10:48:53.553' AS DateTime), CAST(N'2024-08-22T10:48:53.553' AS DateTime), 1, 1)
INSERT [support].[TblServiceType] ([ServiceTypeId], [ServiceTypeName], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (4, N'Need Service', 1, CAST(N'2024-08-22T19:38:39.923' AS DateTime), CAST(N'2024-08-22T19:38:47.300' AS DateTime), 1, 1)
SET IDENTITY_INSERT [support].[TblServiceType] OFF
SET IDENTITY_INSERT [support].[TblStatus] ON 

INSERT [support].[TblStatus] ([StatusId], [StatusName], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (1, N'Requested', 0, CAST(N'2024-08-22T10:35:26.770' AS DateTime), CAST(N'2024-08-22T10:35:26.770' AS DateTime), 1, 1)
INSERT [support].[TblStatus] ([StatusId], [StatusName], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (2, N'Accepted', 0, CAST(N'2024-08-22T10:35:26.770' AS DateTime), CAST(N'2024-08-22T10:35:26.770' AS DateTime), 1, 1)
INSERT [support].[TblStatus] ([StatusId], [StatusName], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (3, N'Booked', 0, CAST(N'2024-08-22T10:35:26.770' AS DateTime), CAST(N'2024-08-22T10:35:26.770' AS DateTime), 1, 1)
INSERT [support].[TblStatus] ([StatusId], [StatusName], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (4, N'InProgress', 0, CAST(N'2024-08-22T10:35:26.770' AS DateTime), CAST(N'2024-08-22T10:35:26.770' AS DateTime), 1, 1)
INSERT [support].[TblStatus] ([StatusId], [StatusName], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (5, N'Completed', 0, CAST(N'2024-08-22T10:35:26.770' AS DateTime), CAST(N'2024-08-22T10:35:26.770' AS DateTime), 1, 1)
INSERT [support].[TblStatus] ([StatusId], [StatusName], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (6, N'Delivered', 0, CAST(N'2024-08-22T10:35:26.770' AS DateTime), CAST(N'2024-08-22T10:35:26.770' AS DateTime), 1, 1)
INSERT [support].[TblStatus] ([StatusId], [StatusName], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (7, N'Canceled', 0, CAST(N'2024-08-29T20:48:39.977' AS DateTime), CAST(N'2024-08-29T20:48:39.977' AS DateTime), 1, 1)
INSERT [support].[TblStatus] ([StatusId], [StatusName], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (8, N'Not Available', 0, CAST(N'2024-08-29T20:48:53.217' AS DateTime), CAST(N'2024-08-29T20:48:53.217' AS DateTime), 1, 1)
INSERT [support].[TblStatus] ([StatusId], [StatusName], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (9, N'Ordered', 0, CAST(N'2024-08-30T19:19:34.287' AS DateTime), CAST(N'2024-08-30T19:19:34.287' AS DateTime), 1, 1)
SET IDENTITY_INSERT [support].[TblStatus] OFF
SET IDENTITY_INSERT [vbs].[TblAllotment] ON 

INSERT [vbs].[TblAllotment] ([AllotmentId], [UserId], [CarId], [StatusId], [IsDelete], [BookingDate], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (1, 13, 4, 9, 0, CAST(N'2024-08-31T15:45:49.023' AS DateTime), CAST(N'2024-08-31T15:45:49.023' AS DateTime), CAST(N'2024-08-31T15:46:23.553' AS DateTime), N'2', N'1')
INSERT [vbs].[TblAllotment] ([AllotmentId], [UserId], [CarId], [StatusId], [IsDelete], [BookingDate], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (2, 13, 2, 9, 0, CAST(N'2024-09-02T11:11:04.883' AS DateTime), CAST(N'2024-09-02T11:11:04.883' AS DateTime), CAST(N'2024-09-02T11:11:34.443' AS DateTime), N'2', N'1')
INSERT [vbs].[TblAllotment] ([AllotmentId], [UserId], [CarId], [StatusId], [IsDelete], [BookingDate], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (3, 13, 12, 3, 0, CAST(N'2024-09-02T16:41:53.000' AS DateTime), CAST(N'2024-09-02T16:41:53.000' AS DateTime), NULL, N'2', N'2')
INSERT [vbs].[TblAllotment] ([AllotmentId], [UserId], [CarId], [StatusId], [IsDelete], [BookingDate], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (4, 18, 2, 9, 0, CAST(N'2024-09-02T17:20:14.187' AS DateTime), CAST(N'2024-09-02T17:20:14.187' AS DateTime), CAST(N'2024-09-02T17:21:05.990' AS DateTime), N'2', N'1')
INSERT [vbs].[TblAllotment] ([AllotmentId], [UserId], [CarId], [StatusId], [IsDelete], [BookingDate], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (5, 13, 1, 9, 0, CAST(N'2024-09-02T17:30:34.493' AS DateTime), CAST(N'2024-09-02T17:30:34.493' AS DateTime), CAST(N'2024-09-02T17:31:04.190' AS DateTime), N'2', N'1')
SET IDENTITY_INSERT [vbs].[TblAllotment] OFF
SET IDENTITY_INSERT [vbs].[TblCarDetails] ON 

INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (1, N'Corolla Basic', 1, 1, CAST(12000.00 AS Decimal(10, 2)), CAST(15000.00 AS Decimal(10, 2)), CAST(1200.00 AS Decimal(10, 2)), N'White', N'Petrol', 130, N'VVT-i', N'Manual', CAST(15.50 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T13:59:05.943' AS DateTime), CAST(N'2024-08-23T13:59:05.943' AS DateTime), 1, 1, N'/assets/img/cars/Corolla%20Basic.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (2, N'Camry Premium', 1, 2, CAST(25000.00 AS Decimal(10, 2)), CAST(30000.00 AS Decimal(10, 2)), CAST(1800.00 AS Decimal(10, 2)), N'Black', N'Hybrid', 150, N'Hybrid', N'Manual', CAST(18.20 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T13:59:05.943' AS DateTime), CAST(N'2024-08-23T13:59:05.943' AS DateTime), 1, 1, N'/assets/img/cars/Camry%20Premium.jpeg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (3, N'Civic Sport', 2, 3, CAST(18000.00 AS Decimal(10, 2)), CAST(22000.00 AS Decimal(10, 2)), CAST(1400.00 AS Decimal(10, 2)), N'Red', N'Petrol', 140, N'i-VTEC', N'Manual', CAST(17.00 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T13:59:05.943' AS DateTime), CAST(N'2024-08-23T13:59:05.943' AS DateTime), 1, 1, N'/assets/img/cars/Civic%20Sport.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (4, N'Accord Classic', 2, 4, CAST(24000.00 AS Decimal(10, 2)), CAST(29000.00 AS Decimal(10, 2)), CAST(1600.00 AS Decimal(10, 2)), N'Blue', N'Diesel', 160, N'i-DTEC', N'Manual', CAST(16.50 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T13:59:05.943' AS DateTime), CAST(N'2024-08-23T13:59:05.943' AS DateTime), 1, 1, N'/assets/img/cars/Accord%20Classic.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (5, N'Focus Trend', 3, 5, CAST(16000.00 AS Decimal(10, 2)), CAST(19500.00 AS Decimal(10, 2)), CAST(1300.00 AS Decimal(10, 2)), N'Silver', N'Petrol', 125, N'EcoBoost', N'Manual', CAST(14.80 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T13:59:05.943' AS DateTime), CAST(N'2024-08-23T13:59:05.943' AS DateTime), 1, 1, N'/assets/img/cars/Focus%20Trend.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (6, N'Mustang GT', 3, 6, CAST(40000.00 AS Decimal(10, 2)), CAST(48000.00 AS Decimal(10, 2)), CAST(3000.00 AS Decimal(10, 2)), N'Yellow', N'Petrol', 450, N'V8', N'Manual', CAST(10.00 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T13:59:05.943' AS DateTime), CAST(N'2024-08-23T13:59:05.943' AS DateTime), 1, 1, N'/assets/img/cars/Mustang%20GT.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (7, N'3 Series Touring', 4, 7, CAST(35000.00 AS Decimal(10, 2)), CAST(42000.00 AS Decimal(10, 2)), CAST(2500.00 AS Decimal(10, 2)), N'White', N'Diesel', 190, N'TwinPower Turbo', N'Manual', CAST(19.50 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T13:59:05.943' AS DateTime), CAST(N'2024-08-23T13:59:05.943' AS DateTime), 1, 1, N'/assets/img/cars/3%20Series%20Touring.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (8, N'5 Series Luxury', 4, 8, CAST(50000.00 AS Decimal(10, 2)), CAST(60000.00 AS Decimal(10, 2)), CAST(3500.00 AS Decimal(10, 2)), N'Black', N'Petrol', 250, N'TwinPower Turbo', N'Manual', CAST(14.00 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T13:59:05.943' AS DateTime), CAST(N'2024-08-23T13:59:05.943' AS DateTime), 1, 1, N'/assets/img/cars/5%20Series%20Luxury.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (9, N'C-Class Executive', 5, 9, CAST(37000.00 AS Decimal(10, 2)), CAST(45000.00 AS Decimal(10, 2)), CAST(2700.00 AS Decimal(10, 2)), N'Blue', N'Petrol', 200, N'M274', N'Manual', CAST(16.80 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T13:59:05.943' AS DateTime), CAST(N'2024-08-23T13:59:05.943' AS DateTime), 1, 1, N'/assets/img/cars/C-Class%20Executive.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (10, N'E-Class Elegance', 5, 10, CAST(60000.00 AS Decimal(10, 2)), CAST(72000.00 AS Decimal(10, 2)), CAST(4000.00 AS Decimal(10, 2)), N'White', N'Diesel', 240, N'OM654', N'Manual', CAST(13.50 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T13:59:05.943' AS DateTime), CAST(N'2024-08-23T13:59:05.943' AS DateTime), 1, 1, N'/assets/img/cars/E-Class%20Elegance.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (11, N'A4 Sport', 6, 11, CAST(38000.00 AS Decimal(10, 2)), CAST(45000.00 AS Decimal(10, 2)), CAST(2900.00 AS Decimal(10, 2)), N'Red', N'Petrol', 190, N'TFSI', N'Manual', CAST(15.20 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T13:59:05.943' AS DateTime), CAST(N'2024-08-23T13:59:05.943' AS DateTime), 1, 1, N'/assets/img/cars/A4%20Sport.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (12, N'Q5 Adventure', 6, 12, CAST(55000.00 AS Decimal(10, 2)), CAST(65000.00 AS Decimal(10, 2)), CAST(3700.00 AS Decimal(10, 2)), N'Green', N'Diesel', 210, N'TDI', N'Manual', CAST(12.50 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T13:59:05.943' AS DateTime), CAST(N'2024-08-23T13:59:05.943' AS DateTime), 1, 1, N'/assets/img/cars/Q5%20Adventure.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (13, N'Model S Classic', 7, 13, CAST(80000.00 AS Decimal(10, 2)), CAST(95000.00 AS Decimal(10, 2)), CAST(5000.00 AS Decimal(10, 2)), N'Black', N'Electric', 670, N'Dual Motor', N'Manual', CAST(0.00 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T13:59:05.943' AS DateTime), CAST(N'2024-08-23T13:59:05.943' AS DateTime), 1, 1, N'/assets/img/cars/Model%20S%20Classic.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (14, N'Model 3 Entry', 7, 14, CAST(35000.00 AS Decimal(10, 2)), CAST(42000.00 AS Decimal(10, 2)), CAST(3200.00 AS Decimal(10, 2)), N'White', N'Electric', 283, N'Single Motor', N'Manual', CAST(0.00 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T13:59:05.943' AS DateTime), CAST(N'2024-08-23T13:59:05.943' AS DateTime), 1, 1, N'/assets/img/cars/Model%203%20Entry.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (15, N'Impala Standard', 8, 15, CAST(30000.00 AS Decimal(10, 2)), CAST(36000.00 AS Decimal(10, 2)), CAST(2000.00 AS Decimal(10, 2)), N'Blue', N'Petrol', 200, N'Ecotec', N'Manual', CAST(13.00 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T13:59:05.943' AS DateTime), CAST(N'2024-08-23T13:59:05.943' AS DateTime), 1, 1, N'/assets/img/cars/Model%203%20Entry.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (16, N'Malibu LS', 8, 16, CAST(22000.00 AS Decimal(10, 2)), CAST(27000.00 AS Decimal(10, 2)), CAST(1700.00 AS Decimal(10, 2)), N'Silver', N'Petrol', 160, N'Turbocharged', N'Manual', CAST(15.50 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T13:59:05.943' AS DateTime), CAST(N'2024-08-23T13:59:05.943' AS DateTime), 1, 1, N'/assets/img/cars/Malibu%20LS.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (17, N'Altima S', 9, 17, CAST(25000.00 AS Decimal(10, 2)), CAST(31000.00 AS Decimal(10, 2)), CAST(2300.00 AS Decimal(10, 2)), N'Grey', N'Petrol', 188, N'VQ35DE', N'Manual', CAST(17.80 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T13:59:05.943' AS DateTime), CAST(N'2024-08-23T13:59:05.943' AS DateTime), 1, 1, N'/assets/img/cars/Altima%20S.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (18, N'Maxima Platinum', 9, 18, CAST(40000.00 AS Decimal(10, 2)), CAST(48000.00 AS Decimal(10, 2)), CAST(3200.00 AS Decimal(10, 2)), N'Red', N'Petrol', 300, N'VQ35DE', N'Manual', CAST(11.50 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T13:59:05.943' AS DateTime), CAST(N'2024-08-23T13:59:05.943' AS DateTime), 1, 1, N'/assets/img/cars/Maxima%20Platinum.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (19, N'Elantra Classic', 10, 19, CAST(18000.00 AS Decimal(10, 2)), CAST(22000.00 AS Decimal(10, 2)), CAST(1500.00 AS Decimal(10, 2)), N'White', N'Petrol', 147, N'Smartstream', N'Manual', CAST(20.10 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T13:59:05.943' AS DateTime), CAST(N'2024-08-23T13:59:05.943' AS DateTime), 1, 1, N'/assets/img/cars/Elantra%20Classic.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (20, N'Sonata Sport', 10, 20, CAST(28000.00 AS Decimal(10, 2)), CAST(34000.00 AS Decimal(10, 2)), CAST(2500.00 AS Decimal(10, 2)), N'Blue', N'Diesel', 180, N'Smartstream', N'Manual', CAST(18.00 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T13:59:05.943' AS DateTime), CAST(N'2024-08-23T13:59:05.943' AS DateTime), 1, 1, N'/assets/img/cars/Sonata%20Sport.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (21, N'Corolla Sport', 1, 1, CAST(14000.00 AS Decimal(10, 2)), CAST(17500.00 AS Decimal(10, 2)), CAST(1300.00 AS Decimal(10, 2)), N'Silver', N'Petrol', 135, N'VVT-i', N'Manual', CAST(16.00 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T14:01:10.180' AS DateTime), CAST(N'2024-08-23T14:01:10.180' AS DateTime), 1, 1, N'/assets/img/cars/Corolla%20Basic.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (22, N'Camry Executive', 1, 2, CAST(26000.00 AS Decimal(10, 2)), CAST(32000.00 AS Decimal(10, 2)), CAST(1900.00 AS Decimal(10, 2)), N'White', N'Hybrid', 155, N'Hybrid', N'Manual', CAST(19.00 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T14:01:10.180' AS DateTime), CAST(N'2024-08-23T14:01:10.180' AS DateTime), 1, 1, N'/assets/img/cars/Camry%20Premium.jpeg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (23, N'Civic Executive', 2, 3, CAST(19000.00 AS Decimal(10, 2)), CAST(23500.00 AS Decimal(10, 2)), CAST(1450.00 AS Decimal(10, 2)), N'Black', N'Petrol', 145, N'i-VTEC', N'Manual', CAST(16.80 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T14:01:10.180' AS DateTime), CAST(N'2024-08-23T14:01:10.180' AS DateTime), 1, 1, N'/assets/img/cars/Civic%20Sport.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (24, N'Accord Elite', 2, 4, CAST(25000.00 AS Decimal(10, 2)), CAST(30500.00 AS Decimal(10, 2)), CAST(1650.00 AS Decimal(10, 2)), N'Red', N'Diesel', 165, N'i-DTEC', N'Manual', CAST(16.00 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T14:01:10.180' AS DateTime), CAST(N'2024-08-23T14:01:10.180' AS DateTime), 1, 1, N'/assets/img/cars/Accord%20Classic.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (25, N'Focus Sport', 3, 5, CAST(17000.00 AS Decimal(10, 2)), CAST(21000.00 AS Decimal(10, 2)), CAST(1350.00 AS Decimal(10, 2)), N'Blue', N'Petrol', 130, N'EcoBoost', N'Manual', CAST(15.00 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T14:01:10.180' AS DateTime), CAST(N'2024-08-23T14:01:10.180' AS DateTime), 1, 1, N'/assets/img/cars/Focus%20Trend.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (26, N'Mustang Coupe', 3, 6, CAST(42000.00 AS Decimal(10, 2)), CAST(50000.00 AS Decimal(10, 2)), CAST(3100.00 AS Decimal(10, 2)), N'Green', N'Petrol', 460, N'V8', N'Manual', CAST(10.50 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T14:01:10.180' AS DateTime), CAST(N'2024-08-23T14:01:10.180' AS DateTime), 1, 1, N'/assets/img/cars/Mustang%20GT.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (27, N'3 Series Gran Turismo', 4, 7, CAST(36000.00 AS Decimal(10, 2)), CAST(43000.00 AS Decimal(10, 2)), CAST(2600.00 AS Decimal(10, 2)), N'Grey', N'Diesel', 195, N'TwinPower Turbo', N'Manual', CAST(19.00 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T14:01:10.180' AS DateTime), CAST(N'2024-08-23T14:01:10.180' AS DateTime), 1, 1, N'/assets/img/cars/3%20Series%20Touring.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (28, N'5 Series Sport', 4, 8, CAST(52000.00 AS Decimal(10, 2)), CAST(62000.00 AS Decimal(10, 2)), CAST(3600.00 AS Decimal(10, 2)), N'Black', N'Petrol', 255, N'TwinPower Turbo', N'Manual', CAST(13.80 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T14:01:10.180' AS DateTime), CAST(N'2024-08-23T14:01:10.180' AS DateTime), 1, 1, N'/assets/img/cars/5%20Series%20Luxury.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (29, N'C-Class Classic', 5, 9, CAST(38000.00 AS Decimal(10, 2)), CAST(46000.00 AS Decimal(10, 2)), CAST(2800.00 AS Decimal(10, 2)), N'Silver', N'Petrol', 205, N'M274', N'Manual', CAST(16.50 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T14:01:10.180' AS DateTime), CAST(N'2024-08-23T14:01:10.180' AS DateTime), 1, 1, N'/assets/img/cars/C-Class%20Executive.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (30, N'E-Class Avantgarde', 5, 10, CAST(61000.00 AS Decimal(10, 2)), CAST(73000.00 AS Decimal(10, 2)), CAST(4100.00 AS Decimal(10, 2)), N'Blue', N'Diesel', 245, N'OM654', N'Manual', CAST(13.20 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T14:01:10.180' AS DateTime), CAST(N'2024-08-23T14:01:10.180' AS DateTime), 1, 1, N'/assets/img/cars/E-Class%20Elegance.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (31, N'A4 Comfort', 6, 11, CAST(39000.00 AS Decimal(10, 2)), CAST(46000.00 AS Decimal(10, 2)), CAST(3000.00 AS Decimal(10, 2)), N'White', N'Petrol', 195, N'TFSI', N'Manual', CAST(14.50 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T14:01:10.180' AS DateTime), CAST(N'2024-08-23T14:01:10.180' AS DateTime), 1, 1, N'/assets/img/cars/A4%20Sport.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (32, N'Q5 Dynamic', 6, 12, CAST(56000.00 AS Decimal(10, 2)), CAST(66000.00 AS Decimal(10, 2)), CAST(3800.00 AS Decimal(10, 2)), N'Red', N'Diesel', 215, N'TDI', N'Manual', CAST(12.00 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T14:01:10.180' AS DateTime), CAST(N'2024-08-23T14:01:10.180' AS DateTime), 1, 1, N'/assets/img/cars/Q5%20Adventure.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (33, N'Model S Comfort', 7, 13, CAST(82000.00 AS Decimal(10, 2)), CAST(97000.00 AS Decimal(10, 2)), CAST(5100.00 AS Decimal(10, 2)), N'Green', N'Electric', 680, N'Dual Motor', N'Manual', CAST(0.00 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T14:01:10.180' AS DateTime), CAST(N'2024-08-23T14:01:10.180' AS DateTime), 1, 1, N'/assets/img/cars/Model%20S%20Classic.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (34, N'Model 3 Plus', 7, 14, CAST(36000.00 AS Decimal(10, 2)), CAST(43000.00 AS Decimal(10, 2)), CAST(3300.00 AS Decimal(10, 2)), N'Blue', N'Electric', 290, N'Single Motor', N'Manual', CAST(0.00 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T14:01:10.180' AS DateTime), CAST(N'2024-08-23T14:01:10.180' AS DateTime), 1, 1, N'/assets/img/cars/Model%203%20Entry.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (35, N'Impala Comfort', 8, 15, CAST(31000.00 AS Decimal(10, 2)), CAST(37000.00 AS Decimal(10, 2)), CAST(2100.00 AS Decimal(10, 2)), N'Grey', N'Petrol', 205, N'Ecotec', N'Manual', CAST(12.80 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T14:01:10.180' AS DateTime), CAST(N'2024-08-23T14:01:10.180' AS DateTime), 1, 1, N'/assets/img/cars/Model%203%20Entry.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (36, N'Malibu Premier', 8, 16, CAST(23000.00 AS Decimal(10, 2)), CAST(28000.00 AS Decimal(10, 2)), CAST(1750.00 AS Decimal(10, 2)), N'Black', N'Petrol', 165, N'Turbocharged', N'Manual', CAST(15.00 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T14:01:10.180' AS DateTime), CAST(N'2024-08-23T14:01:10.180' AS DateTime), 1, 1, N'/assets/img/cars/Malibu%20LS.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (37, N'Altima Comfort', 9, 17, CAST(26000.00 AS Decimal(10, 2)), CAST(32000.00 AS Decimal(10, 2)), CAST(2400.00 AS Decimal(10, 2)), N'White', N'Petrol', 190, N'VQ35DE', N'Manual', CAST(17.50 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T14:01:10.180' AS DateTime), CAST(N'2024-08-23T14:01:10.180' AS DateTime), 1, 1, N'/assets/img/cars/Altima%20S.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (38, N'Maxima Elite', 9, 18, CAST(41000.00 AS Decimal(10, 2)), CAST(49000.00 AS Decimal(10, 2)), CAST(3300.00 AS Decimal(10, 2)), N'Red', N'Petrol', 305, N'VQ35DE', N'Manual', CAST(11.20 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T14:01:10.180' AS DateTime), CAST(N'2024-08-23T14:01:10.180' AS DateTime), 1, 1, N'/assets/img/cars/Maxima%20Platinum.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (39, N'Elantra Premium', 10, 19, CAST(19000.00 AS Decimal(10, 2)), CAST(23000.00 AS Decimal(10, 2)), CAST(1600.00 AS Decimal(10, 2)), N'Blue', N'Petrol', 150, N'Smartstream', N'Manual', CAST(19.80 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T14:01:10.180' AS DateTime), CAST(N'2024-08-23T14:01:10.180' AS DateTime), 1, 1, N'/assets/img/cars/Elantra%20Classic.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (40, N'Sonata Comfort', 10, 20, CAST(29000.00 AS Decimal(10, 2)), CAST(35000.00 AS Decimal(10, 2)), CAST(2600.00 AS Decimal(10, 2)), N'White', N'Diesel', 185, N'Smartstream', N'Manual', CAST(17.80 AS Decimal(5, 2)), 0, CAST(N'2024-08-23T14:01:10.180' AS DateTime), CAST(N'2024-08-23T14:01:10.180' AS DateTime), 1, 1, N'/assets/img/cars/Sonata%20Sport.jpg')
INSERT [vbs].[TblCarDetails] ([CarId], [CarName], [BrandId], [ModelId], [ExShowroomPrice], [OnRoadPrice], [InsurancePrice], [Colour], [FuelType], [HorsePower], [EngineType], [TransmissionType], [Mileage], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [CarImagePath]) VALUES (41, N'Adventure', 4, 5, CAST(35000.00 AS Decimal(10, 2)), CAST(15000.00 AS Decimal(10, 2)), CAST(10000.00 AS Decimal(10, 2)), N'Black', N'Petrol', 135, N'vv4', N'Manual', CAST(200.00 AS Decimal(5, 2)), 0, CAST(N'2024-08-30T17:48:01.077' AS DateTime), CAST(N'2024-08-30T17:48:01.077' AS DateTime), 1, 1, N'/')
SET IDENTITY_INSERT [vbs].[TblCarDetails] OFF
SET IDENTITY_INSERT [vbs].[TblInventoryDetails] ON 

INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (1, 1, 25, 19, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-09-02T17:31:40.200' AS DateTime), 1, 1, 1, 1)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (2, 2, 30, 28, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-29T17:22:10.490' AS DateTime), 1, 2, 1, 2)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (3, 3, 20, 20, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-29T17:24:07.767' AS DateTime), 1, 2, 2, 3)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (4, 4, 10, 6, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 2, 4)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (5, 5, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 3, 5)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (6, 6, 10, 9, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 3, 6)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (7, 7, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 4, 7)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (8, 8, 10, 9, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 4, 8)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (9, 9, 10, 9, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 5, 9)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (10, 10, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 5, 10)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (11, 11, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 6, 11)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (12, 12, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 6, 12)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (13, 13, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 7, 13)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (14, 14, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 7, 14)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (15, 15, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 8, 15)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (16, 16, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 8, 16)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (17, 17, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 9, 17)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (18, 18, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 9, 18)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (19, 19, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 10, 19)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (20, 20, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 10, 20)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (21, 21, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 1, 1)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (22, 22, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 1, 2)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (23, 23, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 2, 3)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (24, 24, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 2, 4)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (25, 25, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 3, 5)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (26, 26, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 3, 6)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (27, 27, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 4, 7)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (28, 28, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 4, 8)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (29, 29, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 5, 9)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (30, 30, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 5, 10)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (31, 31, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 6, 11)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (32, 32, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 6, 12)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (33, 33, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 7, 13)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (34, 34, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 7, 14)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (35, 35, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 8, 15)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (36, 36, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 8, 16)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (37, 37, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 9, 17)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (38, 38, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 9, 18)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (39, 39, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 10, 19)
INSERT [vbs].[TblInventoryDetails] ([InventoryId], [CarId], [StockQuantity], [AvailableQuantity], [IsAvailable], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [BrandId], [ModelId]) VALUES (40, 40, 10, 10, 1, 0, CAST(N'2024-08-28T12:03:53.587' AS DateTime), CAST(N'2024-08-28T12:03:53.587' AS DateTime), 1, 1, 10, 20)
SET IDENTITY_INSERT [vbs].[TblInventoryDetails] OFF
SET IDENTITY_INSERT [vbs].[TblOrder] ON 

INSERT [vbs].[TblOrder] ([OrderId], [OrderNumber], [UserId], [CarId], [PaymentTypeId], [StatusId], [OrderDate], [ExpectDeliverDate], [ActualDeliverDate], [BookingAmount], [TotalAmount], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (1, N'ORD20240831001', 13, 4, 3, 6, CAST(N'2024-08-31' AS Date), CAST(N'2024-09-25' AS Date), CAST(N'2024-09-28' AS Date), CAST(54600.00 AS Decimal(10, 2)), CAST(54600.00 AS Decimal(10, 2)), 0, CAST(N'2024-08-31' AS Date), CAST(N'2024-08-31' AS Date), 1, 1)
INSERT [vbs].[TblOrder] ([OrderId], [OrderNumber], [UserId], [CarId], [PaymentTypeId], [StatusId], [OrderDate], [ExpectDeliverDate], [ActualDeliverDate], [BookingAmount], [TotalAmount], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (2, N'ORD20240902001', 18, 2, 2, 6, CAST(N'2024-09-02' AS Date), CAST(N'2024-09-15' AS Date), CAST(N'2024-09-17' AS Date), CAST(28200.00 AS Decimal(10, 2)), CAST(56800.00 AS Decimal(10, 2)), 0, CAST(N'2024-09-02' AS Date), CAST(N'2024-09-02' AS Date), 1, 1)
INSERT [vbs].[TblOrder] ([OrderId], [OrderNumber], [UserId], [CarId], [PaymentTypeId], [StatusId], [OrderDate], [ExpectDeliverDate], [ActualDeliverDate], [BookingAmount], [TotalAmount], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (3, N'ORD20240902002', 18, 2, 2, 6, CAST(N'2024-09-02' AS Date), CAST(N'2024-09-13' AS Date), CAST(N'2024-09-19' AS Date), CAST(28200.00 AS Decimal(10, 2)), CAST(56800.00 AS Decimal(10, 2)), 0, CAST(N'2024-09-02' AS Date), CAST(N'2024-09-02' AS Date), 1, 1)
INSERT [vbs].[TblOrder] ([OrderId], [OrderNumber], [UserId], [CarId], [PaymentTypeId], [StatusId], [OrderDate], [ExpectDeliverDate], [ActualDeliverDate], [BookingAmount], [TotalAmount], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (4, N'ORD20240902003', 13, 1, 1, 9, CAST(N'2024-09-02' AS Date), CAST(N'2024-09-29' AS Date), CAST(N'2024-09-30' AS Date), CAST(0.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), 0, CAST(N'2024-09-02' AS Date), CAST(N'2024-09-02' AS Date), 1, 1)
INSERT [vbs].[TblOrder] ([OrderId], [OrderNumber], [UserId], [CarId], [PaymentTypeId], [StatusId], [OrderDate], [ExpectDeliverDate], [ActualDeliverDate], [BookingAmount], [TotalAmount], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (5, N'ORD20240903001', 13, 6, 1, 3, CAST(N'2024-09-03' AS Date), CAST(N'2024-09-21' AS Date), CAST(N'2024-09-22' AS Date), CAST(0.00 AS Decimal(10, 2)), CAST(91000.00 AS Decimal(10, 2)), 0, CAST(N'2024-09-03' AS Date), CAST(N'2024-09-03' AS Date), 2, 2)
INSERT [vbs].[TblOrder] ([OrderId], [OrderNumber], [UserId], [CarId], [PaymentTypeId], [StatusId], [OrderDate], [ExpectDeliverDate], [ActualDeliverDate], [BookingAmount], [TotalAmount], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (6, N'ORD20240903002', 13, 8, 1, 3, CAST(N'2024-09-03' AS Date), CAST(N'2024-09-25' AS Date), CAST(N'2024-10-02' AS Date), CAST(0.00 AS Decimal(10, 2)), CAST(113500.00 AS Decimal(10, 2)), 0, CAST(N'2024-09-03' AS Date), CAST(N'2024-09-03' AS Date), 2, 2)
INSERT [vbs].[TblOrder] ([OrderId], [OrderNumber], [UserId], [CarId], [PaymentTypeId], [StatusId], [OrderDate], [ExpectDeliverDate], [ActualDeliverDate], [BookingAmount], [TotalAmount], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (7, N'ORD20240904001', 19, 9, 2, 6, CAST(N'2024-09-04' AS Date), CAST(N'2024-09-15' AS Date), CAST(N'2024-09-18' AS Date), CAST(54600.00 AS Decimal(10, 2)), CAST(84700.00 AS Decimal(10, 2)), 0, CAST(N'2024-09-04' AS Date), CAST(N'2024-09-04' AS Date), 2, 1)
SET IDENTITY_INSERT [vbs].[TblOrder] OFF
SET IDENTITY_INSERT [vbs].[TblServiceDetails] ON 

INSERT [vbs].[TblServiceDetails] ([ServiceId], [UserId], [CarId], [ServiceTypeId], [ServiceDate], [ServiceCost], [ServiceDescription], [IsUnderWarrenty], [NextServiceDate], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [StatusId]) VALUES (1, 13, 4, 1, CAST(N'2024-08-31T15:48:50.230' AS DateTime), CAST(0.00 AS Decimal(10, 2)), N'General Service', 1, CAST(N'2024-11-30T15:48:50.230' AS DateTime), 0, CAST(N'2024-08-31T15:48:50.230' AS DateTime), CAST(N'2024-08-31T15:48:50.230' AS DateTime), 2, 1, 6)
INSERT [vbs].[TblServiceDetails] ([ServiceId], [UserId], [CarId], [ServiceTypeId], [ServiceDate], [ServiceCost], [ServiceDescription], [IsUnderWarrenty], [NextServiceDate], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [StatusId]) VALUES (2, 18, 4, 1, CAST(N'2024-09-02T17:26:16.137' AS DateTime), CAST(0.00 AS Decimal(10, 2)), N'', 1, CAST(N'2024-12-02T17:26:16.137' AS DateTime), 0, CAST(N'2024-09-02T17:26:16.137' AS DateTime), CAST(N'2024-09-02T17:26:16.137' AS DateTime), 2, 1, 2)
INSERT [vbs].[TblServiceDetails] ([ServiceId], [UserId], [CarId], [ServiceTypeId], [ServiceDate], [ServiceCost], [ServiceDescription], [IsUnderWarrenty], [NextServiceDate], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [StatusId]) VALUES (3, 19, 9, 1, CAST(N'2024-09-04T15:43:24.580' AS DateTime), CAST(0.00 AS Decimal(10, 2)), N'', 1, CAST(N'2024-12-04T15:43:24.580' AS DateTime), 0, CAST(N'2024-09-04T15:43:24.580' AS DateTime), CAST(N'2024-09-04T15:43:24.580' AS DateTime), 2, 1, 2)
SET IDENTITY_INSERT [vbs].[TblServiceDetails] OFF
SET IDENTITY_INSERT [vbs].[TblUsers] ON 

INSERT [vbs].[TblUsers] ([UserId], [FirstName], [LastName], [DateOfBirth], [UserName], [Password], [Gender], [PhoneNumber], [RoleId], [Address], [AadharNumber], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [UserImage]) VALUES (1, N'Arun', N'Kumar', CAST(N'1985-05-20' AS Date), N'arunkumar@gmail.com', N'arun@123', 1, N'9876543210', 1, N'Chennai, Tamil Nadu', N'123456789012', 0, CAST(N'2024-08-23T09:59:26.840' AS DateTime), CAST(N'2024-08-23T09:59:26.840' AS DateTime), 1, 1, N'/assets/img/userimg/image_2024_09_02T07_23_35_769Z.png')
INSERT [vbs].[TblUsers] ([UserId], [FirstName], [LastName], [DateOfBirth], [UserName], [Password], [Gender], [PhoneNumber], [RoleId], [Address], [AadharNumber], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [UserImage]) VALUES (2, N'Lakshmi', N'Rai', CAST(N'1990-08-15' AS Date), N'lakshmiraj@gmail.com', N'Lakhmi@123', 0, N'9876543211', 2, N'Coimbatore, Tamil Nadu', N'123456789013', 1, CAST(N'2024-08-23T09:59:26.840' AS DateTime), CAST(N'2024-08-30T21:30:33.030' AS DateTime), 1, 1, NULL)
INSERT [vbs].[TblUsers] ([UserId], [FirstName], [LastName], [DateOfBirth], [UserName], [Password], [Gender], [PhoneNumber], [RoleId], [Address], [AadharNumber], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [UserImage]) VALUES (3, N'Vikram', N'Prabhu', CAST(N'1988-11-22' AS Date), N'vikramprabhu@gmail.com', N'vikram@123', 1, N'9876543212', 2, N'Madurai, Tamil Nadu', N'123456789014', 0, CAST(N'2024-08-23T09:59:26.840' AS DateTime), CAST(N'2024-08-23T09:59:26.840' AS DateTime), 1, 1, NULL)
INSERT [vbs].[TblUsers] ([UserId], [FirstName], [LastName], [DateOfBirth], [UserName], [Password], [Gender], [PhoneNumber], [RoleId], [Address], [AadharNumber], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [UserImage]) VALUES (4, N'Meena', N'Sankar', CAST(N'1992-03-10' AS Date), N'meenasankar@gmail.com', N'meena@123', 0, N'9876543213', 2, N'Salem, Tamil Nadu', N'123456789015', 0, CAST(N'2024-08-23T09:59:26.840' AS DateTime), CAST(N'2024-08-23T09:59:26.840' AS DateTime), 1, 1, NULL)
INSERT [vbs].[TblUsers] ([UserId], [FirstName], [LastName], [DateOfBirth], [UserName], [Password], [Gender], [PhoneNumber], [RoleId], [Address], [AadharNumber], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [UserImage]) VALUES (5, N'Ravi', N'Teja', CAST(N'1986-06-18' AS Date), N'ravinarayanan@gmail.com', N'Password@123', 1, N'9876543214', 2, N'Trichy, Tamil Nadu', N'123456789016', 0, CAST(N'2024-08-23T09:59:26.840' AS DateTime), CAST(N'2024-08-23T16:39:30.437' AS DateTime), 1, 1, NULL)
INSERT [vbs].[TblUsers] ([UserId], [FirstName], [LastName], [DateOfBirth], [UserName], [Password], [Gender], [PhoneNumber], [RoleId], [Address], [AadharNumber], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [UserImage]) VALUES (6, N'Anitha', N'Balaji', CAST(N'1991-09-30' AS Date), N'anithabalaji@gmail.com', N'anitha@123', 0, N'9876543215', 2, N'Erode, Tamil Nadu', N'123456789017', 0, CAST(N'2024-08-23T09:59:26.840' AS DateTime), CAST(N'2024-08-23T09:59:26.840' AS DateTime), 1, 1, NULL)
INSERT [vbs].[TblUsers] ([UserId], [FirstName], [LastName], [DateOfBirth], [UserName], [Password], [Gender], [PhoneNumber], [RoleId], [Address], [AadharNumber], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [UserImage]) VALUES (7, N'Karthik', N'Venkatesh', CAST(N'1989-12-12' AS Date), N'karthikvenkatesh@gmail.com', N'karthik@123', 1, N'9876543216', 2, N'Thanjavur, Tamil Nadu', N'123456789018', 0, CAST(N'2024-08-23T09:59:26.840' AS DateTime), CAST(N'2024-08-23T09:59:26.840' AS DateTime), 1, 1, NULL)
INSERT [vbs].[TblUsers] ([UserId], [FirstName], [LastName], [DateOfBirth], [UserName], [Password], [Gender], [PhoneNumber], [RoleId], [Address], [AadharNumber], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [UserImage]) VALUES (8, N'Geetha', N'Sundar', CAST(N'1993-04-05' AS Date), N'geethasundar@gmail.com', N'geetha@123', 0, N'9876543217', 2, N'Tirunelveli, Tamil Nadu', N'123456789019', 0, CAST(N'2024-08-23T09:59:26.840' AS DateTime), CAST(N'2024-08-23T09:59:26.840' AS DateTime), 1, 1, NULL)
INSERT [vbs].[TblUsers] ([UserId], [FirstName], [LastName], [DateOfBirth], [UserName], [Password], [Gender], [PhoneNumber], [RoleId], [Address], [AadharNumber], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [UserImage]) VALUES (9, N'Manoj', N'Krishna', CAST(N'1987-07-21' AS Date), N'manojkrishna@gmail.com', N'manoj@123', 1, N'9876543218', 2, N'Vellore, Tamil Nadu', N'123456789020', 0, CAST(N'2024-08-23T09:59:26.840' AS DateTime), CAST(N'2024-08-23T09:59:26.840' AS DateTime), 1, 1, NULL)
INSERT [vbs].[TblUsers] ([UserId], [FirstName], [LastName], [DateOfBirth], [UserName], [Password], [Gender], [PhoneNumber], [RoleId], [Address], [AadharNumber], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [UserImage]) VALUES (10, N'Divya', N'Ram', CAST(N'1994-01-11' AS Date), N'divyaram@gmail.com', N'divya@123', 0, N'9876543219', 2, N'Nagercoil, Tamil Nadu', N'123456789021', 0, CAST(N'2024-08-23T09:59:26.840' AS DateTime), CAST(N'2024-08-23T09:59:26.840' AS DateTime), 1, 1, NULL)
INSERT [vbs].[TblUsers] ([UserId], [FirstName], [LastName], [DateOfBirth], [UserName], [Password], [Gender], [PhoneNumber], [RoleId], [Address], [AadharNumber], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [UserImage]) VALUES (11, N'Pravin', N'raj', CAST(N'2004-06-10' AS Date), N'pravin@gmail.com', N'pravin@123', 1, N'9943910848', 1, N'Allikondapattu,Tiruvannamalai-606811', N'953477757376', 0, CAST(N'2024-08-23T10:18:56.717' AS DateTime), CAST(N'2024-08-23T10:38:51.923' AS DateTime), 1, 1, NULL)
INSERT [vbs].[TblUsers] ([UserId], [FirstName], [LastName], [DateOfBirth], [UserName], [Password], [Gender], [PhoneNumber], [RoleId], [Address], [AadharNumber], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [UserImage]) VALUES (12, N'Joseph', N'Thomos', CAST(N'2021-06-18' AS Date), N'joseph@gmail.com', N'Joseph@123', 1, N'4353464564', 2, N'Tiruvannamali', N'454245424524', 1, CAST(N'2024-08-23T12:45:11.653' AS DateTime), CAST(N'2024-08-23T12:56:35.410' AS DateTime), 1, 1, NULL)
INSERT [vbs].[TblUsers] ([UserId], [FirstName], [LastName], [DateOfBirth], [UserName], [Password], [Gender], [PhoneNumber], [RoleId], [Address], [AadharNumber], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [UserImage]) VALUES (13, N'Pravin', N'raj S', CAST(N'2004-06-10' AS Date), N'rajspravin@gmail.com', N'pravin@123', 1, N'9943910848', 2, N'194,parai street,allikondapattu,tiruvannamalai', N'953477757376', 0, CAST(N'2024-08-28T10:35:08.687' AS DateTime), CAST(N'2024-08-28T10:35:08.687' AS DateTime), 1, 1, N'/assets/img/userimage/56544d81-3870-406f-9101-9ef32688f05a.jpg')
INSERT [vbs].[TblUsers] ([UserId], [FirstName], [LastName], [DateOfBirth], [UserName], [Password], [Gender], [PhoneNumber], [RoleId], [Address], [AadharNumber], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [UserImage]) VALUES (14, N'Inbanesan', N'I', CAST(N'2004-12-13' AS Date), N'inbanesan@gmail.com', N'inba@123', 1, N'9789271260', 2, N'22/23 11th new street polur road tiruvannamail', N'953477757376', 0, CAST(N'2024-08-30T15:25:10.460' AS DateTime), CAST(N'2024-08-30T15:25:10.460' AS DateTime), 0, 0, N'/assets/img/userimage/23bb1d35-de09-49c2-a817-fa72f57e2fcd.png')
INSERT [vbs].[TblUsers] ([UserId], [FirstName], [LastName], [DateOfBirth], [UserName], [Password], [Gender], [PhoneNumber], [RoleId], [Address], [AadharNumber], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [UserImage]) VALUES (15, N'Arul', N'Raj A', CAST(N'2004-05-09' AS Date), N'arulraj@gmail.com', N'arul@123', 1, N'9787307241', 2, N'Boscosoft, Yelagiri hills , Tirupathur', N'953477757376', 0, CAST(N'2024-08-30T15:34:01.677' AS DateTime), CAST(N'2024-08-30T15:34:01.677' AS DateTime), 2, 2, N'/assets/img/userimage/b2c3a4a7-5f58-4378-925a-afe55fe5a040.jpg')
INSERT [vbs].[TblUsers] ([UserId], [FirstName], [LastName], [DateOfBirth], [UserName], [Password], [Gender], [PhoneNumber], [RoleId], [Address], [AadharNumber], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [UserImage]) VALUES (16, N'Joseph', N'Thomos', CAST(N'2004-06-10' AS Date), N'joseph@gmail.com', N'Joseph@123', 1, N'9943910848', 2, N'Sanipoondi, Tiruvannamalai', N'454245424524', 0, CAST(N'2024-08-30T17:59:10.040' AS DateTime), CAST(N'2024-08-30T17:59:10.040' AS DateTime), 1, 1, N'/assets/img/userimage/853a42c4-10f6-4600-8429-955e9c53e84a.jpg')
INSERT [vbs].[TblUsers] ([UserId], [FirstName], [LastName], [DateOfBirth], [UserName], [Password], [Gender], [PhoneNumber], [RoleId], [Address], [AadharNumber], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [UserImage]) VALUES (17, N'albin', N'Antony', CAST(N'2024-08-30' AS Date), N'billy@gmail.com', N'billy@123', 1, N'64565464564', 2, N'ryththrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrthrthrth', N'242342423424', 0, CAST(N'2024-08-30T21:05:41.390' AS DateTime), CAST(N'2024-08-30T21:05:41.390' AS DateTime), 0, 0, N'/assets/img/userimage/2e76257d-77f1-4805-8160-55178d41c3b2.user')
INSERT [vbs].[TblUsers] ([UserId], [FirstName], [LastName], [DateOfBirth], [UserName], [Password], [Gender], [PhoneNumber], [RoleId], [Address], [AadharNumber], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [UserImage]) VALUES (18, N'Nirmal', N'I', CAST(N'2004-06-12' AS Date), N'nirmal@gmail.com', N'nirmal@123', 1, N'9943910848', 2, N'194,parai street,allikondapattu,tiruvannamalai', N'95347757376', 0, CAST(N'2024-09-02T17:19:23.780' AS DateTime), CAST(N'2024-09-02T17:19:23.780' AS DateTime), 0, 0, N'/assets/img/userimage/d7e93f8c-ad6e-48c9-8ed8-7ffd40c0b4a0.jpg')
INSERT [vbs].[TblUsers] ([UserId], [FirstName], [LastName], [DateOfBirth], [UserName], [Password], [Gender], [PhoneNumber], [RoleId], [Address], [AadharNumber], [IsDelete], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy], [UserImage]) VALUES (19, N'Angel', N'Aaseervatham', CAST(N'2004-02-12' AS Date), N'angel@gmail.com', N'angel@123', 0, N'9943910848', 2, N'194,parai street,allikondapattu', N'953477757376', 0, CAST(N'2024-09-04T15:40:33.977' AS DateTime), CAST(N'2024-09-04T15:40:33.977' AS DateTime), 0, 0, N'/assets/img/userimage/ccb6da18-6ec4-4fc0-a192-42cb1cd69522.jpg')
SET IDENTITY_INSERT [vbs].[TblUsers] OFF
ALTER TABLE [support].[TblBrand] ADD  DEFAULT ((0)) FOR [IsDelete]
GO
ALTER TABLE [support].[TblBrand] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [support].[TblBrand] ADD  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [support].[TblModels] ADD  DEFAULT ((0)) FOR [IsDelete]
GO
ALTER TABLE [support].[TblModels] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [support].[TblModels] ADD  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [support].[TblPaymentType] ADD  DEFAULT ((0)) FOR [IsDelete]
GO
ALTER TABLE [support].[TblPaymentType] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [support].[TblPaymentType] ADD  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [support].[TblRole] ADD  DEFAULT ((0)) FOR [IsDelete]
GO
ALTER TABLE [support].[TblRole] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [support].[TblRole] ADD  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [support].[TblServiceType] ADD  DEFAULT ((0)) FOR [IsDelete]
GO
ALTER TABLE [support].[TblServiceType] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [support].[TblServiceType] ADD  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [support].[TblStatus] ADD  DEFAULT ((0)) FOR [IsDelete]
GO
ALTER TABLE [support].[TblStatus] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [support].[TblStatus] ADD  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [vbs].[TblAllotment] ADD  CONSTRAINT [DF_TblAllotment_IsDelete]  DEFAULT ((0)) FOR [IsDelete]
GO
ALTER TABLE [vbs].[TblAllotment] ADD  CONSTRAINT [DF__TblAllotm__Creat__2EA5EC27]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [vbs].[TblCarDetails] ADD  DEFAULT ((0)) FOR [IsDelete]
GO
ALTER TABLE [vbs].[TblCarDetails] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [vbs].[TblCarDetails] ADD  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [vbs].[TblInventoryDetails] ADD  DEFAULT ((0)) FOR [IsAvailable]
GO
ALTER TABLE [vbs].[TblInventoryDetails] ADD  DEFAULT ((0)) FOR [IsDelete]
GO
ALTER TABLE [vbs].[TblInventoryDetails] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [vbs].[TblInventoryDetails] ADD  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [vbs].[TblInventoryDetails] ADD  DEFAULT ((0)) FOR [BrandId]
GO
ALTER TABLE [vbs].[TblInventoryDetails] ADD  DEFAULT ((0)) FOR [ModelId]
GO
ALTER TABLE [vbs].[TblOrder] ADD  CONSTRAINT [DF__TblOrder__OrderD__22401542]  DEFAULT (getdate()) FOR [OrderDate]
GO
ALTER TABLE [vbs].[TblOrder] ADD  CONSTRAINT [DF__TblOrder__IsDele__2334397B]  DEFAULT ((0)) FOR [IsDelete]
GO
ALTER TABLE [vbs].[TblOrder] ADD  CONSTRAINT [DF__TblOrder__Create__24285DB4]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [vbs].[TblOrder] ADD  CONSTRAINT [DF__TblOrder__Modifi__251C81ED]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [vbs].[TblServiceDetails] ADD  CONSTRAINT [DF__TblServic__IsDel__6DCC4D03]  DEFAULT ((0)) FOR [IsDelete]
GO
ALTER TABLE [vbs].[TblServiceDetails] ADD  CONSTRAINT [DF__TblServic__Creat__6EC0713C]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [vbs].[TblServiceDetails] ADD  CONSTRAINT [DF__TblServic__Modif__6FB49575]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [vbs].[TblUsers] ADD  DEFAULT ((0)) FOR [Gender]
GO
ALTER TABLE [vbs].[TblUsers] ADD  DEFAULT ((0)) FOR [IsDelete]
GO
ALTER TABLE [vbs].[TblUsers] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [vbs].[TblUsers] ADD  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [support].[TblModels]  WITH CHECK ADD  CONSTRAINT [FK_TblModels_Brand] FOREIGN KEY([BrandId])
REFERENCES [support].[TblBrand] ([BrandId])
GO
ALTER TABLE [support].[TblModels] CHECK CONSTRAINT [FK_TblModels_Brand]
GO
ALTER TABLE [vbs].[TblAllotment]  WITH CHECK ADD  CONSTRAINT [FK__TblAllotm__CarId__308E3499] FOREIGN KEY([CarId])
REFERENCES [vbs].[TblCarDetails] ([CarId])
GO
ALTER TABLE [vbs].[TblAllotment] CHECK CONSTRAINT [FK__TblAllotm__CarId__308E3499]
GO
ALTER TABLE [vbs].[TblAllotment]  WITH CHECK ADD  CONSTRAINT [FK__TblAllotm__Statu__318258D2] FOREIGN KEY([StatusId])
REFERENCES [support].[TblStatus] ([StatusId])
GO
ALTER TABLE [vbs].[TblAllotment] CHECK CONSTRAINT [FK__TblAllotm__Statu__318258D2]
GO
ALTER TABLE [vbs].[TblAllotment]  WITH CHECK ADD  CONSTRAINT [FK__TblAllotm__UserI__2F9A1060] FOREIGN KEY([UserId])
REFERENCES [vbs].[TblUsers] ([UserId])
GO
ALTER TABLE [vbs].[TblAllotment] CHECK CONSTRAINT [FK__TblAllotm__UserI__2F9A1060]
GO
ALTER TABLE [vbs].[TblCarDetails]  WITH CHECK ADD  CONSTRAINT [FK_TblCarDetails_BrandId] FOREIGN KEY([BrandId])
REFERENCES [support].[TblBrand] ([BrandId])
GO
ALTER TABLE [vbs].[TblCarDetails] CHECK CONSTRAINT [FK_TblCarDetails_BrandId]
GO
ALTER TABLE [vbs].[TblCarDetails]  WITH CHECK ADD  CONSTRAINT [FK_TblCarDetails_ModelId] FOREIGN KEY([ModelId])
REFERENCES [support].[TblModels] ([ModelId])
GO
ALTER TABLE [vbs].[TblCarDetails] CHECK CONSTRAINT [FK_TblCarDetails_ModelId]
GO
ALTER TABLE [vbs].[TblInventoryDetails]  WITH CHECK ADD FOREIGN KEY([CarId])
REFERENCES [vbs].[TblCarDetails] ([CarId])
GO
ALTER TABLE [vbs].[TblOrder]  WITH CHECK ADD  CONSTRAINT [FK__TblOrder__CarId__1F63A897] FOREIGN KEY([CarId])
REFERENCES [vbs].[TblCarDetails] ([CarId])
GO
ALTER TABLE [vbs].[TblOrder] CHECK CONSTRAINT [FK__TblOrder__CarId__1F63A897]
GO
ALTER TABLE [vbs].[TblOrder]  WITH CHECK ADD  CONSTRAINT [FK__TblOrder__Paymen__2057CCD0] FOREIGN KEY([PaymentTypeId])
REFERENCES [support].[TblPaymentType] ([PaymentTypeId])
GO
ALTER TABLE [vbs].[TblOrder] CHECK CONSTRAINT [FK__TblOrder__Paymen__2057CCD0]
GO
ALTER TABLE [vbs].[TblOrder]  WITH CHECK ADD  CONSTRAINT [FK__TblOrder__Status__214BF109] FOREIGN KEY([StatusId])
REFERENCES [support].[TblStatus] ([StatusId])
GO
ALTER TABLE [vbs].[TblOrder] CHECK CONSTRAINT [FK__TblOrder__Status__214BF109]
GO
ALTER TABLE [vbs].[TblOrder]  WITH CHECK ADD  CONSTRAINT [FK__TblOrder__UserId__1E6F845E] FOREIGN KEY([UserId])
REFERENCES [vbs].[TblUsers] ([UserId])
GO
ALTER TABLE [vbs].[TblOrder] CHECK CONSTRAINT [FK__TblOrder__UserId__1E6F845E]
GO
ALTER TABLE [vbs].[TblServiceDetails]  WITH CHECK ADD  CONSTRAINT [FK__TblServic__CarId__6BE40491] FOREIGN KEY([CarId])
REFERENCES [vbs].[TblCarDetails] ([CarId])
GO
ALTER TABLE [vbs].[TblServiceDetails] CHECK CONSTRAINT [FK__TblServic__CarId__6BE40491]
GO
ALTER TABLE [vbs].[TblServiceDetails]  WITH CHECK ADD  CONSTRAINT [FK__TblServic__Servi__6CD828CA] FOREIGN KEY([ServiceTypeId])
REFERENCES [support].[TblServiceType] ([ServiceTypeId])
GO
ALTER TABLE [vbs].[TblServiceDetails] CHECK CONSTRAINT [FK__TblServic__Servi__6CD828CA]
GO
ALTER TABLE [vbs].[TblServiceDetails]  WITH CHECK ADD  CONSTRAINT [FK__TblServic__UserI__6AEFE058] FOREIGN KEY([UserId])
REFERENCES [vbs].[TblUsers] ([UserId])
GO
ALTER TABLE [vbs].[TblServiceDetails] CHECK CONSTRAINT [FK__TblServic__UserI__6AEFE058]
GO
ALTER TABLE [vbs].[TblServiceDetails]  WITH CHECK ADD  CONSTRAINT [FK_ServiceDetails_Status] FOREIGN KEY([StatusId])
REFERENCES [support].[TblStatus] ([StatusId])
GO
ALTER TABLE [vbs].[TblServiceDetails] CHECK CONSTRAINT [FK_ServiceDetails_Status]
GO
ALTER TABLE [vbs].[TblUsers]  WITH CHECK ADD  CONSTRAINT [FK_TblUsers_RoleId] FOREIGN KEY([RoleId])
REFERENCES [support].[TblRole] ([RoleId])
GO
ALTER TABLE [vbs].[TblUsers] CHECK CONSTRAINT [FK_TblUsers_RoleId]
GO
