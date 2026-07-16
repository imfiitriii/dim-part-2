-- 1. INDEPENDENT TABLES
CREATE TABLE Person (
    P_ID VARCHAR(15), P_DateOfBirth DATE,
    P_FullName VARCHAR(150) NOT NULL, P_ICNumber VARCHAR(14) UNIQUE NOT NULL,
    P_Address VARCHAR(255) NOT NULL, P_Gender CHAR(1) NOT NULL,
    P_Nationality VARCHAR(50) NOT NULL, P_PhoneNumber VARCHAR(20) NOT NULL,
    P_Email VARCHAR(100) UNIQUE NOT NULL, P_MaritalStatus VARCHAR(15) NOT NULL,
    PRIMARY KEY (P_ID, P_DateOfBirth)
);

CREATE TABLE Branch (
    B_ID VARCHAR(15), B_BranchCode VARCHAR(10),
    B_Name VARCHAR(100) NOT NULL, B_Address VARCHAR(255) NOT NULL,
    B_City VARCHAR(50) NOT NULL, B_State VARCHAR(50) NOT NULL,
    B_Postcode VARCHAR(10) NOT NULL, B_PhoneNumber VARCHAR(20) NOT NULL,
    B_Email VARCHAR(100) UNIQUE NOT NULL, B_OperatingHours VARCHAR(50) NOT NULL,
    PRIMARY KEY (B_ID, B_BranchCode)
);

CREATE TABLE Fund (
    F_ID VARCHAR(15), F_Code VARCHAR(10),
    F_Name VARCHAR(100) NOT NULL, F_Type VARCHAR(30) NOT NULL,
    F_RiskLevel VARCHAR(15) NOT NULL, F_LaunchDate DATE NOT NULL,
    F_Size DECIMAL(15,2) NOT NULL, F_Objective CLOB NOT NULL,
    F_DividendFrequency VARCHAR(20) NOT NULL, F_ManagementFee DECIMAL(4,2) NOT NULL,
    PRIMARY KEY (F_ID, F_Code)
);

CREATE TABLE Asset (
    AS_ID VARCHAR(15), AS_Code VARCHAR(15),
    AS_Name VARCHAR(100) NOT NULL, AS_Category VARCHAR(30) NOT NULL,
    AS_Type VARCHAR(30) NOT NULL, AS_MarketValue DECIMAL(15,4) NOT NULL,
    AS_PurchaseValue DECIMAL(15,4) NOT NULL, AS_AcquisitionDate DATE NOT NULL,
    AS_MaturityDate DATE NOT NULL, AS_RiskRating VARCHAR(10) NOT NULL,
    PRIMARY KEY (AS_ID, AS_Code)
);

CREATE TABLE JobAdvertisment (
    JAD_ID VARCHAR(15), JAD_PostingDate DATE,
    JAD_JobTitle VARCHAR(50) NOT NULL, JAD_Department VARCHAR(50) NOT NULL,
    JAD_EmploymentType VARCHAR(20) NOT NULL, JAD_SalaryType VARCHAR(15) NOT NULL,
    JAD_Location VARCHAR(50) NOT NULL, JAD_QualificationRequired CLOB NOT NULL,
    JAD_ExperienceRequired VARCHAR(50) NOT NULL, JAD_ClosingDate DATE NOT NULL,
    PRIMARY KEY (JAD_ID, JAD_PostingDate)
);

CREATE TABLE JobDescription (
    JD_ID VARCHAR(15), JD_CreationDate DATE,
    JD_PositionTitle VARCHAR(50) NOT NULL, JD_Department VARCHAR(20) NOT NULL,
    JD_JobLevel VARCHAR(20) NOT NULL, JD_EmploymentType VARCHAR(20) NOT NULL,
    JD_Responsibilities VARCHAR(100) NOT NULL, JD_Qualifications VARCHAR(100) NOT NULL,
    JD_SkillsRequired VARCHAR(100) NOT NULL, JD_WorkingHours VARCHAR(30) NOT NULL,
    PRIMARY KEY (JD_ID, JD_CreationDate)
);

-- 2. SUBCLASS/DEPENDENT TABLES
CREATE TABLE Employee (
    E_ID VARCHAR(15), E_HireDate DATE,
    E_Number VARCHAR(15) UNIQUE NOT NULL, E_Department VARCHAR(50) NOT NULL,
    E_Position VARCHAR(50) NOT NULL, E_Type VARCHAR(50) NOT NULL,
    E_SalaryGrade VARCHAR(10) NOT NULL, E_WorkEmail VARCHAR(100) UNIQUE NOT NULL,
    E_WorkPhone VARCHAR(20) NOT NULL, E_ShiftSchedule VARCHAR(30) NOT NULL,
    P_ID VARCHAR(15) NOT NULL, P_DateOfBirth DATE NOT NULL,
    B_ID VARCHAR(15) NOT NULL, B_BranchCode VARCHAR(10) NOT NULL,
    PRIMARY KEY (E_ID, E_HireDate),
    FOREIGN KEY (P_ID, P_DateOfBirth) REFERENCES Person(P_ID, P_DateOfBirth),
    FOREIGN KEY (B_ID, B_BranchCode) REFERENCES Branch(B_ID, B_BranchCode)
);

CREATE TABLE Applicant (
    A_ID VARCHAR(15), A_ApplicationDate DATE,
    A_HighestEducation VARCHAR(50) NOT NULL, A_YearsExperience INT NOT NULL,
    A_CurrentEmployer VARCHAR(100) NOT NULL, A_ExpectedSalary VARCHAR(255) NOT NULL,
    A_ResumeFile VARCHAR(255) NOT NULL, A_PortfolioLink VARCHAR(255) NOT NULL,
    A_ApplicationStatus VARCHAR(20) NOT NULL, A_AvailabilityDate DATE NOT NULL,
    P_ID VARCHAR(15) NOT NULL, P_DateOfBirth DATE NOT NULL,
    PRIMARY KEY (A_ID, A_ApplicationDate),
    FOREIGN KEY (P_ID, P_DateOfBirth) REFERENCES Person(P_ID, P_DateOfBirth)
);

CREATE TABLE Investor (
    I_ID VARCHAR(15), I_RegistrationDate DATE,
    I_Category VARCHAR(30) NOT NULL, I_RiskProfile VARCHAR(30) NOT NULL,
    I_AnnualIncome VARCHAR(20) NOT NULL, I_OccupationSector VARCHAR(20) NOT NULL,
    I_TaxResidency VARCHAR(50) NOT NULL, I_Goal VARCHAR(100) NOT NULL,
    I_Experience VARCHAR(50) NOT NULL, I_PreferredLanguage VARCHAR(20) NOT NULL,
    P_ID VARCHAR(15) NOT NULL, P_DateOfBirth DATE NOT NULL,
    PRIMARY KEY (I_ID, I_RegistrationDate),
    FOREIGN KEY (P_ID, P_DateOfBirth) REFERENCES Person(P_ID, P_DateOfBirth)
);

CREATE TABLE RegistrationForm (
    RF_ID VARCHAR(15), RF_SubmissionDate DATE,
    RF_FormType VARCHAR(30) NOT NULL, RF_VerificationStatus VARCHAR(30) NOT NULL,
    RF_SupportingDocumentType VARCHAR(50) NOT NULL, RF_ApprovalDate DATE NOT NULL,
    RF_VerificationDate DATE NOT NULL, RF_ApprovalStatus VARCHAR(15) NOT NULL,
    RF_SubmissionChannel VARCHAR(20) NOT NULL, RF_KYCStatus VARCHAR(15) NOT NULL,
    I_ID VARCHAR(15) NOT NULL, I_RegistrationDate DATE NOT NULL,
    PRIMARY KEY (RF_ID, RF_SubmissionDate),
    FOREIGN KEY (I_ID, I_RegistrationDate) REFERENCES Investor(I_ID, I_RegistrationDate)
);

CREATE TABLE JobApplication (
    JAPP_ID VARCHAR(15), JAPP_SubmissionDate DATE,
    JAPP_Status VARCHAR(20) NOT NULL, JAPP_ScreeningScore INT NOT NULL,
    JAPP_InterviewDate TIMESTAMP NOT NULL, JAPP_InterviewResult VARCHAR(30) NOT NULL,
    JAPP_OfferStatus VARCHAR(20) NOT NULL, JAPP_ExpectedSalary DECIMAL(10,2) NOT NULL,
    JAPP_AvailabilityDate DATE NOT NULL, JAPP_ApplicationSource VARCHAR(50) NOT NULL,
    A_ID VARCHAR(15) NOT NULL, A_ApplicationDate DATE NOT NULL,
    PRIMARY KEY (JAPP_ID, JAPP_SubmissionDate),
    FOREIGN KEY (A_ID, A_ApplicationDate) REFERENCES Applicant(A_ID, A_ApplicationDate)
);

CREATE TABLE InvestmentPortfolio (
    IP_ID VARCHAR(15), IP_CreationDate DATE,
    IP_Name VARCHAR(50) NOT NULL, IP_Type VARCHAR(30) NOT NULL,
    IP_RiskLevel VARCHAR(15) NOT NULL, IP_Value DECIMAL(15,4) NOT NULL,
    IP_AssetAllocation VARCHAR(100) NOT NULL, IP_ManagerName VARCHAR(50) NOT NULL,
    IP_InvestmentObjective VARCHAR(100) NOT NULL, IP_RebalancingFrequency VARCHAR(20) NOT NULL,
    F_ID VARCHAR(10) NOT NULL, F_Code VARCHAR(10) NOT NULL,
    PRIMARY KEY (IP_ID, IP_CreationDate),
    FOREIGN KEY (F_ID, F_Code) REFERENCES Fund(F_ID, F_Code)
);

CREATE TABLE InvestorAccount (
    IA_ID VARCHAR(15), IA_AccountOpenDate DATE,
    IA_AccountNumber VARCHAR(30) UNIQUE NOT NULL, IA_AccountType VARCHAR(20) NOT NULL,
    IA_RiskCategory VARCHAR(20) NOT NULL, IA_TotalInvestment DECIMAL(15,4) NOT NULL,
    IA_TotalDividend DECIMAL(15,4) NOT NULL, IA_AccountBalance DECIMAL(15,4) NOT NULL,
    IA_AccountStatus VARCHAR(20) NOT NULL, IA_PreferredStatementMethod VARCHAR(20) NOT NULL,
    I_ID VARCHAR(15) NOT NULL, I_RegistrationDate DATE NOT NULL,
    RF_ID VARCHAR(15) NOT NULL, RF_SubmissionDate DATE NOT NULL,
    PRIMARY KEY (IA_ID, IA_AccountOpenDate),
    FOREIGN KEY (I_ID, I_RegistrationDate) REFERENCES Investor(I_ID, I_RegistrationDate),
    FOREIGN KEY (RF_ID, RF_SubmissionDate) REFERENCES RegistrationForm(RF_ID, RF_SubmissionDate)
);

CREATE TABLE OnlineAccount (
    OA_ID VARCHAR(15), OA_RegistrationDate DATE,
    OA_Username VARCHAR(50) UNIQUE NOT NULL, OA_PasswordHash VARCHAR(255) NOT NULL,
    OA_SecurityQuestion VARCHAR(255) NOT NULL, OA_SecurityAnswer VARCHAR(255) NOT NULL,
    OA_LastLogin CHAR(1) NOT NULL, OA_FailedLoginAttempts INT DEFAULT 0,
    OA_MFAStatus VARCHAR(15) NOT NULL, OA_AccountStatus VARCHAR(15) NOT NULL,
    I_ID VARCHAR(15) NOT NULL, I_RegistrationDate DATE NOT NULL,
    IA_ID VARCHAR(15) NOT NULL, IA_AccountOpenDate DATE NOT NULL,
    RF_ID VARCHAR(15) NOT NULL, RF_SubmissionDate DATE NOT NULL,
    PRIMARY KEY (OA_ID, OA_RegistrationDate),
    FOREIGN KEY (I_ID, I_RegistrationDate) REFERENCES Investor(I_ID, I_RegistrationDate),
    FOREIGN KEY (IA_ID, IA_AccountOpenDate) REFERENCES InvestorAccount(IA_ID, IA_AccountOpenDate),
    FOREIGN KEY (RF_ID, RF_SubmissionDate) REFERENCES RegistrationForm(RF_ID, RF_SubmissionDate)
);

CREATE TABLE BankAccount (
    BA_ID VARCHAR(15), BA_RegistrationDate DATE,
    BA_AccountNumber VARCHAR(30) UNIQUE NOT NULL, BA_BankName VARCHAR(100) NOT NULL,
    BA_BranchName VARCHAR(100) NOT NULL, BA_AccountType VARCHAR(20) NOT NULL,
    BA_Currency CHAR(3) NOT NULL, BA_AccountStatus VARCHAR(15) NOT NULL,
    BA_VerificationStatus VARCHAR(15) NOT NULL, BA_AccountHolderName VARCHAR(150) NOT NULL,
    P_ID VARCHAR(15) NOT NULL, P_DateOfBirth DATE NOT NULL,
    IA_ID VARCHAR(15) NOT NULL, IA_AccountOpenDate DATE NOT NULL,
    PRIMARY KEY (BA_ID, BA_RegistrationDate),
    FOREIGN KEY (P_ID, P_DateOfBirth) REFERENCES Person(P_ID, P_DateOfBirth),
    FOREIGN KEY (IA_ID, IA_AccountOpenDate) REFERENCES InvestorAccount(IA_ID, IA_AccountOpenDate)
);

CREATE TABLE FundHolding (
    FH_ID VARCHAR(15), FH_DateCreated DATE,
    FH_UnitsOwned DECIMAL(15,4) NOT NULL, FH_AverageCost DECIMAL(10,4) NOT NULL,
    FH_CurrentValue DECIMAL(15,4) NOT NULL, FH_TotalDividendEarned DECIMAL(15,4) NOT NULL,
    FH_HoldingStatus VARCHAR(15) NOT NULL, FH_LastUpdatedDate DATE NOT NULL,
    FH_UnrealizedGain DECIMAL(15,4) NOT NULL, FH_RealizedGain DECIMAL(15,4) NOT NULL,
    I_ID VARCHAR(15) NOT NULL, I_RegistrationDate DATE NOT NULL,
    IA_ID VARCHAR(15) NOT NULL, IA_AccountOpenDate DATE NOT NULL,
    F_ID VARCHAR(15) NOT NULL, F_Code VARCHAR(10) NOT NULL,
    PRIMARY KEY (FH_ID, FH_DateCreated),
    FOREIGN KEY (I_ID, I_RegistrationDate) REFERENCES Investor(I_ID, I_RegistrationDate),
    FOREIGN KEY (IA_ID, IA_AccountOpenDate) REFERENCES InvestorAccount(IA_ID, IA_AccountOpenDate),
    FOREIGN KEY (F_ID, F_Code) REFERENCES Fund(F_ID, F_Code)
);

CREATE TABLE Transaction (
    T_ID VARCHAR(15), T_Date DATE,
    T_Amount DECIMAL(15,4) NOT NULL, T_ReferenceNumber VARCHAR(30) UNIQUE NOT NULL,
    T_Title VARCHAR(100) NOT NULL, T_Time TIMESTAMP NOT NULL,
    T_ApprovalStatus VARCHAR(15) NOT NULL, T_Currency CHAR(3) NOT NULL,
    T_Remarks VARCHAR(255) NOT NULL, T_PaymentMethod VARCHAR(30) NOT NULL,
    I_ID VARCHAR(15) NOT NULL, I_RegistrationDate DATE NOT NULL,
    FH_ID VARCHAR(15) NOT NULL, FH_DateCreated DATE NOT NULL,
    E_ID VARCHAR(15) NOT NULL, E_HireDate DATE NOT NULL,
    F_ID VARCHAR(15) NOT NULL, F_Code VARCHAR(10) NOT NULL,
    IA_ID VARCHAR(15) NOT NULL, IA_AccountOpenDate DATE NOT NULL,
    OA_ID VARCHAR(15) NOT NULL, OA_RegistrationDate DATE NOT NULL,
    PRIMARY KEY (T_ID, T_Date),
    FOREIGN KEY (I_ID, I_RegistrationDate) REFERENCES Investor(I_ID, I_RegistrationDate),
    FOREIGN KEY (FH_ID, FH_DateCreated) REFERENCES FundHolding(FH_ID, FH_DateCreated),
    FOREIGN KEY (E_ID, E_HireDate) REFERENCES Employee(E_ID, E_HireDate),
    FOREIGN KEY (F_ID, F_Code) REFERENCES Fund(F_ID, F_Code),
    FOREIGN KEY (IA_ID, IA_AccountOpenDate) REFERENCES InvestorAccount(IA_ID, IA_AccountOpenDate),
    FOREIGN KEY (OA_ID, OA_RegistrationDate) REFERENCES OnlineAccount(OA_ID, OA_RegistrationDate)
);

CREATE TABLE PurchaseTransaction (
    PT_PurchaseID VARCHAR(15), PT_PurchaseDate DATE,
    PT_UnitsPurchased DECIMAL(15,4) NOT NULL, PT_UnitPrice DECIMAL(10,4) NOT NULL,
    PT_UnitPriceDate DATE NOT NULL, PT_PurchaseAmount DECIMAL(15,4) NOT NULL,
    PT_PurchaseMethod VARCHAR(20) NOT NULL, PT_PurchaseType VARCHAR(15) NOT NULL,
    PT_SalesCharge DECIMAL(10,4) NOT NULL, PT_AllocationDate DATE NOT NULL,
    T_ID VARCHAR(15) NOT NULL, T_Date DATE NOT NULL,
    PRIMARY KEY (PT_PurchaseID, PT_PurchaseDate),
    FOREIGN KEY (T_ID, T_Date) REFERENCES Transaction(T_ID, T_Date)
);

CREATE TABLE RedemptionTransaction (
    RT_RedemptionID VARCHAR(15), RT_RedemptionDate DATE,
    RT_UnitsRedeemed DECIMAL(15,4) NOT NULL, RT_RedemptionPrice DECIMAL(10,4) NOT NULL,
    RT_RedemptionAmount DECIMAL(10,4) NOT NULL, RT_RedemptionReason VARCHAR(100) NOT NULL,
    RT_EarlyRedemptionFlag CHAR(1) NOT NULL, RT_ExitFee DECIMAL(10,4) NOT NULL,
    RT_SettlementDate DATE NOT NULL, RT_RemainingUnits DECIMAL(10,4) NOT NULL,
    T_ID VARCHAR(15) NOT NULL, T_Date DATE NOT NULL,
    PRIMARY KEY (RT_RedemptionID, RT_RedemptionDate),
    FOREIGN KEY (T_ID, T_Date) REFERENCES Transaction(T_ID, T_Date)
);

CREATE TABLE SwitchTransaction (
    ST_SwitchID VARCHAR(15), ST_SwitchDate DATE,
    ST_SourceFundName VARCHAR(100) NOT NULL, ST_DestinationFundName VARCHAR(100) NOT NULL,
    ST_UnitsSwitched DECIMAL(15,4) NOT NULL, ST_SwitchFee DECIMAL(10,4) NOT NULL,
    ST_SourceFundPrice DECIMAL(10,4) NOT NULL, ST_DestinationFundPrice DECIMAL(10,4) NOT NULL,
    ST_ConversionRatio DECIMAL(6,4) NOT NULL, ST_SwitchReason VARCHAR(20) NOT NULL,
    T_ID VARCHAR(15) NOT NULL, T_Date DATE NOT NULL,
    PRIMARY KEY (ST_SwitchID, ST_SwitchDate),
    FOREIGN KEY (T_ID, T_Date) REFERENCES Transaction(T_ID, T_Date)
);

CREATE TABLE Receipt (
    R_ID VARCHAR(15), R_IssueDate DATE,
    R_Number VARCHAR(20) UNIQUE NOT NULL, R_Type VARCHAR(20) NOT NULL,
    R_Amount DECIMAL(15,4) NOT NULL, R_IssueTime TIMESTAMP NOT NULL,
    R_Remarks VARCHAR(255) NOT NULL, R_Status VARCHAR(20) NOT NULL,
    R_TaxAmount DECIMAL(15,4) NOT NULL, R_Currency VARCHAR(15) NOT NULL,
    E_ID VARCHAR(15) NOT NULL, E_HireDate DATE NOT NULL,
    I_ID VARCHAR(15) NOT NULL, I_RegistrationDate DATE NOT NULL,
    T_ID VARCHAR(15) NOT NULL, T_Date DATE NOT NULL,
    FH_ID VARCHAR(15) NOT NULL, FH_DateCreated DATE NOT NULL,
    PRIMARY KEY (R_ID, R_IssueDate),
    FOREIGN KEY (E_ID, E_HireDate) REFERENCES Employee(E_ID, E_HireDate),
    FOREIGN KEY (I_ID, I_RegistrationDate) REFERENCES Investor(I_ID, I_RegistrationDate),
    FOREIGN KEY (T_ID, T_Date) REFERENCES Transaction(T_ID, T_Date),
    FOREIGN KEY (FH_ID, FH_DateCreated) REFERENCES FundHolding(FH_ID, FH_DateCreated)
);

CREATE TABLE Dividend (
    D_ID VARCHAR(15), D_DeclarationDate DATE,
    D_Rate DECIMAL(6,4) NOT NULL, D_Year INT NOT NULL,
    D_Amount DECIMAL(15,4) NOT NULL, D_DistributionDate DATE NOT NULL,
    D_ApprovalStatus VARCHAR(15) NOT NULL, D_FundPerformance VARCHAR(50) NOT NULL,
    D_TaxRate DECIMAL(4,2) NOT NULL, D_Currency CHAR(3) NOT NULL,
    F_ID VARCHAR(15) NOT NULL, F_Code VARCHAR(10) NOT NULL,
    IP_ID VARCHAR(15) NOT NULL, IP_CreationDate DATE NOT NULL,
    PRIMARY KEY (D_ID, D_DeclarationDate),
    FOREIGN KEY (F_ID, F_Code) REFERENCES Fund(F_ID, F_Code),
    FOREIGN KEY (IP_ID, IP_CreationDate) REFERENCES InvestmentPortfolio(IP_ID, IP_CreationDate)
);

CREATE TABLE DividendDistribution (
    DD_ID VARCHAR(15), DD_DistributionDate VARCHAR(15),
    DD_DistributionAmount DECIMAL(15,4) NOT NULL, DD_DistributionMethod VARCHAR(20) NOT NULL,
    DD_TaxDeduction DECIMAL(12,4) NOT NULL, DD_Currency CHAR(3) NOT NULL,
    DD_PaymentStatus VARCHAR(15) NOT NULL, DD_ApprovalStatus VARCHAR(15) NOT NULL,
    DD_DistributionType VARCHAR(20) NOT NULL, DD_ProcessingDate TIMESTAMP NOT NULL,
    I_ID VARCHAR(15) NOT NULL, I_RegistrationDate DATE NOT NULL,
    FH_ID VARCHAR(15) NOT NULL, FH_DateCreated DATE NOT NULL,
    IA_ID VARCHAR(15) NOT NULL, IA_AccountOpenDate DATE NOT NULL,
    F_ID VARCHAR(15) NOT NULL, F_Code VARCHAR(10) NOT NULL,
    PRIMARY KEY (DD_ID, DD_DistributionDate),
    FOREIGN KEY (I_ID, I_RegistrationDate) REFERENCES Investor(I_ID, I_RegistrationDate),
    FOREIGN KEY (FH_ID, FH_DateCreated) REFERENCES FundHolding(FH_ID, FH_DateCreated),
    FOREIGN KEY (IA_ID, IA_AccountOpenDate) REFERENCES InvestorAccount(IA_ID, IA_AccountOpenDate),
    FOREIGN KEY (F_ID, F_Code) REFERENCES Fund(F_ID, F_Code)
);

CREATE TABLE Statement (
    S_ID VARCHAR(15), S_Period VARCHAR(20),
    S_GeneratedDate DATE NOT NULL, S_Type VARCHAR(20) NOT NULL,
    S_OpeningBalance DECIMAL(15,4) NOT NULL, S_ClosingBalance DECIMAL(15,4) NOT NULL,
    S_TotalInvesment DECIMAL(15,4) NOT NULL, S_TotalRedemption DECIMAL(15,4) NOT NULL,
    S_TotalDividend DECIMAL(15,4) NOT NULL, S_DeliveryMethod VARCHAR(15) NOT NULL,
    I_ID VARCHAR(15) NOT NULL, I_RegistrationDate DATE NOT NULL,
    IA_ID VARCHAR(15) NOT NULL, IA_AccountOpenDate DATE NOT NULL,
    OA_ID VARCHAR(15) NOT NULL, OA_RegistrationDate DATE NOT NULL,
    PRIMARY KEY (S_ID, S_Period),
    FOREIGN KEY (I_ID, I_RegistrationDate) REFERENCES Investor(I_ID, I_RegistrationDate),
    FOREIGN KEY (IA_ID, IA_AccountOpenDate) REFERENCES InvestorAccount(IA_ID, IA_AccountOpenDate),
    FOREIGN KEY (OA_ID, OA_RegistrationDate) REFERENCES OnlineAccount(OA_ID, OA_RegistrationDate)
);

CREATE TABLE Complaint (
    C_ID VARCHAR(15), C_Date DATE,
    C_Type VARCHAR(30) NOT NULL, C_Description CLOB NOT NULL,
    C_PriorityLevel VARCHAR(10) NOT NULL, C_SubmissionChannel VARCHAR(20) NOT NULL,
    C_Status VARCHAR(15) NOT NULL, C_AssignedOfficer VARCHAR(15) NOT NULL,
    C_Resolution CLOB NOT NULL, C_ResolutionDate DATE NOT NULL,
    RF_ID VARCHAR(15) NOT NULL, RF_SubmissionDate DATE NOT NULL,
    FH_ID VARCHAR(15) NOT NULL, FH_DateCreated DATE NOT NULL,
    F_ID VARCHAR(15) NOT NULL, F_Code VARCHAR(10) NOT NULL,
    DD_ID VARCHAR(15) NOT NULL, DD_DistributionDate VARCHAR(15) NOT NULL,
    B_ID VARCHAR(15) NOT NULL, B_BranchCode VARCHAR(10) NOT NULL,
    R_ID VARCHAR(15) NOT NULL, R_IssueDate DATE NOT NULL,
    D_ID VARCHAR(15) NOT NULL, D_DeclarationDate DATE NOT NULL,
    IP_ID VARCHAR(15) NOT NULL, IP_CreationDate DATE NOT NULL,
    AS_ID VARCHAR(15) NOT NULL, AS_Code VARCHAR(15) NOT NULL,
    JAPP_ID VARCHAR(15) NOT NULL, JAPP_SubmissionDate DATE NOT NULL,
    JAD_ID VARCHAR(15) NOT NULL, JAD_PostingDate DATE NOT NULL,
    JD_ID VARCHAR(15) NOT NULL, JD_CreationDate DATE NOT NULL,
    T_ID VARCHAR(15) NOT NULL, T_Date DATE NOT NULL,
    S_ID VARCHAR(15) NOT NULL, S_Period VARCHAR(20) NOT NULL,
    IA_ID VARCHAR(15) NOT NULL, IA_AccountOpenDate DATE NOT NULL,
    OA_ID VARCHAR(15) NOT NULL, OA_RegistrationDate DATE NOT NULL,
    PRIMARY KEY (C_ID, C_Date),
    FOREIGN KEY (RF_ID, RF_SubmissionDate) REFERENCES RegistrationForm(RF_ID, RF_SubmissionDate),
    FOREIGN KEY (FH_ID, FH_DateCreated) REFERENCES FundHolding(FH_ID, FH_DateCreated),
    FOREIGN KEY (F_ID, F_Code) REFERENCES Fund(F_ID, F_Code),
    FOREIGN KEY (DD_ID, DD_DistributionDate) REFERENCES DividendDistribution(DD_ID, DD_DistributionDate),
    FOREIGN KEY (B_ID, B_BranchCode) REFERENCES Branch(B_ID, B_BranchCode),
    FOREIGN KEY (R_ID, R_IssueDate) REFERENCES Receipt(R_ID, R_IssueDate),
    FOREIGN KEY (D_ID, D_DeclarationDate) REFERENCES Dividend(D_ID, D_DeclarationDate),
    FOREIGN KEY (IP_ID, IP_CreationDate) REFERENCES InvestmentPortfolio(IP_ID, IP_CreationDate),
    FOREIGN KEY (AS_ID, AS_Code) REFERENCES Asset(AS_ID, AS_Code),
    FOREIGN KEY (JAPP_ID, JAPP_SubmissionDate) REFERENCES JobApplication(JAPP_ID, JAPP_SubmissionDate),
    FOREIGN KEY (JAD_ID, JAD_PostingDate) REFERENCES JobAdvertisment(JAD_ID, JAD_PostingDate),
    FOREIGN KEY (JD_ID, JD_CreationDate) REFERENCES JobDescription(JD_ID, JD_CreationDate),
    FOREIGN KEY (T_ID, T_Date) REFERENCES Transaction(T_ID, T_Date),
    FOREIGN KEY (S_ID, S_Period) REFERENCES Statement(S_ID, S_Period),
    FOREIGN KEY (IA_ID, IA_AccountOpenDate) REFERENCES InvestorAccount(IA_ID, IA_AccountOpenDate),
    FOREIGN KEY (OA_ID, OA_RegistrationDate) REFERENCES OnlineAccount(OA_ID, OA_RegistrationDate)
);

-- 3. EXPLOSION TABLES
CREATE TABLE P_P_EXP (
    P_ID1 VARCHAR(15), P_DateOfBirth1 DATE,
    P_ID2 VARCHAR(15), P_DateOfBirth2 DATE,
    PRIMARY KEY (P_ID1, P_DateOfBirth1, P_ID2, P_DateOfBirth2),
    FOREIGN KEY (P_ID1, P_DateOfBirth1) REFERENCES Person(P_ID, P_DateOfBirth),
    FOREIGN KEY (P_ID2, P_DateOfBirth2) REFERENCES Person(P_ID, P_DateOfBirth)
);
CREATE TABLE I_D_EXP (
    I_ID VARCHAR(15), I_RegistrationDate DATE,
    D_ID VARCHAR(15), D_DeclarationDate DATE,
    PRIMARY KEY (I_ID, I_RegistrationDate, D_ID, D_DeclarationDate),
    FOREIGN KEY (I_ID, I_RegistrationDate) REFERENCES Investor(I_ID, I_RegistrationDate),
    FOREIGN KEY (D_ID, D_DeclarationDate) REFERENCES Dividend(D_ID, D_DeclarationDate)
);
CREATE TABLE I_B_EXP (
    I_ID VARCHAR(15), I_RegistrationDate DATE,
    B_ID VARCHAR(15), B_BranchCode VARCHAR(10),
    PRIMARY KEY (I_ID, I_RegistrationDate, B_ID, B_BranchCode),
    FOREIGN KEY (I_ID, I_RegistrationDate) REFERENCES Investor(I_ID, I_RegistrationDate),
    FOREIGN KEY (B_ID, B_BranchCode) REFERENCES Branch(B_ID, B_BranchCode)
);
CREATE TABLE E_IA_EXP (
    E_ID VARCHAR(15), E_HireDate DATE,
    IA_ID VARCHAR(15), IA_AccountOpenDate DATE,
    PRIMARY KEY (E_ID, E_HireDate, IA_ID, IA_AccountOpenDate),
    FOREIGN KEY (E_ID, E_HireDate) REFERENCES Employee(E_ID, E_HireDate),
    FOREIGN KEY (IA_ID, IA_AccountOpenDate) REFERENCES InvestorAccount(IA_ID, IA_AccountOpenDate)
);
CREATE TABLE E_OA_EXP (
    E_ID VARCHAR(15), E_HireDate DATE,
    OA_ID VARCHAR(15), OA_RegistrationDate DATE,
    PRIMARY KEY (E_ID, E_HireDate, OA_ID, OA_RegistrationDate),
    FOREIGN KEY (E_ID, E_HireDate) REFERENCES Employee(E_ID, E_HireDate),
    FOREIGN KEY (OA_ID, OA_RegistrationDate) REFERENCES OnlineAccount(OA_ID, OA_RegistrationDate)
);
CREATE TABLE E_FH_EXP (
    E_ID VARCHAR(15), E_HireDate DATE,
    FH_ID VARCHAR(15), FH_DateCreated DATE,
    PRIMARY KEY (E_ID, E_HireDate, FH_ID, FH_DateCreated),
    FOREIGN KEY (E_ID, E_HireDate) REFERENCES Employee(E_ID, E_HireDate),
    FOREIGN KEY (FH_ID, FH_DateCreated) REFERENCES FundHolding(FH_ID, FH_DateCreated)
);
CREATE TABLE E_DD_EXP (
    E_ID VARCHAR(15), E_HireDate DATE,
    DD_ID VARCHAR(15), DD_DistributionDate VARCHAR(15),
    PRIMARY KEY (E_ID, E_HireDate, DD_ID, DD_DistributionDate),
    FOREIGN KEY (E_ID, E_HireDate) REFERENCES Employee(E_ID, E_HireDate),
    FOREIGN KEY (DD_ID, DD_DistributionDate) REFERENCES DividendDistribution(DD_ID, DD_DistributionDate)
);
CREATE TABLE E_JD_EXP (
    E_ID VARCHAR(15), E_HireDate DATE,
    JD_ID VARCHAR(15), JD_CreationDate DATE,
    PRIMARY KEY (E_ID, E_HireDate, JD_ID, JD_CreationDate),
    FOREIGN KEY (E_ID, E_HireDate) REFERENCES Employee(E_ID, E_HireDate),
    FOREIGN KEY (JD_ID, JD_CreationDate) REFERENCES JobDescription(JD_ID, JD_CreationDate)
);
CREATE TABLE E_JAD_EXP (
    E_ID VARCHAR(15), E_HireDate DATE,
    JAD_ID VARCHAR(15), JAD_PostingDate DATE,
    PRIMARY KEY (E_ID, E_HireDate, JAD_ID, JAD_PostingDate),
    FOREIGN KEY (E_ID, E_HireDate) REFERENCES Employee(E_ID, E_HireDate),
    FOREIGN KEY (JAD_ID, JAD_PostingDate) REFERENCES JobAdvertisment(JAD_ID, JAD_PostingDate)
);
CREATE TABLE E_F_EXP (
    E_ID VARCHAR(15), E_HireDate DATE,
    F_ID VARCHAR(15), F_Code VARCHAR(10),
    PRIMARY KEY (E_ID, E_HireDate, F_ID, F_Code),
    FOREIGN KEY (E_ID, E_HireDate) REFERENCES Employee(E_ID, E_HireDate),
    FOREIGN KEY (F_ID, F_Code) REFERENCES Fund(F_ID, F_Code)
);
CREATE TABLE E_IP_EXP (
    E_ID VARCHAR(15), E_HireDate DATE,
    IP_ID VARCHAR(15), IP_CreationDate DATE,
    PRIMARY KEY (E_ID, E_HireDate, IP_ID, IP_CreationDate),
    FOREIGN KEY (E_ID, E_HireDate) REFERENCES Employee(E_ID, E_HireDate),
    FOREIGN KEY (IP_ID, IP_CreationDate) REFERENCES InvestmentPortfolio(IP_ID, IP_CreationDate)
);
CREATE TABLE JAD_JD_EXP (
    JAD_ID VARCHAR(15), JAD_PostingDate DATE,
    JD_ID VARCHAR(15), JD_CreationDate DATE,
    PRIMARY KEY (JAD_ID, JAD_PostingDate, JD_ID, JD_CreationDate),
    FOREIGN KEY (JAD_ID, JAD_PostingDate) REFERENCES JobAdvertisment(JAD_ID, JAD_PostingDate),
    FOREIGN KEY (JD_ID, JD_CreationDate) REFERENCES JobDescription(JD_ID, JD_CreationDate)
);
CREATE TABLE JAPP_JD_EXP (
    JAPP_ID VARCHAR(15), JAPP_SubmissionDate DATE,
    JD_ID VARCHAR(15), JD_CreationDate DATE,
    PRIMARY KEY (JAPP_ID, JAPP_SubmissionDate, JD_ID, JD_CreationDate),
    FOREIGN KEY (JAPP_ID, JAPP_SubmissionDate) REFERENCES JobApplication(JAPP_ID, JAPP_SubmissionDate),
    FOREIGN KEY (JD_ID, JD_CreationDate) REFERENCES JobDescription(JD_ID, JD_CreationDate)
);
CREATE TABLE IP_AS_EXP (
    IP_ID VARCHAR(15), IP_CreationDate DATE,
    AS_ID VARCHAR(15), AS_Code VARCHAR(15),
    PRIMARY KEY (IP_ID, IP_CreationDate, AS_ID, AS_Code),
    FOREIGN KEY (IP_ID, IP_CreationDate) REFERENCES InvestmentPortfolio(IP_ID, IP_CreationDate),
    FOREIGN KEY (AS_ID, AS_Code) REFERENCES Asset(AS_ID, AS_Code)
);
CREATE TABLE A_JD_EXP (
    A_ID VARCHAR(15), A_ApplicationDate DATE,
    JD_ID VARCHAR(15), JD_CreationDate DATE,
    PRIMARY KEY (A_ID, A_ApplicationDate, JD_ID, JD_CreationDate),
    FOREIGN KEY (A_ID, A_ApplicationDate) REFERENCES Applicant(A_ID, A_ApplicationDate),
    FOREIGN KEY (JD_ID, JD_CreationDate) REFERENCES JobDescription(JD_ID, JD_CreationDate)
);
CREATE TABLE F_AS_EXP (
    F_ID VARCHAR(15), F_Code VARCHAR(10),
    AS_ID VARCHAR(15), AS_Code VARCHAR(15),
    PRIMARY KEY (F_ID, F_Code, AS_ID, AS_Code),
    FOREIGN KEY (F_ID, F_Code) REFERENCES Fund(F_ID, F_Code),
    FOREIGN KEY (AS_ID, AS_Code) REFERENCES Asset(AS_ID, AS_Code)
);
CREATE TABLE S_BA_EXP (
    S_ID VARCHAR(15), S_Period VARCHAR(20),
    BA_ID VARCHAR(15), BA_RegistrationDate DATE,
    PRIMARY KEY (S_ID, S_Period, BA_ID, BA_RegistrationDate),
    FOREIGN KEY (S_ID, S_Period) REFERENCES Statement(S_ID, S_Period),
    FOREIGN KEY (BA_ID, BA_RegistrationDate) REFERENCES BankAccount(BA_ID, BA_RegistrationDate)
);
CREATE TABLE A_JAD_EXP (
    A_ID VARCHAR(15), A_ApplicationDate DATE,
    JAD_ID VARCHAR(15), JAD_PostingDate DATE,
    PRIMARY KEY (A_ID, A_ApplicationDate, JAD_ID, JAD_PostingDate),
    FOREIGN KEY (A_ID, A_ApplicationDate) REFERENCES Applicant(A_ID, A_ApplicationDate),
    FOREIGN KEY (JAD_ID, JAD_PostingDate) REFERENCES JobAdvertisment(JAD_ID, JAD_PostingDate)
);
CREATE TABLE JAPP_JAD_EXP (
    JAPP_ID VARCHAR(15), JAPP_SubmissionDate DATE,
    JAD_ID VARCHAR(15), JAD_PostingDate DATE,
    PRIMARY KEY (JAPP_ID, JAPP_SubmissionDate, JAD_ID, JAD_PostingDate),
    FOREIGN KEY (JAPP_ID, JAPP_SubmissionDate) REFERENCES JobApplication(JAPP_ID, JAPP_SubmissionDate),
    FOREIGN KEY (JAD_ID, JAD_PostingDate) REFERENCES JobAdvertisment(JAD_ID, JAD_PostingDate)
);
CREATE TABLE E_JAPP_EXP (
    E_ID VARCHAR(15), E_HireDate DATE,
    JAPP_ID VARCHAR(15), JAPP_SubmissionDate DATE,
    PRIMARY KEY (E_ID, E_HireDate, JAPP_ID, JAPP_SubmissionDate),
    FOREIGN KEY (E_ID, E_HireDate) REFERENCES Employee(E_ID, E_HireDate),
    FOREIGN KEY (JAPP_ID, JAPP_SubmissionDate) REFERENCES JobApplication(JAPP_ID, JAPP_SubmissionDate)
);
CREATE TABLE E_RF_EXP (
    E_ID VARCHAR(15), E_HireDate DATE,
    RF_ID VARCHAR(15), RF_SubmissionDate DATE,
    PRIMARY KEY (E_ID, E_HireDate, RF_ID, RF_SubmissionDate),
    FOREIGN KEY (E_ID, E_HireDate) REFERENCES Employee(E_ID, E_HireDate),
    FOREIGN KEY (RF_ID, RF_SubmissionDate) REFERENCES RegistrationForm(RF_ID, RF_SubmissionDate)
);
CREATE TABLE E_D_EXP (
    E_ID VARCHAR(15), E_HireDate DATE,
    D_ID VARCHAR(15), D_DeclarationDate DATE,
    PRIMARY KEY (E_ID, E_HireDate, D_ID, D_DeclarationDate),
    FOREIGN KEY (E_ID, E_HireDate) REFERENCES Employee(E_ID, E_HireDate),
    FOREIGN KEY (D_ID, D_DeclarationDate) REFERENCES Dividend(D_ID, D_DeclarationDate)
);
CREATE TABLE P_C_EXP (
    P_ID VARCHAR(15), P_DateOfBirth DATE,
    C_ID VARCHAR(15), C_Date DATE,
    PRIMARY KEY (P_ID, P_DateOfBirth, C_ID, C_Date),
    FOREIGN KEY (P_ID, P_DateOfBirth) REFERENCES Person(P_ID, P_DateOfBirth),
    FOREIGN KEY (C_ID, C_Date) REFERENCES Complaint(C_ID, C_Date)
);