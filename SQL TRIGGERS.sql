CREATE TABLE employees1(  
    name varchar(45) NOT NULL,    
    occupation varchar(35) NOT NULL,    
    working_date date,  
    working_hours varchar(10)  
);  

describe employees1;
INSERT INTO employees1 VALUES    
('Robin', 'Scientist', '2020-10-04', 12),  
('Warner', 'Engineer', '2020-10-04', 10),  
('Peter', 'Actor', '2020-10-04', 13),  
('Marco', 'Doctor', '2020-10-04', 14),  
('Brayden', 'Teacher', '2020-10-04', 12),  
('Antonio', 'Business', '2020-10-04', 11);  

select * from employees1;

delimiter //
create trigger before_insert_empworkinghours1
BEFORE INSERT ON employees1 for each row
begin
if new.working_hours < 0 then set new.working_hours = 0;
END IF;
END  //

INSERT INTO employees1 VALUES    
('SARA', 'TAYLOR', '2020-10-04', 16);

INSERT INTO employees1 VALUES    
('JUNE', 'WORK', '2020-10-04', -19);

SELECT * FROM EMPLOYEES1;

DELIMITER //
CREATE TRIGGER BEFORE_INSERT_EMPWORKINGHOURS1
BEFORE INSERT ON EMPLOYEES1 FOR EACH ROW
BEGIN
IF NEW.WORKING_HOURS > 16 THEN SET NEW.WORKING_HOURS = 0;
END IF;
END //

INSERT INTO employees1 VALUES    
('MEERA', 'DESIGNER', '2020-10-04', 19);

SELECT * FROM EMPLOYEES1;




DELIMiTER //
CREATE TRIGGER BEFORE_INSERT_empoccupation2
BEFORE INSERT ON employees1 FOR EACH ROW
BEGIN
IF NEW.occupation = 'Scientist' THEN SET NEW.occupation = 'teacher';
END IF;
END //

INSERT INTO employees1 VALUES    
('JOHN', 'SCIENTIST', '2020-10-04', 19);

SELECT * FROM EMPLOYEES1;

CREATE TABLE student_info (  
  stud_id int NOT NULL,  
  stud_code varchar(15) DEFAULT NULL,  
  stud_name varchar(35) DEFAULT NULL,  
  subject varchar(25) DEFAULT NULL,  
  marks int DEFAULT NULL,  
  phone varchar(15) DEFAULT NULL,  
  PRIMARY KEY (stud_id)  
)  

INSERT INTO student_info VALUES   
(1, 101, 'Alexandar', 'Biology', 67, '2347346438'); 
INSERT INTO student_info VALUES   
(2, 102, 'john', 'history', 68, '2347346437'),
(3, 103, 'meera', 'english', 70, '2347346495'),
INSERT INTO student_info VALUES
(4, 104, 'jasmine', 'maths', 75, '2347346685'),
(5, 105, 'siri', 'hindi', 71, '2347346945'),
(6, 106, 'dolly', 'telugu', 77, '23473464965'),
(7, 107, 'tom', 'social', 86, '2347346495'),
(8, 108, 'mary', 'drawing', 89, '2347341596'),
(9, 109, 'meera', 'painting', 85, '2347346425'),
(10, 110, 'cera', 'geography', 69, '2347346269');

select * from student_info;

CREATE TABLE student_detail1 (  
  stud_id int NOT NULL auto_increment,  
  stud_code varchar(15) DEFAULT NULL,  
  stud_name varchar(35) DEFAULT NULL,  
  subject varchar(25) DEFAULT NULL,  
  marks int DEFAULT NULL,  
  phone varchar(15) DEFAULT NULL,  
  Lastinserted Time,  
  PRIMARY KEY (stud_id)  
);  


delimiter //
create trigger after_insert_detail123
after insert on student_info for each row
begin
insert into student_detail1 values(new.stud_id,
                                new.stud_code,
                                new.stud_name,
                                new.subject,
                                new.marks,
                                new.phone,
                                curtime());
   end //
   
 INSERT INTO student_info VALUES   
(11,120,'lexi','civics',82,'9652405775');

select * from student_detail1;


CREATE TABLE members1 (
    id INT AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255),
    birthDate DATE,
    PRIMARY KEY (id)
);

CREATE TABLE reminders (
    id INT AUTO_INCREMENT,
    memberId INT,
    message VARCHAR(255) NOT NULL,
    PRIMARY KEY (id , memberId)
);

DELIMITER $$

CREATE TRIGGER after_members_insert
AFTER INSERT
ON members1 FOR EACH ROW
BEGIN
    IF NEW.birthDate IS NULL THEN
        INSERT INTO reminders (memberId, message)VALUES(new.id,CONCAT('Hi ', NEW.name, ', please update your date of birth.'));
    END IF;
END$$

INSERT INTO members1(name, email, birthDate)
VALUES
    ('John Doe', 'john.doe@example.com', NULL),
    ('Jane Doe', 'jane.doe@example.com','2000-01-01');


select * from members1;

select * from reminders;

CREATE TABLE sales_info (  
    id INT AUTO_INCREMENT,  
    product VARCHAR(100) NOT NULL,  
    quantity INT NOT NULL DEFAULT 0,  
    fiscalYear SMALLINT NOT NULL,  
    CHECK(fiscalYear BETWEEN 2000 and 2050),  
    CHECK (quantity >=0),  
    UNIQUE(product, fiscalYear),  
    PRIMARY KEY(id)  
);  

INSERT INTO sales_info(product, quantity, fiscalYear)  
VALUES  
    ('2003 Maruti Suzuki',110, 2020),  
    ('2015 Avenger', 120,2020),  
    ('2018 Honda Shine', 150,2020),  
    ('2014 Apache', 150,2020);  


select * from sales_info;

DELIMITER $$  
  
CREATE TRIGGER before_update_salesInfo  
BEFORE UPDATE  
ON sales_info FOR EACH ROW  
BEGIN  
    DECLARE error_msg VARCHAR(255);  
    SET error_msg = ('The new quantity cannot be greater than 2 times the current quantity');  
    IF new.quantity > old.quantity * 2 THEN  
    SIGNAL SQLSTATE '45000'   
    SET MESSAGE_TEXT = error_msg;  
    END IF;  
END $$  
  
DELIMITER ;  

 UPDATE sales_info SET quantity = 125 WHERE id = 2;   

 UPDATE sales_info SET quantity = 600 WHERE id = 2; 
 
 
delimiter $$
create trigger before_update_salesinfo2
before update on sales_info for each row
begin
declare error_msg varchar(65);
set error_msg = ('fiscalyear greaterthan old fiscal year');
if new.fiscalyear > 2020 then
SET NEW.FISCALYEAR = ERROR_MSG;
end if;
end $$

 UPDATE sales_info SET fiscalyear = 2020 WHERE id = 2; 

SELECT * FROM SALES_INFO;

create table customer (acc_no integer primary key, 
                                 cust_name varchar(20), 
                                  avail_balance decimal);

create table mini_statement (acc_no integer, 
                              avail_balance decimal, 
                     foreign key(acc_no) references customer(acc_no) on delete cascade); 

insert into customer values (1000, "Fanny", 7000);
insert into customer values (1001, "Peter", 12000); 

delimiter //
create trigger update_cus1
after update on customer
for each row
begin
      insert into mini_statement values (old.acc_no, old.avail_balance);
end; 


select * from customer;

update customer set avail_balance = avail_balance + 3000 where acc_no = 1001;
update customer set avail_balance = avail_balance + 3000 where acc_no = 1000; 

select * from mini_statement;

 
CREATE TABLE students2(    
    id int NOT NULL AUTO_INCREMENT,    
    name varchar(45) NOT NULL,    
    class int NOT NULL,    
    email_id varchar(65) NOT NULL,    
    PRIMARY KEY (id));

 
INSERT INTO students2 (name, class, email_id)     
VALUES ('Stephen', 6, 'stephen@javatpoint.com'),   
('Bob', 7, 'bob@javatpoint.com'),   
('Steven', 8, 'steven@javatpoint.com'),   
('Alexandar', 7, 'alexandar@javatpoint.com');

CREATE TABLE students_log(    
    user varchar(45) NOT NULL,    
    descreptions varchar(65) NOT NULL  
);  

DELIMITER $$  
CREATE TRIGGER after_update_studentsInfo1  
before UPDATE  
ON students2 FOR EACH ROW  
BEGIN  
    INSERT into students_log VALUES (user(),   
    CONCAT('Update Student Record ', OLD.name, ' Previous Class :',  
    OLD.class, ' Present Class ', NEW.class));  
END $$  

UPDATE students2 SET class = class - 1;  

select * from students_log;
select * from students2;

create table micro_statement (acc_no integer, 
                                  avail_balance decimal, 
            foreign key(acc_no) references customer(acc_no) on delete cascade); 

insert into customer values (1002, "Janitor", 4500);

delimiter //
create trigger update_after
        after update on customer
        for each row
        begin
        insert into micro_statement values(new.acc_no, new.avail_balance);
        end; // 
update customer set avail_balance = avail_balance + 1500 where acc_no = 1002; 

select * from micro_statement;

CREATE TABLE salaries (  
    emp_num INT PRIMARY KEY,  
    valid_from DATE NOT NULL,  
    amount DEC(8 , 2 ) NOT NULL DEFAULT 0  
);  

INSERT INTO salaries (emp_num, valid_from, amount)  
VALUES  
    (102, '2020-01-10', 45000),  
    (103, '2020-01-10', 65000),  
    (105, '2020-01-10', 55000),  
    (107, '2020-01-10', 70000),  
    (109, '2020-01-10', 40000);

select * from salaries;

CREATE TABLE salary_archives (  
    id INT PRIMARY KEY AUTO_INCREMENT,  
    emp_num INT,  
    valid_from DATE NOT NULL,  
    amount DEC(8 , 2 ) NOT NULL DEFAULT 0,  
    deleted_time TIMESTAMP DEFAULT NOW()  
);  
DELIMITER $$  
CREATE TRIGGER before_delete_salaries8  
before DELETE  
ON salaries FOR EACH ROW  
BEGIN  
    INSERT INTO salary_archives (emp_num, valid_from, amount)  
    VALUES(OLD. emp_num, OLD.valid_from, OLD.amount);  
END$$   

delete from salaries where emp_num = '103';
select * from salary_archives;
select * from salaries;

CREATE TABLE total_salary_budget(  
    total_budget DECIMAL(10,2) NOT NULL  
);  

INSERT INTO total_salary_budget (total_budget)  
SELECT SUM(amount) FROM salaries;  

select * from total_salary_budget;

DELIMITER $$  
CREATE TRIGGER after_delete_salaries  
AFTER DELETE  
ON salaries FOR EACH ROW  
BEGIN  
   UPDATE total_salary_budget SET total_budget = total_budget - old.amount;  
END$$   

DELETE FROM salaries WHERE emp_num = 107;  
select* from salaries;
select * from total_salary_budget;