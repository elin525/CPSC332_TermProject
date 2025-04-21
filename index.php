<!DOCTYPE html>
<html>
<head>
    <title>University DB Project</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="index.css" />
</head>
<body>
    <h1 style="text-align: center;">Welcome to The University Database</h1>

    <!-- Tabs -->
    <div class="tab-container">
        <div class="tab active" data-tab="professor-info">Professor Info</div>
        <div class="tab" data-tab="grade-distribution">Grade Distribution</div>
        <div class="tab" data-tab="student-interface">Student Course Sections</div>
        <div class="tab" data-tab="student-grades">Student Grades</div>
    </div>

    <!-- Tab Contents -->
    <div id="professor-info" class="tab-content active">
        <?php include 'form_professor_info.php'; ?>
    </div>
    <div id="grade-distribution" class="tab-content">
        <?php include 'form_grade_distribution.php'; ?>
    </div>
    <div id="student-interface" class="tab-content">
        <?php include 'form_course_sections.php'; ?>
    </div>
    <div id="student-grades" class="tab-content">
        <?php include 'form_student_grades.php'; ?>
    </div>

    <script>
        const tabs = document.querySelectorAll(".tab");
        const contents = document.querySelectorAll(".tab-content");

        tabs.forEach(tab => {
            tab.addEventListener("click", () => {
                tabs.forEach(t => t.classList.remove("active"));
                contents.forEach(c => c.classList.remove("active"));

                tab.classList.add("active");
                document.getElementById(tab.dataset.tab).classList.add("active");
            });
        });
    </script>
</body>
</html>