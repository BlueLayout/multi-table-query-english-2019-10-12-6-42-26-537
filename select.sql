# 1.Query the existence of 1 course
select count(*) from course where id = 1;
# 2.Query the presence of both 1 and 2 courses
select count(*) from course where id = 1 or id = 2;
# 3.Query the student number and student name and average score of students whose average score is 60 or higher.
select s.id,s.name,a from student as s
	join
		(select studentId,avg(score) as a from student_course group by studentId having a>60) c
	on
		s.id = c.studentId;
# 4.Query the SQL statement of student information that does not have grades in the student_course table
select a.id,a.name,a.age,a.sex from student a join (select distinct studentId from student_course where score = 0) b on a.id = b.studentId;
# 5.Query all SQL with grades
select a.id,a.name,count(b.courseId),sum(score) from student a,student_course b
	where
		a.id = b.studentId
	group by
		a.id,a.name
	order by
		a.id;
# 6.Inquire about the information of classmates who have numbered 1 and also studied the course numbered 2
select a.* from student a,student_course b,student_course c
	where
		a.id = b.studentId
			and
				a.id = c.studentId
					and
						b.courseId = 1
						and c.courseId = 2;
# 7.Retrieve 1 student score with less than 60 scores in descending order
select student.* ,student_course.courseId,student_course.score from student,student_course
	where
		student.id = student_course.studentId
			and student_course.score < 60
				and student_course.courseId = 1
	order by
		student_course.score desc;
# 8.Query the average grade of each course. The results are ranked in descending order of average grade. When the average grades are the same, they are sorted in ascending order by course number.
select m.id,m.name,cast(avg(n.score) as decimal(18,2)) avg_score
	from
		course m,student_course n
	where
		m.id = n.courseId
	group by
		m.id,m.name
	order by
		avg_score desc,m.id asc;
# 9.Query the name and score of a student whose course name is "Math" and whose score is less than 60
select student.name,score from student,student_course,course
	where
		student_course.studentId = student.id
	and
		student_course.courseId = course.id
	and
		course.name = 'Math' and score < 60;
