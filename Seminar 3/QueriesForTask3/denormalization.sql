CREATE VIEW STUDENT_LESSON_PRICE AS
SELECT STUDENT.FULL_NAME AS "STUDENT",
	STUDENT_ID,
	CASE
	WHEN EXISTS (SELECT SIBLING_ID_1 FROM BRIDGE_SIBLING WHERE SIBLING_ID_1 = STUDENT.DATABASE_ID OR SIBLING_ID_2 = STUDENT.DATABASE_ID)
	THEN 'HAS SIBLING'
	ELSE 'HAS NO SIBLING'
	END AS DISCOUNT,
	LESSON_ID, 'PRIVATE LESSON' AS "TYPE", DATE, CLASSROOM,
	INSTRUCTORS.FULL_NAME AS "INSTRUCTOR",
	EMPLOYEE_ID,
	PRIVATE_LESSON_BASE_PRICE AS "BASE PRICE",
	SIBLING_DISCOUNT_MODIFIER
FROM PRIVATE_LESSON
INNER JOIN BOOKING_TABLE ON PRIVATE_LESSON_DB_ID = PRIVATE_LESSON.DATABASE_ID
INNER JOIN INSTRUCTORS ON INSTRUCTORS.DATABASE_ID = INSTRUCTOR_DB_ID
INNER JOIN PRICE_TABLE ON BOOKING_TABLE.DATE BETWEEN START_DATE AND END_DATE
INNER JOIN BRIDGE_STUDENT_TO_BOOKING ON BOOKING_DB_ID = BOOKING_TABLE.DATABASE_ID
INNER JOIN STUDENT ON STUDENT_DB_ID = STUDENT.DATABASE_ID
WHERE EXTRACT(MONTH FROM DATE)=EXTRACT(MONTH FROM CURRENT_DATE)
UNION
SELECT STUDENT.FULL_NAME AS "STUDENT",
	STUDENT_ID,
	CASE
	WHEN EXISTS (SELECT SIBLING_ID_1 FROM BRIDGE_SIBLING WHERE SIBLING_ID_1 = STUDENT.DATABASE_ID OR SIBLING_ID_2 = STUDENT.DATABASE_ID)
	THEN 'HAS SIBLING'
	ELSE 'HAS NO SIBLING'
	END AS DISCOUNT,
	LESSON_ID, 'GROUP LESSON' AS "TYPE", DATE, CLASSROOM,
	INSTRUCTORS.FULL_NAME AS "INSTRUCTOR",
	EMPLOYEE_ID,
	GROUP_LESSON_BASE_PRICE AS "BASE PRICE",
	SIBLING_DISCOUNT_MODIFIER
FROM GROUP_LESSON
INNER JOIN BOOKING_TABLE ON GROUP_LESSON_DB_ID = GROUP_LESSON.DATABASE_ID
INNER JOIN INSTRUCTORS ON INSTRUCTORS.DATABASE_ID = INSTRUCTOR_DB_ID
INNER JOIN PRICE_TABLE ON BOOKING_TABLE.DATE BETWEEN START_DATE AND END_DATE
INNER JOIN BRIDGE_STUDENT_TO_BOOKING ON BOOKING_DB_ID = BOOKING_TABLE.DATABASE_ID
INNER JOIN STUDENT ON STUDENT_DB_ID = STUDENT.DATABASE_ID
WHERE EXTRACT(MONTH FROM DATE)=EXTRACT(MONTH FROM CURRENT_DATE)
UNION
SELECT STUDENT.FULL_NAME AS "STUDENT",
	STUDENT_ID,
	CASE
	WHEN EXISTS (SELECT SIBLING_ID_1 FROM BRIDGE_SIBLING WHERE SIBLING_ID_1 = STUDENT.DATABASE_ID OR SIBLING_ID_2 = STUDENT.DATABASE_ID)
	THEN 'HAS SIBLING'
	ELSE 'HAS NO SIBLING'
	END AS DISCOUNT,
	LESSON_ID, 'ENSEMBLE LESSON' AS "TYPE", DATE, CLASSROOM,
	INSTRUCTORS.FULL_NAME AS "INSTRUCTOR",
	EMPLOYEE_ID,
	ENSEMBLE_LESSON_BASE_PRICE AS "BASE PRICE",
	SIBLING_DISCOUNT_MODIFIER
FROM ENSEMBLE
INNER JOIN BOOKING_TABLE ON ENSEMBLE_DB_ID = ENSEMBLE.DATABASE_ID
INNER JOIN INSTRUCTORS ON INSTRUCTORS.DATABASE_ID = INSTRUCTOR_DB_ID
INNER JOIN PRICE_TABLE ON BOOKING_TABLE.DATE BETWEEN START_DATE AND END_DATE
INNER JOIN BRIDGE_STUDENT_TO_BOOKING ON BOOKING_DB_ID = BOOKING_TABLE.DATABASE_ID
INNER JOIN STUDENT ON STUDENT_DB_ID = STUDENT.DATABASE_ID
WHERE EXTRACT(MONTH FROM DATE)=EXTRACT(MONTH FROM CURRENT_DATE);