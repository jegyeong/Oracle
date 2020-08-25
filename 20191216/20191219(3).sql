2019-12-19

 3)자료삭제
 -DELETE 문으로 지원
 (사용형식)
 DELETE FROM 테이블명
    [WHERE 조건]; --생략되면 클날수있어ㅠ, 잘못하면 모든 자료 지울 수 있어서 
    -'WHERE 조건'이 생략되면 모든 자료가 삭제됨
    
예) 장바구니 테이블의 모든 자료를 삭제 하시오
    
SELECT COUNT(*) FROM CART;   --행의 수를 세어줌!

DELETE FROM CART;

SELECT * FROM CART; --다가져옴

ROLLBACK;

**테이블 삭제는 'DROP TABLE 테이블명'을 사용한다. 


DROP TABLE TMP01; --롤백의 대상이 아니다!  >지워짐.. 복구ㄴㄴ


4)SELECT 문     ----  SELECT, FROM 절대로 생략불가능!  fROM 다음에는 테이블명
    -자료 조회에 사용
    -관계형 데이터 베이스 쿼리 명령 중 가장 많이 사용
    (사용형식)
  SELECT [DISTINCT] 컬럼명 [ AS ["] 별칭 ["]],   ---또다른 이름 부여! 여러개 나올경우에 따옴표
                :
                    컬럼명 [ AS ["] 별칭 ["]]
    FROM 테이블명 [별칭] ---이름을 한번 더 부여하는 거라고 생각하면 됨
   [WHERE 조건
    [AND 조건...]] --요구사항을 기술할때 그리고에 해당되어지는거/ 이거나는 OR /
   [GROUP BY 컬러명[,컬럼명,...]]  --어떠한 기준으로해서 소그룹으로 묶을때 /
                                --SUM 은 더하기/그룹을 묶을때는 집계함수가 반드시 사용되어야함 /5개
[HAVING 조건...]  --5개의 함수에 조건이 부여될때?>WHERE 절 쓰면안돼 / SUM BVERAGE COUNT 
    [ORDER BY 컬럼명[컬럼인덱스 [DESC|ASC],...] --그룹에서 묶어서 관리할때   --정령시킬때 DES내립차순/ ASC오름차순  
    
    SELECT 4567878*26365 FROM DUAL;
         
    -'DISTINCT' 중복된 값을제거함 
    -컬럼의 별칭
    -컬럼명 대신 참조하는 경우(서브쿼리에서 주로 사용)
    -출력에서 제목출력
    
 SELECT MEM_NAME AS "회원이름"
    FROM MEMBER;
    
 SELECT MEM_NAME AS "회원이름"
        CASE WHEN SUBSTR(MEN_REGNO2,1,1)='1' THEN '남자회원'
             ELSE '여자회원', END CASE,
        MEM_     
  FROM MEMBER;


    
    