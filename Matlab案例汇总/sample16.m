%{
���ܣ����ݹɼ۴���5���������룬С��5������������
���Է���Sample16_sub1.m�С����۸�仯ʱ�ͻ����Sample16_sub1.m�����������źš�
�û����ڹ�ָ�ڻ�����ʱ���г���
��������Ϊ����2������
A����¼ģ���˻�
B�����������ˮģ��
C���趨������Բ���
���Իص�������Ϊ4������
A�����ղ���
B�����Բ���
C��ί�в�ѯ
D���ɽ��ر�������ˮģ��
%% ������������ɽ��򳷵�����Ʊ���ױ���������Ҫ�ص���ؽ��棬Ȼ���������г���Ŀ���Ǳ������¼��� 
%% ����ɽ�����еġ��˳�����ť�������������ס�
��1��  �����±�д     ��sdzhang@wind.com.cn��   2013��9��5��
%}
clc;clear
clear global
%% ���Գ�ʼ������
w        =  windmatlab;
secCode  =  'CU1706.SHF';
%�жϲ����Ƿ���Ч
choice = questdlg(strcat('����ȷ�ϴ�����secCode:',secCode,' �Ƿ��ǵ�ǰ��Ч�Ĺ�ָ�ڻ���Լ��������ǣ����޸ĺ������У�'),'������ʾ','��������','������','��������')
if strcmpi(choice,'������')==1,return;end
%% 1. ��¼��ָ�ڻ�ģ���˻�        
% �������û�����W0813165����ô�û��ź����02��W081316502�������ڻ�ģ���˺š�
%                 ������  Ӫҵ��  ���ʽ��˺� �ʽ�����  �˺����� 
WindID = inputdlg({'����Wind�˺�'},'',1,{''});
if length(WindID)==0;error('�����������˺�');end
[Data1]= w.tlogon('0000','0',[WindID{1},'02'],'29177624', 'SHF');

if Data1{1}<0;errordlg('�ʽ��˺Ŵ���,��ȷ���Ƿ�ͨ��������Ȩ�ޡ�');assert('');end
%%
%% 3. �������ģ��
RTMontor= figure('position',[300 500 810 250],...
  'Name','��ָ�ڻ�ģ���˻��ɽ����',...
  'NumberTitle','off', ...
  'Menubar','none',...
  'Toolbar','none');
ColumnName={'����','����','��������','�ɽ��۸�','�ɽ�����','ʱ��'};
Data      ={'','','','','',''};
Data=repmat(Data,8,1);
foregroundColor = [1 1 1];
backgroundColor = [.4 .1 .1; .1 .1 .4];
LineDivision=uitable('Parent',RTMontor,...
  'Position', [25 40 800 200],...
  'ColumnName',ColumnName,...
  'ColumnWidth',{180 100 100 100 100 100},...
  'FontSize',12,...
  'ForegroundColor', foregroundColor,...
  'BackgroundColor', backgroundColor,...
  'Data',Data);
set(LineDivision,'ColumnWidth',{180 100 100 140 140});
uicontrol('Parent',RTMontor,'style','pushbutton',...
    'position',[330 10  80 20],'FontSize',12,'value',1,'string','�˳�','HorizontalAlignment','center','callback','w.cancelRequest(0);close(gcf)'); 
%% 2. ������Ժ�������
global discQuery Sign RequestID;
discQuery.t1       = 0;
discQuery.t2       = 0;
Sign.Buy           = 1;
Sign.Sell          = 0;
parTrade.signLong  = 1;
parTrade.signShort = 0;
parTrade.pause     = 5;
parTrade.w         = w;
parTrade.Data      =  Data;
parTrade.LineDivision  = LineDivision;
parTrade.Data1         = Data1(:,1); 
parTrade.Timer         = now ;
w.wsq(secCode,'rt_last',@Sample16_sub1,parTrade);
