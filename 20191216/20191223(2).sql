2019-12-23 (2)

1) 함수(function)
 --함수는 반드시 반환값이 있다/ 함수가 쓰인 위치에 함수값이 반환되어진다.
 --select 절에 사용할 수 있다.
  - 함수가 사용된 위치에 결과 값을 반화 (select, where, having 절에 사용가능)
  - 시스템에서 제공하는 함수
  - 문자열함수, 숫자함수, 날짜형함수, 집계함수, 변환함수(데이터 타입을 변환시킬때 사용) 등이 존재
  
  
1. 문자열함수
    1) '||' : 문자열 결합연산자
            : java의  '+' (문자열)와 동일
        (사용형식)
        c1 || c2 
         - 'c1' 과 'c2'는 문자열이거나 문자열 자료를 정장하고 있는 컬럼명 
         - 같은 기능을 수행하는 함수로는 concat (c1,c2) 가 제공
         - 'c1'과 'c2'를 결합하여 새로운 문자열 반환
         
    예) 회원테이블의 자료를 이용하여 다으모가 같은 결과를 
     query를 작성하시오
      (출력 예)
      김은대 회원님의 마일리지는 1000점 입니다. --조건 없다
    
    select mem_name || '회원님의 마일리지는'||mem_mileage||'점입니다.'
        from member;
        
        
    2)concat --매개변수 2개밖에 못씀
    - 문자열 결합 함수 
    - '||' 와 같은 기능
     (사용형식)
     concat(c1,c2)
     -c1과 c2를 결합하여 새로운 문자열 반환 
     
    예) 회원테이블에서 마일리지가 3000이상인 남성회원의 자료를 조회하시오 
    Alias 는 회원번호, 회원명, 주민번호, 마일리지(주민번호는 '123456-2345678')
            주민번호 결합에 concat함수를 사용하시오
            
    select mem_id as 회원번호,
           mem_name as 회원명,
        -- concat (concat(mem_regno1,'-'), mem_regno2) as 주민번호, --밖보다 안의 함수가 먼저 실행되어진다/ 함수안에 함수가 또 실행되어질 수 있다
          ㅡmem_regno1||'-'|| mem_regno2 as 주민번호,
           mem_mileage as 마일리지
        from member
    where  (mem_regno2 like '1%'or mem_regno2 like '3%') 
           and mem_mileage >= 3000;
           
    2) lower(c1), upper(c1), initcap(c1) --lower : 소문자로 바꾸세요, upper : 대문자로 바꾸세요, initcap : 첫글자만 대문자
        - lower(c1) : c1의 모든 문자를 소문자로 변환
        - upper(c1) : c1의 모든 문자를 대문자로 변환
        - initcap(c1) : c1의 단어 첫 글자만 대문자로 변환

예)사원테이블(employees)의 사원명을 소문자로 변경하시오
    Alias 는 사원번호, 사원명,부서번호이다.
        select employee_id as 사원번호,
               lower(emp_name) as "사원명(소)",
               upper(emp_name) as "사원명(대)",
               inticap(emp_name) as "사원명(inticap)",
               department_id as 부서번호
            from employees;
            --왜 안될까..?
            
    select mem_id, mem_name, mem_mileage
    from member
    where upper (mem_id) < 'F001';
        
        
            
    
    
    
    