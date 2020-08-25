2020-01-20  02)subqery를 사용한 DML(insert, update, delete)

예)상위부서(parent_id)가 90번인 부서(60,70,100,110)의 평균급여를 계산하여 그들 부서에 속한 사우ㅓㄴ의 급여를 모두 평균급여로 갱신하시오
1)위부서(parent_id)가 90번인 부서의 편균급여
    select department_id,
           avg(salary)
        from employees a
        where a.department_id in (서브쿼리)
        group by a.department_id
        
    (서브퀄) 상위부서(parent_id)가 90번인 부서
    select department_id
    from departments
    where parent_id = 90
    
    select department_id,
           round(avg(salary))
        from employees a
        where a.department_id in (select department_id
                                    from departments
                                    where parent_id = 90)
        group by a.department_id;
        
-----------------------------------------------------------------
    select emp_name, salary, department_id
    from employees
    where department_id in (60,70,100,110);
    
    (급여update)
    update employees a 
   set a.salary = (select d.sal
                    from (select c.department_id as dept,
                                round(avg(b.salary)) as sal
                           from employees b, departments c
                          where c.parent_id = 90
                            and b.department_id = c.department_id
                          group by c.department_id) d
                    where a.department_id = d.dept)
     where a.department_id in (select department_id
                             from departments
                            where parent_id = 90);
                                  
        rollback;      
        
        
    select emp_name, departmnet_id, salary
        from emplyees
        where department_id in (60,70,100,110)
                                  
    (서브쿼리)
    select department_id as dept,
                                round (avg(salary)) as sal
                            from employees ;
                                  b, departments c
                            where c.parent_id = 90
                            and b.department_id = c.department_id
                            group by department_id) d, employees a
                            
                            where department_id = d.dept;