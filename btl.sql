CREATE TABLE IF NOT EXISTS Manufacturer (
    ManufacturerID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Origin VARCHAR(255) NOT NULL
);
CREATE TABLE IF NOT EXISTS Product (
    ProductID VARCHAR(10) PRIMARY KEY,
    ManufacturerID VARCHAR(10)  NOT NULL,
    EntryPrice DECIMAL(10, 2) NOT NULL,
    SalePrice DECIMAL(10, 2) NOT NULL,
    ProductName VARCHAR(255) NOT NULL,
    Weight DECIMAL(10, 2) NOT NULL,
    Size VARCHAR(255) NOT NULL,
    ManufacturingDate DATE NOT NULL,
    WarrantyPeriod INT NOT NULL,
    PowerConsumption DECIMAL(10, 2) NOT NULL,
    Description TEXT NOT NULL,
    StockQuantity INT NOT NULL,
    ImageURL TEXT NOT NULL,
    CONSTRAINT chk_StockQuantity CHECK (StockQuantity >= 0),
	CONSTRAINT fk_Product_ManufacturerID FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer(ManufacturerID)

);
-- Assuming the Material, Utility, and Color tables have already been created as shown previously

-- Junction table for Product and Material
CREATE TABLE IF NOT EXISTS Material (
    MaterialID VARCHAR(10) PRIMARY KEY,
    MaterialName VARCHAR(255) NOT NULL
);

-- Utilities Table
CREATE TABLE IF NOT EXISTS Utility (
    UtilityID VARCHAR(10) PRIMARY KEY,
    UtilityName VARCHAR(255) NOT NULL
);

-- Colors Table
CREATE TABLE IF NOT EXISTS Color (
    ColorID VARCHAR(10) PRIMARY KEY,
    ColorName VARCHAR(255) NOT NULL
);
CREATE TABLE IF NOT EXISTS ProductMaterial (
    ProductID VARCHAR(10),
    MaterialID VARCHAR(10),
    PRIMARY KEY (ProductID, MaterialID),
    CONSTRAINT fk_ProductMaterial_ProductID FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    CONSTRAINT fk_ProductMaterial_MaterialID FOREIGN KEY (MaterialID) REFERENCES Material(MaterialID)
);

-- Junction table for Product and Utility
CREATE TABLE IF NOT EXISTS ProductUtility (
    ProductID VARCHAR(10),
    UtilityID VARCHAR(10),
    PRIMARY KEY (ProductID, UtilityID),
    CONSTRAINT fk_ProductUtility_ProductID FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    CONSTRAINT fk_ProductUtility_UtilityID FOREIGN KEY (UtilityID) REFERENCES Utility(UtilityID)
);

-- Junction table for Product and Color
CREATE TABLE IF NOT EXISTS ProductColor (
    ProductID VARCHAR(10),
    ColorID VARCHAR(10),
    PRIMARY KEY (ProductID, ColorID),
    CONSTRAINT fk_ProductColor_ProductID FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    CONSTRAINT fk_ProductColor_ColorID FOREIGN KEY (ColorID) REFERENCES Color(ColorID)
);


-- Images Table
CREATE TABLE IF NOT EXISTS Image (
    ImageID VARCHAR(10) PRIMARY KEY,
    ProductID VARCHAR(10) NOT NULL,
    ImageURL TEXT NOT NULL,
    CONSTRAINT fk_Image_ProductID FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);


-- Đồ điện tử
-- Electronics Table
CREATE TABLE IF NOT EXISTS Electronics (
    ProductID VARCHAR(10) PRIMARY KEY,
    ScreenSpecs TEXT NOT NULL,
    OperatingSystem VARCHAR(255) NOT NULL,
    Description TEXT NOT NULL,
    CONSTRAINT fk_Electronics_ProductID FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Refrigeration Appliances Table
CREATE TABLE IF NOT EXISTS RefrigerationAppliances (
    ProductID VARCHAR(10) PRIMARY KEY,
    RefrigerationType VARCHAR(255) NOT NULL,
    EnergyConsumptionLevel VARCHAR(255) NOT NULL,
    Technology VARCHAR(255) NOT NULL,
    Capacity DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_Refrigeration_ProductID FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Home Appliances Table
CREATE TABLE IF NOT EXISTS HomeAppliances (
    ProductID VARCHAR(10) PRIMARY KEY,
    Type VARCHAR(255) NOT NULL,
    Functions VARCHAR(255) NOT NULL,
    Technology VARCHAR(255) NOT NULL,
    CONSTRAINT fk_HomeAppliances_ProductID FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);
-- Tài khoản
CREATE TABLE IF NOT EXISTS Account (
    AccountID VARCHAR(10) PRIMARY KEY,
    Username VARCHAR(255) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    PhoneNumber VARCHAR(255) NOT NULL,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Age INT NOT NULL,
    CONSTRAINT chk_PasswordLength CHECK (LENGTH(Password) > 8),
    CONSTRAINT chk_Age CHECK (Age >= 18)
);
CREATE TABLE IF NOT EXISTS Customer(
    CustomerID VARCHAR(10) PRIMARY KEY,
    CONSTRAINT fk_Customer_AccountID FOREIGN KEY (CustomerID) REFERENCES Account(AccountID)
);
CREATE TABLE IF NOT EXISTS Employee (
    EmployeeID VARCHAR(10) PRIMARY KEY,
    StartDate DATE NOT NULL,
    Status VARCHAR(255) NOT NULL,
    SuperiorID VARCHAR(10),
    CONSTRAINT fk_Employee_SuperiorID FOREIGN KEY (SuperiorID) REFERENCES Employee(EmployeeID)
);

CREATE TABLE IF NOT EXISTS Orders (
    OrderID VARCHAR(10) PRIMARY KEY,
    CreationDate DATE NOT NULL,
    Status VARCHAR(255) NOT NULL,
    Note TEXT NOT NULL,
    ProductQuantity INT NOT NULL,
    EmployeeID VARCHAR(10) NOT NULL,
    CONSTRAINT fk_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES Account(AccountID),
    CONSTRAINT fk_Orders_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)

);
-- Tạo bảng PurchaseOrder
CREATE TABLE IF NOT EXISTS PurchaseOrder (
    OrderID VARCHAR(10) PRIMARY KEY,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_PurchaseOrder_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Tạo bảng SaleOrder
CREATE TABLE IF NOT EXISTS SaleOrder (
    OrderID VARCHAR(10) PRIMARY KEY,
    CustomerID VARCHAR(10) NOT NULL,
    ExpectedDeliveryDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    
    CONSTRAINT fk_SaleOrder_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
	CONSTRAINT fk_SaleOrder_CustomerID FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)

    
);

CREATE TABLE IF NOT EXISTS CustomerAddress (
    AddressID VARCHAR(10) PRIMARY KEY,
    CustomerID VARCHAR(10) NOT NULL,
    Street VARCHAR(255) NOT NULL,
    District VARCHAR(255) NOT NULL,
    City VARCHAR(255) NOT NULL,
    State VARCHAR(255) NOT NULL,
	CONSTRAINT fk_CustomerAddress_CustomerID FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE IF NOT EXISTS OrderDetails (
    OrderDetailsID VARCHAR(10) PRIMARY KEY,
    OrderID VARCHAR(10) NOT NULL,
    ProductID VARCHAR(10) NOT NULL,
    Quantity INT NOT NULL,
    CONSTRAINT fk_OrderDetails_OrderID FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT fk_OrderDetails_ProductID FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- The remaining tables like Television, Phone, Laptop, etc., should follow the same pattern for their ID fields.
-- Primary keys are assumed to be managed by the application logic for prefixing and numbering.

-- Example for the Television table:
CREATE TABLE IF NOT EXISTS Television (
    ProductID VARCHAR(10) PRIMARY KEY,
    ImageTech VARCHAR(255) NOT NULL,
    SoundTech VARCHAR(255) NOT NULL,
    ConnectivityTech TEXT NOT NULL,
    CONSTRAINT fk_Television_ProductID FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- And so on for the other tables...

CREATE TABLE IF NOT EXISTS Phone (
    ProductID VARCHAR(10) PRIMARY KEY,
    CPU VARCHAR(255) NOT NULL,
    Memory INT NOT NULL,
    TouchScreen VARCHAR(255) NOT NULL,
    BatteryLife VARCHAR(255) NOT NULL,
    ConnectivitySupport TEXT NOT NULL,
    CameraSpecs TEXT NOT NULL,
    CONSTRAINT fk_Phone_ProductID FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);


-- Laptop Table
CREATE TABLE IF NOT EXISTS Laptop (
    ProductID VARCHAR(10) PRIMARY KEY,
    CPU VARCHAR(255) NOT NULL,
    Memory INT NOT NULL,
    ConnectivityPorts TEXT NOT NULL,
    BatteryLife VARCHAR(255) NOT NULL,
    SoundTech VARCHAR(255) NOT NULL,
    GraphicsCard VARCHAR(255) NOT NULL,
    CONSTRAINT fk_Laptop_ProductID FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Refrigerator Table
CREATE TABLE IF NOT EXISTS Refrigerator (
    ProductID VARCHAR(10) PRIMARY KEY,
    FridgeType VARCHAR(255) NOT NULL,
    Capacity DECIMAL(10,2) NOT NULL,
    PreservationTech TEXT NOT NULL,
    CONSTRAINT fk_Refrigerator_ProductID FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- AirConditioner Table
CREATE TABLE IF NOT EXISTS AirConditioner (
    ProductID VARCHAR(10) PRIMARY KEY,
    Type VARCHAR(255) NOT NULL,
    CoolingPower DECIMAL(10,2) NOT NULL,
    AirFilteringTech TEXT NOT NULL,
    GasType VARCHAR(255) NOT NULL,
    CONSTRAINT fk_AirConditioner_ProductID FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- WashingMachine Table
CREATE TABLE IF NOT EXISTS WashingMachine (
    ProductID VARCHAR(10) PRIMARY KEY,
    WasherType VARCHAR(255) NOT NULL,
    MotorType VARCHAR(255) NOT NULL,
    WashingTech TEXT NOT NULL,
    CONSTRAINT fk_WashingMachine_ProductID FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- RiceCooker Table
CREATE TABLE IF NOT EXISTS RiceCooker (
    ProductID VARCHAR(10) PRIMARY KEY,
    CookerType VARCHAR(255) NOT NULL,
    CookingTech TEXT NOT NULL,
    CookingFunction TEXT NOT NULL,
    CONSTRAINT fk_RiceCooker_ProductID FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- PurchaseOrder Table
CREATE TABLE IF NOT EXISTS PurchaseOrder (
    PO_ID VARCHAR(10) PRIMARY KEY,
    OrderDate DATE NOT NULL,
    TotalPurchasePrice DECIMAL(10,2) NOT NULL,
    ArrivalDate DATE NOT NULL,
    CONSTRAINT chk_ArrivalDate CHECK (ArrivalDate >= OrderDate)
);

-- SaleOrder Table
CREATE TABLE IF NOT EXISTS SaleOrder (
    SO_ID VARCHAR(10) PRIMARY KEY,
    ExpectedDeliveryDate DATE NOT NULL,
    DeliveryAddressID VARCHAR(10) NOT NULL,
    TotalSalePrice DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_SaleOrder_DeliveryAddressID FOREIGN KEY (DeliveryAddressID) REFERENCES CustomerAddress(AddressID)
);
-- Insert sample data into the Product table
-- Insert additional Phones into the Product and Phone tables

-- Insert sample data into the Material table
INSERT INTO Material (MaterialID, MaterialName) VALUES
('MAT001', 'Plastic'),
('MAT002', 'Metal'),
('MAT003', 'Glass'),
('MAT004', 'Ceramic'),
('MAT005', 'Carbon Fiber');

-- Insert sample data into the Utility table
INSERT INTO Utility (UtilityID, UtilityName) VALUES
('UTI001', 'Wi-Fi Connectivity'),
('UTI002', 'Bluetooth'),
('UTI003', 'GPS Functionality'),
('UTI004', 'Water Resistance'),
('UTI005', 'Noise Cancellation');
-- THêm 5 Material 5 Utility 5 Color vào các bảng trên
-- Insert sample data into the Color table
INSERT INTO Color (ColorID, ColorName) VALUES
('COL001', 'Black'),
('COL002', 'White'),
('COL003', 'Silver'),
('COL004', 'Gold'),
('COL005', 'Blue'),
('COL006', 'Red'),
('COL007', 'Green'),
('COL008', 'Blue-Grey'),
('COL009', 'Pink'),
('COL010', 'Purple'),
('COL011', 'Orange'),
('COL012', 'Yellow'),
('COL013', 'Brown'),
('COL014', 'Maroon'),
('COL015', 'Navy');


INSERT INTO Manufacturer (ManufacturerID, Name, Origin) VALUES
('MAN001', 'Nhà Sản Xuất A', 'Việt Nam'),
('MAN002', 'Nhà Sản Xuất B', 'Việt Nam');
INSERT INTO Product (ProductID, ManufacturerID, EntryPrice, SalePrice, ProductName, Weight, Size, ManufacturingDate, WarrantyPeriod, PowerConsumption, Description, StockQuantity, ImageURL) VALUES
('PRD1001', 'MAN001', 200.00, 300.00, 'Smartphone Alpha', 0.150, '5.5 inches', '2023-01-01', 12, 10.0, 'An advanced smartphone with an excellent camera.', 10 , 'http://example.com/images/smartphone_alpha.jpg'),
('PRD1002', 'MAN002', 150.00, 250.00, 'Smartphone Beta', 0.160, '6.1 inches', '2023-01-02', 12, 10.0, 'A budget-friendly smartphone with great battery life.', 15 , 'http://example.com/images/smartphone_beta.jpg'),
('PRD1003', 'MAN001', 250.00, 450.00, 'Smartphone Delta', 0.160, '6.2 inches', '2023-01-03', 12, 10.0, 'Mid-range smartphone with fast charging.', 10 , 'http://example.com/images/smartphone_delta.jpg'),
('PRD1004', 'MAN001', 300.00, 550.00, 'Smartphone Epsilon', 0.180, '6.5 inches', '2023-01-04', 24, 10.0, 'High-end smartphone with water resistance.', 15 ,'http://example.com/images/smartphone_epsilon.jpg'),
('PRD1005', 'MAN002', 400.00, 650.00, 'Smartphone Zeta', 0.200, '6.7 inches', '2023-01-05', 24, 10.0, 'Flagship smartphone with the best camera.', 10,  'http://example.com/images/smartphone_zeta.jpg'),
('PRD1006', 'MAN001', 500.00, 800.00, 'Gaming Laptop', 2.5, '15 inches', '2023-01-01', 24, 150, 'High performance gaming laptop with best in class graphics.', 5, 'http://example.com/images/laptop_gaming.jpg'),
('PRD1007', 'MAN002', 300.00, 500.00, 'Business Laptop', 2.0, '14 inches', '2023-01-01', 24, 100, 'A reliable business laptop with extended battery life.', 5, 'http://example.com/images/laptop_business.jpg'),
('PRD1008', 'MAN001', 550.00, 900.00, 'Ultra HD Laptop', 2.2, '17 inches', '2023-01-01', 36, 180, '4K UHD laptop with immersive audio and a premium build.', 30, 'http://example.com/images/laptop_ultrahd.jpg'),
('PRD1009', 'MAN002', 400.00, 700.00, 'Convertible Laptop', 1.5, '13 inches', '2023-01-01', 24, 120, 'Convertible laptop with touch screen and versatile design.', 40, 'http://example.com/images/laptop_convertible.jpg'),
('PRD1010', 'MAN001', 450.00, 750.00, 'Compact Laptop', 1.8, '11 inches', '2023-01-01', 24, 90, 'Compact laptop for on-the-go productivity and entertainment.', 50, 'http://example.com/images/laptop_compact.jpg'),
('PRD1011', 'MAN001', 400.00, 600.00, 'LED TV 40 inch', 15.0, '40 inches', '2023-01-01', 24, 100, '40 inch LED TV with Full HD resolution.', 30, 'http://example.com/images/ledtv40.jpg'),
('PRD1012', 'MAN002', 500.00, 800.00, 'Smart TV 50 inch', 20.0, '50 inches', '2023-01-01', 36, 150, '50 inch Smart TV with 4K resolution and HDR support.', 25, 'http://example.com/images/smarttv50.jpg'),
('PRD1013', 'MAN002', 550.00, 900.00, 'Curved TV 55 inch', 22.0, '55 inches', '2023-01-02', 36, 180, '55 inch Curved TV with Ultra HD resolution.', 20, 'http://example.com/images/curvedtv55.jpg'),
('PRD1014', 'MAN001', 650.00, 1200.00, 'OLED TV 65 inch', 25.0, '65 inches', '2023-01-02', 48, 200, '65 inch OLED TV with 4K resolution and high dynamic range.', 15, 'http://example.com/images/oledtv65.jpg'),
('PRD1015', 'MAN001', 350.00, 550.00, 'HD TV 32 inch', 10.0, '32 inches', '2023-01-02', 24, 85, '32 inch HD TV perfect for small rooms and apartments.', 40, 'http://example.com/images/hdtv32.jpg'),
('PRD1016', 'MAN001', 300.00, 500.00, 'Compact Air Conditioner', 25.0, 'Medium', '2023-01-01', 24, 150, 'Energy-efficient compact air conditioner, ideal for small rooms.', 40, 'http://example.com/images/compact_ac.jpg'),
('PRD1017', 'MAN002', 400.00, 700.00, 'Smart Air Conditioner', 35.0, 'Large', '2023-01-02', 36, 200, 'Smart air conditioner with Wi-Fi connectivity and remote control.', 30, 'http://example.com/images/smart_ac.jpg'),
('PRD1018', 'MAN002', 450.00, 650.00, 'High-Capacity Air Conditioner', 40.0, 'Large', '2023-01-03', 48, 250, 'High-capacity air conditioner, suitable for large spaces.', 20, 'http://example.com/images/high_capacity_ac.jpg'),
('PRD1019', 'MAN001', 350.00, 550.00, 'Portable Air Conditioner', 15.0, 'Small', '2023-01-03', 24, 100, 'Portable air conditioner, easy to move and install.', 35, 'http://example.com/images/portable_ac.jpg'),
('PRD1020', 'MAN002', 500.00, 800.00, 'Energy-Saving Air Conditioner', 30.0, 'Medium', '2023-01-03', 36, 180, 'Energy-saving air conditioner with eco-friendly technology.', 25, 'http://example.com/images/energy_saving_ac.jpg'),
('PRD1021', 'MAN001', 600.00, 1000.00, 'Double Door Refrigerator', 60.0, 'Large', '2023-01-01', 36, 250, 'Double door refrigerator with advanced cooling technology.', 15, 'http://example.com/images/double_door_fridge.jpg'),
('PRD1022', 'MAN002', 500.00, 900.00, 'Energy-Saving Refrigerator', 55.0, 'Medium', '2023-01-02', 48, 200, 'Energy-saving refrigerator with eco-friendly design.', 20, 'http://example.com/images/energy_saving_fridge.jpg'),
('PRD1023', 'MAN001', 550.00, 850.00, 'Smart Refrigerator', 50.0, 'Medium', '2023-01-03', 36, 180, 'Smart refrigerator with touch screen panel and Wi-Fi connectivity.', 25, 'http://example.com/images/smart_fridge.jpg'),
('PRD1024', 'MAN002', 700.00, 1200.00, 'Side-by-Side Refrigerator', 75.0, 'Extra Large', '2023-01-04', 48, 300, 'Side-by-side refrigerator with water dispenser and ice maker.', 10, 'http://example.com/images/sidebyside_fridge.jpg'),
('PRD1025', 'MAN001', 450.00, 700.00, 'Compact Refrigerator', 30.0, 'Small', '2023-01-05', 24, 150, 'Compact refrigerator, ideal for small spaces or as a secondary fridge.', 30, 'http://example.com/images/compact_fridge.jpg'),
('PRD1026', 'MAN003', 400.00, 600.00, 'Front Load Washer', 60.0, 'Large', '2023-01-06', 24, 250, 'Front load washing machine with various wash programs and energy-efficient operation.', 20, 'http://example.com/images/frontload_washer.jpg'),
('PRD1027', 'MAN004', 350.00, 500.00, 'Top Load Washer', 55.0, 'Medium', '2023-01-07', 24, 200, 'Top load washing machine with agitator for powerful cleaning performance.', 15, 'http://example.com/images/topload_washer.jpg'),
('PRD1028', 'MAN003', 600.00, 900.00, 'Smart Washer-Dryer Combo', 70.0, 'Extra Large', '2023-01-08', 36, 300, 'Smart washer-dryer combo with app control and multiple drying options.', 10, 'http://example.com/images/smart_washer_dryer.jpg'),
('PRD1029', 'MAN005', 450.00, 700.00, 'Compact Portable Washer', 35.0, 'Small', '2023-01-09', 24, 150, 'Compact and portable washing machine, ideal for small spaces or travel.', 25, 'http://example.com/images/portable_washer.jpg'),
('PRD1030', 'MAN003', 550.00, 800.00, 'High-Efficiency Washer', 65.0, 'Large', '2023-01-10', 24, 280, 'High-efficiency washing machine with large capacity and quick wash cycles.', 18, 'http://example.com/images/high_efficiency_washer.jpg'),
('PRD1031', 'MAN003', 80.00, 120.00, 'Basic Rice Cooker', 4.0, 'Small', '2023-01-11', 12, 300, 'Simple and reliable rice cooker for everyday use.', 30, 'http://example.com/images/basic_rice_cooker.jpg'),
('PRD1032', 'MAN004', 120.00, 180.00, 'Multi-Function Rice Cooker', 5.5, 'Medium', '2023-01-12', 18, 400, 'Versatile rice cooker with multiple cooking functions and keep-warm feature.', 25, 'http://example.com/images/multi_function_rice_cooker.jpg'),
('PRD1033', 'MAN003', 150.00, 220.00, 'Smart Rice Cooker', 6.0, 'Medium', '2023-01-13', 24, 350, 'Smart rice cooker with app control and customizable cooking settings.', 15, 'http://example.com/images/smart_rice_cooker.jpg'),
('PRD1034', 'MAN005', 100.00, 150.00, 'Compact Rice Cooker', 3.5, 'Small', '2023-01-14', 12, 250, 'Compact and lightweight rice cooker, suitable for small kitchens or travel.', 20, 'http://example.com/images/compact_rice_cooker.jpg'),
('PRD1035', 'MAN003', 130.00, 200.00, 'Advanced Rice Cooker', 5.0, 'Medium', '2023-01-15', 24, 380, 'Advanced rice cooker with fuzzy logic technology for precise cooking results.', 18, 'http://example.com/images/advanced_rice_cooker.jpg');


INSERT INTO RefrigerationAppliances (ProductID, RefrigerationType, EnergyConsumptionLevel, Technology, Capacity) VALUES
('PRD1016', 'Split AC', 'A+', 'Inverter', 1.5),
('PRD1017', 'Window AC', 'A', 'Standard', 2.0),
('PRD1018', 'Split AC', 'A+', 'Inverter', 1.8),
('PRD1019', 'Split AC', 'A', 'Smart Inverter', 2.0),
('PRD1020', 'Window AC', 'B+', 'Standard', 1.2),
('PRD1021', 'Double Door', 'A+', 'Frost Free', 500),
('PRD1022', 'Single Door', 'A', 'Standard', 350),
('PRD1023', 'Smart Fridge', 'A++', 'Frost Free, IoT Enabled', 400),
('PRD1024', 'Side-by-Side', 'A+', 'Frost Free, Water Dispenser', 700),
('PRD1025', 'Compact', 'B+', 'Standard, Energy Efficient', 200);



INSERT INTO Electronics ( ProductID, ScreenSpecs, OperatingSystem, Description) VALUES
( 'PRD1001', '1080x1920 pixels Full HD', 'Android 11', 'Smartphone Alpha with 5.5-inch Full HD display and Android 11.'),
( 'PRD1002', '720x1280 pixels HD', 'Android 11', 'Smartphone Beta with 6.1-inch HD display and Android 11.'),
( 'PRD1003', '2340x1080 pixels Full HD+', 'Android 11', 'Smartphone Delta with 6.2-inch Full HD+ display and Android 11.'),
( 'PRD1004', '2640x1200 pixels Full HD+', 'Android 11', 'Smartphone Epsilon with 6.5-inch Full HD+ display and Android 11.'),
( 'PRD1005', '3040x1440 pixels Quad HD+', 'Android 11', 'Smartphone Zeta with 6.7-inch Quad HD+ display and Android 11.'),
('PRD1006', '15.6-inch 1920x1080', 'Windows 10', 'High-end gaming laptop with RGB keyboard and high-refresh-rate display.'),
('PRD1007', '14-inch 1920x1080', 'Windows 10', 'Business laptop with secure biometric login and all-day battery life.'),
('PRD1008', '17-inch 3840x2160', 'Windows 10', 'Ultra HD Laptop with vibrant colors and exceptional clarity.'),
('PRD1009', '13.3-inch 1920x1080 touch screen', 'Windows 10', 'Convertible Laptop that doubles as a tablet.'),
('PRD1010', '11.6-inch 1366x768', 'Windows 10', 'Compact Laptop with long battery life and lightweight design.'),
('PRD1011', '40-inch Full HD LED', 'None', '40-inch LED TV with sharp and vibrant picture quality.'),
('PRD1012', '50-inch 4K UHD Smart', 'Android TV', '50-inch Smart TV with 4K resolution and smart features.'),
('PRD1013', '55-inch Ultra HD Curved', 'None', '55-inch Curved TV with immersive viewing experience.'),
('PRD1014', '65-inch 4K OLED', 'None', '65-inch OLED TV offering deep blacks and rich colors.'),
('PRD1015', '32-inch HD Ready', 'None', '32-inch HD TV, perfect for small spaces and budget-friendly.');


INSERT INTO HomeAppliances (ProductID, Type, Functions, Technology) VALUES
('PRD1026', 'Front Load Washer', 'Front Load, Quick Wash, Eco Wash', 'Inverter Technology'),
('PRD1027', 'Washing Machine', 'Top Load, Gentle Wash, Spin Dry', 'Conventional'),
('PRD1028', 'Portable Washer', 'Washer-Dryer Combo, Steam Wash, Anti-Allergen', 'Smart Inverter'),
('PRD1029', 'Washing Machine', 'Portable Washer, Single Tub, Compact Design', 'Standard'),
('PRD1030', 'Washing Machine', 'Front Load, High Efficiency, Multiple Wash Programs', 'Inverter Technology'),
('PRD1031', 'Basic Rice Cooker', 'Basic Cook, Keep Warm', 'Standard'),
('PRD1032', 'Rice Cooker', 'Multiple Cooking Modes, Keep Warm, Timer', 'Fuzzy Logic'),
('PRD1033', 'Compact Rice Cooker', 'Smart Cooking, App Control, Customizable Settings', 'IoT Enabled'),
('PRD1034', 'Rice Cooker', 'Compact, Travel-Friendly, Quick Cook', 'Standard'),
('PRD1035', 'Advanced Rice Cooker', 'Advanced Cooking, Delay Timer, Multi-Function', 'Fuzzy Logic');

INSERT INTO Television (ProductID, ImageTech, SoundTech, ConnectivityTech) VALUES
('PRD1011', 'Full HD', 'Stereo', 'HDMI, USB, Wi-Fi'),
('PRD1012', '4K HDR', 'Dolby Audio', 'HDMI, USB, Wi-Fi, Bluetooth'),
('PRD1013', 'Ultra HD', 'Surround Sound', 'HDMI, USB, Wi-Fi, Bluetooth'),
('PRD1014', '4K OLED', 'Dolby Atmos', 'HDMI, USB, Wi-Fi, Bluetooth, Ethernet'),
('PRD1015', 'HD', 'Stereo', 'HDMI, USB');


INSERT INTO Phone ( ProductID, CPU, Memory, TouchScreen, BatteryLife, ConnectivitySupport, CameraSpecs) VALUES
('PRD1001', 'Octa-Core', 128, 'Capacitive', '24 hours', '5G, WiFi 6, Bluetooth 5.2', '12MP Ultra-wide, 48MP Main'),
('PRD1002', 'Quad-Core', 64, 'Capacitive', '36 hours', '4G, WiFi 5, Bluetooth 5.0', '8MP Wide, 24MP Main'),
('PRD1003', 'Octa-Core', 64, 'AMOLED', '20 hours', '4G, WiFi 5, Bluetooth 5.0', '8MP Wide, 16MP Main'),
('PRD1004', 'Octa-Core', 256, 'AMOLED', '24 hours', '5G, WiFi 6, Bluetooth 5.1', '12MP Ultra-wide, 64MP Main'),
('PRD1005','Octa-Core', 256, 'AMOLED', '24 hours', '5G, WiFi 6, Bluetooth 5.1', '12MP Ultra-wide, 108MP Main');
INSERT INTO Laptop (ProductID, CPU, Memory, ConnectivityPorts, BatteryLife, SoundTech, GraphicsCard) VALUES
('PRD1006', 'Intel Core i7', 16, 'USB-C, HDMI, Wi-Fi, Bluetooth', '10 hours', 'Dolby Audio', 'NVIDIA RTX 3060'),
('PRD1007', 'Intel Core i5', 8, 'USB 3.0, HDMI, Wi-Fi, Bluetooth', '12 hours', 'Standard Stereo', 'Integrated Intel Graphics'),
('PRD1008', 'Intel Core i9', 32, 'USB-C, Thunderbolt, Wi-Fi 6, Bluetooth 5.0', '8 hours', 'Dolby Atmos', 'NVIDIA RTX 3080'),
('PRD1009', 'AMD Ryzen 5', 16, 'USB-C, HDMI, Wi-Fi, Bluetooth', '9 hours', 'High Definition Audio', 'AMD Radeon Graphics'),
('PRD1010', 'AMD Ryzen 3', 8, 'USB 3.0, HDMI, Wi-Fi, Bluetooth', '11 hours', 'Standard Stereo', 'Integrated AMD Graphics');
INSERT INTO AirConditioner (ProductID, Type, CoolingPower, AirFilteringTech, GasType) VALUES
('PRD1016', 'Split AC', 1.5, 'HEPA Filter', 'R32'),
('PRD1017', 'Smart AC', 2.0, 'Activated Carbon Filter', 'R410A'),
('PRD1018', 'Split AC', 2.5, 'UV Air Purification', 'R32'),
('PRD1019', 'Portable AC', 1.2, 'Dust Filter', 'R290'),
('PRD1020', 'Window AC', 1.8, 'Bio Filter', 'R22');
INSERT INTO Refrigerator (ProductID, FridgeType, Capacity, PreservationTech) VALUES
('PRD1021', 'Double Door', 500, 'Frost Free, Multi Airflow System'),
('PRD1022', 'Single Door', 350, 'Static Cooling, Energy Saving Mode'),
('PRD1023', 'Smart Fridge', 400, 'Frost Free, Wi-Fi Enabled Controls'),
('PRD1024', 'Side-by-Side', 700, 'Frost Free, Ice Dispenser'),
('PRD1025', 'Compact', 200, 'Static Cooling, Adjustable Shelves');
INSERT INTO WashingMachine (ProductID, WasherType, MotorType, WashingTech) VALUES
('PRD1026', 'Front Load', 'Inverter Motor', 'Steam Wash'),
('PRD1027', 'Top Load', 'Conventional Motor', 'Agitator Wash'),
('PRD1028', 'Combo', 'Digital Inverter Motor', 'Eco Bubble Wash'),
('PRD1029', 'Portable', 'Brushed Motor', 'Impeller Wash'),
('PRD1030', 'Front Load', 'SmartDrive Motor', 'Direct Drive Wash');
INSERT INTO RiceCooker (ProductID, CookerType, CookingTech, CookingFunction) VALUES
('PRD1031', 'Basic', 'Thermal Heating', 'Standard Cook'),
('PRD1032', 'Multifunctional', 'Fuzzy Logic', 'Multi Cook, Slow Cook'),
('PRD1033', 'Smart', 'Induction Heating', 'App-Controlled, Preset Menus'),
('PRD1034', 'Compact', 'Thermal Heating', 'Rapid Cook'),
('PRD1035', 'Advanced', '3D Heating', 'Multigrain, Quick Cook');



INSERT INTO ProductColor (ProductID, ColorID) VALUES 
('PRD1001', 'COL001'), ('PRD1001', 'COL002'),
('PRD1002', 'COL002'), 
('PRD1003', 'COL001'), ('PRD1003', 'COL004'),
('PRD1004', 'COL004'), 
('PRD1005', 'COL003'), ('PRD1005', 'COL005'),
('PRD1006', 'COL002'), ('PRD1006', 'COL001'),
('PRD1007', 'COL003'), ('PRD1007', 'COL005'),
('PRD1008', 'COL004'), ('PRD1008', 'COL002'),
('PRD1009', 'COL005'), 
('PRD1010', 'COL001'), ('PRD1010', 'COL005'),
('PRD1011', 'COL001'), ('PRD1011', 'COL003'),
('PRD1012', 'COL002'), ('PRD1012', 'COL004'),
('PRD1013', 'COL005'), ('PRD1013', 'COL003'),
('PRD1014', 'COL001'), ('PRD1014', 'COL004'),
('PRD1015', 'COL002'), ('PRD1015', 'COL005'),
('PRD1016', 'COL001'), ('PRD1016', 'COL003'),
('PRD1017', 'COL002'), ('PRD1017', 'COL004'),
('PRD1018', 'COL003'), ('PRD1018', 'COL004'),
('PRD1019', 'COL001'), ('PRD1019', 'COL002'),
('PRD1020', 'COL005'), ('PRD1020', 'COL002'),
('PRD1021', 'COL003'), ('PRD1021', 'COL004'),
('PRD1022', 'COL001'), ('PRD1022', 'COL002'),
('PRD1023', 'COL005'), ('PRD1023', 'COL002'),
('PRD1024', 'COL003'), ('PRD1024', 'COL001'),
('PRD1025', 'COL004'), ('PRD1025', 'COL005'),
('PRD1026', 'COL001'), ('PRD1026', 'COL003'),
('PRD1027', 'COL002'), ('PRD1027', 'COL004'),
('PRD1028', 'COL005'), ('PRD1028', 'COL001'),
('PRD1029', 'COL003'), ('PRD1029', 'COL002'),
('PRD1030', 'COL004'), ('PRD1030', 'COL001'),
('PRD1031', 'COL001'), ('PRD1031', 'COL003'),
('PRD1032', 'COL002'), ('PRD1032', 'COL004'),
('PRD1033', 'COL005'), ('PRD1033', 'COL001'),
('PRD1034', 'COL003'), ('PRD1034', 'COL002'),
('PRD1035', 'COL004'), ('PRD1035', 'COL001');






INSERT INTO ProductMaterial (ProductID, MaterialID) VALUES 
('PRD1001', 'MAT001'), ('PRD1001', 'MAT002'),
('PRD1002', 'MAT001'), ('PRD1002', 'MAT003'),
('PRD1003', 'MAT002'), 
('PRD1004', 'MAT003'), ('PRD1004', 'MAT005'),
('PRD1005', 'MAT004'), ('PRD1005', 'MAT001'),
('PRD1006', 'MAT001'), 
('PRD1007', 'MAT002'), ('PRD1007', 'MAT004'),
('PRD1008', 'MAT003'), 
('PRD1009', 'MAT001'), ('PRD1009', 'MAT003'),
('PRD1010', 'MAT004') ,
('PRD1011', 'MAT001'), ('PRD1011', 'MAT003'),
('PRD1012', 'MAT002'), ('PRD1012', 'MAT004'),
('PRD1013', 'MAT005'), ('PRD1013', 'MAT003'),
('PRD1014', 'MAT002'), ('PRD1014', 'MAT004'),
('PRD1015', 'MAT001'), ('PRD1015', 'MAT003'),
('PRD1016', 'MAT001'), ('PRD1016', 'MAT003'),
('PRD1017', 'MAT002'), ('PRD1017', 'MAT004'),
('PRD1018', 'MAT004'), ('PRD1018', 'MAT005'),
('PRD1019', 'MAT002'), ('PRD1019', 'MAT003'),
('PRD1020', 'MAT001'), ('PRD1020', 'MAT002'),
('PRD1021', 'MAT004'), ('PRD1021', 'MAT005'),
('PRD1022', 'MAT002'), ('PRD1022', 'MAT003'),
('PRD1023', 'MAT003'), ('PRD1023', 'MAT001'),
('PRD1024', 'MAT005'), ('PRD1024', 'MAT002'),
('PRD1025', 'MAT004'), ('PRD1025', 'MAT003'),
('PRD1026', 'MAT001'), ('PRD1026', 'MAT002'),
('PRD1027', 'MAT003'), ('PRD1027', 'MAT004'),
('PRD1028', 'MAT005'), ('PRD1028', 'MAT001'),
('PRD1029', 'MAT002'), ('PRD1029', 'MAT003'),
('PRD1030', 'MAT004'), ('PRD1030', 'MAT001'),
('PRD1032', 'MAT003'), ('PRD1032', 'MAT004'),
('PRD1033', 'MAT005'), ('PRD1033', 'MAT001'),
('PRD1034', 'MAT002'), ('PRD1034', 'MAT003'),
('PRD1035', 'MAT004'), ('PRD1035', 'MAT001');



INSERT INTO ProductUtility (ProductID, UtilityID) VALUES 
('PRD1001', 'UTI001'), ('PRD1001', 'UTI002'),
('PRD1002', 'UTI002'), ('PRD1002', 'UTI003'),
('PRD1003', 'UTI003'), ('PRD1003', 'UTI004'),
('PRD1004', 'UTI004'), ('PRD1004', 'UTI005'),
('PRD1005', 'UTI005'), ('PRD1005', 'UTI001'),
('PRD1006', 'UTI001'), ('PRD1006', 'UTI002'), ('PRD1006', 'UTI003'), 
('PRD1007', 'UTI001'), ('PRD1007', 'UTI002'), ('PRD1007', 'UTI004'),
('PRD1008', 'UTI001'), ('PRD1008', 'UTI002'), ('PRD1008', 'UTI005'),
('PRD1009', 'UTI001'), ('PRD1009', 'UTI002'), ('PRD1009', 'UTI004'),
('PRD1010', 'UTI001'), ('PRD1010', 'UTI002'), ('PRD1010', 'UTI005'),
('PRD1011', 'UTI001'), ('PRD1011', 'UTI003'),
('PRD1012', 'UTI002'), ('PRD1012', 'UTI004'),
('PRD1013', 'UTI005'), ('PRD1013', 'UTI004'),
('PRD1014', 'UTI003'), ('PRD1014', 'UTI002'),
('PRD1015', 'UTI001'), ('PRD1015', 'UTI005'),
('PRD1016', 'UTI001'), ('PRD1016', 'UTI003'),
('PRD1017', 'UTI002'), ('PRD1017', 'UTI004'),
('PRD1018', 'UTI002'), ('PRD1018', 'UTI003'),
('PRD1019', 'UTI004'), ('PRD1019', 'UTI005'),
('PRD1020', 'UTI001'), ('PRD1020', 'UTI002'),
('PRD1021', 'UTI002'), ('PRD1021', 'UTI003'),
('PRD1022', 'UTI004'), ('PRD1022', 'UTI005'),
('PRD1023', 'UTI001'), ('PRD1023', 'UTI005'),
('PRD1024', 'UTI003'), ('PRD1024', 'UTI002'),
('PRD1025', 'UTI004'), ('PRD1025', 'UTI001'),
('PRD1026', 'UTI001'), ('PRD1026', 'UTI002'),
('PRD1027', 'UTI003'), ('PRD1027', 'UTI004'),
('PRD1028', 'UTI005'), ('PRD1028', 'UTI001'),
('PRD1029', 'UTI002'), ('PRD1029', 'UTI003'),
('PRD1030', 'UTI004'), ('PRD1030', 'UTI005'),
('PRD1031', 'UTI001'), ('PRD1031', 'UTI002'),
('PRD1032', 'UTI003'), ('PRD1032', 'UTI004'),
('PRD1033', 'UTI005'), ('PRD1033', 'UTI001'),
('PRD1034', 'UTI002'), ('PRD1034', 'UTI003'),
('PRD1035', 'UTI004'), ('PRD1035', 'UTI005');



INSERT INTO Account (AccountID, Username, Password, Email, PhoneNumber, FirstName, LastName, Age) VALUES
('ACC001', 'phamhuuhuy', 'password123!', 'phamhuuhuy@example.com', '0987654321', 'Phạm', 'Hữu Huy', 28),
('ACC002', 'tranvanlam', 'passwor123!', 'tranvanlam@example.com', '0987654322', 'Trần', 'Văn Lâm', 32),
('ACC003', 'lethibichnga', 'securePass456!', 'lethibichnga@example.com', '0987654323', 'Lê', 'Thị Bích Ngà', 26),
('ACC004', 'phamthanhhoa', 'mySecurePass789!', 'phamthanhhoa@example.com', '0987654324', 'Phạm', 'Thanh Hoa', 29),
('ACC005', 'ngocanh92', 'NgocAnh@92', 'ngocanh92@example.com', '0987123455', 'Ngọc', 'Anh', 29),
('ACC006', 'minhthu1988', 'ThuMinh!1988', 'minhthu1988@example.com', '0987234566', 'Minh', 'Thư', 33),
('ACC007', 'hoangtuan91', 'TuanHoang1991*', 'hoangtuan91@example.com', '0987345677', 'Hoàng', 'Tuấn', 30),
('ACC008', 'linhchi24', 'ChiLinh@24', 'linhchi24@example.com', '0987456788', 'Linh', 'Chi', 27),
('ACC009', 'quanghuy95', 'HuyQuang@95', 'quanghuy95@example.com', '0987567899', 'Quang', 'Huy', 26),
('ACC010', 'dangnam90', 'NamDang!1990', 'dangnam90@example.com', '0987651010', 'Đặng', 'Nam', 31),
('ACC011', 'phuongmai87', 'MaiPhuong#1987', 'phuongmai87@example.com', '0987651111', 'Phương', 'Mai', 34),
('ACC012', 'trungduong92', 'DuongTrung92$', 'trungduong92@example.com', '0987651212', 'Trung', 'Dương', 29),
('ACC013', 'baoanh88', 'AnhBao*1988', 'baoanh88@example.com', '0987651313', 'Bảo', 'Anh', 33),
('ACC014', 'hoangyen93', 'YenHoang1993!', 'hoangyen93@example.com', '0987651414', 'Hoàng', 'Yến', 28),
('ACC015', 'thuylinh89', 'LinhThuy@1989', 'thuylinh89@example.com', '0987651515', 'Thùy', 'Linh', 32),
('ACC016', 'vietlong94', 'LongViet#1994', 'vietlong94@example.com', '0987651616', 'Việt', 'Long', 27),
('ACC017', 'ngocbao95', 'BaoNgoc*1995', 'ngocbao95@example.com', '0987651717', 'Ngọc', 'Bảo', 26),
('ACC018', 'tuananh96', 'AnhTuan1996!', 'tuananh96@example.com', '0987651818', 'Tuấn', 'Anh', 25),
('ACC019', 'minhhang91', 'HangMinh91$', 'minhhang91@example.com', '0987651919', 'Minh', 'Hằng', 30),
('ACC020', 'nguyenhoa89', 'HoaNguyen1989!', 'nguyenhoa89@example.com', '0987652020', 'Nguyễn', 'Hoa', 32),
('ACC021', 'ducmanh87', 'ManhDuc@1987', 'ducmanh87@example.com', '0987652121', 'Đức', 'Mạnh', 34),
('ACC022', 'hienthao92', 'ThaoHien!1992', 'hienthao92@example.com', '0987652222', 'Hiền', 'Thảo', 29),
('ACC023', 'thanhson93', 'SonThanh#1993', 'thanhson93@example.com', '0987652323', 'Thanh', 'Sơn', 28),
('ACC024', 'khanhlinh88', 'LinhKhanh@1988', 'khanhlinh88@example.com', '0987652424', 'Khánh', 'Linh', 33);


INSERT INTO Customer (CustomerID) VALUES
('ACC005'),
('ACC006'),
('ACC007'),
('ACC008'),
('ACC009'),
('ACC010'),
('ACC011'),
('ACC012'),
('ACC013'),
('ACC014'),
('ACC015'),
('ACC016'),
('ACC017'),
('ACC018'),
('ACC019'),
('ACC020'),
('ACC021'),
('ACC022'),
('ACC023'),
('ACC024');

INSERT INTO Employee (EmployeeID, StartDate, Status, SuperiorID) VALUES
('ACC001', '2021-01-01', 'Active', NULL),
('ACC002', '2021-01-02', 'Active', 'ACC001'),
('ACC003', '2021-01-03', 'Active', 'ACC001'),
('ACC004', '2021-01-04', 'Active', 'ACC002');

-- Insert sample data into the Orders table
INSERT INTO Orders (OrderID,  CreationDate, Status, Note, ProductQuantity, EmployeeID) VALUES
('ORD007', '2023-03-15', 'Đã nhận', 'Nhập hàng từ nhà cung cấp', 5, 'ACC001'),
('ORD008', '2023-03-16', 'Đang xử lý', 'Nhập hàng từ nhà cung cấp', 3, 'ACC002'),
('ORD009', '2023-03-17', 'Đang vận chuyển', 'Nhập hàng từ nhà cung cấp', 4, 'ACC003'),
('ORD010', '2023-03-18', 'Chờ xác nhận', 'Nhập hàng từ nhà cung cấp', 2, 'ACC004'),
('ORD011', '2023-03-19', 'Đã nhận', 'Nhập hàng từ nhà cung cấp', 6, 'ACC001'),
('ORD012', '2023-03-15', 'Đang xử lý', 'Đơn hàng bán ra', 3, 'ACC002'),
('ORD013', '2023-03-16', 'Đã giao', 'Đơn hàng bán ra', 2, 'ACC003'),
('ORD014', '2023-03-17', 'Đang vận chuyển', 'Đơn hàng bán ra', 4, 'ACC004'),
('ORD015', '2023-03-18', 'Chờ xác nhận', 'Đơn hàng bán ra', 1, 'ACC001'),
('ORD016', '2023-03-19', 'Đang xử lý', 'Đơn hàng bán ra', 5, 'ACC002');

-- Insert sample data into the CustomerAddress table
INSERT INTO CustomerAddress (AddressID, CustomerID, Street, District, City, State) VALUES
('ADD001', 'ACC002', '123 Lê Lợi', '1', 'TP.Hồ Chí Minh', 'Việt Nam'),
('ADD002', 'ACC001', '456 Phan Đình Phùng', '2', 'Hà Nội', 'Việt Nam'),
('ADD003', 'ACC004', '789 Trần Hưng Đạo', '3', 'Đà Nẵng', 'Việt Nam'),
('ADD004', 'ACC003', '1011 Nguyễn Trãi', '4', 'Cần Thơ', 'Việt Nam'),
('ADD010', 'ACC010', '123 Phan Văn Trị', '7', 'TP.Hồ Chí Minh', 'Việt Nam'),
('ADD011', 'ACC011', '456 Lê Duẩn', '1', 'Hà Nội', 'Việt Nam'),
('ADD012', 'ACC012', '789 Nguyễn Trãi', '5', 'Đà Nẵng', 'Việt Nam'),
('ADD013', 'ACC013', '1011 Lý Thường Kiệt', '3', 'Nha Trang', 'Việt Nam'),
('ADD014', 'ACC014', '1213 Trần Hưng Đạo', '9', 'Cần Thơ', 'Việt Nam'),
('ADD015', 'ACC015', '1315 Lê Lợi', '2', 'Huế', 'Việt Nam'),
('ADD016', 'ACC016', '1517 Phạm Ngũ Lão', '10', 'Vũng Tàu', 'Việt Nam'),
('ADD017', 'ACC017', '1719 Bà Triệu', '4', 'Hải Phòng', 'Việt Nam'),
('ADD018', 'ACC018', '1921 Lê Thánh Tông', '6', 'Quảng Ninh', 'Việt Nam'),
('ADD019', 'ACC019', '2123 Hùng Vương', '11', 'Phú Quốc', 'Việt Nam'),
('ADD020', 'ACC020', '2325 Lê Quý Đôn', '7', 'Bình Dương', 'Việt Nam'),
('ADD021', 'ACC021', '2527 Nguyễn Huệ', '8', 'Thái Nguyên', 'Việt Nam'),
('ADD022', 'ACC022', '2729 Trường Chinh', '12', 'Phan Thiết', 'Việt Nam'),
('ADD023', 'ACC023', '2931 Nguyễn Khắc Nhu', '5', 'Đà Lạt', 'Việt Nam'),
('ADD024', 'ACC024', '3133 Lê Hồng Phong', '3', 'Biên Hòa', 'Việt Nam');
INSERT INTO PurchaseOrder (OrderID, OrderDate, TotalAmount) 
VALUES 
('ORD007', '2023-03-15', 1500),
('ORD008', '2023-03-16', 900),
('ORD009', '2023-03-17', 1200),
('ORD010', '2023-03-18', 600),
('ORD011', '2023-03-19', 1800);
INSERT INTO SaleOrder (OrderID, CustomerID, ExpectedDeliveryDate, TotalAmount, Address) 
VALUES 
('ORD012', 'ACC007', '2023-03-20', 900, 'Địa chỉ giao hàng A'),
('ORD013', 'ACC008', '2023-03-21', 600, 'Địa chỉ giao hàng B'),
('ORD014', 'ACC009', '2023-03-22', 1200, 'Địa chỉ giao hàng C'),
('ORD015', 'ACC010', '2023-03-23', 300, 'Địa chỉ giao hàng D'),
('ORD016', 'ACC011', '2023-03-24', 1500, 'Địa chỉ giao hàng E');


-- Insert sample data into the OrderDetails table
INSERT INTO OrderDetails (OrderDetailsID, OrderID, ProductID, Quantity) VALUES
('ODTL010', 'ORD007', 'PRD1001', 2),
('ODTL011', 'ORD008', 'PRD1002', 1),
('ODTL012', 'ORD009', 'PRD1003', 2),
('ODTL013', 'ORD010', 'PRD1004', 1),
('ODTL014', 'ORD011', 'PRD1005', 3),
('ODTL015', 'ORD012', 'PRD1006', 1),
('ODTL016', 'ORD013', 'PRD1007', 1),
('ODTL017', 'ORD014', 'PRD1008', 2),
('ODTL018', 'ORD015', 'PRD1009', 1),
('ODTL019', 'ORD016', 'PRD1010', 2);


-- ...Continue with similar INSERT statements for the Television, Phone, Laptop, Refrigerator, AirConditioner, WashingMachine, RiceCooker, PurchaseOrder, and SaleOrder tables.


