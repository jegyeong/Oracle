2020-01-13 3)ROLLUP �� CUBE 
    - GROUP BY ���� ����ϸ� �߰� ���踦 ���Ҷ� ���
    --
    
    1)ROLLUP 
    (�������)
    GROUP BY [�÷���,...], ROLLUP(�÷���[,�÷���...]),[�÷���,...]
        
        -�ݵ�� GROUP BY ���ȿ� ���
        -ROLLUP �ȿ� ����� �÷����� ����(������ > ����)�� ���� ����
        -ROLLUP �ȿ� ����� �÷����� n���� �� n+1���� ���� ��ȯ
        
    ��)kor_loan_status ���� ������, �⵵�� ����� �հ踦 ���Ͻÿ�
    (group by ���� ���)
    
    select region as ������,
           substr(period, 1, 4) as �⵵,
           sum(loan_jan_amt) as ������հ�
        from kor_loan_status
        group by region, substr(period,1,4)
        order by 1;
        
    select region as ������,
           substr(period, 1, 4) as �⵵,
           sum(loan_jan_amt) as ������հ�,
           gubun as ���ⱸ��
        from kor_loan_status
        group by rollup(region, substr(period,1,4), gubun)
        order by 1;
        
    ��)�������̺�(buyprod)�� �̿��Ͽ� 2005�⵵ ����, �з��� ���Աݾ��հ踦 ���϶�
        ��, ���� �հ�� ��ü �հ踦 ���Ͻÿ�
        
        select extract(month from buy_date) as ����,
               substr(buy_prod,1,4) as �з�,
               sum (buy_qty * buy_cost) as ���Աݾ��հ�
               
            from buyprod
            where extract(year from buy_date) = 2005
            group by rollup(extract(month from buy_date), substr(buy_prod, 1,4))
            order by 1;
            
    
    2)CUBE 
    -ROLLUP �� ���� ������, ������ ������ ROLLUP ���� �� �پ���
    -ROLLUP ���� �پ��� ������ ������ ��ȯ
    -CUBE ���� ����� �÷��� ���� n���� �� 2^n���� ������ ���踦 ��ȯ
    -������ ���� ����
    
    ��)kor_loan_status ���� ������, �⵵�� ���к� ����� �հ踦 ���Ͻÿ�
    (rollup���)
    select region as ������,
           substr(period,1,4) as �⵵,
           gubun as ����,
           sum(loan_jan_amt) as �����ܾ��հ�
        from kor_loan_status
     group by rollup(region, substr(period,1,4), gubun)
     order by 1;
     
     (cube ���)
    select region as ������,
           substr(period,1,4) as �⵵,
           gubun as ����,
           sum(loan_jan_amt) as �����ܾ��հ�
        from kor_loan_status
     group by cube(region, substr(period,1,4), gubun)
     order by 1;
    
    (�κ� rollup)
    select region as ������,
           substr(period,1,4) as �⵵,
           gubun as ����,
           sum(loan_jan_amt) as �����ܾ��հ�
        from kor_loan_status
     group by gubun, rollup(region, substr(period,1,4))
     order by 1;
    
          
           