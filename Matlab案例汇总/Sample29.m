%% R-Breaker���ڣ��Ǹ�Ƶ�����ײ���
%{
 ��1��    �����£�sdzhang@wind.com.cn��  2013��7��5��
R-Breaker�Ǹ�����ľ��г��������ڵ�����ģ�ͣ���14������Future Trust��־���ǰ10��׬Ǯ�Ĳ��ԡ� 
�ò��԰���ͻ���뷴ת���ֲ��ԣ�
��Ҫ��˼�룺
����ǰһ�������յ����̼ۡ���߼ۺ���ͼ�����ͨ��һ����ʽ�����������λ���Ӵ�С����Ϊ��
�۲�������(Ssetup):���+0.35*(����-���);           //ssetup
��ת������(Senter):(1.07/2)*(���+���)-0.07*���;  //senter
��ת�����(Benter):(1.07/2)*(���+���)-0.07*���;  //benter
�۲������(Bsetup):���-0.35*(���-����);           //bsetup
ͻ������ۣ�Bbreak):(�۲�������+0.25*(�۲�������-�۲������)); //bbreeak
ͻ��������(Sbreak):�۲������-0.25*(�۲�������-�۲������);    //sbreak
��ת����:
�ֶ൥����������߼۳����۲�������(Ssetup)�����м۸���ֻ��䣬�ҽ�һ�����Ʒ�ת�����ۣ�Senter�����ɵ�֧����ʱ����ȡ��ת���ԣ����ڸõ�λ�������գ�
�ֿյ�����������ͼ۵��ڹ۲������(Bsetup�������м۸���ַ������ҽ�һ��������ת�����(Benter)���ɵ�������ʱ����ȡ��ת���ԣ����ڸõ�λ�������ࣻ
ͻ�Ʋ���:
�ڿղֵ�����£�������м۸񳬹�ͻ������ۣ����ȡ���Ʋ��ԣ����ڸõ�λ�������ࣻ
�ڿղֵ�����£�������м۸����ͻ�������ۣ����ȡ���Ʋ��ԣ����ڸõ�λ�������գ�
������Դ
1��http://www.yafco.com/show.php?contentid=261740
%}
clc
clear
w=windmatlab
% ���ɣ�M1309.DCE����Ϊ��ġ�
strStockList='M1309.DCE';
[w_wsd_data]=w.wsd(strStockList,'open,high,low,close','2013-04-11','2013-04-11');
Open=w_wsd_data(1);
High=w_wsd_data(2);
Low=w_wsd_data(3);
Close=w_wsd_data(4);
%% ��ȡ4��12�յķ��Ӽ۸�
[iPrice]=w.wsi(strStockList,'high,low,close','2013-04-12 09:00:00','2013-04-12  15:30:00 ','barsize','1');
%% �����6����λ��
Bsetup=Low-0.35*(High-Close);              % �۲������
Ssetup=High+0.35*(Close-Low);              % �۲�������
Benter=(1.07/2)*(High+Low)-0.07*High;      % ��ת�����
Senter=(1.07/2)*(High+Low)-0.07*Low;       % ��ת������
Bbreak=Ssetup+0.25*(Ssetup-Bsetup);        % ͻ�������
Sbreak=Bsetup-0.25*(Ssetup-Bsetup);        % ͻ��������
%% ���Գ�ֵ
holding=0;     % 1��ʾ���࣬-1��ʾ���գ�0��ʾû�в�����
hi=iPrice(1,1);
lo=iPrice(1,2);
con_3=0;
con_4=0;
for i=1:size(iPrice,1)
hi=max(iPrice(i,1),hi);
lo=min(iPrice(i,2),lo);
c=iPrice(i,3) ; 
con_1=c>Bbreak && sum(holding)==0;  % �ղ�����
con_2=c<Sbreak && sum(holding)==0;  % �ղ�����    
if hi>Ssetup ;con_3==1;end        
if lo<Bsetup ;con_4==1;end        
%% ����
if con_3==1      &&  sum(holding)==1&& c<Senter      % �൥��ת
    holding(i,1)=-1;    
elseif con_2==1                                      % �ղֿ��� 
    holding(i,1)=-1;        
elseif con_4==1  && sum(holding)==-1  && c>Benter    % �յ���ת 
    holding(i,1)=1;         
elseif  con_1==1                                     % �ղ����� 
    holding(i,1)=1;     
else
    holding(i,1)=0;
end
end
%% β����ƽ
if sum(holding)==1&&holding(end)==1
holding(end)=0;
elseif sum(holding)==1
holding(end)=-1;
elseif sum(holding)==-1 && holding(end)==-1
holding(end)=0;
elseif sum(holding)==-1
holding(end)=1;
else
end
%% ͳ�Ʋ���ʾ����
disp('R-Break��������')
Return=nansum(iPrice(:,3).*holding)





