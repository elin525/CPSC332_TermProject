CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(20),
    office_location VARCHAR(100),
    chair_ssn CHAR(9)
);

CREATE TABLE Professor (
    ssn CHAR(9) PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(200),
    phone VARCHAR(20),
    sex CHAR(1),
    title VARCHAR(50),
    salary DECIMAL(10, 2),
    degree VARCHAR(50)
);

CREATE TABLE Course (
  course_number VARCHAR(10) PRIMARY KEY,
  title VARCHAR(100),
  textbook VARCHAR(100),
  units INT,
  dept_number INT
);

CREATE TABLE Section (
  course_number VARCHAR(10),
  section_number INT,
  classroom VARCHAR(20),
  seats INT,
  meeting_days VARCHAR(10),
  start_time TIME,
  end_time TIME,
  professor_ssn VARCHAR(11),
  PRIMARY KEY (course_number, section_number),
  FOREIGN KEY (course_number) REFERENCES Course(course_number),
  FOREIGN KEY (professor_ssn) REFERENCES Professor(ssn)
);

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    street_address VARCHAR(100),
    city VARCHAR(50),
    state CHAR(2),
    zip_code VARCHAR(5),
    phone_area_code CHAR(3),
    phone_number CHAR(7),
    major_dept_id INT,
    FOREIGN KEY (major_dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Prerequisite (
    course_number VARCHAR(10),
    prerequisite_number VARCHAR(10),
    PRIMARY KEY (course_number, prerequisite_number),
    FOREIGN KEY (course_number) REFERENCES Course(course_number),
    FOREIGN KEY (prerequisite_number) REFERENCES Course(course_number)
);

CREATE TABLE Enrollment (
    student_id INT,
    course_number VARCHAR(10),
    section_number INT,
    grade ENUM('A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D', 'D-', 'F'),
    PRIMARY KEY (student_id, course_number, section_number),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_number, section_number) REFERENCES Section(course_number, section_number)
);

CREATE TABLE Minor (
    student_id INT,
    dept_id INT,
    PRIMARY KEY (student_id, dept_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

/* Professor Info */
INSERT INTO Professor (ssn, name, address, phone, sex, title, salary, degree)
VALUES ('123456789', 'Dr. Jane Smith', '123 Main St, Springfield, IL', '(123) 456-7890', 'F', 'Professor', 95000.00, 'PhD in Computer Science');

INSERT INTO Professor (ssn, name, address, phone, sex, title, salary, degree) 
VALUES ('987654321', 'Dr. Alan Turing', '456 Oak St, Fullerton, CA', '(714) 234-5678', 'M', 'Associate Professor', 88000.00, 'PhD in Mathematics');

INSERT INTO Professor (ssn, name, address, phone, sex, title, salary, degree) 
VALUES ('111223333', 'Dr. Grace Hopper', '789 Pine St, Anaheim, CA', '(621) 345-6789', 'F', 'Professor', 92000.00, 'PhD in Computer Science');

/* Department Info */
INSERT INTO Department (dept_id, name, phone, office_location, chair_ssn)
VALUES (1, 'Computer Science', '(123) 456-7890', 'Building A, Room 201', '123456789');

INSERT INTO Department (dept_id, name, phone, office_location, chair_ssn) 
VALUES (2, 'Mathematics', '(123) 987-6543', 'Building B, Room 102', '987654321');

/* Course Info */
INSERT INTO Course (course_number, title, textbook, units, dept_number)
VALUES ('CS101', 'Introduction to Computer Science', 'Intro to CS Textbook', 3, 1);

INSERT INTO Course (course_number, title, textbook, units, dept_number)
VALUES ('CS131', 'Data Structures', 'Data Structures in C++', 3, 1);

INSERT INTO Course (course_number, title, textbook, units, dept_number)
VALUES ('CS332', 'Database and File Structure', 'Database System', 3, 1);

INSERT INTO Course (course_number, title, textbook, units, dept_number)
VALUES ('MATH160', 'Calculus I', 'Calculus Textbook', 3, 2);

INSERT INTO Course (course_number, title, textbook, units, dept_number)
VALUES ('MATH170', 'Linear Algebra', 'Linear Algebra Textbook', 3, 2);

/* Section Info */
INSERT INTO Section (course_number, section_number, classroom, seats, meeting_days, start_time, end_time, professor_ssn)
VALUES ('CS101', 1, 'Room 101', 30, 'MWF', '08:00:00', '09:00:00', '123456789');

INSERT INTO Section (course_number, section_number, classroom, seats, meeting_days, start_time, end_time, professor_ssn)
VALUES ('CS131', 2, 'Room 102', 39, 'TuThu', '09:00:00', '10:45:00', '987654321');

INSERT INTO Section (course_number, section_number, classroom, seats, meeting_days, start_time, end_time, professor_ssn)
VALUES ('CS332', 6, 'Room 103', 35, 'MW', '10:30:00', '11:30:00', '123456789');

INSERT INTO Section (course_number, section_number, classroom, seats, meeting_days, start_time, end_time, professor_ssn)
VALUES ('CS201', 3, 'Room 104', 27, 'TuThu', '13:00:00', '14:15:00', '987654321');

INSERT INTO Section (course_number, section_number, classroom, seats, meeting_days, start_time, end_time, professor_ssn)
VALUES ('MATH160', 7, 'Room 105', 46, 'F', '08:00:00', '10:00:00', '111223333');

INSERT INTO Section (course_number, section_number, classroom, seats, meeting_days, start_time, end_time, professor_ssn)
VALUES ('MATH170', 2, 'Room 106', 40, 'Sa', '10:30:00', '11:55:00', '111223333');

/* Prerequisite Info */
INSERT INTO Prerequisite (course_number, prerequisite_number) VALUES ('CS332', 'CS131');
INSERT INTO Prerequisite (course_number, prerequisite_number) VALUES ('Math170', 'Math160');

/* Student Info */
INSERT INTO Student (student_id, first_name, last_name, street_address, city, state, zip_code, phone_area_code, phone_number, major_dept_id)
VALUES (884926548, 'Alice', 'Deng', '123 Maple St', 'Fullerton', 'CA', '92831', '714', '1234567', 1);

INSERT INTO Student (student_id, first_name, last_name, street_address, city, state, zip_code, phone_area_code, phone_number, major_dept_id)
VALUES (884926776, 'Brian', 'Kim', '456 Oak St', 'Anaheim', 'CA', '92805', '714', '2345678', 1);

INSERT INTO Student (student_id, first_name, last_name, street_address, city, state, zip_code, phone_area_code, phone_number, major_dept_id)
VALUES (886726533, 'Cathy', 'Lee', '789 Pine St', 'Brea', 'CA', '92821', '657', '3456789', 2);

INSERT INTO Student (student_id, first_name, last_name, street_address, city, state, zip_code, phone_area_code, phone_number, major_dept_id)
VALUES (884917512, 'David', 'Nguyen', '321 Punte St', 'West Covina', 'CA', '91722', '949', '4567890', 1);

INSERT INTO Student (student_id, first_name, last_name, street_address, city, state, zip_code, phone_area_code, phone_number, major_dept_id)
VALUES (883589011, 'Emma', 'Garcia', '1064 Birch St', 'Tustin', 'CA', '92780', '714', '5678901', 2);

INSERT INTO Student (student_id, first_name, last_name, street_address, city, state, zip_code, phone_area_code, phone_number, major_dept_id)
VALUES (887465014, 'Frank', 'Lopez', '1850 Colima Rd', 'Rowland Heights', 'CA', '91748', '657', '6789012', 2);

INSERT INTO Student (student_id, first_name, last_name, street_address, city, state, zip_code, phone_area_code, phone_number, major_dept_id)
VALUES (884936481, 'Sherry', 'Smith', '246 Elm St', 'La Habra', 'CA', '90631', '562', '7890123', 1);

INSERT INTO Student (student_id, first_name, last_name, street_address, city, state, zip_code, phone_area_code, phone_number, major_dept_id)
VALUES (886540129, 'Hannah', 'Chen', '135 Palm St', 'Garden Grove', 'CA', '92840', '714', '8901234', 1);

/* Enrollment Info */
INSERT INTO Enrollment (student_id, course_number, section_number, grade)
VALUES (884926548, 'CS131', 2, 'B');

INSERT INTO Enrollment (student_id, course_number, section_number, grade)
VALUES (887465014, 'MATH170', 2, 'B');

INSERT INTO Enrollment (student_id, course_number, section_number, grade)
VALUES (886540129, 'MATH160', 7, 'F');

INSERT INTO Enrollment (student_id, course_number, section_number, grade)
VALUES (884917512, 'MATH170', 2, 'D');

INSERT INTO Enrollment (student_id, course_number, section_number, grade)
VALUES (886540129, 'CS101', 1, 'A-');

INSERT INTO Enrollment (student_id, course_number, section_number, grade)
VALUES (883589011, 'CS131', 2, 'F');

INSERT INTO Enrollment (student_id, course_number, section_number, grade)
VALUES (884926548, 'CS201', 3, 'A');

INSERT INTO Enrollment (student_id, course_number, section_number, grade)
VALUES (884936481, 'MATH170', 2, 'B-');

INSERT INTO Enrollment (student_id, course_number, section_number, grade)
VALUES (886726533, 'CS131', 2, 'A-');

INSERT INTO Enrollment (student_id, course_number, section_number, grade)
VALUES (883589011, 'CS131', 2, 'F');

INSERT INTO Enrollment (student_id, course_number, section_number, grade)
VALUES (884926776, 'CS101', 1, 'B+');

INSERT INTO Enrollment (student_id, course_number, section_number, grade)
VALUES (884926548, 'MATH170', 2, 'B');

INSERT INTO Enrollment (student_id, course_number, section_number, grade)
VALUES (887465014, 'MATH160', 7, 'F');

INSERT INTO Enrollment (student_id, course_number, section_number, grade)
VALUES (883589011, 'CS201', 3, 'A-');

INSERT INTO Enrollment (student_id, course_number, section_number, grade)
VALUES (884926548, 'CS101', 1, 'A');

INSERT INTO Enrollment (student_id, course_number, section_number, grade)
VALUES (884917512, 'CS131', 2, 'B+');

INSERT INTO Enrollment (student_id, course_number, section_number, grade)
VALUES (884936481, 'MATH160', 7, 'A-');

INSERT INTO Enrollment (student_id, course_number, section_number, grade)
VALUES (884926548, 'CS101', 1, 'A');

INSERT INTO Enrollment (student_id, course_number, section_number, grade)
VALUES (887465014, 'CS131', 2, 'C+');

INSERT INTO Enrollment (student_id, course_number, section_number, grade)
VALUES (886726533, 'MATH160', 7, 'A-');

/* Minor Info */
INSERT INTO Minor (student_id, dept_id) VALUES (884926548, 2);

INSERT INTO Minor (student_id, dept_id) VALUES (884917512, 1);

INSERT INTO Minor (student_id, dept_id) VALUES (884936481, 2);


