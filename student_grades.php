<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Grades</title>
    <link rel="stylesheet" href="index.css" />
</head>
<body>

<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $student_id = $_POST['student_id'];

    $conn = new mysqli("mariadb", "cs332s11", "1ZGaeiOF", "cs332s11");
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    $stmt = $conn->prepare("SELECT c.title AS course_title,e.grade
                            FROM Enrollment e
                            JOIN Course c ON e.course_number = c.course_number
                            WHERE e.student_id = ?;");

    $stmt->bind_param("i", $student_id);
    $stmt->execute();

    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        echo "<h2>Student Grades: " . htmlspecialchars($student_id) . "</h2>";
        while ($row = $result->fetch_assoc()) {
            echo "<p>";
            echo "Course Title: " . htmlspecialchars($row["course_title"]) . "<br>";
            echo "Grade: " . htmlspecialchars($row["grade"]) . "<br>";
            echo "</p><hr>";
        }
    } else {
        echo "<p>Student has no courses: " . htmlspecialchars($student_id) . "</p>";
    }

    $result->close();
    $stmt->close();
    $conn->close();
}
?>

</body>
</html>

