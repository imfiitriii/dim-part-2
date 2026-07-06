-- 1. Branch
CREATE TABLE Branch (
    B_ID VARCHAR(15),
    B_BranchCode VARCHAR(10),
    B_Name VARCHAR(100) NOT NULL,
    B_Address VARCHAR(255) NOT NULL,
    B_City VARCHAR(50) NOT NULL,
    B_State VARCHAR(50) NOT NULL,
    B_Postcode VARCHAR(10) NOT NULL,
    B_PhoneNumber VARCHAR(20) NOT NULL,
    B_Email VARCHAR(100) UNIQUE NOT NULL,
    B_OperatingHours VARCHAR(50) NOT NULL,
    PRIMARY KEY (B_ID, B_BranchCode)
);

-- 2. Person
CREATE TABLE Person (
    P_ID VARCHAR(15),
    P_DateOfBirth DATE,
    P_FullName VARCHAR(150) NOT NULL,
    P_ICNumber VARCHAR(14) UNIQUE NOT NULL,
    P_Address VARCHAR(255) NOT NULL,
    P_Gender CHAR(1) NOT NULL CHECK (P_Gender IN ('M', 'F')),
    P_Nationality VARCHAR(50) NOT NULL,
    P_PhoneNumber VARCHAR(20) NOT NULL,
    P_Email VARCHAR(100) UNIQUE NOT NULL,
    P_MaritalStatus VARCHAR(15) NOT NULL,
    PRIMARY KEY (P_ID, P_DateOfBirth)
);

-- 3. Employee (Requires Branch and Person)
CREATE TABLE Employee (
    E_ID VARCHAR(15),
    E_HireDate DATE,
    E_Number VARCHAR(15) UNIQUE NOT NULL,
    E_Department VARCHAR(50) NOT NULL,
    E_Position VARCHAR(50) NOT NULL,
    E_Type VARCHAR(50) NOT NULL,
    E_SalaryGrade VARCHAR(10) NOT NULL,
    E_WorkEmail VARCHAR(100) UNIQUE NOT NULL,
    E_WorkPhone VARCHAR(20) NOT NULL,
    E_ShiftSchedule VARCHAR(30) NOT NULL,
    P_ID VARCHAR(15) NOT NULL,
    P_DateOfBirth DATE NOT NULL,
    B_ID VARCHAR(15) NOT NULL,
    B_BranchCode VARCHAR(10) NOT NULL,
    PRIMARY KEY (E_ID, E_HireDate),
    FOREIGN KEY (P_ID, P_DateOfBirth) REFERENCES Person(P_ID, P_DateOfBirth),
    FOREIGN KEY (B_ID, B_BranchCode) REFERENCES Branch(B_ID, B_BranchCode)
);

-- 4. Applicant
CREATE TABLE Applicant (
    A_ID VARCHAR(15),
    A_ApplicationDate DATE,
    A_HighestEducation VARCHAR(50) NOT NULL,
    A_YearsExperience INT NOT NULL CHECK (A_YearsExperience >= 0),
    A_CurrentEmployer VARCHAR(100) NOT NULL,
    A_ExpectedSalary VARCHAR(255) NOT NULL,
    A_ResumeFile VARCHAR(255) NOT NULL,
    A_PortfolioLink VARCHAR(255) NOT NULL,
    A_ApplicationStatus VARCHAR(20) NOT NULL,
    A_AvailabilityDate DATE NOT NULL,
    P_ID VARCHAR(15) NOT NULL,
    P_DateOfBirth DATE NOT NULL,
    PRIMARY KEY (A_ID, A_ApplicationDate),
    FOREIGN KEY (P_ID, P_DateOfBirth) REFERENCES Person(P_ID, P_DateOfBirth)
);

-- 5. Fund
CREATE TABLE Fund (
    F_ID VARCHAR(15),
    F_Code VARCHAR(10),
    F_Name VARCHAR(100) NOT NULL,
    F_Type VARCHAR(30) NOT NULL,
    F_RiskLevel VARCHAR(15) NOT NULL,
    F_LaunchDate DATE NOT NULL,
    F_Size DECIMAL(15,2) NOT NULL,
    F_Objective TEXT NOT NULL,
    F_DividendFrequency VARCHAR(20) NOT NULL,
    F_ManagementFee DECIMAL(4,2) NOT NULL,
    PRIMARY KEY (F_ID, F_Code)
);

-- 6. Investor
CREATE TABLE Investor (
    I_ID VARCHAR(15),
    I_RegistrationDate DATE,
    I_Category VARCHAR(30) NOT NULL,
    I_RiskProfile VARCHAR(30) NOT NULL,
    I_AnnualIncome VARCHAR(20) NOT NULL,
    I_OccupationSector VARCHAR(20) NOT NULL,
    I_TaxResidency VARCHAR(50) NOT NULL,
    I_Goal VARCHAR(100) NOT NULL,
    I_Experience VARCHAR(50) NOT NULL,
    I_PreferredLanguage VARCHAR(20) NOT NULL,
    P_ID VARCHAR(15) NOT NULL,
    P_DateOfBirth DATE NOT NULL,
    PRIMARY KEY (I_ID, I_RegistrationDate),
    FOREIGN KEY (P_ID, P_DateOfBirth) REFERENCES Person(P_ID, P_DateOfBirth)
);

-- 7. RegistrationForm
CREATE TABLE RegistrationForm (
    RF_ID VARCHAR(15),
    RF_SubmissionDate DATE,
    RF_FormType VARCHAR(30) NOT NULL,
    RF_VerificationStatus VARCHAR(30) NOT NULL,
    RF_SupportingDocumentType VARCHAR(50) NOT NULL,
    RF_ApprovalDate DATE NOT NULL,
    RF_VerificationDate DATE NOT NULL,
    RF_ApprovalStatus VARCHAR(15) NOT NULL,
    RF_SubmissionChannel VARCHAR(20) NOT NULL,
    RF_KYCStatus VARCHAR(15) NOT NULL,
    I_ID VARCHAR(15) NOT NULL,
    I_RegistrationDate DATE NOT NULL,
    PRIMARY KEY (RF_ID, RF_SubmissionDate),
    FOREIGN KEY (I_ID, I_RegistrationDate) REFERENCES Investor(I_ID, I_RegistrationDate)
);

-- 8. InvestorAccount
CREATE TABLE InvestorAccount (
    IA_ID VARCHAR(15),
    IA_AccountOpenDate DATE,
    IA_AccountNumber VARCHAR(30) UNIQUE NOT NULL,
    IA_AccountType VARCHAR(20) NOT NULL,
    IA_RiskCategory VARCHAR(20) NOT NULL,
    IA_TotalInvestment DECIMAL(15,4) NOT NULL,
    IA_TotalDividend DECIMAL(15,4) NOT NULL,
    IA_AccountBalance DECIMAL(15,4) NOT NULL,
    IA_AccountStatus VARCHAR(20) NOT NULL,
    IA_PreferredStatementMethod VARCHAR(20),
    I_ID VARCHAR(15) NOT NULL,
    I_RegistrationDate DATE NOT NULL,
    RF_ID VARCHAR(15) NOT NULL,
    RF_SubmissionDate DATE NOT NULL,
    PRIMARY KEY (IA_ID, IA_AccountOpenDate),
    FOREIGN KEY (I_ID, I_RegistrationDate) REFERENCES Investor(I_ID, I_RegistrationDate),
    FOREIGN KEY (RF_ID, RF_SubmissionDate) REFERENCES RegistrationForm(RF_ID, RF_SubmissionDate)
);

-- 9. OnlineAccount
CREATE TABLE OnlineAccount (
    OA_ID VARCHAR(15),
    OA_RegistrationDate DATE,
    OA_Username VARCHAR(50) UNIQUE NOT NULL,
    OA_PasswordHash VARCHAR(255) NOT NULL,
    OA_SecurityQuestion VARCHAR(255) NOT NULL,
    OA_SecurityAnswer VARCHAR(255) NOT NULL,
    OA_LastLogin CHAR(1) NOT NULL,
    OA_FailedLoginAttempts INT NOT NULL DEFAULT 0,
    OA_MFAStatus VARCHAR(15) NOT NULL,
    OA_AccountStatus VARCHAR(15) NOT NULL,
    I_ID VARCHAR(15) NOT NULL,
    I_RegistrationDate DATE NOT NULL,
    IA_ID VARCHAR(15) NOT NULL,
    IA_AccountOpenDate DATE NOT NULL,
    RF_ID VARCHAR(15) NOT NULL,
    RF_SubmissionDate DATE NOT NULL,
    PRIMARY KEY (OA_ID, OA_RegistrationDate),
    FOREIGN KEY (I_ID, I_RegistrationDate) REFERENCES Investor(I_ID, I_RegistrationDate),
    FOREIGN KEY (IA_ID, IA_AccountOpenDate) REFERENCES InvestorAccount(IA_ID, IA_AccountOpenDate),
    FOREIGN KEY (RF_ID, RF_SubmissionDate) REFERENCES RegistrationForm(RF_ID, RF_SubmissionDate)
);

-- 10. Statement
CREATE TABLE Statement (
    S_ID VARCHAR(15),
    S_Period VARCHAR(20),
    S_GeneratedDate DATE NOT NULL,
    S_Type VARCHAR(20) NOT NULL,
    S_OpeningBalance DECIMAL(15,4) NOT NULL,
    S_ClosingBalance DECIMAL(15,4) NOT NULL,
    S_TotalInvesment DECIMAL(15,4) NOT NULL,
    S_TotalRedemption DECIMAL(15,4) NOT NULL,
    S_TotalDividend DECIMAL(15,4) NOT NULL,
    S_DeliveryMethod VARCHAR(15) NOT NULL,
    I_ID VARCHAR(15) NOT NULL,
    I_RegistrationDate DATE NOT NULL,
    IA_ID VARCHAR(15) NOT NULL,
    IA_AccountOpenDate DATE NOT NULL,
    OA_ID VARCHAR(15) NOT NULL,
    OA_RegistrationDate DATE NOT NULL,
    PRIMARY KEY (S_ID, S_Period),
    FOREIGN KEY (I_ID, I_RegistrationDate) REFERENCES Investor(I_ID, I_RegistrationDate),
    FOREIGN KEY (IA_ID, IA_AccountOpenDate) REFERENCES InvestorAccount(IA_ID, IA_AccountOpenDate),
    FOREIGN KEY (OA_ID, OA_RegistrationDate) REFERENCES OnlineAccount(OA_ID, OA_RegistrationDate)
);

-- 11. FundHolding
CREATE TABLE FundHolding (
    FH_ID VARCHAR(15),
    FH_DateCreated DATE,
    FH_UnitsOwned DECIMAL(15,4) NOT NULL,
    FH_AverageCost DECIMAL(10,4) NOT NULL,
    FH_CurrentValue DECIMAL(15,4) NOT NULL,
    FH_TotalDividendEarned DECIMAL(15,4) NOT NULL,
    FH_HoldingStatus VARCHAR(15) NOT NULL,
    FH_LastUpdatedDate DATE NOT NULL,
    FH_UnrealizedGain DECIMAL(15,4) NOT NULL,
    FH_RealizedGain DECIMAL(15,4) NOT NULL,
    I_ID VARCHAR(15) NOT NULL,
    I_RegistrationDate DATE NOT NULL,
    IA_ID VARCHAR(15) NOT NULL,
    IA_AccountOpenDate DATE NOT NULL,
    F_ID VARCHAR(15) NOT NULL,
    F_Code VARCHAR(10) NOT NULL,
    PRIMARY KEY (FH_ID, FH_DateCreated),
    FOREIGN KEY (I_ID, I_RegistrationDate) REFERENCES Investor(I_ID, I_RegistrationDate),
    FOREIGN KEY (IA_ID, IA_AccountOpenDate) REFERENCES InvestorAccount(IA_ID, IA_AccountOpenDate),
    FOREIGN KEY (F_ID, F_Code) REFERENCES Fund(F_ID, F_Code)
);

-- 12. Transaction
CREATE TABLE Transaction (
    T_ID VARCHAR(15),
    T_Date DATE,
    T_Amount DECIMAL(15,4) NOT NULL,
    T_ReferenceNumber VARCHAR(30) UNIQUE NOT NULL,
    T_Title VARCHAR(100) NOT NULL,
    T_Time TIME NOT NULL,
    T_ApprovalStatus VARCHAR(15) NOT NULL,
    T_Currency CHAR(3) NOT NULL,
    T_Remarks VARCHAR(255) NOT NULL,
    T_PaymentMethod VARCHAR(30) NOT NULL,
    I_ID VARCHAR(15) NOT NULL,
    I_RegistrationDate DATE NOT NULL,
    FH_ID VARCHAR(15) NOT NULL,
    FH_DateCreated DATE NOT NULL,
    E_ID VARCHAR(15) NOT NULL,
    E_HireDate DATE NOT NULL,
    F_ID VARCHAR(15) NOT NULL,
    F_Code VARCHAR(10) NOT NULL,
    IA_ID VARCHAR(15) NOT NULL,
    IA_AccountOpenDate DATE NOT NULL,
    OA_ID VARCHAR(15) NOT NULL,
    OA_RegistrationDate DATE NOT NULL,
    PRIMARY KEY (T_ID, T_Date),
    FOREIGN KEY (I_ID, I_RegistrationDate) REFERENCES Investor(I_ID, I_RegistrationDate),
    FOREIGN KEY (FH_ID, FH_DateCreated) REFERENCES FundHolding(FH_ID, FH_DateCreated),
    FOREIGN KEY (E_ID, E_HireDate) REFERENCES Employee(E_ID, E_HireDate),
    FOREIGN KEY (F_ID, F_Code) REFERENCES Fund(F_ID, F_Code),
    FOREIGN KEY (IA_ID, IA_AccountOpenDate) REFERENCES InvestorAccount(IA_ID, IA_AccountOpenDate),
    FOREIGN KEY (OA_ID, OA_RegistrationDate) REFERENCES OnlineAccount(OA_ID, OA_RegistrationDate)
);

-- 13. PurchaseTransaction
CREATE TABLE PurchaseTransaction (
    PT_PurchaseID VARCHAR(15),
    PT_PurchaseDate DATE,
    PT_UnitsPurchased DECIMAL(15,4) NOT NULL,
    PT_UnitPrice DECIMAL(10,4) NOT NULL,
    PT_UnitPriceDate DATE NOT NULL,
    PT_PurchaseAmount DECIMAL(15,4) NOT NULL,
    PT_PurchaseMethod VARCHAR(20) NOT NULL,
    PT_PurchaseType VARCHAR(15) NOT NULL,
    PT_SalesCharge DECIMAL(10,4) NOT NULL,
    PT_AllocationDate DATE NOT NULL,
    T_ID VARCHAR(15) NOT NULL,
    T_Date DATE NOT NULL,
    PRIMARY KEY (PT_PurchaseID, PT_PurchaseDate),
    FOREIGN KEY (T_ID, T_Date) REFERENCES Transaction(T_ID, T_Date)
);

-- 14. RedemptionTransaction
CREATE TABLE RedemptionTransaction (
    RT_RedemptionID VARCHAR(15),
    RT_RedemptionDate DATE,
    RT_UnitsRedeemed DECIMAL(15,4) NOT NULL,
    RT_RedemptionPrice DECIMAL(10,4) NOT NULL,
    RT_RedemptionAmount DECIMAL(10,4) NOT NULL,
    RT_RedemptionReason VARCHAR(100) NOT NULL,
    RT_EarlyRedemptionFlag CHAR(1) NOT NULL CHECK (RT_EarlyRedemptionFlag IN ('Y', 'N')),
    RT_ExitFee DECIMAL(10,4) NOT NULL,
    RT_SettlementDate DATE NOT NULL,
    RT_RemainingUnits DECIMAL(10,4) NOT NULL,
    T_ID VARCHAR(15) NOT NULL,
    T_Date DATE NOT NULL,
    PRIMARY KEY (RT_RedemptionID, RT_RedemptionDate),
    FOREIGN KEY (T_ID, T_Date) REFERENCES Transaction(T_ID, T_Date)
);

-- 15. SwitchTransaction
CREATE TABLE SwitchTransaction (
    ST_SwitchID VARCHAR(15),
    ST_SwitchDate DATE,
    ST_SourceFundName VARCHAR(100) NOT NULL,
    ST_DestinationFundName VARCHAR(100) NOT NULL,
    ST_UnitsSwitched DECIMAL(15,4) NOT NULL,
    ST_SwitchFee DECIMAL(10,4) NOT NULL,
    ST_SourceFundPrice DECIMAL(10,4) NOT NULL,
    ST_DestinationFundPrice DECIMAL(10,4) NOT NULL,
    ST_ConversionRatio DECIMAL(6,4) NOT NULL,
    ST_SwitchReason VARCHAR(20) NOT NULL,
    T_ID VARCHAR(15) NOT NULL,
    T_Date DATE NOT NULL,
    PRIMARY KEY (ST_SwitchID, ST_SwitchDate),
    FOREIGN KEY (T_ID, T_Date) REFERENCES Transaction(T_ID, T_Date)
);

-- 16. Receipt
CREATE TABLE Receipt (
    R_ID VARCHAR(15),
    R_IssueDate DATE,
    R_Number VARCHAR(20) UNIQUE NOT NULL,
    R_Type VARCHAR(20) NOT NULL,
    R_Amount DECIMAL(15,4) NOT NULL,
    R_IssueTime TIME NOT NULL,
    R_Remarks VARCHAR(255) NOT NULL,
    R_Status VARCHAR(20) NOT NULL,
    R_TaxAmount DECIMAL(15,4) NOT NULL,
    R_Currency VARCHAR(15) NOT NULL,
    E_ID VARCHAR(15) NOT NULL,
    E_HireDate DATE NOT NULL,
    I_ID VARCHAR(15) NOT NULL,
    I_RegistrationDate DATE NOT NULL,
    T_ID VARCHAR(15) NOT NULL,
    T_Date DATE NOT NULL,
    FH_ID VARCHAR(15) NOT NULL,
    FH_DateCreated DATE NOT NULL,
    PRIMARY KEY (R_ID, R_IssueDate),
    FOREIGN KEY (E_ID, E_HireDate) REFERENCES Employee(E_ID, E_HireDate),
    FOREIGN KEY (I_ID, I_RegistrationDate) REFERENCES Investor(I_ID, I_RegistrationDate),
    FOREIGN KEY (T_ID, T_Date) REFERENCES Transaction(T_ID, T_Date),
    FOREIGN KEY (FH_ID, FH_DateCreated) REFERENCES FundHolding(FH_ID, FH_DateCreated)
);

-- 17. JobAdvertisement
CREATE TABLE JobAdvertisement (
    JAD_ID VARCHAR(15),
    JAD_PostingDate DATE,
    JAD_JobTitle VARCHAR(50) NOT NULL,
    JAD_Department VARCHAR(50) NOT NULL,
    JAD_EmploymentType VARCHAR(20) NOT NULL,
    JAD_SalaryType VARCHAR(15) NOT NULL,
    JAD_Location VARCHAR(50) NOT NULL,
    JAD_QualificationRequired TEXT NOT NULL,
    JAD_ExperienceRequired VARCHAR(50) NOT NULL,
    JAD_ClosingDate DATE NOT NULL,
    PRIMARY KEY (JAD_ID, JAD_PostingDate)
);

-- 18. JobDescription
CREATE TABLE JobDescription (
    JD_ID VARCHAR(15),
    JD_CreationDate DATE,
    JD_PositionTitle VARCHAR(50) NOT NULL,
    JD_Department VARCHAR(20) NOT NULL,
    JD_JobLevel VARCHAR(20) NOT NULL,
    JD_EmploymentType VARCHAR(20) NOT NULL,
    JD_Responsibilities VARCHAR(100) NOT NULL,
    JD_Qualifications VARCHAR(100) NOT NULL,
    JD_SkillsRequired VARCHAR(100) NOT NULL,
    JD_WorkingHours VARCHAR(30) NOT NULL,
    PRIMARY KEY (JD_ID, JD_CreationDate)
);

-- 19. JobApplication
CREATE TABLE JobApplication (
    JAPP_ID VARCHAR(15),
    JAPP_SubmissionDate DATE,
    JAPP_Status VARCHAR(20) NOT NULL,
    JAPP_ScreeningScore INT NOT NULL,
    JAPP_InterviewDate DATETIME NOT NULL,
    JAPP_InterviewResult VARCHAR(30) NOT NULL,
    JAPP_OfferStatus VARCHAR(20) NOT NULL,
    JAPP_ExpectedSalary DECIMAL(10,2) NOT NULL,
    JAPP_AvailabilityDate DATE NOT NULL,
    JAPP_ApplicationSource VARCHAR(50) NOT NULL,
    A_ID VARCHAR(15) NOT NULL,
    A_ApplicationDate DATE NOT NULL,
    PRIMARY KEY (JAPP_ID, JAPP_SubmissionDate),
    FOREIGN KEY (A_ID, A_ApplicationDate) REFERENCES Applicant(A_ID, A_ApplicationDate)
);

-- 20. Complaint (Explosion table logic incorporated)
CREATE TABLE Complaint (
    C_ID VARCHAR(15),
    C_Date DATE,
    C_Type VARCHAR(30) NOT NULL,
    C_Description TEXT NOT NULL,
    C_PriorityLevel VARCHAR(10) NOT NULL,
    C_SubmissionChannel VARCHAR(20) NOT NULL,
    C_Status VARCHAR(15) NOT NULL,
    C_AssignedOfficer VARCHAR(15) NOT NULL,
    C_Resolution TEXT NOT NULL,
    C_ResolutionDate DATE NOT NULL,
    P_ID VARCHAR(15) NOT NULL,
    P_DateOfBirth DATE NOT NULL,
    RF_ID VARCHAR(15) NOT NULL,
    RF_SubmissionDate DATE NOT NULL,
    FH_ID VARCHAR(15) NOT NULL,
    FH_DateCreated DATE NOT NULL,
    F_ID VARCHAR(15) NOT NULL,
    F_Code VARCHAR(10) NOT NULL,
    DD_ID VARCHAR(15) NOT NULL,
    DD_DistributionDate DATE NOT NULL,
    B_ID VARCHAR(15) NOT NULL,
    B_BranchCode VARCHAR(10) NOT NULL,
    R_ID VARCHAR(15) NOT NULL,
    R_IssueDate DATE NOT NULL,
    D_ID VARCHAR(15) NOT NULL,
    D_DeclarationDate DATE NOT NULL,
    IP_ID VARCHAR(15) NOT NULL,
    IP_CreationDate DATE NOT NULL,
    AS_ID VARCHAR(15) NOT NULL,
    AS_Code VARCHAR(15) NOT NULL,
    JAPP_ID VARCHAR(15) NOT NULL,
    JAPP_SubmissionDate DATE NOT NULL,
    JAD_ID VARCHAR(15) NOT NULL,
    JAD_PostingDate DATE NOT NULL,
    JD_ID VARCHAR(15) NOT NULL,
    JD_CreationDate DATE NOT NULL,
    T_ID VARCHAR(15) NOT NULL,
    T_Date DATE NOT NULL,
    S_ID VARCHAR(15) NOT NULL,
    S_Period VARCHAR(20) NOT NULL,
    IA_ID VARCHAR(15) NOT NULL,
    IA_AccountOpenDate DATE NOT NULL,
    OA_ID VARCHAR(15) NOT NULL,
    OA_RegistrationDate DATE NOT NULL,
    PRIMARY KEY (C_ID, C_Date),
    FOREIGN KEY (C_AssignedOfficer, C_Date) REFERENCES Employee(E_ID, E_HireDate), -- Example Mapping
    FOREIGN KEY (P_ID, P_DateOfBirth) REFERENCES Person(P_ID, P_DateOfBirth),
    FOREIGN KEY (RF_ID, RF_SubmissionDate) REFERENCES RegistrationForm(RF_ID, RF_SubmissionDate),
    FOREIGN KEY (FH_ID, FH_DateCreated) REFERENCES FundHolding(FH_ID, FH_DateCreated),
    FOREIGN KEY (F_ID, F_Code) REFERENCES Fund(F_ID, F_Code),
    FOREIGN KEY (B_ID, B_BranchCode) REFERENCES Branch(B_ID, B_BranchCode),
    FOREIGN KEY (R_ID, R_IssueDate) REFERENCES Receipt(R_ID, R_IssueDate),
    FOREIGN KEY (T_ID, T_Date) REFERENCES Transaction(T_ID, T_Date),
    FOREIGN KEY (IA_ID, IA_AccountOpenDate) REFERENCES InvestorAccount(IA_ID, IA_AccountOpenDate),
    FOREIGN KEY (OA_ID, OA_RegistrationDate) REFERENCES OnlineAccount(OA_ID, OA_RegistrationDate)
);