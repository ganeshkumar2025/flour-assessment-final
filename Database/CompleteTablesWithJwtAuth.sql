USE [SalesRepDB]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 14-06-2025 14:35:13 ******/
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
/****** Object:  Table [dbo].[RefreshTokens]    Script Date: 14-06-2025 14:35:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RefreshTokens](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Token] [nvarchar](255) NOT NULL,
	[UserId] [int] NOT NULL,
	[ExpiryDate] [datetime] NOT NULL,
	[IsRevoked] [bit] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[RevokedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 14-06-2025 14:35:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sales]    Script Date: 14-06-2025 14:35:14 ******/
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
/****** Object:  Table [dbo].[SalesRepresentatives]    Script Date: 14-06-2025 14:35:14 ******/
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
/****** Object:  Table [dbo].[Targets]    Script Date: 14-06-2025 14:35:14 ******/
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
/****** Object:  Table [dbo].[UserRoles]    Script Date: 14-06-2025 14:35:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 14-06-2025 14:35:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[PasswordHash] [nvarchar](255) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Products] ON 
GO
INSERT [dbo].[Products] ([Id], [Name], [Category], [Price], [IsActive], [stock]) VALUES (1, N'UltraCleaner X1', N'Cleaning Supplies', CAST(499.99 AS Decimal(10, 2)), 0, 117)
GO
INSERT [dbo].[Products] ([Id], [Name], [Category], [Price], [IsActive], [stock]) VALUES (2, N'SparkVac Pro', N'Electronics', CAST(1299.50 AS Decimal(10, 2)), 1, 100)
GO
INSERT [dbo].[Products] ([Id], [Name], [Category], [Price], [IsActive], [stock]) VALUES (3, N'EcoMop 3000', N'Cleaning Supplies', CAST(299.00 AS Decimal(10, 2)), 0, 100)
GO
INSERT [dbo].[Products] ([Id], [Name], [Category], [Price], [IsActive], [stock]) VALUES (4, N'Test Product', N'Electronics', CAST(499.99 AS Decimal(10, 2)), 1, 100)
GO
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[RefreshTokens] ON 
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [UserId], [ExpiryDate], [IsRevoked], [CreatedAt], [RevokedAt]) VALUES (4, N'q36cjmX6Nqy6EaVPHktrC155GLM4nU7aFfO/N1gAd9LSa3Km9z9Uj1DR5KPX7MYQSCPRQ5zjqs2RQWF6WXyNwA==', 1, CAST(N'2025-06-16T20:12:04.377' AS DateTime), 1, CAST(N'2025-06-09T20:12:04.377' AS DateTime), CAST(N'2025-06-10T16:18:45.533' AS DateTime))
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [UserId], [ExpiryDate], [IsRevoked], [CreatedAt], [RevokedAt]) VALUES (5, N'ZOcnP3GTfLV/sy4wlnGsAR8Z/lXJcBP2eGOAepg39+IahN0qF8A2tPeGwL+493F6cwIBKKHE3HAqU1sbkfXM9A==', 1, CAST(N'2025-06-16T20:23:24.270' AS DateTime), 1, CAST(N'2025-06-09T20:23:24.270' AS DateTime), CAST(N'2025-06-10T16:18:45.533' AS DateTime))
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [UserId], [ExpiryDate], [IsRevoked], [CreatedAt], [RevokedAt]) VALUES (6, N'dg9//NNJiLYHNeFHI/++QvO/puUJL83jMNkgkZpCQhmwL9ixZWdPMyetTQoUVTpNF9ReCzUorzBKT1cvWULNSw==', 1, CAST(N'2025-06-16T20:43:17.033' AS DateTime), 1, CAST(N'2025-06-09T20:43:17.033' AS DateTime), CAST(N'2025-06-10T16:18:45.533' AS DateTime))
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [UserId], [ExpiryDate], [IsRevoked], [CreatedAt], [RevokedAt]) VALUES (7, N'a158PtIKY290WhXO2DPd5IV6jyCeit4NdbivbOVvYBEWbO2agPOs4PDmiM12kXIkN3AkwXyJl5scmTrzeENruA==', 1, CAST(N'2025-06-16T21:00:41.173' AS DateTime), 1, CAST(N'2025-06-09T21:00:41.173' AS DateTime), CAST(N'2025-06-10T16:18:45.533' AS DateTime))
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [UserId], [ExpiryDate], [IsRevoked], [CreatedAt], [RevokedAt]) VALUES (8, N'LYOMNDmWTbvofT1BUn5h/QjhzeRTWO7dFIdhLk9tga/+ta4EzaibLjbdLlc/QHg0K6uGARZlcHZODBND2I0gyg==', 1, CAST(N'2025-06-16T22:45:24.140' AS DateTime), 1, CAST(N'2025-06-09T22:45:24.140' AS DateTime), CAST(N'2025-06-10T16:18:45.533' AS DateTime))
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [UserId], [ExpiryDate], [IsRevoked], [CreatedAt], [RevokedAt]) VALUES (9, N'+BmDjF/x9s1YfGFJNRMRQ7wv2DszMpY09Qdu1CZhwAMPznUNARjjZLta9O1S0azHT+QVX5uFgPGoy6KcLB0msQ==', 2, CAST(N'2025-06-16T23:07:53.620' AS DateTime), 1, CAST(N'2025-06-09T23:07:53.620' AS DateTime), CAST(N'2025-06-10T16:33:09.483' AS DateTime))
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [UserId], [ExpiryDate], [IsRevoked], [CreatedAt], [RevokedAt]) VALUES (10, N'9u+fUQNkgxTOjdauIECN8LqO4hLFjqpy/TEUya1X6dTdAtoSGM4NUT4UcLgN6xYl6txQTyPq6olP2wbFOk2Hvw==', 2, CAST(N'2025-06-16T23:08:02.413' AS DateTime), 1, CAST(N'2025-06-09T23:08:02.413' AS DateTime), CAST(N'2025-06-10T16:33:09.483' AS DateTime))
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [UserId], [ExpiryDate], [IsRevoked], [CreatedAt], [RevokedAt]) VALUES (11, N'eSBqMjMZw3cmXfcaPML9vkHITjYnkO7suXcIXpVZ6VlnoPcHAmw4biNkI0lWBUs9vgMHexZ00P9zlkkQwzwV/A==', 2, CAST(N'2025-06-16T23:10:21.783' AS DateTime), 1, CAST(N'2025-06-09T23:10:21.783' AS DateTime), CAST(N'2025-06-10T16:33:09.483' AS DateTime))
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [UserId], [ExpiryDate], [IsRevoked], [CreatedAt], [RevokedAt]) VALUES (12, N'3Vc/hcL13Ct+Kn4DkVmtwX25ZH720RlyBbqglSMUwjPF/BVRUbQG3yyWWWBLtHY2vcKIVkN2xN0SacaaasIDCA==', 2, CAST(N'2025-06-16T23:10:33.547' AS DateTime), 1, CAST(N'2025-06-09T23:10:33.547' AS DateTime), CAST(N'2025-06-10T16:33:09.483' AS DateTime))
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [UserId], [ExpiryDate], [IsRevoked], [CreatedAt], [RevokedAt]) VALUES (13, N'pOgEPxPLk49OyoBNFd+KpxifXcbdpfaRJHdOu6OESt2WhYBg3duEjql9eHNAq3ErHBeK5r0eKVno9Uhu07KeiQ==', 2, CAST(N'2025-06-16T23:12:03.890' AS DateTime), 1, CAST(N'2025-06-09T23:12:03.890' AS DateTime), CAST(N'2025-06-10T16:33:09.483' AS DateTime))
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [UserId], [ExpiryDate], [IsRevoked], [CreatedAt], [RevokedAt]) VALUES (14, N'sWmSlCg2+3qu5WwBm+ZVBnD6LeCShNzwwgJ1AJEhzMjc7p0ItCCyKBMdB3OLaJzDMo+Rj+CYYrLApd5Ttmtuyw==', 2, CAST(N'2025-06-16T23:14:58.473' AS DateTime), 1, CAST(N'2025-06-09T23:14:58.473' AS DateTime), CAST(N'2025-06-10T16:33:09.483' AS DateTime))
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [UserId], [ExpiryDate], [IsRevoked], [CreatedAt], [RevokedAt]) VALUES (15, N'hHblsYOxBXImPxHBzLh28fJQOtradmZexwUhAtAL2ux2KmXvWSdQjEpxf5/DwFJqp50yVpILFDVUgW3TODLkyA==', 2, CAST(N'2025-06-16T23:20:52.293' AS DateTime), 1, CAST(N'2025-06-09T23:20:52.293' AS DateTime), CAST(N'2025-06-10T16:33:09.483' AS DateTime))
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [UserId], [ExpiryDate], [IsRevoked], [CreatedAt], [RevokedAt]) VALUES (16, N'uLk7rkYfIaRdlufE0+xzDt4DtNFbA/U8OFmdt2fw1I1BBB7QhHD0g+cqw33sij2m1e8IkktyGuCo/10FI+vHpA==', 1, CAST(N'2025-06-16T23:27:08.723' AS DateTime), 1, CAST(N'2025-06-09T23:27:08.723' AS DateTime), CAST(N'2025-06-10T16:18:45.533' AS DateTime))
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [UserId], [ExpiryDate], [IsRevoked], [CreatedAt], [RevokedAt]) VALUES (17, N'grPluRaCbN/QuUUKlng77/2fq/dkP/Zcc3Q5oBDh5Aq5nUfWbl+4V4JaDpFIm7s9VX3Ysk+Is1+2+j03yLdFNw==', 1, CAST(N'2025-06-16T23:27:51.813' AS DateTime), 1, CAST(N'2025-06-09T23:27:51.813' AS DateTime), CAST(N'2025-06-10T16:18:45.533' AS DateTime))
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [UserId], [ExpiryDate], [IsRevoked], [CreatedAt], [RevokedAt]) VALUES (18, N'lQKJvtbXnw064oNF/Zqsug45i1XlWVoVrgs7joh65j4GOLBjrmOxZEJxRicvH1e1dxVbhl72oWnTFULk8vxbaQ==', 2, CAST(N'2025-06-16T23:38:45.567' AS DateTime), 1, CAST(N'2025-06-09T23:38:45.567' AS DateTime), CAST(N'2025-06-10T16:33:09.483' AS DateTime))
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [UserId], [ExpiryDate], [IsRevoked], [CreatedAt], [RevokedAt]) VALUES (19, N'x9+bUfRAocyYHX3sK3dwmHvmQieTRSqByXXHTPqvcgSePHbXB+R8I57EYwWB4D1TzzhypwC40ssve1js0SiPzw==', 2, CAST(N'2025-06-16T23:38:51.960' AS DateTime), 1, CAST(N'2025-06-09T23:38:51.960' AS DateTime), CAST(N'2025-06-10T16:33:09.483' AS DateTime))
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [UserId], [ExpiryDate], [IsRevoked], [CreatedAt], [RevokedAt]) VALUES (20, N'JSdkFK6rKq6Uh4W0mvajRioOSzkpGLjQruGJcJ/rNmM9EsSxXdxjveKrsTO2TwR8RhnpaU8jrU5bDPdhwGWy6Q==', 1, CAST(N'2025-06-16T23:50:19.233' AS DateTime), 1, CAST(N'2025-06-09T23:50:19.233' AS DateTime), CAST(N'2025-06-10T16:18:45.533' AS DateTime))
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [UserId], [ExpiryDate], [IsRevoked], [CreatedAt], [RevokedAt]) VALUES (21, N'MXbfewIWrLusdOcq5vHwsaQYLr3qMklmHONL2RNYX/4UWtMQE3T9O0X5GkopSAcOwt+z3QMhzPR51okpefPArA==', 1, CAST(N'2025-06-17T00:00:18.977' AS DateTime), 1, CAST(N'2025-06-10T00:00:18.977' AS DateTime), CAST(N'2025-06-10T16:18:45.533' AS DateTime))
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [UserId], [ExpiryDate], [IsRevoked], [CreatedAt], [RevokedAt]) VALUES (22, N'Sz17789I7injZZuw+A6RnyR+ZP1DNBzZjhxTnS3M1GjK/GEIHyE32YD9EReAFppIs5P/k/CVXTVqrdtiDdwllQ==', 1, CAST(N'2025-06-17T00:00:30.800' AS DateTime), 1, CAST(N'2025-06-10T00:00:30.800' AS DateTime), CAST(N'2025-06-10T16:18:45.533' AS DateTime))
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [UserId], [ExpiryDate], [IsRevoked], [CreatedAt], [RevokedAt]) VALUES (23, N'vZaiwC8NbsDr/9G/lTkRqTYqJo2ckHkuHc+5ddNtv0e/5w1KSQBQEu5q3XqhYmgphOhtRME2H9S1eLLikxp6yA==', 1, CAST(N'2025-06-17T00:21:34.073' AS DateTime), 1, CAST(N'2025-06-10T00:21:34.073' AS DateTime), CAST(N'2025-06-10T16:18:45.533' AS DateTime))
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [UserId], [ExpiryDate], [IsRevoked], [CreatedAt], [RevokedAt]) VALUES (24, N'IKuRcPvyZQtwdUwpc5zzjdBsk/XhqgUjY+bZBUEoIe3UxkJRnlBucA06hYtiCO7XzLo/FiyvLheYDi7D44md6Q==', 1, CAST(N'2025-06-17T00:31:56.810' AS DateTime), 1, CAST(N'2025-06-10T00:31:56.810' AS DateTime), CAST(N'2025-06-10T16:18:45.533' AS DateTime))
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [UserId], [ExpiryDate], [IsRevoked], [CreatedAt], [RevokedAt]) VALUES (25, N'Ojnt9JfYkmHKzfz5LoyVnpjIcR7c1/SlhEXP1SjIOluZ81cRpnJ3Q9D86/LHt5tRkL5aO+L5G5oR+67pYgqqQQ==', 1, CAST(N'2025-06-17T01:20:01.563' AS DateTime), 1, CAST(N'2025-06-10T01:20:01.563' AS DateTime), CAST(N'2025-06-10T16:18:45.533' AS DateTime))
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [UserId], [ExpiryDate], [IsRevoked], [CreatedAt], [RevokedAt]) VALUES (26, N'S7yifgZXH2yyzc1vk5jiH+CGqakw+PHFsl+tdURSiw9tGTK3vSsciYFZKG93Mv1d+ohuR2x1YW4vR2tLO/ebZw==', 2, CAST(N'2025-06-17T01:27:34.287' AS DateTime), 1, CAST(N'2025-06-10T01:27:34.287' AS DateTime), CAST(N'2025-06-10T16:33:09.483' AS DateTime))
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [UserId], [ExpiryDate], [IsRevoked], [CreatedAt], [RevokedAt]) VALUES (27, N'HraMcD1I6+h6iLKsvBwF8lhealRX25vH4zxeCxp36y3XSPLF8XFM+baVvE8zWFg6dKrX7WpIAw1KNltzZN6MjQ==', 1, CAST(N'2025-06-17T01:48:49.343' AS DateTime), 1, CAST(N'2025-06-10T01:48:49.343' AS DateTime), CAST(N'2025-06-10T16:18:45.533' AS DateTime))
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [UserId], [ExpiryDate], [IsRevoked], [CreatedAt], [RevokedAt]) VALUES (28, N'8w5GLBIl1uf+TvdbJ2kWvd/uOO8OOtoijqoRlaXQYswcj6VBxs/6PCnI1nSVQov9GPVn020KDIyA1Btun49qXw==', 1, CAST(N'2025-06-17T01:54:34.423' AS DateTime), 1, CAST(N'2025-06-10T01:54:34.423' AS DateTime), CAST(N'2025-06-10T16:18:45.533' AS DateTime))
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [UserId], [ExpiryDate], [IsRevoked], [CreatedAt], [RevokedAt]) VALUES (29, N'RxI19T+3/LPSPT0dMTZeNm4HPDSp5URiBTjInNI2Rt9n66E1/e3N+8g5wVONFB6OWccK6hqZ5jfc+3IvXwsSwg==', 2, CAST(N'2025-06-17T01:55:48.093' AS DateTime), 1, CAST(N'2025-06-10T01:55:48.093' AS DateTime), CAST(N'2025-06-10T16:33:09.483' AS DateTime))
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [UserId], [ExpiryDate], [IsRevoked], [CreatedAt], [RevokedAt]) VALUES (30, N'FN5Stkjf/nAJgz61kkFY36VtVXg1D8QyBzPYgYHz3fd6idJOa4baaGQLegB+qBuvt36lh3KJijpbL8s1hyhC3Q==', 1, CAST(N'2025-06-17T11:38:39.147' AS DateTime), 1, CAST(N'2025-06-10T11:38:39.147' AS DateTime), CAST(N'2025-06-10T16:18:45.533' AS DateTime))
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [UserId], [ExpiryDate], [IsRevoked], [CreatedAt], [RevokedAt]) VALUES (31, N'gkj/fC/z8vRCRQqJzX4/OzIhegt/6Tl9nrcw/1v07AhIh+XTcLnZLGWCCRNhas/RqotL+/kuNYBTvkCcBZYNkg==', 2, CAST(N'2025-06-17T11:49:29.893' AS DateTime), 1, CAST(N'2025-06-10T11:49:29.893' AS DateTime), CAST(N'2025-06-10T16:33:09.483' AS DateTime))
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [UserId], [ExpiryDate], [IsRevoked], [CreatedAt], [RevokedAt]) VALUES (32, N'722yypotCx+Eod4AXRQfCB7u8/Lv8gpzI76ScXHwE+9aF+8anSJWuA1sL6mJPrVx30FMMlF/PSOODeQzi19V0Q==', 1, CAST(N'2025-06-17T21:48:45.533' AS DateTime), 0, CAST(N'2025-06-10T21:48:45.533' AS DateTime), NULL)
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [UserId], [ExpiryDate], [IsRevoked], [CreatedAt], [RevokedAt]) VALUES (33, N'LiCTRolWaZI2/nm1aMki5MB+abSdBIkl73TlRHIW1bqMgfbYSSEP6f66vjKnlZdRXEPYjmXC0iU/pRlZLEJnKw==', 2, CAST(N'2025-06-17T22:03:09.483' AS DateTime), 1, CAST(N'2025-06-10T22:03:09.483' AS DateTime), CAST(N'2025-06-10T16:37:14.403' AS DateTime))
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [UserId], [ExpiryDate], [IsRevoked], [CreatedAt], [RevokedAt]) VALUES (34, N'cT6MWLY750ktUy5CFz5Ibca27MaW/mbltZEGBo26gVZnRnKoPpeYxMX59vebC8XaAtgtRsR2q22b8EU3IaDe4Q==', 2, CAST(N'2025-06-17T22:07:14.403' AS DateTime), 0, CAST(N'2025-06-10T22:07:14.403' AS DateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[RefreshTokens] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 
GO
INSERT [dbo].[Roles] ([Id], [Name]) VALUES (1, N'Admin')
GO
INSERT [dbo].[Roles] ([Id], [Name]) VALUES (2, N'SalesManager')
GO
INSERT [dbo].[Roles] ([Id], [Name]) VALUES (3, N'SalesRep')
GO
SET IDENTITY_INSERT [dbo].[Roles] OFF
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
INSERT [dbo].[Sales] ([Id], [SalesRepId], [ProductId], [Quantity], [SaleDate], [Amount]) VALUES (7, 9, 4, 3, CAST(N'2000-01-01' AS Date), CAST(0.00 AS Decimal(10, 2)))
GO
SET IDENTITY_INSERT [dbo].[Sales] OFF
GO
SET IDENTITY_INSERT [dbo].[SalesRepresentatives] ON 
GO
INSERT [dbo].[SalesRepresentatives] ([Id], [FirstName], [LastName], [Email], [PhoneNumber], [Region], [HireDate], [Status]) VALUES (1, N'Rahul', N'Malhotra', N'rahul.mehra@example.com', N'9876543210', N'East', CAST(N'2022-04-22' AS Date), N'Active')
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
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (1, 1)
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (2, 2)
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([Id], [Email], [PasswordHash], [CreatedAt], [IsActive]) VALUES (1, N'admin@test.com', N'HASHED_PASSWORD_1', CAST(N'2025-06-06T11:40:44.337' AS DateTime), 1)
GO
INSERT [dbo].[Users] ([Id], [Email], [PasswordHash], [CreatedAt], [IsActive]) VALUES (2, N'manager@test.com', N'HASHED_PASSWORD_2', CAST(N'2025-06-06T11:40:44.337' AS DateTime), 1)
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Roles__737584F62B324419]    Script Date: 14-06-2025 14:35:15 ******/
ALTER TABLE [dbo].[Roles] ADD UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__A9D1053468CD3F28]    Script Date: 14-06-2025 14:35:15 ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RefreshTokens] ADD  DEFAULT ((0)) FOR [IsRevoked]
GO
ALTER TABLE [dbo].[RefreshTokens] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[RefreshTokens]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
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
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
