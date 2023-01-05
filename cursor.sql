CREATE PROCEDURE spOrderReport
--Alter PROCEDURE spOrderReport -- Alter değişiklik modu değişiklik yapmak için kullanılır
AS
BEGIN 
DECLARE @vi_OrderID int
DECLARE @vs_CustomerID nchar(5)
DECLARE @vs_ShipCompany nchar(50)

DECLARE curOrders CURSOR
FOR 
	SELECT OrderID, CustomerID,CompanyName FROM Orders
	inner join Shippers on Orders.ShipVia=ShipperID
	WHERE YEAR(OrderDate)=1997 and EmployeeID=1 and 
	ShipCountry='UK'and ShipCity='London'

	-- cursor aç
	OPEN curOrders

	--İLK KAYDI OKU
	FETCH NEXT FROM curOrders INTO @vi_OrderID, @vs_CustomerID, @vs_ShipCompany
	WHILE @@FETCH_STATUS=0 --KAYIT OKUMASI BAŞARILI VE BİR KAYIT GELDİ
	BEGIN
		PRINT 'Siparis no: '+CONVERT(nvarchar(20),@vi_OrderID)+'Musteri Kodu:  '+ @vs_CustomerID+ 'sirket adi: '+@vs_ShipCompany
		--Vi_OrderID int string yapmak lazım
		--
		FETCH NEXT FROM curOrders INTO @vi_OrderID, @vs_CustomerID, @vs_ShipCompany	

	END
	CLOSE curOrders  --Kayıtlar biti cursor kapatılıyor
	DEALLOCATE CurOrders -- cursora ayrılanhafızayı boşaltıyor

END
