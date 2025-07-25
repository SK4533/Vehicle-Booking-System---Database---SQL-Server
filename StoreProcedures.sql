USE [VBSAPP]
GO
/****** Object:  StoredProcedure [MBMSApp].[AllocateCarandInsert]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [MBMSApp].[AllocateCarandInsert]
    @UserId INT,
    @CarId INT,
    @StatusId INT,
    @BookingDate DATE,
    @CreatedBy NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @AvailableQuantity INT;
    DECLARE @BookingAmount DECIMAL(18, 2);
    DECLARE @TotalAmount DECIMAL(18, 2);
    DECLARE @OrderNumber NVARCHAR(50);
    DECLARE @OrderId INT;
    
    -- Get the available quantity from inventory
    SELECT @AvailableQuantity = [AvailableQuantity]
    FROM [VBSAPP].[vbs].[TblInventoryDetails]
    WHERE CarId = @CarId;

    -- Check if CarId exists, if not return an error
    IF @AvailableQuantity IS NULL
    BEGIN
        RAISERROR('Car with ID %d does not exist', 16, 1, @CarId);
        RETURN;
    END

    -- Generate a unique order number (e.g., ORD202408280001)
    SET @OrderNumber = 'ORD' + CONVERT(NVARCHAR(8), GETDATE(), 112) + RIGHT('0000' + CAST(NEXT VALUE FOR dbo.OrderSeq AS NVARCHAR(4)), 4);

    -- Check if the car is available
    IF @AvailableQuantity > 0
    BEGIN
        -- Decrease the available quantity by 1
        UPDATE [VBSAPP].[vbs].[TblInventoryDetails]
        SET AvailableQuantity = AvailableQuantity - 1
        WHERE CarId = @CarId;

        -- Get the amount details for the order
        SELECT @BookingAmount = OnRoadPrice,
               @TotalAmount = OnRoadPrice + InsurancePrice
        FROM [VBSAPP].[vbs].[TblCarDetails]
        WHERE CarId = @CarId;

        -- Insert into TblOrder
        INSERT INTO [VBSAPP].[vbs].[TblOrder]
            ([OrderNumber], [UserId], [CarId], [PaymentTypeId], [StatusId], [OrderDate], [BookingAmount], [TotalAmount], [CreatedDate], [CreatedBy])
        VALUES
            (@OrderNumber, @UserId, @CarId, 1, @StatusId, GETDATE(), @BookingAmount, @TotalAmount, GETDATE(), @CreatedBy);

        -- Get the inserted OrderId
        SET @OrderId = SCOPE_IDENTITY();

        -- Insert into TblAllotment
        INSERT INTO [VBSAPP].[vbs].[TblAllotment]
            ([UserId], [CarId], [StatusId], [BookingDate], [CreatedDate], [CreatedBy])
        VALUES
            (@UserId, @CarId, @StatusId, @BookingDate, GETDATE(), @CreatedBy);

    END
    ELSE
    BEGIN
        -- Get the amount details for the pending order
        SELECT @BookingAmount = OnRoadPrice,
               @TotalAmount = OnRoadPrice + InsurancePrice
        FROM [VBSAPP].[vbs].[TblCarDetails]
        WHERE CarId = @CarId;

        -- Insert into TblOrder with pending status (e.g., 2 = Pending)
        INSERT INTO [VBSAPP].[vbs].[TblOrder]
            ([OrderNumber], [UserId], [CarId], [PaymentTypeId], [StatusId], [OrderDate], [BookingAmount], [TotalAmount], [CreatedDate], [CreatedBy])
        VALUES
            (@OrderNumber, @UserId, @CarId, 1, 2, GETDATE(), @BookingAmount, @TotalAmount, GETDATE(), @CreatedBy);

        -- Get the inserted OrderId
        SET @OrderId = SCOPE_IDENTITY();

        -- Insert the pending allotment entry in TblAllotment for earliest booking
        INSERT INTO [VBSAPP].[vbs].[TblAllotment]
            ([UserId], [CarId], [StatusId], [BookingDate], [CreatedDate], [CreatedBy])
        SELECT TOP 1 [UserId], [CarId], 2, [BookingDate], GETDATE(), @CreatedBy
        FROM [VBSAPP].[vbs].[TblAllotment]
        WHERE [CarId] = @CarId
        ORDER BY [BookingDate] ASC;
    END
END;

GO
/****** Object:  StoredProcedure [MBMSApp].[GetTableCounts]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [MBMSApp].[GetTableCounts]
AS
BEGIN
    -- Declare variables to store the counts
    DECLARE @UserCount INT;
    DECLARE @ServiceCount INT;
    DECLARE @OrderCount INT;
    DECLARE @InventoryCount INT;
    DECLARE @CarCount INT;
    DECLARE @AllotmentCount INT;

    -- Get counts from each table
    SELECT @UserCount = COUNT(*) FROM [VBSAPP].[vbs].[TblUsers];
    SELECT @ServiceCount = COUNT(*) FROM [VBSAPP].[vbs].[TblServiceDetails];
    SELECT @OrderCount = COUNT(*) FROM [VBSAPP].[vbs].[TblOrder];
    SELECT @InventoryCount = COUNT(*) FROM [VBSAPP].[vbs].[TblInventoryDetails];
    SELECT @CarCount = COUNT(*) FROM [VBSAPP].[vbs].[TblCarDetails];
    SELECT @AllotmentCount = COUNT(*) FROM [VBSAPP].[vbs].[TblAllotment];

    -- Return the counts as a result set
    SELECT 'TblUsers' AS TableName, @UserCount AS TotalCount
    UNION ALL
    SELECT 'TblServiceDetails', @ServiceCount
    UNION ALL
    SELECT 'TblOrder', @OrderCount
    UNION ALL
    SELECT 'TblInventoryDetails', @InventoryCount
    UNION ALL
    SELECT 'TblCarDetails', @CarCount
    UNION ALL
    SELECT 'TblAllotment', @AllotmentCount;
END
GO
/****** Object:  StoredProcedure [MBMSApp].[GetTotalProfit]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [MBMSApp].[GetTotalProfit]
AS
BEGIN
    -- Calculate total profit by summing the difference between TotalAmount and BookingAmount
    SELECT SUM(TotalAmount) AS TotalProfit
    FROM [VBSAPP].[vbs].[TblOrder]
    WHERE IsDelete = 0; -- Assuming IsDelete indicates if a record is deleted or not
END
GO
/****** Object:  StoredProcedure [support].[ManageBrand]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE PROCEDURE [support].[ManageBrand]
    @ActionId INT,
    @BrandId INT = NULL,
    @BrandName VARCHAR(100) = NULL,
    @CreatedBy INT = NULL,
    @ModifiedBy INT = NULL
AS
BEGIN
    -- ActionId = 1: Retrieve Role Information
    IF @ActionId = 1
    BEGIN
        IF @BrandId =0
        BEGIN
            SELECT BrandId, BrandName
            FROM support.TblBrand
            WHERE IsDelete = 0;
        END
        ELSE
        BEGIN
            SELECT BrandId, BrandName
            FROM support.TblBrand
            WHERE BrandId = @BrandId AND IsDelete = 0;
        END
    END
    -- ActionId = 2: Insert or Update Role
    ELSE IF @ActionId = 2
    BEGIN
        IF @BrandId =0
        BEGIN
            INSERT INTO support.TblBrand (BrandName, CreatedBy, ModifiedBy)
            VALUES (@BrandName, @CreatedBy, @ModifiedBy);
        END
        ELSE
        BEGIN
            UPDATE support.TblBrand
            SET BrandName = @BrandName,
                CreatedBy = @CreatedBy,
                ModifiedBy = @ModifiedBy
            WHERE BrandId = @BrandId;
        END
    END
    -- ActionId = 3: Soft Delete Role
    ELSE IF @ActionId = 3
    BEGIN
        UPDATE support.TblBrand
        SET IsDelete = 1
        WHERE BrandId = @BrandId;
    END
    ELSE
    BEGIN
        -- Handle unexpected ActionId values if needed
        RAISERROR('Invalid ActionId value', 16, 1);
    END
END
GO
/****** Object:  StoredProcedure [support].[ManageModel]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [support].[ManageModel]
    @ActionId INT,
    @ModelId INT = NULL,
    @BrandId SMALLINT = NULL,
    @ModelName VARCHAR(100) = NULL,
    @CreatedBy INT = NULL,
    @ModifiedBy INT = NULL
AS
BEGIN
    -- ActionId = 1: Retrieve Model Information
    IF @ActionId = 1
    BEGIN
        IF @ModelId = 0
        BEGIN
            -- Retrieve specific model details
            SELECT m.ModelId, m.ModelName, b.BrandId, b.BrandName
            FROM support.TblModels m
            INNER JOIN support.TblBrand b ON m.BrandId = b.BrandId
            WHERE  m.IsDelete = 0;
        END
        ELSE IF @ModelId > 0 AND @ModelId IS NOT NULL
        BEGIN
            -- Retrieve all models when BrandId is 0 or NULL
            SELECT m.ModelId, m.ModelName, b.BrandId, b.BrandName
            FROM support.TblModels m
            INNER JOIN support.TblBrand b ON m.BrandId = b.BrandId
            WHERE m.ModelId = @ModelId AND m.IsDelete = 0;
        END
        ELSE
        BEGIN
            -- Retrieve all models for a specific BrandId
            SELECT m.ModelId, m.ModelName, b.BrandId, b.BrandName
            FROM support.TblModels m
            INNER JOIN support.TblBrand b ON m.BrandId = b.BrandId
            WHERE m.BrandId = @BrandId AND m.IsDelete = 0;
        END
    END
    -- ActionId = 2: Insert or Update Model
    ELSE IF @ActionId = 2
    BEGIN
        IF @ModelId = 0 OR @ModelId IS NULL
        BEGIN
            INSERT INTO support.TblModels (ModelName, BrandId, CreatedBy, ModifiedBy)
            VALUES (@ModelName, @BrandId, @CreatedBy, @ModifiedBy);
        END
        ELSE
        BEGIN
            UPDATE support.TblModels
            SET ModelName = @ModelName,
                BrandId = @BrandId,
                ModifiedBy = @ModifiedBy,
                ModifiedDate = GETDATE()
            WHERE ModelId = @ModelId;
        END
    END
    -- ActionId = 3: Soft Delete Model
    ELSE IF @ActionId = 3
    BEGIN
        UPDATE support.TblModels
        SET IsDelete = 1
        WHERE ModelId = @ModelId;
    END
    ELSE
    BEGIN
        -- Handle unexpected ActionId values if needed
        RAISERROR('Invalid ActionId value', 16, 1);
    END
END;



GO
/****** Object:  StoredProcedure [support].[ManagePaymentType]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE PROCEDURE [support].[ManagePaymentType]
    @ActionId INT,
    @PaymentTypeId SMALLINT = NULL,
    @PaymentTypeName VARCHAR(50) = NULL,
    @CreatedBy INT = NULL,
    @ModifiedBy INT = NULL
AS
BEGIN
    -- ActionId = 1: Retrieve Payment Type Information
    IF @ActionId = 1
    BEGIN
        IF @PaymentTypeId = 0 OR @PaymentTypeId IS NULL
        BEGIN
            -- Retrieve all payment types that are not deleted
            SELECT PaymentTypeId, PaymentTypeName
            FROM support.TblPaymentType
            WHERE IsDelete = 0;
        END
        ELSE
        BEGIN
            -- Retrieve specific payment type by PaymentTypeId
            SELECT PaymentTypeId, PaymentTypeName
            FROM support.TblPaymentType
            WHERE PaymentTypeId = @PaymentTypeId AND IsDelete = 0;
        END
    END

    -- ActionId = 2: Insert or Update Payment Type
    ELSE IF @ActionId = 2
    BEGIN
        IF @PaymentTypeId = 0 OR @PaymentTypeId IS NULL
        BEGIN
            -- Insert a new payment type
            INSERT INTO support.TblPaymentType (PaymentTypeName, CreatedBy, ModifiedBy)
            VALUES (@PaymentTypeName, @CreatedBy, @ModifiedBy);
        END
        ELSE
        BEGIN
            -- Update an existing payment type
            UPDATE support.TblPaymentType
            SET PaymentTypeName = @PaymentTypeName,
                ModifiedBy = @ModifiedBy,
                ModifiedDate = GETDATE()
            WHERE PaymentTypeId = @PaymentTypeId;
        END
    END

    -- ActionId = 3: Soft Delete Payment Type
    ELSE IF @ActionId = 3
    BEGIN
        -- Soft delete the payment type by setting IsDelete = 1
        UPDATE support.TblPaymentType
        SET IsDelete = 1
        WHERE PaymentTypeId = @PaymentTypeId;
    END

    -- Handle invalid ActionId values
    ELSE
    BEGIN
        RAISERROR('Invalid ActionId value', 16, 1);
    END
END;
GO
/****** Object:  StoredProcedure [support].[ManageRole]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [support].[ManageRole]
    @ActionId INT,
    @RoleId INT = NULL,
    @RoleName VARCHAR(100) = NULL,
    @CreatedBy INT = NULL,
    @ModifiedBy INT = NULL
AS
BEGIN
    -- ActionId = 1: Retrieve Role Information
    IF @ActionId = 1
    BEGIN
        IF @RoleId =0
        BEGIN
            SELECT RoleId, RoleName
            FROM support.TblRole
            WHERE IsDelete = 0;
        END
        ELSE
        BEGIN
            SELECT RoleId, RoleName
            FROM support.TblRole
            WHERE RoleId = @RoleId AND IsDelete = 0;
        END
    END
    -- ActionId = 2: Insert or Update Role
    ELSE IF @ActionId = 2
    BEGIN
        IF @RoleId =0
        BEGIN
            INSERT INTO support.TblRole (RoleName, CreatedBy, ModifiedBy)
            VALUES (@RoleName, @CreatedBy, @ModifiedBy);
        END
        ELSE
        BEGIN
            UPDATE support.TblRole
            SET RoleName = @RoleName,
                CreatedBy = @CreatedBy,
                ModifiedBy = @ModifiedBy
            WHERE RoleId = @RoleId;
        END
    END
    -- ActionId = 3: Soft Delete Role
    ELSE IF @ActionId = 3
    BEGIN
        UPDATE support.TblRole
        SET IsDelete = 1
        WHERE RoleId = @RoleId;
    END
    ELSE
    BEGIN
        -- Handle unexpected ActionId values if needed
        RAISERROR('Invalid ActionId value', 16, 1);
    END
END
GO
/****** Object:  StoredProcedure [support].[ManageServiceType]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE PROCEDURE [support].[ManageServiceType]
    @ActionId INT,
    @ServiceTypeId SMALLINT = NULL,
    @ServiceTypeName VARCHAR(50) = NULL,
    @CreatedBy INT = NULL,
    @ModifiedBy INT = NULL
AS
BEGIN
    -- ActionId = 1: Retrieve Service Type Information
    IF @ActionId = 1
    BEGIN
        IF @ServiceTypeId = 0 OR @ServiceTypeId IS NULL
        BEGIN
            -- Retrieve all service types that are not deleted
            SELECT ServiceTypeId, ServiceTypeName
            FROM support.TblServiceType
            WHERE IsDelete = 0;
        END
        ELSE
        BEGIN
            -- Retrieve specific service type by ServiceTypeId
            SELECT ServiceTypeId, ServiceTypeName
            FROM support.TblServiceType
            WHERE ServiceTypeId = @ServiceTypeId AND IsDelete = 0;
        END
    END

    -- ActionId = 2: Insert or Update Service Type
    ELSE IF @ActionId = 2
    BEGIN
        IF @ServiceTypeId = 0 OR @ServiceTypeId IS NULL
        BEGIN
            -- Insert a new service type
            INSERT INTO support.TblServiceType (ServiceTypeName, CreatedBy, ModifiedBy)
            VALUES (@ServiceTypeName, @CreatedBy, @ModifiedBy);
        END
        ELSE
        BEGIN
            -- Update an existing service type
            UPDATE support.TblServiceType
            SET ServiceTypeName = @ServiceTypeName,
                ModifiedBy = @ModifiedBy,
                ModifiedDate = GETDATE()
            WHERE ServiceTypeId = @ServiceTypeId;
        END
    END

    -- ActionId = 3: Soft Delete Service Type
    ELSE IF @ActionId = 3
    BEGIN
        -- Soft delete the service type by setting IsDelete = 1
        UPDATE support.TblServiceType
        SET IsDelete = 1
        WHERE ServiceTypeId = @ServiceTypeId;
    END

    -- Handle invalid ActionId values
    ELSE
    BEGIN
        RAISERROR('Invalid ActionId value', 16, 1);
    END
END;
GO
/****** Object:  StoredProcedure [support].[ManageStatus]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE PROCEDURE [support].[ManageStatus]
    @ActionId INT,
    @StatusId SMALLINT = NULL,
    @StatusName VARCHAR(50) = NULL,
    @CreatedBy INT = NULL,
    @ModifiedBy INT = NULL
AS
BEGIN
    -- ActionId = 1: Retrieve Status Information
    IF @ActionId = 1
    BEGIN
        IF @StatusId = 0 OR @StatusId IS NULL
        BEGIN
            -- Retrieve all status records that are not deleted
            SELECT StatusId, StatusName
            FROM support.TblStatus
            WHERE IsDelete = 0;
        END
        ELSE
        BEGIN
            -- Retrieve specific status by StatusId
            SELECT StatusId, StatusName
            FROM support.TblStatus
            WHERE StatusId = @StatusId AND IsDelete = 0;
        END
    END

    -- ActionId = 2: Insert or Update Status
    ELSE IF @ActionId = 2
    BEGIN
        IF @StatusId = 0 OR @StatusId IS NULL
        BEGIN
            -- Insert a new status record
            INSERT INTO support.TblStatus (StatusName, CreatedBy, ModifiedBy)
            VALUES (@StatusName, @CreatedBy, @ModifiedBy);
        END
        ELSE
        BEGIN
            -- Update an existing status record
            UPDATE support.TblStatus
            SET StatusName = @StatusName,
                ModifiedBy = @ModifiedBy,
                ModifiedDate = GETDATE()
            WHERE StatusId = @StatusId;
        END
    END

    -- ActionId = 3: Soft Delete Status
    ELSE IF @ActionId = 3
    BEGIN
        -- Soft delete the status by setting IsDelete = 1
        UPDATE support.TblStatus
        SET IsDelete = 1
        WHERE StatusId = @StatusId;
    END

    -- Handle invalid ActionId values
    ELSE
    BEGIN
        RAISERROR('Invalid ActionId value', 16, 1);
    END
END;
GO
/****** Object:  StoredProcedure [vbs].[ApproveBooking]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [vbs].[ApproveBooking]
  @ActionId INT,
  @OrderId INT,
  @ModifiedBy INT
  AS
  BEGIN
	IF @ActionId = 1
	BEGIN
	 UPDATE [vbs].[TblOrder] SET [StatusId] = 3,
			ModifiedBy = @ModifiedBy
			WHERE OrderId = @OrderId
  END
  IF @ActionId = 2
  BEGIN
	BEGIN
  UPDATE [vbs].[TblOrder] SET [StatusId] = 7,
			ModifiedBy = @ModifiedBy
			WHERE OrderId = @OrderId
  END
  END
END
GO
/****** Object:  StoredProcedure [vbs].[DeleteCar]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [vbs].[DeleteCar]
@CarId INT ,
@ModifiedBy INT
AS
BEGIN
	UPDATE vbs.TblCarDetails
	SET IsDelete = 1,
	ModifiedBy = @ModifiedBy
	WHERE CarId = @CarId
END
GO
/****** Object:  StoredProcedure [vbs].[DeleteInventory]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [vbs].[DeleteInventory]
    @InventoryId INT,         
    @ModifiedBy INT 
AS
BEGIN
    UPDATE [vbs].[TblInventoryDetails]
    SET IsDelete = 1,
        ModifiedBy = @ModifiedBy
    WHERE InventoryId = @InventoryId;
END;
GO
/****** Object:  StoredProcedure [vbs].[DeleteProfilePic]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [vbs].[DeleteProfilePic]
@UserId INT
AS
BEGIN
Update [vbs].[TblUsers]
Set [UserImage] = ''
WHERE UserId = @UserId
END
GO
/****** Object:  StoredProcedure [vbs].[DeleteUser]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [vbs].[DeleteUser]
    @UserId INT,
    @ModifiedBy INT
AS
BEGIN
    UPDATE vbs.TblUsers
    SET 
        IsDelete = 1,
        ModifiedDate = GETDATE(), 
        ModifiedBy = @ModifiedBy
    WHERE UserId = @UserId;
END;
GO
/****** Object:  StoredProcedure [vbs].[GetBookedCars]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [vbs].[GetBookedCars]
@ActionId INT = 0,
@StatusId INT,
@OrderId INT
AS
BEGIN
IF @ActionId = 1
BEGIN
IF @StatusId = 1 AND @OrderId = 0
	BEGIN
	  SELECT
            o.OrderId,
            o.OrderNumber,
            o.PaymentTypeId,
            o.StatusId,
            o.OrderDate,
            o.ExpectDeliverDate,
            o.ActualDeliverDate,
            o.BookingAmount,
            o.TotalAmount,
            s.StatusName,
            p.PaymentTypeName,
            -- Concatenate BrandName and ModelName as CarName
            CONCAT(b.BrandName, ' ', m.ModelName) AS CarName,
            -- Calculate total cost
            c.ExShowroomPrice + c.InsurancePrice + c.OnRoadPrice AS TotalCost,
            c.CarImagePath,
            -- Concatenate FirstName and LastName as Name
            CONCAT(u.FirstName, ' ', u.LastName) AS Name,
            u.PhoneNumber,
            u.Address,
            u.AadharNumber
        FROM [vbs].[TblOrder] o
        INNER JOIN [vbs].[TblCarDetails] c ON o.CarId = c.CarId
        INNER JOIN [support].[TblBrand] b ON c.BrandId = b.BrandId
        INNER JOIN [support].[TblModels] m ON c.ModelId = m.ModelId
        INNER JOIN [vbs].[TblUsers] u ON o.UserId = u.UserId
        INNER JOIN [support].[TblPaymentType] p ON o.PaymentTypeId = p.PaymentTypeId
        INNER JOIN [support].[TblStatus] s ON o.StatusId = s.StatusId
		WHERE o.StatusId = 1;
	END
	ELSE IF @StatusId =1 AND @OrderId >0
	BEGIN
	SELECT
            o.OrderId,
            o.OrderNumber,
            o.PaymentTypeId,
            o.StatusId,
            o.OrderDate,
            o.ExpectDeliverDate,
            o.ActualDeliverDate,
            o.BookingAmount,
            o.TotalAmount,
            s.StatusName,
            p.PaymentTypeName,
            -- Concatenate BrandName and ModelName as CarName
            CONCAT(b.BrandName, ' ', m.ModelName) AS CarName,
            -- Calculate total cost
            c.ExShowroomPrice + c.InsurancePrice + c.OnRoadPrice AS TotalCost,
            c.CarImagePath,
            -- Concatenate FirstName and LastName as Name
            CONCAT(u.FirstName, ' ', u.LastName) AS Name,
            u.PhoneNumber,
            u.Address,
            u.AadharNumber
        FROM [vbs].[TblOrder] o
        INNER JOIN [vbs].[TblCarDetails] c ON o.CarId = c.CarId
        INNER JOIN [support].[TblBrand] b ON c.BrandId = b.BrandId
        INNER JOIN [support].[TblModels] m ON c.ModelId = m.ModelId
        INNER JOIN [vbs].[TblUsers] u ON o.UserId = u.UserId
        INNER JOIN [support].[TblPaymentType] p ON o.PaymentTypeId = p.PaymentTypeId
        INNER JOIN [support].[TblStatus] s ON o.StatusId = s.StatusId
		WHERE o.StatusId = 1 AND o.OrderId = @OrderId;
	END
END
IF @ActionId = 2
BEGIN
IF @StatusId = 3 AND @OrderId = 0
	BEGIN
	  SELECT
            o.OrderId,
            o.OrderNumber,
            o.PaymentTypeId,
            o.StatusId,
            o.OrderDate,
            o.ExpectDeliverDate,
            o.ActualDeliverDate,
            o.BookingAmount,
            o.TotalAmount,
            s.StatusName,
            p.PaymentTypeName,
            -- Concatenate BrandName and ModelName as CarName
            CONCAT(b.BrandName, ' ', m.ModelName) AS CarName,
            -- Calculate total cost
            c.ExShowroomPrice + c.InsurancePrice + c.OnRoadPrice AS TotalCost,
            c.CarImagePath,
            -- Concatenate FirstName and LastName as Name
            CONCAT(u.FirstName, ' ', u.LastName) AS Name,
            u.PhoneNumber,
            u.Address,
            u.AadharNumber
        FROM [vbs].[TblOrder] o
        INNER JOIN [vbs].[TblCarDetails] c ON o.CarId = c.CarId
        INNER JOIN [support].[TblBrand] b ON c.BrandId = b.BrandId
        INNER JOIN [support].[TblModels] m ON c.ModelId = m.ModelId
        INNER JOIN [vbs].[TblUsers] u ON o.UserId = u.UserId
        INNER JOIN [support].[TblPaymentType] p ON o.PaymentTypeId = p.PaymentTypeId
        INNER JOIN [support].[TblStatus] s ON o.StatusId = s.StatusId
		WHERE o.StatusId = 3;
	END
	ELSE IF @StatusId = 3 AND @OrderId > 0
	BEGIN
	SELECT
            o.OrderId,
            o.OrderNumber,
            o.PaymentTypeId,
            o.StatusId,
            o.OrderDate,
            o.ExpectDeliverDate,
            o.ActualDeliverDate,
            o.BookingAmount,
            o.TotalAmount,
            s.StatusName,
            p.PaymentTypeName,
            -- Concatenate BrandName and ModelName as CarName
            CONCAT(b.BrandName, ' ', m.ModelName) AS CarName,
            -- Calculate total cost
            c.ExShowroomPrice + c.InsurancePrice + c.OnRoadPrice AS TotalCost,
            c.CarImagePath,
            -- Concatenate FirstName and LastName as Name
            CONCAT(u.FirstName, ' ', u.LastName) AS Name,
            u.PhoneNumber,
            u.Address,
            u.AadharNumber
        FROM [vbs].[TblOrder] o
        INNER JOIN [vbs].[TblCarDetails] c ON o.CarId = c.CarId
        INNER JOIN [support].[TblBrand] b ON c.BrandId = b.BrandId
        INNER JOIN [support].[TblModels] m ON c.ModelId = m.ModelId
        INNER JOIN [vbs].[TblUsers] u ON o.UserId = u.UserId
        INNER JOIN [support].[TblPaymentType] p ON o.PaymentTypeId = p.PaymentTypeId
        INNER JOIN [support].[TblStatus] s ON o.StatusId = s.StatusId
		WHERE o.StatusId = 3 AND o.OrderId = @OrderId;
	END
END
END
GO
/****** Object:  StoredProcedure [vbs].[GetCarDetails]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [vbs].[GetCarDetails]
    @CarId INT = 0,
    @BrandId INT = 0,
    @ModelId INT = 0
AS
BEGIN
    SET NOCOUNT ON;
    
    IF @CarId = 0 AND @BrandId = 0 AND @ModelId = 0
    BEGIN
        -- Get all car details
        SELECT
            c.CarId,
            c.CarName,
            c.BrandId,
            c.ModelId,
            c.ExShowroomPrice,
            c.OnRoadPrice,
            c.InsurancePrice,
            c.Colour,
            c.FuelType,
            c.HorsePower,
            c.EngineType,
            c.TransmissionType,
            c.Mileage,
			c.CarImagePath,
            b.BrandName,
            m.ModelName
        FROM vbs.TblCarDetails c
        INNER JOIN support.TblBrand b ON c.BrandId = b.BrandId
        INNER JOIN support.TblModels m ON c.ModelId = m.ModelId
        WHERE c.IsDelete = 0;
    END
    ELSE IF @CarId = 0 AND @BrandId <> 0 AND @ModelId = 0
    BEGIN
        -- Get car details sorted by brand
        SELECT
            c.CarId,
            c.CarName,
            c.BrandId,
            c.ModelId,
            c.ExShowroomPrice,
            c.OnRoadPrice,
            c.InsurancePrice,
            c.Colour,
            c.FuelType,
            c.HorsePower,
            c.EngineType,
            c.TransmissionType,
            c.Mileage,
			c.CarImagePath,
            b.BrandName,
            m.ModelName
        FROM vbs.TblCarDetails c
        INNER JOIN support.TblBrand b ON c.BrandId = b.BrandId
        INNER JOIN support.TblModels m ON c.ModelId = m.ModelId
        WHERE c.BrandId = @BrandId AND c.IsDelete = 0;
    END
    ELSE IF @CarId = 0 AND @BrandId <> 0 AND @ModelId <> 0
    BEGIN
        -- Get car details sorted by brand and model
        SELECT
            c.CarId,
            c.CarName,
            c.BrandId,
            c.ModelId,
            c.ExShowroomPrice,
            c.OnRoadPrice,
            c.InsurancePrice,
            c.Colour,
            c.FuelType,
            c.HorsePower,
            c.EngineType,
            c.TransmissionType,
            c.Mileage,
			c.CarImagePath,
            b.BrandName,
            m.ModelName
        FROM vbs.TblCarDetails c
        INNER JOIN support.TblBrand b ON c.BrandId = b.BrandId
        INNER JOIN support.TblModels m ON c.ModelId = m.ModelId
        WHERE c.BrandId = @BrandId AND c.ModelId = @ModelId AND c.IsDelete = 0;
    END
    ELSE IF @CarId <> 0
    BEGIN
        -- Get car details by CarId
        SELECT
            c.CarId,
            c.CarName,
            c.BrandId,
            c.ModelId,
            c.ExShowroomPrice,
            c.OnRoadPrice,
            c.InsurancePrice,
            c.Colour,
            c.FuelType,
            c.HorsePower,
            c.EngineType,
            c.TransmissionType,
            c.Mileage,
			c.CarImagePath,
            b.BrandName,
            m.ModelName
        FROM vbs.TblCarDetails c
        INNER JOIN support.TblBrand b ON c.BrandId = b.BrandId
        INNER JOIN support.TblModels m ON c.ModelId = m.ModelId
        WHERE c.CarId = @CarId AND c.IsDelete = 0;
    END
END;
GO
/****** Object:  StoredProcedure [vbs].[GetOrderDetails]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [vbs].[GetOrderDetails]
    @OrderId INT = 0,
    @CarId INT = 0,
	@UserId INT = 0,
	@RoleId INT = 0
AS
BEGIN
    IF @OrderId = 0 AND @CarId = 0 AND @UserId > 0 AND @RoleId = 1
    BEGIN
        SELECT
			u.UserId,
            o.OrderId,
			o.CarId,
            o.OrderNumber,
            o.PaymentTypeId,
            o.StatusId,
            o.OrderDate,
            o.ExpectDeliverDate,
            o.ActualDeliverDate,
            o.BookingAmount,
            o.TotalAmount,
            s.StatusName,
            p.PaymentTypeName,
            -- Concatenate BrandName and ModelName as CarName
            CONCAT(b.BrandName, ' ', m.ModelName) AS CarName,
            -- Calculate total cost
            c.ExShowroomPrice + c.InsurancePrice + c.OnRoadPrice AS TotalCost,
            c.CarImagePath,
            -- Concatenate FirstName and LastName as Name
            CONCAT(u.FirstName, ' ', u.LastName) AS Name,
            u.PhoneNumber,
            u.Address,
            u.AadharNumber
        FROM [vbs].[TblOrder] o
        INNER JOIN [vbs].[TblCarDetails] c ON o.CarId = c.CarId
        INNER JOIN [support].[TblBrand] b ON c.BrandId = b.BrandId
        INNER JOIN [support].[TblModels] m ON c.ModelId = m.ModelId
        INNER JOIN [vbs].[TblUsers] u ON o.UserId = u.UserId
        INNER JOIN [support].[TblPaymentType] p ON o.PaymentTypeId = p.PaymentTypeId
        INNER JOIN [support].[TblStatus] s ON o.StatusId = s.StatusId
    END
    ELSE IF @OrderId <> 0 AND @CarId = 0 AND @UserId > 0 AND @RoleId = 1
    BEGIN
        SELECT
			u.UserId,
            o.OrderId,
			o.CarId,
            o.OrderNumber,
            o.OrderDate,
            o.ExpectDeliverDate,
            o.ActualDeliverDate,
            o.BookingAmount,
            o.TotalAmount,
            s.StatusName,
            p.PaymentTypeName,
            CONCAT(b.BrandName, ' ', m.ModelName) AS CarName,
            c.ExShowroomPrice + c.InsurancePrice + c.OnRoadPrice AS TotalCost,
            c.CarImagePath,
            CONCAT(u.FirstName, ' ', u.LastName) AS Name,
            u.PhoneNumber,
            u.Address,
            u.AadharNumber
        FROM [vbs].[TblOrder] o
        INNER JOIN [vbs].[TblCarDetails] c ON o.CarId = c.CarId
        INNER JOIN [support].[TblBrand] b ON c.BrandId = b.BrandId
        INNER JOIN [support].[TblModels] m ON c.ModelId = m.ModelId
        INNER JOIN [vbs].[TblUsers] u ON o.UserId = u.UserId
        INNER JOIN [support].[TblPaymentType] p ON o.PaymentTypeId = p.PaymentTypeId
        INNER JOIN [support].[TblStatus] s ON o.StatusId = s.StatusId
        WHERE o.OrderId = @OrderId
    END
    ELSE IF @OrderId > 0 AND @CarId = 0 AND @UserId > 0 AND @RoleId = 2
    BEGIN
        SELECT
		u.UserId,
            o.OrderId,
			o.CarId,
            o.OrderNumber,
            o.OrderDate,
            o.ExpectDeliverDate,
            o.ActualDeliverDate,
            o.BookingAmount,
            o.TotalAmount,
            s.StatusName,
            p.PaymentTypeName,
            CONCAT(b.BrandName, ' ', m.ModelName) AS CarName,
            c.ExShowroomPrice + c.InsurancePrice + c.OnRoadPrice AS TotalCost,
            c.CarImagePath,
            CONCAT(u.FirstName, ' ', u.LastName) AS Name,
            u.PhoneNumber,
            u.Address,
            u.AadharNumber
        FROM [vbs].[TblOrder] o
        INNER JOIN [vbs].[TblCarDetails] c ON o.CarId = c.CarId
        INNER JOIN [support].[TblBrand] b ON c.BrandId = b.BrandId
        INNER JOIN [support].[TblModels] m ON c.ModelId = m.ModelId
        INNER JOIN [vbs].[TblUsers] u ON o.UserId = u.UserId
        INNER JOIN [support].[TblPaymentType] p ON o.PaymentTypeId = p.PaymentTypeId
        INNER JOIN [support].[TblStatus] s ON o.StatusId = s.StatusId
        WHERE  u.UserId = @UserId
    END
	ELSE IF @OrderId = 0 AND @CarId = 0 AND @UserId > 0 AND @RoleId = 2
    BEGIN
        SELECT
		u.UserId,
            o.OrderId,
			o.CarId,
            o.OrderNumber,
            o.PaymentTypeId,
            o.StatusId,
            o.OrderDate,
            o.ExpectDeliverDate,
            o.ActualDeliverDate,
            o.BookingAmount,
            o.TotalAmount,
            s.StatusName,
            p.PaymentTypeName,
            -- Concatenate BrandName and ModelName as CarName
            CONCAT(b.BrandName, ' ', m.ModelName) AS CarName,
            -- Calculate total cost
            c.ExShowroomPrice + c.InsurancePrice + c.OnRoadPrice AS TotalCost,
            c.CarImagePath,
            -- Concatenate FirstName and LastName as Name
            CONCAT(u.FirstName, ' ', u.LastName) AS Name,
            u.PhoneNumber,
            u.Address,
            u.AadharNumber
        FROM [vbs].[TblOrder] o
        INNER JOIN [vbs].[TblCarDetails] c ON o.CarId = c.CarId
        INNER JOIN [support].[TblBrand] b ON c.BrandId = b.BrandId
        INNER JOIN [support].[TblModels] m ON c.ModelId = m.ModelId
        INNER JOIN [vbs].[TblUsers] u ON o.UserId = u.UserId
        INNER JOIN [support].[TblPaymentType] p ON o.PaymentTypeId = p.PaymentTypeId
        INNER JOIN [support].[TblStatus] s ON o.StatusId = s.StatusId
		WHERE u.UserId = @UserId
    END
END
GO
/****** Object:  StoredProcedure [vbs].[GetServiceDetails]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [vbs].[GetServiceDetails]
    @ServiceId INT = 0,
    @RoleId INT = 0,
    @UserId INT = 0
AS
BEGIN
    -- Case 1: Get all service details if ServiceId = 0, UserId > 0, and RoleId = 1
    IF @ServiceId = 0 AND @UserId > 0 AND @RoleId = 1
    BEGIN
        SELECT 
            sd.ServiceId,
            sd.ServiceDescription,
            sd.ServiceDate,
            sd.ServiceCost,
            sd.NextServiceDate,
            sd.CarId,
            c.CarName,
            c.Colour,
            c.FuelType,
            c.TransmissionType,
            sd.UserId,
            u.FirstName + ' ' + u.LastName AS UserName,
            u.PhoneNumber,
            u.Address,
            u.Gender,
            st.ServiceTypeName,
            sd.ServiceTypeId,
            s.StatusName,
			s.StatusId
        FROM 
            vbs.tblServiceDetails sd
        INNER JOIN 
            vbs.TblCarDetails c ON sd.CarId = c.CarId
        INNER JOIN 
            vbs.tblUsers u ON sd.UserId = u.UserId
        INNER JOIN 
            support.TblServiceType st ON sd.ServiceTypeId = st.ServiceTypeId
        INNER JOIN 
            support.TblStatus s ON sd.StatusId = s.StatusId
        WHERE 
            sd.IsDelete = 0
    END

    -- Case 2: Get service details for the selected user if ServiceId = 0, UserId > 0, and RoleId = 2
    ELSE IF @ServiceId = 0 AND @UserId > 0 AND @RoleId = 2
    BEGIN
        SELECT 
            sd.ServiceId,
            sd.ServiceDescription,
            sd.ServiceDate,
            sd.ServiceCost,
            sd.NextServiceDate,
            sd.CarId,
            c.CarName,
            c.Colour,
            c.FuelType,
            c.TransmissionType,
            sd.UserId,
            u.FirstName + ' ' + u.LastName AS UserName,
            u.PhoneNumber,
            u.Address,
            u.Gender,
            st.ServiceTypeName,
            sd.ServiceTypeId,
            s.StatusName,
			s.StatusId
        FROM 
            vbs.tblServiceDetails sd
        INNER JOIN 
            vbs.TblCarDetails c ON sd.CarId = c.CarId
        INNER JOIN 
            vbs.tblUsers u ON sd.UserId = u.UserId
        INNER JOIN 
            support.TblServiceType st ON sd.ServiceTypeId = st.ServiceTypeId
        INNER JOIN 
            support.TblStatus s ON sd.StatusId = s.StatusId
        WHERE 
            sd.UserId = @UserId AND sd.IsDelete = 0
    END

    -- Case 3: Get service details for the selected service ID if ServiceId > 0, UserId > 0, and RoleId = 1
    ELSE IF @ServiceId > 0 AND @UserId > 0 AND @RoleId = 1
    BEGIN
        SELECT 
            sd.ServiceId,
            sd.ServiceDescription,
            sd.ServiceDate,
            sd.ServiceCost,
            sd.NextServiceDate,
            sd.CarId,
            c.CarName,
            c.Colour,
            c.FuelType,
            c.TransmissionType,
            sd.UserId,
            u.FirstName + ' ' + u.LastName AS UserName,
            u.PhoneNumber,
            u.Address,
            u.Gender,
            st.ServiceTypeName,
            sd.ServiceTypeId,
            s.StatusName,
			s.StatusId
        FROM 
            vbs.tblServiceDetails sd
        INNER JOIN 
            vbs.TblCarDetails c ON sd.CarId = c.CarId
        INNER JOIN 
            vbs.tblUsers u ON sd.UserId = u.UserId
        INNER JOIN 
            support.TblServiceType st ON sd.ServiceTypeId = st.ServiceTypeId
        INNER JOIN 
            support.TblStatus s ON sd.StatusId = s.StatusId
        WHERE 
            sd.ServiceId = @ServiceId AND sd.IsDelete = 0
    END

    -- Case 4: Get service details for the selected service ID if ServiceId > 0, UserId > 0, and RoleId = 2
    ELSE IF @ServiceId > 0 AND @UserId > 0 AND @RoleId = 2
    BEGIN
        SELECT 
            sd.ServiceId,
            sd.ServiceDescription,
            sd.ServiceDate,
            sd.ServiceCost,
            sd.NextServiceDate,
            sd.CarId,
            c.CarName,
            c.Colour,
            c.FuelType,
            c.TransmissionType,
            sd.UserId,
            u.FirstName + ' ' + u.LastName AS UserName,
            u.PhoneNumber,
            u.Address,
            u.Gender,
            st.ServiceTypeName,
            sd.ServiceTypeId,
            s.StatusName,
			s.StatusId
        FROM 
            vbs.tblServiceDetails sd
        INNER JOIN 
            vbs.TblCarDetails c ON sd.CarId = c.CarId
        INNER JOIN 
            vbs.tblUsers u ON sd.UserId = u.UserId
        INNER JOIN 
            support.TblServiceType st ON sd.ServiceTypeId = st.ServiceTypeId
        INNER JOIN 
            support.TblStatus s ON sd.StatusId = s.StatusId
        WHERE 
            sd.ServiceId = @ServiceId AND sd.UserId = @UserId AND sd.IsDelete = 0
    END
END
GO
/****** Object:  StoredProcedure [vbs].[GetUserDetails]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [vbs].[GetUserDetails]
@UserId INT = 0,
@RoleId INT = 0
AS
BEGIN
    IF @UserId = 0 AND @RoleId = 0
    BEGIN
        SELECT 
			u.UserId,
            u.FirstName,
            u.LastName,
            u.DateOfBirth,
            u.UserName,
            u.Password,
            u.Gender,
            u.PhoneNumber,
            u.AadharNumber,
            u.Address,
            r.RoleId,
            r.RoleName 
        FROM vbs.TblUsers u 
        INNER JOIN support.TblRole r ON u.RoleId = r.RoleId
        WHERE u.IsDelete = 0;
    END
	ELSE IF @UserId = 0 AND @RoleId <> 0
    BEGIN
        SELECT 
			u.UserId,
            u.FirstName,
            u.LastName,
            u.DateOfBirth,
            u.UserName,
            u.Password,
            u.Gender,
            u.PhoneNumber,
            u.AadharNumber,
            u.Address,
            r.RoleId,
            r.RoleName 
        FROM vbs.TblUsers u 
        INNER JOIN support.TblRole r ON u.RoleId = r.RoleId
        WHERE u.RoleId = @RoleId AND u.IsDelete = 0;
    END
    ELSE
    BEGIN
        SELECT 
			u.UserId,
            u.FirstName,
            u.LastName,
            u.DateOfBirth,
            u.UserName,
            u.Password,
            u.Gender,
            u.PhoneNumber,
            u.AadharNumber,
            u.Address,
            r.RoleId,
            r.RoleName 
        FROM vbs.TblUsers u 
        INNER JOIN support.TblRole r ON u.RoleId = r.RoleId
        WHERE u.UserId = @UserId AND u.IsDelete = 0;
    END
END;
GO
/****** Object:  StoredProcedure [vbs].[GetUserProfileDetails]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [vbs].[GetUserProfileDetails]
    @UserId INT
AS
BEGIN
    SELECT
        U.[UserId],
        -- Concatenate FirstName and LastName as UserName
        CONCAT(U.[FirstName], ' ', U.[LastName]) AS [Name],
        U.[DateOfBirth],
        U.[Gender],
        U.[PhoneNumber],
        U.[UserImage],
        U.[RoleId],
		U.UserName,
        U.[Address],
        U.[AadharNumber],
        S.[ServiceId],
        S.[ServiceTypeId],
        S.[ServiceDate],
        S.[ServiceCost],
        S.[ServiceDescription],
        S.[IsUnderWarrenty],  -- Ensure column name is correct
        O.[OrderId],
        O.[StatusId],
        O.[OrderDate],
        O.[BookingAmount],
        O.[TotalAmount],
        C.[CarId],
        C.[CarName],
        R.[RoleName],        -- Role Name from TblRole
        SS.[StatusName],    -- Status Name from TblStatus
        ST.[ServiceTypeName]-- Service Type Name from TblServiceType
    FROM [VBSAPP].[vbs].[TblUsers] U
    LEFT JOIN [VBSAPP].[vbs].[TblServiceDetails] S
        ON U.[UserId] = S.[UserId]
    LEFT JOIN [VBSAPP].[vbs].[TblOrder] O
        ON U.[UserId] = O.[UserId]
    LEFT JOIN [VBSAPP].[vbs].[TblCarDetails] C
        ON C.[CarId] = S.[CarId] OR C.[CarId] = O.[CarId]
    LEFT JOIN [VBSAPP].support.[TblRole] R
        ON U.[RoleId] = R.[RoleId]
    LEFT JOIN [VBSAPP].support.[TblStatus] SS
        ON O.[StatusId] = SS.[StatusId]
    LEFT JOIN [VBSAPP].support.[TblServiceType] ST
        ON S.[ServiceTypeId] = ST.[ServiceTypeId]
    WHERE U.[UserId] = @UserId;
END;
GO
/****** Object:  StoredProcedure [vbs].[InsertandUpdateInventory]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [vbs].[InsertandUpdateInventory]
    @InventoryId INT = 0,
    @CarId INT,
    @StockQuantity INT,
    @AvailableQuantity INT,
    @IsAvailable BIT,
	@CreatedBy INT,
    @ModifiedBy INT
AS
BEGIN
    -- Check if the InventoryId is 0, which indicates an insert operation
    IF @InventoryId = 0
    BEGIN
        INSERT INTO [vbs].[TblInventoryDetails]
        (
            CarId,
            StockQuantity,
            AvailableQuantity,
            IsAvailable,
			CreatedDate,
            ModifiedDate,
			CreatedBy,
            ModifiedBy
        )
        VALUES
        (
            @CarId,
            @StockQuantity,
            @AvailableQuantity,
            @IsAvailable,
            GETDATE(),
			GETDATE() ,
			@CreatedBy,
            @ModifiedBy
        );
    END
    ELSE
    BEGIN
        -- Update the existing row based on InventoryId
        UPDATE [vbs].[TblInventoryDetails]
        SET
            CarId = @CarId,
            StockQuantity = @StockQuantity,
            AvailableQuantity = @AvailableQuantity,
            IsAvailable = @IsAvailable,
			CreatedDate = GETDATE(),
            ModifiedDate = GETDATE(),
			CreatedBy = @CreatedBy,
            ModifiedBy = @ModifiedBy
        WHERE InventoryId = @InventoryId;
    END
END;
GO
/****** Object:  StoredProcedure [vbs].[InsertandUpdateUserDetails]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [vbs].[InsertandUpdateUserDetails]
    @UserId INT = 0,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @DateOfBirth DATE,
    @UserName VARCHAR(50),
    @Password VARCHAR(100),
    @Gender BIT = 0,
    @PhoneNumber VARCHAR(11),
    @RoleId SMALLINT,
    @Address VARCHAR(200),
    @AadharNumber VARCHAR(12),
    @CreatedBy INT = NULL,
    @ModifiedBy INT,
	@UserImage Varchar(255)
AS
BEGIN
    IF @UserId = 0
    BEGIN
        INSERT INTO vbs.TblUsers (
            FirstName, 
            LastName, 
            DateOfBirth, 
            UserName, 
            Password, 
            Gender, 
            PhoneNumber, 
            RoleId, 
            Address, 
            AadharNumber, 
            CreatedBy, 
            ModifiedBy,
			UserImage
        )
        VALUES (
            @FirstName, 
            @LastName, 
            @DateOfBirth, 
            @UserName, 
            @Password, 
            @Gender, 
            @PhoneNumber, 
            @RoleId, 
            @Address, 
            @AadharNumber, 
            @CreatedBy, 
            @ModifiedBy,
			@UserImage
        );
    END
    ELSE
    BEGIN
        UPDATE vbs.TblUsers
        SET 
            FirstName = @FirstName, 
            LastName = @LastName, 
            DateOfBirth = @DateOfBirth, 
            UserName = @UserName, 
            Password = @Password, 
            Gender = @Gender, 
            PhoneNumber = @PhoneNumber, 
            RoleId = @RoleId, 
            Address = @Address, 
            AadharNumber = @AadharNumber, 
            ModifiedDate = GETDATE(), 
            ModifiedBy = @ModifiedBy,
			UserImage = @UserImage
        WHERE UserId = @UserId;
    END
END;

GO
/****** Object:  StoredProcedure [vbs].[InsertAndUpsertCarDetails]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [vbs].[InsertAndUpsertCarDetails]
    @CarId INT = 0,
    @CarName VARCHAR(50),
    @BrandId SMALLINT,
    @ModelId INT,
    @ExShowroomPrice DECIMAL(10, 2),
    @OnRoadPrice DECIMAL(10, 2),
    @InsurancePrice DECIMAL(10, 2),
    @Colour VARCHAR(50) = NULL,
    @FuelType VARCHAR(50) = NULL,
    @HorsePower INT,
    @EngineType VARCHAR(50),
    @TransmissionType VARCHAR(50) = NULL,
    @Mileage DECIMAL(5, 2),
	@CarImagePath VARCHAR = NULL,
    @CreatedBy INT,
    @ModifiedBy INT
AS
BEGIN
    IF @CarId > 0
    BEGIN
        UPDATE vbs.TblCarDetails
        SET 
            CarName = @CarName,
            BrandId = @BrandId,
            ModelId = @ModelId,
            ExShowroomPrice = @ExShowroomPrice,
            OnRoadPrice = @OnRoadPrice,
            InsurancePrice = @InsurancePrice,
            Colour = @Colour,
            FuelType = @FuelType,
            HorsePower = @HorsePower,
            EngineType = @EngineType,
            TransmissionType = @TransmissionType,
            Mileage = @Mileage,
			CarImagePath = @CarImagePath,
            ModifiedDate = GETDATE(),
            ModifiedBy = @ModifiedBy
        WHERE CarId = @CarId;
    END
    ELSE
    BEGIN
        INSERT INTO vbs.TblCarDetails (
            CarName, BrandId, ModelId, ExShowroomPrice, OnRoadPrice, InsurancePrice, 
            Colour, FuelType, HorsePower, EngineType, TransmissionType, Mileage,CarImagePath, 
			CreatedDate, ModifiedDate, CreatedBy, ModifiedBy
        ) VALUES (
            @CarName, @BrandId, @ModelId, @ExShowroomPrice, @OnRoadPrice, @InsurancePrice,
            @Colour, @FuelType, @HorsePower, @EngineType, @TransmissionType, @Mileage,@CarImagePath,
             GETDATE(), GETDATE(), @CreatedBy, @ModifiedBy
        );
    END
END;
GO
/****** Object:  StoredProcedure [vbs].[sp_AllotCar]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [vbs].[sp_AllotCar]
    @UserId INT,           -- Input parameter for the User ID
    @CarId INT,            -- Input parameter for the Car ID
    @BookingDate DATETIME = NULL, -- Input parameter for the Booking Date, default to NULL
    @CreatedBy NVARCHAR(100) = NULL, -- Input parameter for the CreatedBy, default to NULL
    @ModifiedBy NVARCHAR(100) = NULL -- Input parameter for the ModifiedBy, default to NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Use the current date as the default booking date if not provided
    SET @BookingDate = ISNULL(@BookingDate, GETDATE());

    DECLARE @AvailableQuantity INT;

    -- Retrieve the available quantity for the car
    SELECT @AvailableQuantity = [AvailableQuantity]
    FROM [VBSAPP].[vbs].[TblInventoryDetails]
    WHERE [CarId] = @CarId
      AND [IsAvailable] = 1
      AND [IsDelete] = 0;

    -- Ensure @AvailableQuantity is initialized to 0 if NULL to handle conditional checks properly
    SET @AvailableQuantity = ISNULL(@AvailableQuantity, 0);

    -- If the car is available and there are cars left to be booked
    IF @AvailableQuantity > 0
    BEGIN
        -- Insert the allotment record with the status "Booked"
        INSERT INTO [VBSAPP].[vbs].[TblAllotment] (
            [UserId], [CarId], [BookingDate], [StatusId], [CreatedBy], [ModifiedBy]
        )
        VALUES (
            @UserId, @CarId, @BookingDate, 1, -- StatusId 1 corresponds to "Booked"
            @CreatedBy, @ModifiedBy
        );

        -- Update inventory to reflect the car has been allotted
        UPDATE [VBSAPP].[vbs].[TblInventoryDetails]
        SET [AvailableQuantity] = [AvailableQuantity] - 1
        WHERE [CarId] = @CarId;

        -- Insert a row into TblOrder
        INSERT INTO [VBSAPP].[vbs].[TblOrder] (
            [UserId], [CarId], [OrderDate], [StatusId], [CreatedBy], [ModifiedBy]
        )
        VALUES (
            @UserId, @CarId, @BookingDate, 1, -- StatusId 1 corresponds to "Booked"
            @CreatedBy, @ModifiedBy
        );
    END
    ELSE
    BEGIN
        -- If there are no cars available, handle multiple bookings
        DECLARE @BookingCount INT;

        -- Count current bookings for this car
        SELECT @BookingCount = COUNT(*)
        FROM [VBSAPP].[vbs].[TblAllotment]
        WHERE [CarId] = @CarId
          AND [StatusId] = 1; -- StatusId 1 corresponds to "Booked"

        -- If bookings are more than available quantity
        IF @BookingCount >= @AvailableQuantity
        BEGIN
            -- Find and prioritize users based on the earliest BookingDate
            ;WITH RankedBookings AS (
                SELECT 
                    [UserId], [BookingDate],
                    ROW_NUMBER() OVER (ORDER BY [BookingDate]) AS rn
                FROM [VBSAPP].[vbs].[TblAllotment]
                WHERE [CarId] = @CarId
                  AND [StatusId] = 1
            )
            -- Only delete from TblAllotment not RankedBookings directly
            DELETE FROM [VBSAPP].[vbs].[TblAllotment]
            WHERE [CarId] = @CarId
              AND [StatusId] = 1
              AND [UserId] IN (
                  SELECT [UserId]
                  FROM RankedBookings
                  WHERE rn > @AvailableQuantity
              );

            -- Insert the orders for the users who booked early
            INSERT INTO [VBSAPP].[vbs].[TblOrder] (
                [UserId], [CarId], [OrderDate], [StatusId], [CreatedBy], [ModifiedBy]
            )
            SELECT 
                [UserId], @CarId, [BookingDate], 1, -- StatusId 1 corresponds to "Booked"
                @CreatedBy, @ModifiedBy
            FROM RankedBookings
            WHERE rn <= @AvailableQuantity;

            -- Update the remaining entries in the allotment table to a "Waiting" status
            UPDATE [VBSAPP].[vbs].[TblAllotment]
            SET [StatusId] = 2 -- StatusId 2 corresponds to "Waiting"
            WHERE [CarId] = @CarId
              AND [StatusId] = 1
              AND [UserId] IN (
                  SELECT [UserId]
                  FROM RankedBookings
                  WHERE rn > @AvailableQuantity
              );
        END
    END
END
GO
/****** Object:  StoredProcedure [vbs].[sp_BookCarOrder]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [vbs].[sp_BookCarOrder]
    @UserId INT,
    @CarId INT,
    @PaymentTypeId SMALLINT = 0,
    @StatusId SMALLINT = 1,
    @BookingAmount DECIMAL(10,2) = 0,
    @TotalAmount DECIMAL(10,2),
    @CreatedBy INT,
    @ModifiedBy INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the PaymentTypeId exists in TblPaymentType
    IF NOT EXISTS (SELECT 1 FROM [VBSAPP].[support].[TblPaymentType] WHERE PaymentTypeId = @PaymentTypeId)
    BEGIN
        -- Set a default PaymentTypeId if not provided or invalid
        SET @PaymentTypeId = (SELECT TOP 1 PaymentTypeId FROM [VBSAPP].[support].[TblPaymentType]);
    END

    DECLARE @OrderNumber VARCHAR(100);
    DECLARE @CurrentDate CHAR(8);
    DECLARE @NextOrderNumber INT;
    DECLARE @ExpectDeliverDate DATE;
    DECLARE @ActualDeliverDate DATE;
    DECLARE @RandomDaysExpect INT;
    DECLARE @RandomDaysActual INT;
    DECLARE @AvailableQuantity INT;
    DECLARE @NewAvailableQuantity INT;
    DECLARE @OrdersToCreate INT;
    DECLARE @RequestedQuantity INT;
    DECLARE @OrderDate DATE;

    -- Generate current date in YYYYMMDD format
    SET @CurrentDate = CONVERT(CHAR(8), GETDATE(), 112);

    -- Get the number of orders created today for unique numbering
    SELECT @NextOrderNumber = COUNT(*) + 1
    FROM [VBSAPP].[vbs].[TblOrder]
    WHERE CONVERT(CHAR(8), OrderDate, 112) = @CurrentDate;

    -- Generate OrderNumber in the format ORDYYYYMMDDNNN
    SET @OrderNumber = 'ORD' + @CurrentDate + RIGHT('000' + CAST(@NextOrderNumber AS VARCHAR(3)), 3);

    -- Get the current date (Order Date)
    SET @OrderDate = GETDATE();

    -- Generate random days for expected delivery (between 1 and 30 days from OrderDate)
    SET @RandomDaysExpect = ABS(CHECKSUM(NEWID())) % 30 + 1;
    SET @ExpectDeliverDate = DATEADD(DAY, @RandomDaysExpect, @OrderDate);

    -- Generate random days for actual delivery (greater than or equal to expected delivery date)
    SET @RandomDaysActual = ABS(CHECKSUM(NEWID())) % (30 - @RandomDaysExpect + 1);
    SET @ActualDeliverDate = DATEADD(DAY, @RandomDaysExpect + @RandomDaysActual, @OrderDate);

    -- Debugging: Print values
    PRINT 'OrderDate: ' + CONVERT(VARCHAR, @OrderDate, 112);
    PRINT 'ExpectDeliverDate: ' + CONVERT(VARCHAR, @ExpectDeliverDate, 112);
    PRINT 'ActualDeliverDate: ' + CONVERT(VARCHAR, @ActualDeliverDate, 112);

    -- Check the available quantity for the car
    SELECT @AvailableQuantity = AvailableQuantity
    FROM [VBSAPP].[vbs].[TblInventoryDetails]
    WHERE CarId = @CarId;

    -- Calculate total requested quantity for the car from other orders
    SELECT @RequestedQuantity = COUNT(*)
    FROM [VBSAPP].[vbs].[TblOrder]
    WHERE CarId = @CarId AND StatusId = @StatusId;

    -- Determine how many orders can be fulfilled
    IF @AvailableQuantity >= @RequestedQuantity + 1
    BEGIN
        -- There are enough cars available to fulfill the order
        SET @OrdersToCreate = @RequestedQuantity + 1;
        SET @NewAvailableQuantity = @AvailableQuantity - @OrdersToCreate;
    END
    ELSE
    BEGIN
        -- Only some of the requested cars are available
        SET @OrdersToCreate = @AvailableQuantity;
        SET @NewAvailableQuantity = 0;
    END

    -- Insert orders that can be fulfilled
    WHILE @OrdersToCreate > 0
    BEGIN
        -- Insert the order
        INSERT INTO [VBSAPP].[vbs].[TblOrder] 
        (
            OrderNumber, 
            UserId, 
            CarId, 
            PaymentTypeId, 
            StatusId, 
            OrderDate, 
            ExpectDeliverDate, 
            ActualDeliverDate, 
            BookingAmount, 
            TotalAmount, 
            IsDelete, 
            CreatedDate, 
            ModifiedDate, 
            CreatedBy, 
            ModifiedBy
        )
        VALUES 
        (
            @OrderNumber, 
            @UserId, 
            @CarId, 
            @PaymentTypeId, 
            @StatusId, 
            @OrderDate, 
            ISNULL(@ExpectDeliverDate, GETDATE()), -- Default to current date if NULL
            ISNULL(@ActualDeliverDate, GETDATE()), -- Default to current date if NULL
            @BookingAmount, 
            @TotalAmount, 
            0, 
            GETDATE(), 
            GETDATE(), 
            @CreatedBy, 
            @ModifiedBy
        );

        -- Reduce the available quantity by 1 for each car booked
        SET @AvailableQuantity = @AvailableQuantity - 1;

        -- Update the counter
        SET @OrdersToCreate = @OrdersToCreate - 1;
    END

    -- Update the inventory with the remaining available quantity
    UPDATE [VBSAPP].[vbs].[TblInventoryDetails]
    SET AvailableQuantity = @NewAvailableQuantity
    WHERE CarId = @CarId;

    -- Insert orders that couldn't be fulfilled due to insufficient stock
    IF @RequestedQuantity + 1 > @AvailableQuantity
    BEGIN
        -- Insert orders with "Not Available" status for remaining users
        INSERT INTO [VBSAPP].[vbs].[TblOrder] 
        (
            OrderNumber, 
            UserId, 
            CarId, 
            PaymentTypeId, 
            StatusId, 
            OrderDate, 
            BookingAmount, 
            TotalAmount, 
            IsDelete, 
            CreatedDate, 
            ModifiedDate, 
            CreatedBy, 
            ModifiedBy
        )
        VALUES 
        (
            @OrderNumber, 
            @UserId, 
            @CarId, 
            @PaymentTypeId, 
            8, -- Set to "Not Available"
            @OrderDate, 
            @BookingAmount, 
            @TotalAmount, 
            0, 
            GETDATE(), 
            GETDATE(), 
            @CreatedBy, 
            @ModifiedBy
        );
    END

    -- Return the new OrderId(s)
    SELECT SCOPE_IDENTITY() AS NewOrderId;
END

GO
/****** Object:  StoredProcedure [vbs].[sp_CheckUsernameExists]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [vbs].[sp_CheckUsernameExists]
    @Username NVARCHAR(100),  -- Assuming @Username is the email to check
    @UserId INT = 0
AS
BEGIN
    -- Declare variable to hold the count of usernames
    DECLARE @Count INT;

    -- Count the number of users with the given username, excluding the specified UserId
    SELECT @Count = COUNT(*)
    FROM [vbs].[TblUsers]
    WHERE [Username] = @Username AND UserId <> @UserId;

    -- Return 1 if the username exists, otherwise 0
    SELECT CASE 
        WHEN @Count > 0 THEN 1  -- Username exists
        ELSE 0  -- Username does not exist
    END AS UserNameExist;
END;
GO
/****** Object:  StoredProcedure [vbs].[sp_GetAllotmentDetails]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [vbs].[sp_GetAllotmentDetails]
    @AllotmentId INT = 0,
    @CarId INT = 0
AS
BEGIN
	IF @AllotmentId = 0 AND @CarId = 0
	BEGIN
	SELECT 
        a.[AllotmentId],
        a.[UserId],
        u.[FirstName] + ' ' + u.[LastName] AS [UserName],
        u.[DateOfBirth],
        u.[Gender],
        u.[PhoneNumber],
        a.[CarId],
        c.[CarName],
		c.BrandId,
		c.ModelId,
		b.BrandName,
		m.ModelName,
        c.[ExShowroomPrice],
        c.[OnRoadPrice],
        c.[InsurancePrice],
        c.[Colour],
        c.[FuelType],
        c.[HorsePower],
        c.[EngineType],
        c.[TransmissionType],
        c.[Mileage],
        c.[CarImagePath],
        a.[StatusId],
        s.[StatusName],
        a.[BookingDate],
        a.[CreatedDate],
        a.[ModifiedDate],
        a.[CreatedBy],
        a.[ModifiedBy]
    FROM 
        [VBSAPP].[vbs].[TblAllotment] a
    INNER JOIN 
        [VBSAPP].[vbs].[TblUsers] u ON a.[UserId] = u.[UserId]
    INNER JOIN 
        [VBSAPP].[vbs].[TblCarDetails] c ON a.[CarId] = c.[CarId]
    INNER JOIN 
        [VBSAPP].[support].[TblStatus] s ON a.[StatusId] = s.[StatusId]
		INNER JOIN [support].[TblBrand] b ON c.BrandId = b.BrandId
		INNER JOIN [support].[TblModels] m ON c.ModelId = m.ModelId
    WHERE 
        a.IsDelete = 0 AND a.StatusId = 3
    ORDER BY 
        a.[CreatedDate] DESC;
	END
    ELSE IF @AllotmentId > 0 AND @CarId = 0
	BEGIN
	SELECT 
        a.[AllotmentId],
        a.[UserId],
        u.[FirstName] + ' ' + u.[LastName] AS [UserName],
        u.[DateOfBirth],
        u.[Gender],
        u.[PhoneNumber],
        a.[CarId],
        c.[CarName],
		c.BrandId,
		c.ModelId,
		b.BrandName,
		m.ModelName,
        c.[ExShowroomPrice],
        c.[OnRoadPrice],
        c.[InsurancePrice],
        c.[Colour],
        c.[FuelType],
        c.[HorsePower],
        c.[EngineType],
        c.[TransmissionType],
        c.[Mileage],
        c.[CarImagePath],
        a.[StatusId],
        s.[StatusName],
        a.[BookingDate],
        a.[CreatedDate],
        a.[ModifiedDate],
        a.[CreatedBy],
        a.[ModifiedBy]
    FROM 
        [VBSAPP].[vbs].[TblAllotment] a
    INNER JOIN 
        [VBSAPP].[vbs].[TblUsers] u ON a.[UserId] = u.[UserId]
    INNER JOIN 
        [VBSAPP].[vbs].[TblCarDetails] c ON a.[CarId] = c.[CarId]
    INNER JOIN 
        [VBSAPP].[support].[TblStatus] s ON a.[StatusId] = s.[StatusId]
		INNER JOIN [support].[TblBrand] b ON c.BrandId = b.BrandId
		INNER JOIN [support].[TblModels] m ON c.ModelId = m.ModelId
    WHERE 
        a.IsDelete = 0 AND  a.[AllotmentId] = @AllotmentId AND a.StatusId = 3
    ORDER BY 
        a.[CreatedDate] DESC;
	END
	ELSE IF @AllotmentId = 0 AND @CarId > 0
BEGIN
	SELECT 
        a.[AllotmentId],
        a.[UserId],
        u.[FirstName] + ' ' + u.[LastName] AS [UserName],
        u.[DateOfBirth],
        u.[Gender],
        u.[PhoneNumber],
        a.[CarId],
        c.[CarName],
		c.BrandId,
		c.ModelId,
		b.BrandName,
		m.ModelName,
        c.[ExShowroomPrice],
        c.[OnRoadPrice],
        c.[InsurancePrice],
        c.[Colour],
        c.[FuelType],
        c.[HorsePower],
        c.[EngineType],
        c.[TransmissionType],
        c.[Mileage],
        c.[CarImagePath],
        a.[StatusId],
        s.[StatusName],
        a.[BookingDate],
        a.[CreatedDate],
        a.[ModifiedDate],
        a.[CreatedBy],
        a.[ModifiedBy]
    FROM 
        [VBSAPP].[vbs].[TblAllotment] a
    INNER JOIN 
        [VBSAPP].[vbs].[TblUsers] u ON a.[UserId] = u.[UserId]
    INNER JOIN 
        [VBSAPP].[vbs].[TblCarDetails] c ON a.[CarId] = c.[CarId]
    INNER JOIN 
        [VBSAPP].[support].[TblStatus] s ON a.[StatusId] = s.[StatusId]
		INNER JOIN [support].[TblBrand] b ON c.BrandId = b.BrandId
		INNER JOIN [support].[TblModels] m ON c.ModelId = m.ModelId
    WHERE 
        a.IsDelete = 0 AND  a.CarId = @CarId AND a.StatusId = 3
    ORDER BY 
        a.[CreatedDate] DESC;
	END
END;
GO
/****** Object:  StoredProcedure [vbs].[sp_GetInventoryDetails]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [vbs].[sp_GetInventoryDetails]
    @InventoryId INT = 0,
    @CarId INT = 0
AS
BEGIN
    IF @InventoryId = 0 AND @CarId = 0
    BEGIN
        SELECT 
            i.InventoryId,
            i.CarId,
            c.CarName,
            c.BrandId,
            b.BrandName,
            c.ModelId,
            m.ModelName,
            c.ExShowroomPrice,
            c.OnRoadPrice,
			c.InsurancePrice,
            c.Colour,
			c.HorsePower,
			c.EngineType,
			c.TransmissionType,
            c.FuelType,
			c.CarImagePath,
            i.StockQuantity,
            i.AvailableQuantity,
            i.IsAvailable,
            i.CreatedDate,
            i.ModifiedDate
        FROM 
            vbs.TblInventoryDetails i
        INNER JOIN 
            vbs.TblCarDetails c ON i.CarId = c.CarId
        INNER JOIN 
            support.TblBrand b ON c.BrandId = b.BrandId
        INNER JOIN 
            support.TblModels m ON c.ModelId = m.ModelId
        WHERE 
            i.IsDelete = 0
    END
    ELSE IF @InventoryId = 0 AND @CarId <> 0
    BEGIN
        SELECT 
            i.InventoryId,
            i.CarId,
            c.CarName,
            c.BrandId,
            b.BrandName,
            c.ModelId,
            m.ModelName,
            c.ExShowroomPrice,
            c.OnRoadPrice,
			c.InsurancePrice,
            c.Colour,
			c.HorsePower,
			c.EngineType,
			c.TransmissionType,
            c.FuelType,
			c.CarImagePath,
            i.StockQuantity,
            i.AvailableQuantity,
            i.IsAvailable,
            i.CreatedDate,
            i.ModifiedDate
        FROM 
            vbs.TblInventoryDetails i
        INNER JOIN 
            vbs.TblCarDetails c ON i.CarId = c.CarId
        INNER JOIN 
            support.TblBrand b ON c.BrandId = b.BrandId
        INNER JOIN 
            support.TblModels m ON c.ModelId = m.ModelId
        WHERE 
            c.CarId = @CarId AND i.IsDelete = 0
    END
    ELSE
    BEGIN
        SELECT 
            i.InventoryId,
            i.CarId,
            c.CarName,
            c.BrandId,
            b.BrandName,
            c.ModelId,
            m.ModelName,
            c.ExShowroomPrice,
            c.OnRoadPrice,
			c.InsurancePrice,
            c.Colour,
			c.HorsePower,
			c.EngineType,
			c.TransmissionType,
            c.FuelType,
			c.CarImagePath,
            i.StockQuantity,
            i.AvailableQuantity,
            i.IsAvailable,
            i.CreatedDate,
            i.ModifiedDate
        FROM 
            vbs.TblInventoryDetails i
        INNER JOIN 
            vbs.TblCarDetails c ON i.CarId = c.CarId
        INNER JOIN 
            support.TblBrand b ON c.BrandId = b.BrandId
        INNER JOIN 
            support.TblModels m ON c.ModelId = m.ModelId
        WHERE 
            i.InventoryId = @InventoryId AND i.IsDelete = 0
    END
END;
GO
/****** Object:  StoredProcedure [vbs].[sp_GetOrderCounts]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [vbs].[sp_GetOrderCounts]
AS
BEGIN
    -- Declare variables to store the results
    DECLARE @TotalOrders INT;
    DECLARE @TodayOrders INT;

    -- Calculate total orders count
    SELECT @TotalOrders = COUNT(*)
    FROM [VBSAPP].[vbs].[TblOrder]
    WHERE IsDelete = 0; -- Exclude deleted records

    -- Calculate today's orders count
    SELECT @TodayOrders = COUNT(*)
    FROM [VBSAPP].[vbs].[TblOrder]
    WHERE CAST(OrderDate AS DATE) = CAST(GETDATE() AS DATE)
      AND IsDelete = 0; -- Exclude deleted records

    -- Return the results
    SELECT 
        @TotalOrders AS TotalOrders,
        @TodayOrders AS TodayOrders;
END;
GO
/****** Object:  StoredProcedure [vbs].[sp_GetServiceRequestCounts]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [vbs].[sp_GetServiceRequestCounts]
AS
BEGIN
    -- Declare variables to store the results
    DECLARE @TotalServiceRequests INT;
    DECLARE @TodayServiceRequests INT;

    -- Calculate total service requests
    SELECT @TotalServiceRequests = COUNT(*)
    FROM [VBSAPP].[vbs].[TblServiceDetails]
    WHERE IsDelete = 0; -- Exclude deleted records

    -- Calculate today's service requests
    SELECT @TodayServiceRequests = COUNT(*)
    FROM [VBSAPP].[vbs].[TblServiceDetails]
    WHERE CAST(ServiceDate AS DATE) = CAST(GETDATE() AS DATE)
      AND IsDelete = 0; -- Exclude deleted records

    -- Return the results
    SELECT 
        @TotalServiceRequests AS TotalServiceRequests,
        @TodayServiceRequests AS TodayServiceRequests;
END;
GO
/****** Object:  StoredProcedure [vbs].[sp_InsertAllotment]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [vbs].[sp_InsertAllotment]
    @UserId INT,
    @CarId INT,
    @StatusId INT,
    @CreatedBy  INT ,
    @ModifiedBy INT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO [vbs].[TblAllotment] (
        [UserId],
        [CarId],
        [StatusId],
        [BookingDate],
        [CreatedBy],
        [ModifiedBy]
    )
    VALUES (
        @UserId,
        @CarId,
        @StatusId,
        GetDate(),
        @CreatedBy,
        @ModifiedBy
    );

    SELECT SCOPE_IDENTITY() AS NewAllotmentId;
END;

GO
/****** Object:  StoredProcedure [vbs].[sp_InsertServiceDetails]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [vbs].[sp_InsertServiceDetails]
    @UserId INT,
    @CarId INT,
    @ServiceTypeId INT null,
    @ServiceCost DECIMAL(10,2),
    @ServiceDescription NVARCHAR(500) ='',
    @IsUnderWarrenty BIT,
    @CreatedBy INT,
    @ModifiedBy INT,
    @StatusId INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ServiceDate DATETIME;
    DECLARE @NextServiceDate DATETIME;

    -- Set ServiceDate to current date
    SET @ServiceDate = GETDATE();

    -- Calculate NextServiceDate as 3 months after ServiceDate
    SET @NextServiceDate = DATEADD(MONTH, 3, @ServiceDate);

    -- Insert the new row into TblServiceDetails
    INSERT INTO [VBSAPP].[vbs].[TblServiceDetails]
    (
        UserId,
        CarId,
        ServiceTypeId,
        ServiceDate,
        ServiceCost,
        ServiceDescription,
        IsUnderWarrenty,
        NextServiceDate,
        IsDelete,
        CreatedDate,
        ModifiedDate,
        CreatedBy,
        ModifiedBy,
        StatusId
    )
    VALUES
    (
        @UserId,
        @CarId,
        @ServiceTypeId,
        @ServiceDate,
        @ServiceCost,
        @ServiceDescription,
        @IsUnderWarrenty,
        @NextServiceDate,
        0,  -- IsDelete set to 0 (not deleted)
        GETDATE(),  -- CreatedDate set to current date
        GETDATE(),  -- ModifiedDate set to current date
        @CreatedBy,
        @ModifiedBy,
        @StatusId
    );
END;
GO
/****** Object:  StoredProcedure [vbs].[sp_ManageLogin]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [vbs].[sp_ManageLogin]
(
	@Email VARCHAR(150),
	@Password VARCHAR(20)
)
AS
BEGIN
		SELECT
			UserId,
			RoleId
		FROM
			[vbs].[TblUsers]
		WHERE
			UserName = @Email AND [Password] = @Password AND IsDelete = 0;
	END
GO
/****** Object:  StoredProcedure [vbs].[sp_UpdateAllotmentStatus]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [vbs].[sp_UpdateAllotmentStatus]
    @AllotmentId INT,       -- Input parameter for the Allotment ID
    @NewStatusId SMALLINT,  -- Input parameter for the new Status ID
    @ModifiedBy NVARCHAR(100) = NULL -- Input parameter for the ModifiedBy, default to NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Update the status of the allotment record
    UPDATE [VBSAPP].[vbs].[TblAllotment]
    SET [StatusId] = @NewStatusId,
        [ModifiedDate] = GETDATE(),
        [ModifiedBy] = @ModifiedBy
    WHERE [AllotmentId] = @AllotmentId;

END
GO
/****** Object:  StoredProcedure [vbs].[UpdateCarOrder]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [vbs].[UpdateCarOrder]
    @UserId INT,
    @CarId INT,
    @PaymentTypeId SMALLINT = 0,
    @StatusId SMALLINT,
    @BookingAmount DECIMAL(10,2) = 0,
    @TotalAmount DECIMAL(10,2),
    @ModifiedBy INT
AS
BEGIN
    -- Update the order in the TblOrder table
    UPDATE [vbs].[TblOrder]
    SET
        UserId = @UserId,
        CarId = @CarId,
        PaymentTypeId = @PaymentTypeId,
        StatusId = @StatusId,
        BookingAmount = @BookingAmount,
        TotalAmount = @TotalAmount,
        ModifiedBy = @ModifiedBy
    WHERE 
        CarId = @CarId; 
END;
GO
/****** Object:  StoredProcedure [vbs].[UpdateInventoryStock]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [vbs].[UpdateInventoryStock]
    @InventoryId INT,
    @NewStockQuantity INT, -- This will represent the quantity being added, not the final total.
    @ModifiedBy INT
AS
BEGIN
    -- Declare variables to hold the current stock quantity and available quantity
    DECLARE @CurrentStockQuantity INT;
    DECLARE @CurrentAvailableQuantity INT;

    -- Get the current stock and available quantities
    SELECT 
        @CurrentStockQuantity = StockQuantity,
        @CurrentAvailableQuantity = AvailableQuantity
    FROM [VBSAPP].[vbs].[TblInventoryDetails]
    WHERE InventoryId = @InventoryId;

    -- Add the new stock to the current stock and available quantities
    DECLARE @UpdatedStockQuantity INT = @CurrentStockQuantity + @NewStockQuantity;
    DECLARE @UpdatedAvailableQuantity INT = @CurrentAvailableQuantity + @NewStockQuantity;

    -- Update StockQuantity and AvailableQuantity
    UPDATE [VBSAPP].[vbs].[TblInventoryDetails]
    SET 
        StockQuantity = @UpdatedStockQuantity,  -- Add the new stock to the current stock
        AvailableQuantity = @UpdatedAvailableQuantity,  -- Add the new stock to the available quantity
        ModifiedDate = GETDATE(),
        ModifiedBy = @ModifiedBy
    WHERE InventoryId = @InventoryId;
END;
GO
/****** Object:  StoredProcedure [vbs].[UpdateProfilePic]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [vbs].[UpdateProfilePic]
@UserId INT,
@UserImage Varchar(200)
AS
BEGIN
Update [vbs].[TblUsers]
Set [UserImage] = @UserImage
WHERE UserId = @UserId
END
GO
/****** Object:  StoredProcedure [vbs].[UpdateServiceStatus]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [vbs].[UpdateServiceStatus]
@ServiceId INT,
@ServiceDescription VARCHAR(200),
@StatusId INT,
@ModifiedBy INT
AS
BEGIN
	UPDATE [vbs].[TblServiceDetails]
	SET ServiceDescription = @ServiceDescription,
	StatusId = @StatusId,
	ModifiedBy = @ModifiedBy
	WHERE ServiceId = @ServiceId
END
GO
/****** Object:  StoredProcedure [vbs].[usp_GetBookingCounts]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [vbs].[usp_GetBookingCounts]
AS
BEGIN
    -- Declare variables to store the results
    DECLARE @TotalBookingCount INT;
    DECLARE @TodayBookingCount INT;
    
    -- Calculate total booking count
    SELECT @TotalBookingCount = COUNT(*)
    FROM [VBSAPP].[vbs].[TblAllotment]
    WHERE IsDelete = 0; -- Exclude deleted records

    -- Calculate today's booking count
    SELECT @TodayBookingCount = COUNT(*)
    FROM [VBSAPP].[vbs].[TblAllotment]
    WHERE CAST(BookingDate AS DATE) = CAST(GETDATE() AS DATE)
      AND IsDelete = 0; -- Exclude deleted records

    -- Return the results
    SELECT 
        @TotalBookingCount AS TotalBookingCount,
        @TodayBookingCount AS TodayBookingCount;
END;
GO
/****** Object:  StoredProcedure [vbs].[usp_GetStockCounts]    Script Date: 1/30/2025 1:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [vbs].[usp_GetStockCounts]
AS
BEGIN
    -- Declare variables to store the results
    DECLARE @TotalStockQuantity INT;
    DECLARE @TodayIncomingStock INT;
    
    -- Calculate total stock quantity
    SELECT @TotalStockQuantity = SUM(StockQuantity)
    FROM [VBSAPP].[vbs].[TblInventoryDetails]
    WHERE IsDelete = 0; -- Assuming you don't want to count deleted records

    -- Calculate today's incoming stock quantity
    SELECT @TodayIncomingStock = SUM(StockQuantity)
    FROM [VBSAPP].[vbs].[TblInventoryDetails]
    WHERE (CAST(CreatedDate AS DATE) = CAST(GETDATE() AS DATE) OR CAST(ModifiedDate AS DATE) = CAST(GETDATE() AS DATE))
      AND IsDelete = 0; -- Assuming you don't want to count deleted records

    -- Return the results
    SELECT 
        @TotalStockQuantity AS TotalStockQuantity,
        ISNULL(@TodayIncomingStock, 0) AS TodayIncomingStock;
END
GO
