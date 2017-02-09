%{
���ܣ�����300ָ��������ģ����ʱ���ԡ�
Fama����������ΪӰ��ɼ���Ҫȡ��������3�����ӡ�
A���г����������ʣ�RMT��
B����ģ���ӣ�SMB��
C��������ֵ�ȣ�HML��
������Ŀ���Ǹ���Fama������ģ�͹�������С�̷���ֶ����ԡ�
��1��  �����±�д��sdzhang@wind.com.cn��   2013��9��5��
�ο���
����������̩����֤ȯ�ɷ����޹�˾��������ѡ��ģ��֮���ӷ�����ɸѡ��:��ֵ�����ɳ���ָ�ꡪ���������о�ϵ��֮ʮ�ߡ�
%}


clc;clear;
w=windmatlab
%% 1.������������
% ʱ������Ϊ2013��1��1����2013��6��1��
BeginDate  = '2013-06-01';
EndDate    = '2013-09-12';
%% 1.����׼��
%% 1.1  ָ֤������
close_index_000001_SH=w.wsd('000300.SH','close',BeginDate,EndDate);
%% 1.2  ���м�1��ع����ʣ�R001.IB
rf_R001_IB=w.wsd('R001.IB','close',BeginDate,EndDate,'Fill=Previous');
%% 1.3  ȡ�û���300�ɷֹɴ���
IndexConstituent_000300_SH=w.wset('IndexConstituent','date=20130912;windcode=000300.SH');
%% 1.4  ��ȡ���̼ۣ�Close��������ͨ�ɣ�free_float_shares��������ֵ(mkt_cap)
for i=1:size(IndexConstituent_000300_SH,1)
Data              =  w.wsd(IndexConstituent_000300_SH(i,2),'close,free_float_shares,mkt_cap',BeginDate,EndDate,'Fill=Previous');
daily.close(:,i)  =  Data(:,1);
daily.free_float_shares(:,i)  =  Data(:,2);
daily.mkt_cap(:,i)            =  Data(:,3);
end
daily.free_float_shares=daily.free_float_shares';
%% 1.5   ��ȡ�б��ɶ�Ȩ��(������)
ShareholdersRight =  w.wss(IndexConstituent_000300_SH(:,2),'tot_equity','rptDate=20130630','rptType=1');
%% 2.  ���ݼӹ�
%% 2.1 �����Ʊ����������
ret_close=price2ret(daily.close);
%% 2.2 �����г�����������
ret_close_index_000001_SH=price2ret(close_index_000001_SH);
market_Premium=ret_close_index_000001_SH-log(1+rf_R001_IB(2:end)/100)/252;
%% 2.2 �������˱�
HML=daily.mkt_cap'./repmat(ShareholdersRight,1,71);
%% 2.3 �����ģ
% ���ڸ��ɹ�ģ�������ϴ�������1��ʾС����ͨ��ֵ��2��ʾ�����ͨ��ֵ��
% ������ͨ�ɴ���Ϊ1��С��Ϊ-1��
free_float_shares=daily.free_float_shares;
free_float_shares(free_float_shares<=8.2538e+08)=1;
free_float_shares(free_float_shares> 8.2538e+08)=2;
%% 2.2 ��ÿ�����������ع�(����ȱʡֵ�Ļع���ecmmvnrmle)��
Par=[];
for i=1:70
x=[free_float_shares(:,i+1),HML(:,i+1)];
y=ret_close(i,:)'-ones(300,1)*market_Premium(i);
a= ecmmvnrmle(y,x);
Par=[Par;a'];
end
%% 3. ϵ�����Իع�
AutoOPar1=parcorr(Par(:,1));
AutoOPar2=parcorr(Par(:,2));
%% ����ѡ�ɹ���
% A�����a(1)>0ʱ,����ѡ����̹ɡ����a(1)<0ʱ������ѡ��С�̹ɡ�
%% 3.1 �ز⡣
ret_close1=ret_close';
for i=3:71
N=free_float_shares(:,i-1)==2 ;  
if Par(i-1,1)>0   
   ret_backTest(i-2)=mean(ret_close1(N,i-1));
else
   ret_backTest(i-2)=mean(ret_close1(~N,i-1)) ;   
end   
end
%% 3.2 �����ۼ�������
ret_backTest=cumsum(ret_backTest);
ret_HS300=log([close_index_000001_SH(3:end)/close_index_000001_SH(2)]);
plot([ret_backTest',ret_HS300],'LineWidth',4);
legend('����С��ѡ�����','����300');
title('����С����ʱ����뻦��300ָ�����ƶԱ�');













