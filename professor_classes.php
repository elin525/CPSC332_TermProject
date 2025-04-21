<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Professor Class Schedule</title>
    <link rel="stylesheet" href="index.css" />
</head>
<body>




<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $ssn = $_POST['ssn'];

    $conn = new mysqli("mariadb", "cs332s11", "1ZGaeiOF", "cs332s11");
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    $stmt = $conn->prepare("SELECT Course.title, Section.section_number,Section.classroom, Section.meeting_days, Section.start_time, S>        FROM Section
        JOIN Course ON Section.course_number = Course.course_number
        WHERE Section.professor_ssn = ?;");

    $stmt->bind_param('i',$ssn);
    $stmt->execute();

    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        echo "<h2>Professor's Class Schedule:</h2>";
        while ($row = $result->fetch_assoc()) {
            echo "<p>";
            echo "Title: " . htmlspecialchars($row["title"]) . "<br>";
            echo "Section: " . htmlspecialchars($row["section_number"]) . "<br>";
            echo "Classroom: " . htmlspecialchars($row["classroom"]) . "<br>";
            echo "Days: " . htmlspecialchars($row["meeting_days"]) . "<br>";
            echo "Time: " . htmlspecialchars($row["start_time"]) . " - " . htmlspecialchars($row["end_time"]) . "<br>";
            echo "</p><hr>";
        }
    } else {
        echo "No classes found for SSN: $ssn";
    }
    $result ->free_result();
    $conn->close();
    $stmt->close();
}
?>

