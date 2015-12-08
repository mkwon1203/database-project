create table Employee (
	employeeID integer not null,
	name varchar2(100),
	DOB date,
	sex char(1),
	jobTitle varchar2(100),
	officeID integer,
	phone integer,
	address varchar2(100),
	carID integer,
	primary key(employeeID)
);

create table Client (
	clientID integer not null,
	name varchar2(100),
	sex char(1),
	DOB date,
	address varchar2(100),
	instID integer,
	primary key(clientID)
);

create table Office (
	officeID integer not null,
	mgrID integer,
	city varchar2(100),
	address varchar2(100),
	primary key(officeID)
);

create table Car (
	regNum integer not null,
	model varchar2(50),
	faulted char(1),
	primary key(regNum)
);

create table Lesson (
	employeeID integer not null,
	clientID integer not null,
	dateAndTime timestamp,
	miles integer,
	primary key(employeeID, clientID)
);

create table Test (
	employeeID integer not null,
	clientID integer not null,
	dateAndTime timestamp,
	passed char(1),
	reason_for_failure varchar2(100),
	primary key(employeeID, clientID)
);

create table Interview (
	employeeID integer not null,
	clientID integer not null,
	dateAndTime timestamp,
	primary key(employeeID, clientID)
);

grant all privileges on Employee to jarryd999, mkwon1203, chrisstep18;
grant all privileges on Client to jarryd999, mkwon1203, chrisstep18;
grant all privileges on Office to jarryd999, mkwon1203, chrisstep18;
grant all privileges on Car to jarryd999, mkwon1203, chrisstep18;
grant all privileges on Test to jarryd999, mkwon1203, chrisstep18;
grant all privileges on Interview to jarryd999, mkwon1203, chrisstep18;
grant all privileges on Lesson to jarryd999, mkwon1203, chrisstep18;
