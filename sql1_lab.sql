-- SQL Exercises (With Answers)

-- 1. Retrieve all students who enrolled in 2023.
SELECT * FROM students 
WHERE enrollmentdate like '2023%';


-- 2. Find students whose email contains 'gmail.com'.
SELECT * FROM students
WHERE email like '%@gmail.com';

-- 3. Count how many students are enrolled in the database.
SELECT COUNT(StudentID) FROM students;


-- 4. Find students born between 2000 and 2005.
SELECT * FROM students
WHERE YEAR(DateofBirth) >= 2000 && YEAR(DateofBirth)<=2005;

-- 5. List students sorted by last name in descending order.
SELECT FirstName, LastName FROM students
ORDER BY LastName DESC;


-- 6. Find the names of students and the courses they are enrolled in.
SELECT * FROM students
INNER JOIN enrollments ON students.StudentID = enrollments.StudentID
INNER JOIN courses ON enrollments.CourseID = courses.CourseID;


-- 7. List all students and their courses, ensuring students without courses are included (LEFT JOIN).
SELECT * FROM students
LEFT JOIN enrollments ON students.StudentID = enrollments.StudentID
LEFT JOIN courses ON enrollments.CourseID = courses.CourseID;


-- 8. Find all courses with no students enrolled (LEFT JOIN).
SELECT DISTINCT courses.CourseID, CourseName, Credits, Instructor FROM courses
LEFT JOIN enrollments ON enrollments.CourseID = courses.CourseID
LEFT JOIN students ON students.StudentID = enrollments.StudentID
WHERE enrollments.StudentID IS NULL;


-- 10. List courses and show the number of students enrolled in each course.
SELECT courses.CourseID, CourseName, count(students.StudentID) AS StudentCount FROM courses
LEFT JOIN enrollments ON enrollments.CourseID = courses.CourseID
LEFT JOIN students ON students.StudentID = enrollments.StudentID
GROUP BY courses.CourseID;



