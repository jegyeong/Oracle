2019-01-02 01)���ں�ȯ�Լ�

    1)to_number
        - ���ڷ� ��ȯ ������ ���ڿ��� ������ �ڷ�� ��ȯ
        (�������)
        to_number(c1 [,fm])
         - 'fmt'�� to_char�� ���� ��ȯ ���ڿ��� ����
         - 'c1'�� ���ں�ȯ ������ ���ڿ�
         
         ��)
         select to_number('1234','9,999'),
                to_number(sysdate),
                to_number('p101')
            from dual; --����.. ��ȯ �Ұ����Ѱ��� ��ȯ�Ϸ��� �õ��߱� ������
        
        select to_number('1234','9999') --(,)�� ���� ���� �Ұ����� ���ڰ� �Ǿ����~~~
--                to_number(sysdate),
--                to_number('p101')
            from dual;
            
        select substr(cart_no, 5, 4) from cart; --substr�� ���°� ���ڿ�> ���ڿ��������ٰ� �ص� ���ڿ� ��������> ����!
        select to_number(substr(cart_no, 5, 4)) from cart; --���������� > ����! 
        select to_char(substr(cart_no, 5, 4), 'mmdd') from cart; --������, �ϴ� ��¥������ �ٲ������
        select to_date(substr(cart_no, 5, 4), 'mmdd') from cart; --�������� ���̳����ϱ� ���� ¥���� ���ؼ� to_char �ٿ�����
        select to_char(to_date(substr(cart_no, 5, 4), 'mmdd'),'mm"��" dd"��"') from cart; --��¥�ϱ� to_char �ٿ��� �� �־�
        --to_char �� �Ҷ� ���ڿ��� ���ڿ��� ��ȯ�Ҷ� �����ؾ���! �׻� �Ǵ°� �ƴϰ� �Ǵ°� �ֱ� ������ �� �� �ܰ� �� ���ľ� �� ���� �־�
        --���ڿ� ��ü�� ������ ��¥ Ÿ������ �ٷ� �ȵ� ��¥> ���� ����> �� �� ���̱� ! �̰Ÿ� ������� �ؾ���! �ƴ� �ȵ�!
        
    2)to_date
        -��¥������ �������� date ������ ��ȯ
        ( �������)
        to_date(c1, [,fmt])
        - c1�� ��¥�� ��ȯ ������ ���ڿ�
        - 'fmt'�� to_char �Լ��� ��¥��ȯ ���ڿ��� ����
        
        ��)
        select to_date('20200131') 
--               to_date(20200131),
--               to_date(20201131)
            from dual;
            
        select to_date('20200131'),
               to_date('20200131', 'yyyy/mm/dd'),
               to_date(20200131, 'yyyymmddhh24miss') --���� ��ȯ �ȵŤФ�to char�� ��ȯ�������
--               to_date(20200131),
--               to_date(20201131)
            from dual;
        
            select to_date('20200131'),
               to_date('20200131', 'yyyy/mm/dd'),
               to_char(to_date(20200131, 'yyyymmddhh24miss'),'yyyy/mm/ddhh24:mi:ss') --���� ��ȯ �ȵŤФ�to char�� ��ȯ�������
--               to_date(20200131),
--               to_date(20201131)
            from dual;
            
          select to_date('20200131'),
               to_date('20200131', 'yyyy/mm/dd'),
               to_char(to_date(20200131, 'yyyymmddhh24miss'),'yyyy/mm/ddhh24:mi:ss) --���� ��ȯ �ȵŤФ�to char�� ��ȯ�������
--               to_date(20200131),
--               to_date(20201131)
            from dual;
         