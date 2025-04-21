<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Course Section</title>
    <link rel="stylesheet" href="index.css" />
</head>
<body>

<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $course_no = $_POST['course_no'];

    $conn = new mysqli("mariadb", "cs332s11", "1ZGaeiOF", "cs332s11");
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // Prepare the SQL statement
    $stmt = $conn->prepare("SELECT
                            s.section_number,s.classroom,s.meeting_days,s.start_time,s.end_time,
                            COUNT(e.student_id) AS enrolled_students
                            FROM Section s
                            LEFT JOIN Enrollment e ON s.course_number = e.course_number AND s.section_number = e.section_number
                            WHERE s.course_number = ?
                            GROUP BY s.section_number, s.classroom, s.meeting_days, s.start_time, s.end_time;");

    $stmt->bind_param("s", $course_no);
    $stmt->execute();

    $result = $stmt->get_result();


    if ($result->num_rows > 0) {
        echo "<h2>Sections for Course: " . htmlspecialchars($course_no) . "</h2>";
        while ($row = $result->fetch_assoc()) {
            echo "<p>";
            echo "Section: " . htmlspecialchars($row["section_number"]) . "<br>";
            echo "Classroom: " . htmlspecialchars($row["classroom"]) . "<br>";
            echo "Meeting Days: " . htmlspecialchars($row["meeting_days"]) . "<br>";
            echo "Time: " . htmlspecialchars($row["start_time"]) . " - " . htmlspecialchars($row["end_time"]) . "<br>";
            echo "Enrolled Students: " . htmlspecialchars($row["enrolled_students"]);
            echo "</p><hr>";
        }
    } else {
        echo "<p>No sections found for Course: " . htmlspecialchars($course_no) . "</p>";
    }

    $result->free();
    $stmt->close();
    $conn->close();
}
?>
</body>
</html>

