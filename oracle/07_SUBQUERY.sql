/*
    서브쿼리(SUBQUERY)
    - 하나의 SQL문 안에 포함된 또 다른 SQL문
*/
-- 간단 서브쿼리 예시1
-- 노옹철 사원과 같은 부서원들을 조회
-- 1) 먼저 노옹철 사원의 부서코드 조회
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철';  -- D9

-- 2) 부서코드가 D9인 사원들을 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- > 3) 위의 두 쿼리 합치면 됨!
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                                    FROM EMPLOYEE
                                    WHERE EMP_NAME = '노옹철');
                                    

-- 전 직원의 평균 급여보다 더 많은 급여를 받는 사원들의 사번, 사원명, 직급코드, 급여 조회
SELECT ROUND(AVG(SALARY),0)
FROM EMPLOYEE;  --3047663

SELECT EMP_ID, EMP_NAME, JOB_CODE, TO_CHAR(SALARY, 'FM999,999,999')||'원' "급여"
FROM EMPLOYEE
WHERE SALARY > (SELECT ROUND(AVG(SALARY),0)
                             FROM EMPLOYEE);
                             
/*
    서브쿼리의 분류
    - 서브쿼리를 수행한 결과값이 몇 행 몇 열이냐에 따라서 분류됨
    - 서브쿼리의 종류에 따라 서브쿼리 앞에 붙는 연산자가 달라짐
*/
/*
    1. 단일행 서브쿼리(SINGLE ROW SUBQUERY)
    - 서브쿼리의 조회 결과값의 개수가 오로지 1개일 때 (한행 한열)
    - 일반 비교연산자 사용 가능 : =, !=, ^=, > , <, >=, ...
*/
-- 노옹철 사원의 급여보다 더 많이 받은 사원의 사번, 사원명, 부서명, 직급코드, 급여 조회
SELECT SALARY
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철';  --370000

-->> ANSI 구문
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
WHERE SALARY > (SELECT SALARY
                             FROM EMPLOYEE
                             WHERE EMP_NAME = '노옹철');

-->> 오라클 구문              
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE E  , DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
AND SALARY > (SELECT SALARY
                          FROM EMPLOYEE
                          WHERE EMP_NAME = '노옹철');
                             

-- 부서별 급여의 합이 가장 큰 부서의 부서코드, 급여의 합 조회

-- 부서별 급여의 합
SELECT SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 부서별 급여의 합이 가장 큰 값
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;  -- 17700000

-- 부서별 급여의 합이 17700000인 부서 조회
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING  SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                                         FROM EMPLOYEE
                                         GROUP BY DEPT_CODE);
                                         
                                         
                                         
-- 전지연 사원이 속해있는 부서원들의 사번, 사원명, 전화번호, 직급명, 부서명, 입사일 조회(단, 전지연 사원은 제외)
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '전지연';   -- D1

--> ANSI 구문
SELECT EMP_ID, EMP_NAME, PHONE, JOB_NAME, DEPT_TITLE, HIRE_DATE
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
WHERE E.DEPT_CODE = (SELECT DEPT_CODE
                                        FROM EMPLOYEE
                                        WHERE EMP_NAME = '전지연') AND EMP_NAME != '전지연';
                                        
-->> 오라클 구문
SELECT EMP_ID, EMP_NAME, PHONE, JOB_NAME, DEPT_TITLE, HIRE_DATE
FROM EMPLOYEE E, JOB J, DEPARTMENT D
WHERE E.JOB_CODE = J.JOB_CODE
AND E.DEPT_CODE = D.DEPT_ID
AND E.DEPT_CODE = (SELECT DEPT_CODE
                                  FROM EMPLOYEE
                                  WHERE EMP_NAME = '전지연') AND EMP_NAME != '전지연';


