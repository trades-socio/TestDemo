USE [tc_stage3copy_23112018]
GO
/****** Object:  StoredProcedure [dbo].[ATE_GetOrdersForTest]    Script Date: 8/29/2019 10:12:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertParticipantDetail]    Script Date: 01/10/2016 17:09:03 ******/
ALTER PROCEDURE [dbo].[ATE_GetOrdersForTest] 
	-- Add the parameters for the stored procedure here
	@OrigOrdID Varchar(20),  /*MT4 Order_ID of Mater Account */
	@MT4ManagerID Bigint     /*MT4 Manager Login ID */
	
AS
BEGIN

	Declare @ManagerID BIGINT
	Select @ManagerID=MT4managerLoginID from MT4managerInfo where PK_ManagerID=
	(Select top 1 FK_ManagerID from Accounts where PK_AccountID in 
			(
			select FK_AccountID from CurrentOrders where OrigOrdID=@OrigOrdID
			)
	)

	if (@ManagerID=@MT4ManagerID)
	Begin

	select OrigOrdID
		   ,PositionSize
		   ,Price
		   ,(Select [Description] from OrderTypes where PK_OrderTypeID=FK_OrderType) OrderType	
		   ,(Select [Description] from OrderStatusTypes where PK_OrderStatusTypeID=FK_OrderStatusID) OrderStatus
		   ,(Select [Description] from [OrderSide] where PK_SideID=FK_Side) Side
		   ,OrderDateTimeRequested
		   ,(Select Symbol from Instruments where PK_InstrumentID=FK_Symbol) Symbol
		   ,LastUpdateTime
		   ,AvgFillPRice
		   ,ProfitValue
		   ,PositionEffect
		   ,ClosePrice
		   ,SL
		   ,TP
		
		  
		   
	   from CurrentOrders where LinkedOrderID in 
	(
	select PK_OrderID from CurrentOrders where OrigOrdID=@OrigOrdID
	)

	End

	Else
	Begin
	Select 'Master'' Order Doesn''t Exit OR not belong to repective Manager'

	End

END	











