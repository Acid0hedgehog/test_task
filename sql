https://sql-academy.org/ru/sandbox 
раздел - расписание

Задание 1: Найдите фамилию и имя ученика с неуказанным отчеством в таблице Student, у которого в расписании есть занятие с учителем Моисеевым Богданом Романовичем (Moiseev Bogdan Romanovich)

SELECT DISTINCT s.first_name, s.last_name, s.middle_name
FROM Student s
JOIN Student_in_class sic ON s.id = sic.student
JOIN Class c ON sic.class = c.id
JOIN Schedule sch ON c.id = sch.class
JOIN Teacher t ON sch.teacher = t.id
WHERE t.first_name = 'Bogdan'
  AND t.last_name = 'Moiseev'
  AND t.middle_name = 'Romanovich';

Задание 2: Найдите уроки, на которых у учителя Андрея Евсеева (Andrej Evseev) будет больше одного класса. В результате выведите дату, начало урока, конец урока, порядковый номер урока, количество классов на одном уроке.

SELECT sch.date, tp.start_pair, tp.end_pair, sch.number_pair, COUNT(DISTINCT c.id) as classes_count
FROM Schedule sch
JOIN Timepair tp ON sch.number_pair = tp.id
JOIN Teacher t ON sch.teacher = t.id
JOIN Class c ON sch.class = c.id
WHERE t.first_name = 'Andrej' AND t.last_name = 'Evseev'
GROUP BY sch.date, tp.start_pair, tp.end_pair, sch.number_pair
HAVING classes_count > 1;

Задание 3: Посчитайте сколько в расписании уроков в августе 2019 у классов с буквой “A” в названии

SELECT COUNT(*) as lesson_count
FROM Schedule sch
JOIN Class c ON sch.class = c.id
WHERE c.name LIKE '%A%'
  AND sch.date >= '2019-08-01'
  AND sch.date <= '2019-08-31';

Задание 4: Выведите полный список учителей и студентов с указанием типа (student или teacher).

SELECT id, first_name, middle_name, last_name, 'teacher' as type
FROM Teacher

UNION ALL 

SELECT id, first_name, middle_name, last_name, 'student' as type
FROM Student;
Задание 5: Посчитайте сколько часов занимают занятия языками по расписанию. Сгруппируйте результат по предмету и классу. Округлите количество часов до одного знака после запятой.

SELECT
    subj.name as subject,
    c.name as class,
    ROUND(SUM(tp.end_pair - tp.start_pair) / 2.0, 1) as total_hours
FROM Schedule sch
JOIN Subject subj ON sch.subject = subj.id
JOIN Class c ON sch.class = c.id
JOIN Timepair tp ON sch.number_pair = tp.id
WHERE subj.name IN ('English language', 'Russian language')
GROUP BY subj.name, c.name;

