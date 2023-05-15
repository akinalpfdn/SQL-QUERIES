--An example for where clause with different conditions
--instead of if clauses with select statements this query can be used
DECLARE @DeliveryDate nvarchar(500)
DECLARE @OrderDate nvarchar(500)
DECLARE @SupplierCode nvarchar(500)
DECLARE @CASE int
SET @DeliveryDate = ''
SET @OrderDate = '01-01-1900'
SET @SupplierCode = ''
set @CASE = 1
IF @DeliveryDate <> '' AND @OrderDate = '' AND @SupplierCode = ''
BEGIN
set @CASE = 1
END
ELSE IF @DeliveryDate = '' AND @OrderDate <> '' AND @SupplierCode = ''
BEGIN
set @CASE = 2
END
ELSE IF @DeliveryDate <> '' AND @OrderDate = '' AND @SupplierCode <> ''
BEGIN
set @CASE = 3
END
ELSE IF @DeliveryDate = '' AND @OrderDate <> '' AND @SupplierCode <> ''
BEGIN
set @CASE = 4
END;
SELECT
	[OrderNo] As 'Sipariş Numarası'
	,[SupplierCode] As 'Müşteri Kodu'
    ,[SupplierName] As 'Müşteri Adı'
    ,[ItemId] As 'Ürün Numarası'
    ,[ItemName] As 'Ürün İsmi'
    ,CAST([ItemCount] AS int ) As 'Ürün Adedi'
	,CAST(SalesCount AS int) As 'Gönderilecek Adet'
    ,[OrderAdress] As 'Sipariş Adresi'
    ,[OrderDate]As 'Sipariş Tarihi'
	,[DeliveryDate] AS 'Temin Tarihi'
    ,[IsEmriNo] As 'İş Emri Numarası'
    ,[DepoCode] As 'Depo Kodu'	   
	,StokCount AS 'Stoktan Karşılanan'
	,UretilecekAdet AS 'Üretilecek Adet'
	,ItemDeliveryDate AS 'Gönderilecek Tarih'
	,SevkDate AS 'Planlanan Sevk Tarihi'
	,Toplam AS 'Toplam'
	FROM TbProducts
  WHERE (DeliveryDate = CONVERT(DATETIME,@DeliveryDate,105) AND @CASE = 1)
  OR (OrderDate = CONVERT(DATETIME,@OrderDate,105) AND @CASE = 2)
  OR (SupplierCode = @SupplierCode	AND 	DeliveryDate = CONVERT(DATETIME,@DeliveryDate,105) AND @CASE = 3)
  OR (SupplierCode = @SupplierCode	AND 	OrderDate = CONVERT(DATETIME,@OrderDate,105) AND @CASE = 4)
  