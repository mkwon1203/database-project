insert into Employee values (12345,'Jarryd Goodman',TO_DATE('1989-12-09','YYYY-MM-DD'),'M','Instructor',10,'5203952912','555 E 10th st Tucson, AZ 85716',333);
insert into Employee values (23451,'Min Kwon',TO_DATE('1992-12-01','YYYY-MM-DD'),'M','Senior Instructor',10,'520354324','556 E 10th st Tucson, AZ 85716',222);
insert into Employee values (34512,'Ryan Melzer',TO_DATE('1990-08-26','YYYY-MM-DD'),'M','Senior Instructor',20,'5205555555','557 E 10th st Tucson, AZ 85716',111);
insert into Employee values (45123,'Christopher Stepanski',TO_DATE('1996-07-20','YYYY-MM-DD'),'F','Admistrative staff',10,'3949293493','558 E 10th st Tucson, AZ 85716',null);
insert into Employee values (51234,'Shuo YAANNNGGGGGG',TO_DATE('1989-11-09','YYYY-MM-DD'),'F','Admistrative staff',20,'3857483823','559 E 10th st Tucson, AZ 85716',null);

insert into Client values (1000,'Bill Matheson','M',TO_DATE('1989-12-09','YYYY-MM-DD'),'2341 E 2nd st Tucson, AZ 85716',12345);
insert into Client values (2000,'Jennifer Creed','M',TO_DATE('1992-12-01','YYYY-MM-DD'),'2341 E 2nd st Tucson, AZ 85716',23451);
insert into Client values (3000,'Lester McCann','F',TO_DATE('1989-11-09','YYYY-MM-DD'),'4342 E 11th st Tucson, AZ 85716',23451);
insert into Client values (4000,'MC Can','F',TO_DATE('1989-11-09','YYYY-MM-DD'),'6453 E 12th st Tucson, AZ 85716',34512);
insert into Client values (5000,'Slick Rick','M',TO_DATE('1989-11-09','YYYY-MM-DD'),'1342 W 15th st Tucson, AZ 85716',34512);

insert into Office values (10,23451,'Tucson','233 W 1st st');
insert into Office values (20,34512,'Wonderland','111 N 0th st');

insert into Car values (111,'Tesla Model S','N');
insert into Car values (222,'Ford Model T','N');
insert into Car values (333,'Lamborghini Diablo','N');
insert into Car values (444,'Toyota Corolla','Y');

insert into Lesson values (12345,1000,TO_TIMESTAMP('2015-04-12 10:30:00', 'YYYY-MM-DD HH24:MI:SS'),22);
insert into Lesson values (23451,5000,TO_TIMESTAMP('2015-04-12 13:30:00', 'YYYY-MM-DD HH24:MI:SS'),14);
insert into Lesson values (23451,5000,TO_TIMESTAMP('2015-04-12 08:30:00', 'YYYY-MM-DD HH24:MI:SS'),13);
insert into Lesson values (34512,2000,TO_TIMESTAMP('2015-04-12 01:30:00', 'YYYY-MM-DD HH24:MI:SS'),12);
insert into Lesson values (34512,3000,TO_TIMESTAMP('2015-04-12 11:30:00', 'YYYY-MM-DD HH24:MI:SS'),10);

insert into Test values (12345,1000,TO_TIMESTAMP('2015-04-13 10:30:00', 'YYYY-MM-DD HH24:MI:SS'),'Y', null);
insert into Test values (23451,5000,TO_TIMESTAMP('2015-04-14 13:30:00', 'YYYY-MM-DD HH24:MI:SS'),'Y', null);
insert into Test values (23451,5000,TO_TIMESTAMP('2015-04-15 08:30:00', 'YYYY-MM-DD HH24:MI:SS'),'Y', null);
insert into Test values (34512,2000,TO_TIMESTAMP('2015-04-16 01:30:00', 'YYYY-MM-DD HH24:MI:SS'),'Y', null);
insert into Test values (34512,3000,TO_TIMESTAMP('2015-04-11 11:30:00', 'YYYY-MM-DD HH24:MI:SS'),'N','Antisemetic?');

insert into Interview values (12345,1000,TO_TIMESTAMP('2015-03-13 10:30:00', 'YYYY-MM-DD HH24:MI:SS'));
insert into Interview values (23451,5000,TO_TIMESTAMP('2015-03-14 13:30:00', 'YYYY-MM-DD HH24:MI:SS'));
insert into Interview values (34512,2000,TO_TIMESTAMP('2015-03-16 01:30:00', 'YYYY-MM-DD HH24:MI:SS'));
insert into Interview values (34512,3000,TO_TIMESTAMP('2015-03-11 11:30:00', 'YYYY-MM-DD HH24:MI:SS'));
