%{
��1��    �����£�sdzhang@wind.com.cn��  2013��7��5��
���ܣ���ȡ���ݼ���
Ŀǰ���Զ�ȡ���ɷ֡�ָ���ɷֹɼ�Ȩ�ء�ETF����ɷ���Ϣ���ּ�������ϸ�����ʱ�ġ���ȯ��ġ�������ȯ����Ʒ���ع�����Ʒ��ͣ�ƹ�Ʊ���ֺ���ת�ȹ�Ʊ���ݡ�
%}
% ��ȡHS300�ɷֹ�ָ��������Ϊ2013��6��3�գ�Ϊ��Ȼ�ա�
choice = questdlg({'����������ʱ�����20����;','Ҫ����������?'},'������ʾ','����','������','����')
if strcmpi(choice,'������')==1,return;end

w=windmatlab
[w_wset_data,w_wset_codes,w_wset_fields,w_wset_times,w_wset_errorid,w_wset_reqid]=w.wset('IndexConstituent','date=20130603;windcode=000300.SH')
%%  ��ȡ����2��������ȯ���������ʽ���������ͳ�ơ�
% ����˵����
% %%�����ʱ�Ĵ���
% w_wset_data1    ���ʱ�Ĵ���
% w_wset_data2    ��ȯ��Ĵ���
% %%  �������ͳ��
% MarginBuy1;% ���������
% MarginBuy2;% ���ʳ�����
% MarginBuy3;% �������
% %%  ��ȯ���ͳ��
% MarginSell1;% ��ȯ������
% MarginSell2;% ��ȯ������
% MarginSell3;% ��ȯ����
% MarginSell4;% ��ȯ���
% %% ����Ʒ���ʽ�����ͳ��
% buyCash1;% �������ʽ�
% buyCash2;% ��������
% buyCash3;% ���������
% buyCash4;% �ʽ�����ռ��
% buyCash5;% β�̾������ʽ�
% buyCash6;% ���̾������ʽ�
% %% ��ȯƷ���ʽ�����ͳ��
% SellCash1;% �������ʽ�
% SellCash2;% ��������
% SellCash3;% ���������
% SellCash4;% �ʽ�����ռ��
% SellCash5;% β�̾������ʽ�
% SellCash6;% ���̾������ʽ�
%% 0. Ŀ¼
clear
w=windmatlab;
% ��ʼʱ�������ʱ��
BeginDay = '2013-10-01'
EndDay   = '2013-11-19'
%% 1. ���ʱ��ͳ��
%% 1.1 ��ȡ���ʱ��
% ��ȡ���ʱ��
[w_wset_data1]=w.wset('MarginTradingUnderlying','date=20131001');
%% 1.2 ���ʱ�����ͳ��
MarginBuy1=[];% ���������
MarginBuy2=[];% ���ʳ�����
MarginBuy3=[];% �������
for i=1:length(w_wset_data1)
data=w.wsd(w_wset_data1{i,2},'mrg_long_amt,mrg_long_repay,mrg_long_bal',BeginDay,EndDay);
if iscell(data)==1&&isnan(data{1})==1;data=cell2mat(data);end
MarginBuy1=[MarginBuy1,data(:,1)];  
MarginBuy2=[MarginBuy2,data(:,2)];  
MarginBuy3=[MarginBuy3,data(:,3)];  
end
%% 1.3 ���ʱ���ʽ�����ͳ��
buyCash1=[];% �������ʽ�
buyCash2=[];% ��������
buyCash3=[];% ���������
buyCash4=[];% �ʽ�����ռ��
buyCash5=[];% β�̾������ʽ�
buyCash6=[];% ���̾������ʽ�
for i=1:length(w_wset_data1)
data=w.wsd(w_wset_data1{i,2},'mf_amt,mf_vol,mf_amt_ratio,mf_vol_ratio,mf_amt_close,mf_amt_open',BeginDay,EndDay);
if iscell(data)==1&&isnan(data{1})==1;data=cell2mat(data);end
buyCash1=[buyCash1,data(:,1)];  
buyCash2=[buyCash1,data(:,2)]; 
buyCash3=[buyCash1,data(:,3)]; 
buyCash4=[buyCash1,data(:,4)]; 
buyCash5=[buyCash1,data(:,5)]; 
buyCash6=[buyCash1,data(:,6)]; 
end
%% 2. ��ȯ���ͳ��

%% 2.1 ��ȡ��ȯ���
[w_wset_data2]=w.wset('ShortSellingUnderlying','date=20130530');
%% 2.2 ��ȯ������ͳ��
MarginSell1=[];% ��ȯ������
MarginSell2=[];% ��ȯ������
MarginSell3=[];% ��ȯ����
MarginSell4=[];% ��ȯ���
for i=1:length(w_wset_data2)
data=w.wsd(w_wset_data2{i,2},'mrg_short_vol,mrg_short_vol_repay,mrg_short_vol_bal,mrg_short_bal,',BeginDay,EndDay);
if iscell(data)==1&&isnan(data{1})==1;data=cell2mat(data);end 
MarginSell1=[MarginSell1,data(:,1)];
MarginSell2=[MarginSell2,data(:,2)];
MarginSell3=[MarginSell3,data(:,3)];
MarginSell4=[MarginSell4,data(:,4)];  
end
%% 2.3 ��ȯ����ʽ�����ͳ��
SellCash1=[];% �������ʽ�
SellCash2=[];% ��������
SellCash3=[];% ���������
SellCash4=[];% �ʽ�����ռ��
SellCash5=[];% β�̾������ʽ�
SellCash6=[];% ���̾������ʽ�
for i=1:length(w_wset_data2)
data=w.wsd(w_wset_data2{i,2},'mf_amt,mf_vol,mf_amt_ratio,mf_vol_ratio,mf_amt_close,mf_amt_open',BeginDay,EndDay);
if iscell(data)==1&&isnan(data{1})==1;data=cell2mat(data);end    ;
SellCash1=[SellCash1,data(:,1)];  
SellCash2=[SellCash1,data(:,2)]; 
SellCash3=[SellCash1,data(:,3)]; 
SellCash4=[SellCash1,data(:,4)]; 
SellCash5=[SellCash1,data(:,5)]; 
SellCash6=[SellCash1,data(:,6)]; 
end

















