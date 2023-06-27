-- 1.
SELECT STUDENT_NAME "학생 이름", STUDENT_ADDRESS "주소지"
FROM TB_STUDENT
ORDER BY STUDENT_NAME;

-- 2.
SELECT STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY SUBSTR(STUDENT_SSN,1,6) DESC;

-- 3. 
SELECT STUDENT_NAME 학생이름, STUDENT_NO 학번, STUDENT_ADDRESS "거주지 주소"
FROM TB_STUDENT
WHERE (STUDENT_ADDRESS LIKE '%강원%' OR STUDENT_ADDRESS LIKE '경기도%') AND STUDENT_NO NOT LIKE 'A%'
ORDER BY STUDENT_NAME;

-- 4.
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO = '005'
ORDER BY SUBSTR(PROFESSOR_SSN,1,6);

-- 5.
SELECT STUDENT_NO,TO_CHAR(POINT, 'FM999990.00')            
FROM TB_GRADE
WHERE TERM_NO = 200402 AND CLASS_NO = 'C3118100'
ORDER BY POINT DESC, STUDENT_NO ASC;


-- 6.
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT S
JOIN TB_DEPARTMENT D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO)
ORDER BY STUDENT_NAME;

-- 7.
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO);


-- 8.  -- 맞는지 모르겠습니다ㅠㅠ
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS
JOIN TB_PROFESSOR USING (DEPARTMENT_NO);    


-- 9.
SELECT STUDENT_NO 학번, STUDENT_NAME "학생 이름", ROUND(AVG(POINT),1) "전체 평점"
FROM TB_STUDENT 
JOIN TB_GRADE USING (STUDENT_NO)
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME = '음악학과')
GROUP BY STUDENT_NO, STUDENT_NAME
ORDER BY STUDENT_NO, ROUND(SUM(POINT)/COUNT(STUDENT_NO),1) DESC;


-- 10. 
SELECT DEPARTMENT_NAME 학과이름, STUDENT_NAME 학생이름, PROFESSOR_NAME 지도교수이름
FROM TB_DEPARTMENT
JOIN TB_STUDENT USING (DEPARTMENT_NO)
JOIN TB_PROFESSOR USING (DEPARTMENT_NO)
WHERE STUDENT_NO = 'A313047';           -- 지도교수 이름...?


-- 11.
SELECT CLASS_NO
FROM TB_CLASS
WHERE CLASS_NAME = '인간관계론'; -- CLASS_NO

SELECT STUDENT_NAME, TERM_NO AS "TERM_NAME"
FROM TB_STUDENT
JOIN TB_GRADE USING (STUDENT_NO)
WHERE TERM_NO LIKE '2007%' 
AND CLASS_NO = (SELECT CLASS_NO FROM TB_CLASS WHERE CLASS_NAME = '인간관계론');

-- 12.                                            -- 담당교수 없는 조건 다시 생각해보기
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
LEFT JOIN TB_PROFESSOR USING (DEPARTMENT_NO)
WHERE CATEGORY = '예체능'
AND PROFESSOR_NO IS NULL;
 


-- 13. 
SELECT STUDENT_NAME 학생이름, NVL(PROFESSOR_NAME, '지도교수 미지정') 지도교수
FROM TB_STUDENT S
LEFT JOIN TB_PROFESSOR P ON (S.COACH_PROFESSOR_NO = P.PROFESSOR_NO)
WHERE S.DEPARTMENT_NO = (SELECT DEPARTMENT_NO FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME = '서반아어학과')
ORDER BY STUDENT_NO ASC; 


-- 14. 
SELECT S.STUDENT_NO AS 학번, S.STUDENT_NAME AS 이름, D.DEPARTMENT_NAME AS "학과 이름", ROUND(AVG(G.POINT), 1) "평점"
FROM TB_STUDENT S
JOIN TB_DEPARTMENT D ON S.DEPARTMENT_NO = D.DEPARTMENT_NO
JOIN TB_GRADE G ON S.STUDENT_NO = G.STUDENT_NO
WHERE S.ABSENCE_YN = 'N'
GROUP BY S.STUDENT_NO, S.STUDENT_NAME, D.DEPARTMENT_NAME
HAVING ROUND(AVG(G.POINT), 1) >= 4.0
ORDER BY S.STUDENT_NO ASC;



-- 15. 
SELECT DEPARTMENT_NO
FROM TB_DEPARTMENT
WHERE DEPARTMENT_NAME = '환경조경학과';   --034

SELECT C.CLASS_NO, CLASS_NAME, ROUND(AVG(G.POINT),1) AS 평점
FROM TB_CLASS C
JOIN TB_GRADE G ON (C.CLASS_NO = G.CLASS_NO)
WHERE C.DEPARTMENT_NO = (SELECT DEPARTMENT_NO FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME = '환경조경학과')
AND CLASS_TYPE LIKE '전공%'
GROUP BY C.CLASS_NO, CLASS_NAME
ORDER BY CLASS_NO;



-- 16.
SELECT STUDENT_NAME, STUDENT_ADDRESS
FROM TB_STUDENT
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                       FROM TB_STUDENT
                       WHERE STUDENT_NAME = '최경희');
                       
-- 17.  
                
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
JOIN TB_GRADE USING (STUDENT_NO)
WHERE DEPARTMENT_NAME = '국어국문학과' -- 국어국문학과 학생들
GROUP BY STUDENT_NO, STUDENT_NAME
HAVING AVG(POINT) = (SELECT MAX(AVG(POINT)) 
                     FROM TB_STUDENT 
                     JOIN TB_GRADE USING (STUDENT_NO) 
                     WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO 
                                            FROM TB_DEPARTMENT 
                                            WHERE DEPARTMENT_NAME = '국어국문학과')
                                            GROUP BY STUDENT_NAME);
                  
             
                        
-- 18.
-- "환경조경학과"가 속한 같은 계열 학과들
SELECT CATEGORY
FROM TB_DEPARTMENT
WHERE DEPARTMENT_NAME = '환경조경학과';  -- 자연과학

SELECT DEPARTMENT_NAME "계열 학과명", ROUND(AVG(POINT), 1)"전공평점"
FROM TB_DEPARTMENT 
JOIN TB_CLASS USING (DEPARTMENT_NO)
JOIN TB_GRADE USING (CLASS_NO)
WHERE CATEGORY = (SELECT CATEGORY
                  FROM TB_DEPARTMENT
                  WHERE DEPARTMENT_NAME = '환경조경학과')
GROUP BY DEPARTMENT_NAME
ORDER BY DEPARTMENT_NAME;
