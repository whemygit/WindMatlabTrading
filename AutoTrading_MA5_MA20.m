%{
���ܣ����ݹɼ���������MA5����MA20���룬С��MA20������������
���Է���Minte3_MA5_MA20.m�С����۸�仯ʱ�ͻ����Minte3_MA5_MA20.m�����������źš�
�û�ֻ����ָ���ڻ�Ʒ�ֿ���ʱ���д˳���
��������Ϊ����4�����֣�
A��׼������
B����¼ģ���˻���ѡ������Ʒ��
C�����������ˮģ��
D���趨������Բ���
���Իص�������Ϊ4������
A�����ղ���
B�����Բ���
C��ί�в�ѯ
D���ɽ��ر�������ˮģ��
%% ������������ɽ��򳷵������ױ�����������ɽ�����еġ��˳�����ť�������������ס�
%}
%% 1 ǰ��׼������
% �����ڵ�
clear all;
clc;
clear global;
% ���ù���·��
cd F:\git\WindMatlabTrading
% ����windmatlab����
w=windmatlab;

%% 2 ��¼windģ���˻���ѡ���Լ��Ŀǰ�ݶ�ֻ��ѡ����������Լ,SHF��
% ��¼wind�˻�
% �������û�����W84394005����ô�û��ź����02��W8439400502�������ڻ�ģ���˺š�
WindID = inputdlg({'����Wind�˺�'},'',1,{''});        % wind��¼��
if length(WindID)==0;error('�����������˺�');end
WindPWD = inputdlg({'����Wind�ʽ��˺ŵ�¼����'},'',1,{''});  % �ʽ��˺�����
if length(WindPWD)==0;error('�������');end
[Data1]= w.tlogon('0000','0',[WindID{1},'02'],WindPWD, 'SHF');     % ��¼��tlogon
                                                                   % ���������������,Ӫҵ��,���ʽ��˺�,�ʽ�����,�˺�����
                                                                   % ���������'LogonID','LogonAccount','AccountType','ErrorCode'��0��ʾ������,'ErrorMsg'.
                                                                   % ��[1]    'W8439400502'    'SHF'    [0]    ''
if Data1{1}<0;errordlg('�ʽ��˺Ŵ���,��ȷ���Ƿ�ͨ��������Ȩ�ޡ�');assert('');end   % �鿴��¼��Data1{1}�����С��0��ʾ�ʽ��ʺŴ���

% ѡ���Լ
windcode={'CU1702.SHF','CU1703.SHF','CU1704.SHF','CU1705.SHF','CU1706.SHF'};     % ��ѡ��wind���룬�����������
[s,v] = listdlg('PromptString','��ѡ��Ҫ���׵��ڻ�Ʒ��:','SelectionMode','single',...
                      'ListString',windcode);                                    % �б�Ի���ѡ��ɽ��׵�Ʒ�ִ���
secCode=windcode(s);                                                             % ѡ���Ľ���Ʒ�ִ���
%�жϴ����Ƿ���Ч
choice = questdlg(strcat('����ȷ�ϴ�����secCode:',secCode,' �Ƿ��ǵ�ǰ��Ч�Ĺ�ָ�ڻ���Լ��������ǣ����޸ĺ������У�'),'������ʾ','��������','������','��������')
if strcmpi(choice,'������')==1,return;end

%% 3 �������ģ��
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
uicontrol('Parent',RTMontor,'style','pushbutton','position',[330 10  80 20],'FontSize',12,'value',1,...
    'string','�˳�','HorizontalAlignment','center','callback','w.cancelRequest(0);close(gcf)'); 

%% 4 ������Ժ�������
global discQuery Sign RequestID;
discQuery.t1       = 0;
discQuery.t2       = 0;
Sign.Buy           = 1;    % �������źš���ʼֵΪ1 ��������������������
Sign.Sell          = 1;    % �������źš���ʼֵΪ1
parTrade.signLong  = 1;
parTrade.signShort = 0;
parTrade.pause     = 5;
parTrade.w         = w;
parTrade.Data      =  Data; 
parTrade.LineDivision  = LineDivision;
parTrade.Data1         = Data1(:,1);  % �Զ����ɵĵ�¼�ţ���Ԫ���飬��[1]
parTrade.Timer         = now;
w.wsq(secCode,'rt_last',@Minte3_MA5_MA20,parTrade); % ��wsq��������secCode��ʵʱ�������ݣ�������Minte3_MA5_MA20�������ź�ʱִ��wsq,��ȡ�ּۡ�rt_last��ָ��

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
