create schema if not exists attendance;
use attendance;
create table student(
	student_id varchar(50) primary key,
	student_name varchar(50) not null,
	student_password varchar(64) not null #Using sha-256 encrypt the password, 65 characters
);

create table course(
	course_id int primary key auto_increment, #For future easier reference
	course_department varchar(10) not null,
	course_number varchar(10) not null,
	course_section varchar(10) not null,
	course_name varchar(50) not null,
	unique(course_department, course_number, course_section)
);

create table teacher(
	teacher_id varchar(50) primary key,
	teacher_name varchar(50) not null,
	teacher_password varchar(64) not null
);

create table classroom(
	cr_id int primary key auto_increment,
	cr_name varchar(50) not null,
	cr_file varchar(200)
);

#TeacherCourse
#• tc id int
#• teacher id string
#• course id int
#• cr id int
#• time string # the format for time is something like
#[{‘weekday′ : ‘M′, ‘start time′ : ‘15 : 55′, ‘end time′ : ‘17 : 20′}, . . .] • semester string
create table teacher_course(
	tc_id int primary key auto_increment,
	teacher_id varchar(50) not null,
	course_id int not null,
	cr_id int not null,
	col_time varchar(500) not null,
	semester varchar(50) not null,
	foreign key(teacher_id) references teacher(teacher_id),
	foreign key(course_id) references course(course_id),
	foreign key(cr_id) references classroom(cr_id),
	unique(teacher_id, course_id, cr_id)
);

#StudentCourse
#• sc id int
#• student id string • course id int
create table student_course(
	sc_id int primary key auto_increment,
	student_id varchar(50) not null,
	tc_id int not null,
	foreign key(student_id) references student(student_id),
	foreign key(tc_id) references teacher_course(tc_id),
	unique(student_id, tc_id)
);

#Record
#• record id int
#• tc id int
#• student id string
create table record(
	record_id int primary key auto_increment,
	tc_id int not null,
	student_id varchar(50) not null,
	date_time varchar(50) not null,
	foreign key(tc_id) references teacher_course(tc_id),
	foreign key(student_id) references student(student_id)
);