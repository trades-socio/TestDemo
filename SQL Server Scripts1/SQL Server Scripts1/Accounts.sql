USE [TC_FXPrimus_Cov]
GO

/****** Object:  Table [dbo].[Accounts]    Script Date: 8/29/2019 5:31:00 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Accounts](
	[PK_AccountID] [int] IDENTITY(1,1) NOT NULL,
	[FK_ParticipantID] [bit] NOT NULL,
	[Balance] [decimal](18, 5) NULL,
	[Equity] [decimal](18, 5) NULL,
	[UsedMargin] [decimal](18, 5) NULL,
	[IsLive] [int] NULL,
	[ExternalID] [int] NOT NULL,
	[FK_ManagerID] [int] NOT NULL,
	[FK_ParticipantAccountType] [int] NULL,
	[MinLotSupport] [int] NOT NULL,
	[LotStepSupport] [int] NOT NULL,
	[MasterManagerShare] [decimal](18, 2) NULL,
	[MasterShare] [decimal](18, 2) NULL,
	[SlaveShare] [decimal](18, 2) NULL,
	[FK_PSType] [int] NULL,
	[SlaveManagerShare] [decimal](18, 2) NULL,
	[TSShare] [decimal](18, 2) NULL,
	[IsActive] [int] NULL,
	[FK_GroupID] [int] NULL,
	[RootToMT4Server] [int] NULL,
	[ShareOnlyProfit] [int] NULL,
	[isAccountDisabledForTCSL] [int] NULL,
	[IsStopCopyTriggerDisabled] [int] NULL,
	[CoverageAccount] [int] NULL,
	[IsRebatedefined] [int] NULL,
	[RebateType] [int] NULL,
	[RebateValue] [decimal](18, 2) NULL,
	[Introducer] [int] NULL,
	[FK_BrokerShareType] [int] NULL,
 CONSTRAINT [PK_Accounts] PRIMARY KEY CLUSTERED 
(
	[PK_AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Accounts] ADD  CONSTRAINT [DF_Accounts_MinLotSupport]  DEFAULT ((1)) FOR [MinLotSupport]
GO

ALTER TABLE [dbo].[Accounts] ADD  CONSTRAINT [DF_Accounts_LotStepSupport]  DEFAULT ((1)) FOR [LotStepSupport]
GO

ALTER TABLE [dbo].[Accounts] ADD  CONSTRAINT [DF_Accounts_ShareOnlyProfit]  DEFAULT ((0)) FOR [ShareOnlyProfit]
GO

ALTER TABLE [dbo].[Accounts] ADD  CONSTRAINT [DF_Accounts_CoverageAccount]  DEFAULT ((-1)) FOR [CoverageAccount]
GO

ALTER TABLE [dbo].[Accounts] ADD  CONSTRAINT [DF_Accounts_FK_BrokerShareType]  DEFAULT ((-1)) FOR [FK_BrokerShareType]
GO

ALTER TABLE [dbo].[Accounts]  WITH NOCHECK ADD  CONSTRAINT [FK_Accounts_MT4managerInfo] FOREIGN KEY([FK_ManagerID])
REFERENCES [dbo].[MT4managerInfo] ([PK_ManagerID])
GO

ALTER TABLE [dbo].[Accounts] NOCHECK CONSTRAINT [FK_Accounts_MT4managerInfo]
GO

ALTER TABLE [dbo].[Accounts]  WITH NOCHECK ADD  CONSTRAINT [FK_Accounts_ParticipantAccountType] FOREIGN KEY([FK_ParticipantAccountType])
REFERENCES [dbo].[ParticipantAccountType] ([AccountTypeID])
GO

ALTER TABLE [dbo].[Accounts] NOCHECK CONSTRAINT [FK_Accounts_ParticipantAccountType]
GO

ALTER TABLE [dbo].[Accounts]  WITH NOCHECK ADD  CONSTRAINT [FK_Accounts_Participants] FOREIGN KEY([FK_ParticipantID])
REFERENCES [dbo].[Participants] ([PK_ParticipantID])
GO

ALTER TABLE [dbo].[Accounts] NOCHECK CONSTRAINT [FK_Accounts_Participants]
GO

ALTER TABLE [dbo].[Accounts]  WITH CHECK ADD  CONSTRAINT [CK_Accounts] CHECK  (([CoverageAccount]<>(0)))
GO

ALTER TABLE [dbo].[Accounts] CHECK CONSTRAINT [CK_Accounts]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'CovAccountNotZero' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Accounts', @level2type=N'CONSTRAINT',@level2name=N'CK_Accounts'
GO


