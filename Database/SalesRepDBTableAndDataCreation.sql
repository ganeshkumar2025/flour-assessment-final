USE [SalesRepDB]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 04-06-2025 13:01:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Category] [nvarchar](100) NULL,
	[Price] [decimal](10, 2) NULL,
	[IsActive] [bit] NULL,
	[stock] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sales]    Script Date: 04-06-2025 13:01:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sales](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SalesRepId] [int] NULL,
	[ProductId] [int] NULL,
	[Quantity] [int] NULL,
	[SaleDate] [date] NULL,
	[Amount] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalesRepresentatives]    Script Date: 04-06-2025 13:01:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesRepresentatives](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NULL,
	[LastName] [nvarchar](100) NULL,
	[Email] [nvarchar](150) NULL,
	[PhoneNumber] [nvarchar](20) NULL,
	[Region] [nvarchar](100) NULL,
	[HireDate] [date] NULL,
	[Status] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Targets]    Script Date: 04-06-2025 13:01:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Targets](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SalesRepId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[TargetMonth] [date] NOT NULL,
	[TargetAmount] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Products] ON 
GO
INSERT [dbo].[Products] ([Id], [Name], [Category], [Price], [IsActive], [stock]) VALUES (1, N'UltraCleaner X1', N'Cleaning Supplies', CAST(499.99 AS Decimal(10, 2)), 0, 116)
GO
INSERT [dbo].[Products] ([Id], [Name], [Category], [Price], [IsActive], [stock]) VALUES (2, N'SparkVac Pro', N'Electronics', CAST(1299.50 AS Decimal(10, 2)), 1, 100)
GO
INSERT [dbo].[Products] ([Id], [Name], [Category], [Price], [IsActive], [stock]) VALUES (3, N'EcoMop 3000', N'Cleaning Supplies', CAST(299.00 AS Decimal(10, 2)), 0, 100)
GO
INSERT [dbo].[Products] ([Id], [Name], [Category], [Price], [IsActive], [stock]) VALUES (4, N'Test Product', N'Electronics', CAST(499.99 AS Decimal(10, 2)), 1, 100)
GO
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[Sales] ON 
GO
INSERT [dbo].[Sales] ([Id], [SalesRepId], [ProductId], [Quantity], [SaleDate], [Amount]) VALUES (1, 1, 1, 10, CAST(N'2025-05-01' AS Date), CAST(4999.90 AS Decimal(10, 2)))
GO
INSERT [dbo].[Sales] ([Id], [SalesRepId], [ProductId], [Quantity], [SaleDate], [Amount]) VALUES (2, 2, 2, 5, CAST(N'2025-05-10' AS Date), CAST(6497.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[Sales] ([Id], [SalesRepId], [ProductId], [Quantity], [SaleDate], [Amount]) VALUES (3, 1, 2, 2, CAST(N'2025-05-15' AS Date), CAST(2599.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Sales] ([Id], [SalesRepId], [ProductId], [Quantity], [SaleDate], [Amount]) VALUES (4, 8, 1, 1, CAST(N'2023-12-01' AS Date), CAST(1500.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Sales] ([Id], [SalesRepId], [ProductId], [Quantity], [SaleDate], [Amount]) VALUES (5, 8, 1, 1, CAST(N'2024-03-10' AS Date), CAST(1750.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Sales] ([Id], [SalesRepId], [ProductId], [Quantity], [SaleDate], [Amount]) VALUES (6, 8, 4, 300, CAST(N'2025-06-03' AS Date), CAST(0.00 AS Decimal(10, 2)))
GO
SET IDENTITY_INSERT [dbo].[Sales] OFF
GO
SET IDENTITY_INSERT [dbo].[SalesRepresentatives] ON 
GO
INSERT [dbo].[SalesRepresentatives] ([Id], [FirstName], [LastName], [Email], [PhoneNumber], [Region], [HireDate], [Status]) VALUES (1, N'Rahul', N'Malhotra', N'rahul.mehra@example.com', N'9876543210', N'East', CAST(N'2022-04-04' AS Date), N'Active')
GO
INSERT [dbo].[SalesRepresentatives] ([Id], [FirstName], [LastName], [Email], [PhoneNumber], [Region], [HireDate], [Status]) VALUES (2, N'Sneha', N'Rao', N'sneha.rao@example.com', N'9812345678', N'West', CAST(N'2023-01-12' AS Date), N'Active')
GO
INSERT [dbo].[SalesRepresentatives] ([Id], [FirstName], [LastName], [Email], [PhoneNumber], [Region], [HireDate], [Status]) VALUES (3, N'Amit', N'Singh', N'amit.singh@example.com', N'9923456781', N'North', CAST(N'2021-08-30' AS Date), N'Inactive')
GO
INSERT [dbo].[SalesRepresentatives] ([Id], [FirstName], [LastName], [Email], [PhoneNumber], [Region], [HireDate], [Status]) VALUES (8, N'Carol', N'Bennett', N'carol.bennett@example.com', N'5551112222', N'South', CAST(N'2020-09-01' AS Date), N'Active')
GO
INSERT [dbo].[SalesRepresentatives] ([Id], [FirstName], [LastName], [Email], [PhoneNumber], [Region], [HireDate], [Status]) VALUES (9, N'Test', N'Kumar', N'test@kumar.com', N'9810775099', N'India', CAST(N'2025-06-02' AS Date), N'Active')
GO
SET IDENTITY_INSERT [dbo].[SalesRepresentatives] OFF
GO
SET IDENTITY_INSERT [dbo].[Targets] ON 
GO
INSERT [dbo].[Targets] ([Id], [SalesRepId], [ProductId], [TargetMonth], [TargetAmount]) VALUES (5, 1, 1, CAST(N'2025-06-01' AS Date), CAST(5000.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Targets] ([Id], [SalesRepId], [ProductId], [TargetMonth], [TargetAmount]) VALUES (6, 2, 2, CAST(N'2025-06-01' AS Date), CAST(8000.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Targets] ([Id], [SalesRepId], [ProductId], [TargetMonth], [TargetAmount]) VALUES (7, 3, 2, CAST(N'2025-06-01' AS Date), CAST(4000.00 AS Decimal(10, 2)))
GO
SET IDENTITY_INSERT [dbo].[Targets] OFF
GO
ALTER TABLE [dbo].[Sales]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[Sales]  WITH CHECK ADD FOREIGN KEY([SalesRepId])
REFERENCES [dbo].[SalesRepresentatives] ([Id])
GO
ALTER TABLE [dbo].[Targets]  WITH CHECK ADD  CONSTRAINT [FK_Targets_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[Targets] CHECK CONSTRAINT [FK_Targets_Product]
GO
ALTER TABLE [dbo].[Targets]  WITH CHECK ADD  CONSTRAINT [FK_Targets_SalesRep] FOREIGN KEY([SalesRepId])
REFERENCES [dbo].[SalesRepresentatives] ([Id])
GO
ALTER TABLE [dbo].[Targets] CHECK CONSTRAINT [FK_Targets_SalesRep]
GO
