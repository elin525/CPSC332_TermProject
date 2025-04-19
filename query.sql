/* Professor Query */
SELECT 
    c.title AS course_title,
    s.classroom,
    s.meeting_days,
    s.start_time,
    s.end_time
FROM Section s
JOIN Course c ON s.course_number = c.course_number
WHERE s.professor_ssn = '123456789';

SELECT grade, COUNT(*) AS student_count
FROM Enrollment
WHERE course_number = 'CS131' AND section_number = 2
GROUP BY grade;

/* Student Query */
SELECT 
    s.section_number,
    s.classroom,
    s.meeting_days,
    s.start_time,
    s.end_time,
    COUNT(e.student_id) AS enrolled_students
FROM Section s
LEFT JOIN Enrollment e ON s.course_number = e.course_number AND s.section_number = e.section_number
WHERE s.course_number = 'CS131'
GROUP BY 
    s.section_number, s.classroom, s.meeting_days, s.start_time, s.end_time;

SELECT 
    c.title AS course_title,
    e.grade
FROM Enrollment e
JOIN Course c ON e.course_number = c.course_number
WHERE e.student_id = 884926548;

