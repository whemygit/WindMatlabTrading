function Sample5_sub1(reqid,isfinished,errorid,datas,codes,fields,times,selfdata)
%��������������ʾ�û��Զ���ص���������׫д��ʽ

global cellFields data1 h3
fields=lower(fields);
cellFIelds=lower(cellFields);
[ia,ib]=ismember(fields,cellFields);
data1(ib)=datas;
global str1 h3 
str1{1}=['��5�ۣ�  ' ,num2str(data1(1))];     
str1{2}=['��4�ۣ�  ' ,num2str(data1(2))];       
str1{3}=['��3�ۣ�  ' ,num2str(data1(3))];       
str1{4}=['��2�ۣ�  ' ,num2str(data1(4))];      
str1{5}=['��1�ۣ�  ' ,num2str(data1(5))];      
str1{6}=['�ɽ��ۣ�' ,num2str(data1(6))];     
str1{7}=['��1�ۣ�  ' ,num2str(data1(7))];  
str1{8}=['��2�ۣ�  ' ,num2str(data1(8))];     
str1{9}=['��3�ۣ�  ' ,num2str(data1(9))];    
str1{10}=['��4�ۣ� ' ,num2str(data1(10))];      
str1{11}=['��5�ۣ� ' ,num2str(data1(11))];   
str1=str1(:);
set(h3,'string',str1);
      
