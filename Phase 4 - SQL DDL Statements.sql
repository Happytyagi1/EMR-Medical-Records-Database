CREATE DATABASE IF NOT EXISTS EMR_DB;

-- Switch the active context to this database
USE EMR_DB;

CREATE TABLE Patients (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    PatientName VARCHAR(100) NOT NULL,
    Birthdate DATE NOT NULL,
    Phone VARCHAR(20)
);

CREATE TABLE Doctors (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    DoctorName VARCHAR(100) NOT NULL,
    Specialization VARCHAR(100) NOT NULL
);

CREATE TABLE Diagnoses (
    DiagnosisID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    Conditions VARCHAR(200) NOT NULL,
    DateDiagnosed DATE NOT NULL,
    Notes TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE Treatments (
    TreatmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    TreatmentDescription VARCHAR(300) NOT NULL,
    StartDate DATE NOT NULL,
    Status ENUM('Active', 'Completed', 'Cancelled') DEFAULT 'Active',
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE TreatmentDoctors (
    TreatmentID INT NOT NULL,
    DoctorID INT NOT NULL,
    PRIMARY KEY (TreatmentID, DoctorID),
    FOREIGN KEY (TreatmentID) REFERENCES Treatments(TreatmentID) ON DELETE CASCADE,
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

CREATE TABLE DiagnosesDoctors (
  DiagnosisID INT NOT NULL, 
  DoctorID INT NOT NULL,
  PRIMARY KEY (DiagnosisID, DoctorID), 
  FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
  FOREIGN KEY (DiagnosisID) REFERENCES Diagnoses(DiagnosisID) ON DELETE CASCADE
)