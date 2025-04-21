<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Grade Distribution</title>
    <link rel="stylesheet" href="index.css" />
</head>
<body>

<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $course_no = $_POST['course_no'];
    $section_no = $_POST['section_no'];

    $conn = new mysqli("mariadb", "cs332s11", "1ZGaeiOF", "cs332s11");
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // Prepare the SQL statement
    $stmt = $conn->prepare("SELECT grade, COUNT(*) AS student_count
                            FROM Enrollment
                            WHERE course_number = ? AND section_number = ?
                            GROUP BY grade");

    $stmt->bind_param("si", $course_no, $section_no); // "s" for string, "i" for integer
    $stmt->execute();

    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        echo "<h2>Grade Distribution:</h2>";
        while ($row = $result->fetch_assoc()) {
            echo "<p>Grade: " . htmlspecialchars($row["grade"]) .
                 " - Students: " . htmlspecialchars($row["student_count"]) . "</p><hr>";
        }
    } else {
        echo "<p>No grades found for Course: " . htmlspecialchars($course_no) .
             ", Section: " . htmlspecialchars($section_no) . "</p>";
    }
    $result->free();
    $stmt->close();
    $conn->close();
}
?>
</body>
</html>



