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
w        =  windmatlab;            % ����windmatlab����w
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% �˲��ֿ��޸�Ϊ�Ի�������
secCode  =  'IF1702.CFE';          % Ҫ���н��׵ġ���Լ���롿secCode
%�жϲ����Ƿ���Ч
choice = questdlg(strcat('����ȷ�ϴ�����secCode:',secCode,' �Ƿ��ǵ�ǰ��Ч�Ĺ�ָ�ڻ���Լ��������ǣ����޸ĺ������У�'),'������ʾ','��������','������','��������')  %��������Ч������Ի���...
%����Ի������Ϊ��������ʾ������ʾ����Ϊ'����ȷ�ϴ�����secCode:',secCode,'
%�Ƿ��ǵ�ǰ��Ч�Ĺ�ָ�ڻ���Լ��������ǣ����޸ĺ������У�'��������ť��'��������'��'������'������'��������'Ĭ������Ϊ��ʶ״̬��
if strcmpi(choice,'������')==1,return;end   % if�������ú�Լ����������������·��أ�������ֹ��

% ���Գ�ʼ�����������w��secCode��

%% 1. ��¼��ָ�ڻ�ģ���˻�        
% �������û�����W0813165����ô�û��ź����02��W081316502�������ڻ�ģ���˺š�
%                 ������  Ӫҵ��  ���ʽ��˺� �ʽ�����  �˺����� 
WindID = inputdlg({'����Wind�˺�'},'',1,{''});  % ͨ������Ի������룬�����wind��¼�˺š�WindID��WindIDΪһ��һ��һ�еĵ�Ԫ���飬ֵΪ�����wind��¼�˺�
if length(WindID)==0;error('�����������˺�');end  % ��һ��δ���룬����������wind�˺�
[Data1]= w.tlogon('0000','0',[WindID{1},'02'],'29177624', 'CFE');  % ͨ��wind�Դ�������tlogon����¼wind�����һ��һ�����еĵ�Ԫ���顾Data1����ÿ��ֵ�ֱ�Ϊ��1���Զ����ɵ�...
% ��¼��LogonID����[1],[2];��2����¼�˻�LogonAccount,��'W8439400502';��3���˻�����AccountType����CFE;(4)���صĴ����ErrorCode...
% 0��ʾ���в������ԣ�������ʾ�д�;(5)������ϢErrorMsg����Invalid arguments��
% tlogon�������У���¼�˺�Ϊ�ַ�����WindID{1}Ϊ�ַ���'W84394005'��[WindID{1},'02']Ϊ�ַ���'W8439400502'.
% tlogon����һ����ʽ[Data,Fields,ErrorCode] = tlogon(w,BrokerID, DepartmentID, LogonAccount, Password, AccountType, varargin)
 % �������
      %  BrokerID        �����̴���.ģ���˺�Ϊ0000
      %  DepartmentID    Ӫҵ������(�ڻ���¼��д0)
      %  LogonAccount    �ʽ��˺�
      %  Password        �˺�����
      %  AccountType     �˺�����: �����Ϻ�A ��11��SH��SZ��SHSZ; ����B��12 �� SZB;�Ϻ�B��13��SHB;֣������14��CZC
                        % ��������15��SHF;��������16��DCE; �н�����17��CFE
      %  varargin        ������ѡ�����������@wsqcallback��ʾί��/�ɽ��ر�
 % �������
      %  Data            ���ص���������,Ϊһ��cell���������Ϊ����źʹ�����Ϣ��
      %  Fields          ���ص����������ж�Ӧ�Ľ���.
      %  ErrorCode       ���صĴ���ţ�0��ʾ���в������ԣ�������ʾ�д����Ը���Data��λ������� .  

if Data1{1}<0;errordlg('�ʽ��˺Ŵ���,��ȷ���Ƿ�ͨ��������Ȩ�ޡ�');assert('');end   % �鿴��¼��Data1{1}�����С��0��ʾ�ʽ��ʺŴ���
%%
%% 3. �������ģ��
RTMontor= figure('position',[300 500 810 250],...
  'Name','��ָ�ڻ�ģ���˻��ɽ����',...
  'NumberTitle','off', ...
  'Menubar','none',...
  'Toolbar','none');                  % ����ͼ�δ��ڶ���RTMontor                  
ColumnName={'����','����','��������','�ɽ��۸�','�ɽ�����','ʱ��'};
Data      ={'','','','','',''};
Data=repmat(Data,8,1);             % 8��6�еĿյĵ�Ԫ����Data
foregroundColor = [1 1 1];
backgroundColor = [.4 .1 .1; .1 .1 .4];
LineDivision=uitable('Parent',RTMontor,...
  'Position', [25 40 800 200],...
  'ColumnName',ColumnName,...
  'ColumnWidth',{180 100 100 100 100 100},...
  'FontSize',12,...
  'ForegroundColor', foregroundColor,...
  'BackgroundColor', backgroundColor,...
  'Data',Data);          % ������LineDivision
set(LineDivision,'ColumnWidth',{180 100 100 140 140});
uicontrol('Parent',RTMontor,'style','pushbutton','position',[330 10  80 20],...
    'FontSize',12,'value',1,'string','�˳�','HorizontalAlignment','center','callback','w.cancelRequest(0);close(gcf)'); 
%% 2. ������Ժ�������
global discQuery Sign RequestID;
discQuery.t1       = 0;
discQuery.t2       = 0;
Sign.Buy           = 1;    % �������źš���ʼֵΪ1
%%%%%%%%%%�źų�ʼֵ�����ã����źŵı仯
Sign.Sell          = 0;    % �������źš���ʼֵΪ0
parTrade.signLong  = 1;
parTrade.signShort = 0;
parTrade.pause     = 5;
parTrade.w         = w;
parTrade.Data      =  Data; 
parTrade.LineDivision  = LineDivision;
parTrade.Data1         = Data1(:,1);  % �Զ����ɵĵ�¼�ţ���Ԫ���飬��[1]
parTrade.Timer         = now ;
w.wsq(secCode,'rt_last',@Sample16_sub1,parTrade); % ��wsq��������secCode��ʵʱ�������ݣ���ȡָ��Ϊ�ּۡ�rt_last��,��ʵʱָ�괥��ʱִ��Sample16_sub1����
% wsq����˵��
  %  һ��������ʵʱ�������ݣ�
  %  [data,codes,fields,times,errorid] = w.wsq(windcodes,windfields)
  %  ����ʵʱ�������ݣ�
  %  [~,~,~,~,errorid,reqid] = w.wsq(windcodes,windfields,callback,userdata)
  %  ����callbackΪ�ص�����������ָ��ʵʱָ�괥��ʱִ����Ӧ�Ļص�����.
      %  userdataΪ���ݸ��ص��������û��Լ�������  
  %  Description��
      %   w              ������windmatlab����
      %   windcodes      Wind���룬��ʽΪ'600000.SH',��������֧�ֶ�Ʒ��.
      %   windfields     ��ȡָ�꣬��ʽΪ'rt_last_vol,rt_ask1,rt_asize1'.
      %   callback       �ص�����,ͨ���ص��������ղ��ϴ��ݻ�����ʵʱ����
     
      %   data         ���ص����ݽ��.
      %   codes          �������ݶ�Ӧ�Ĵ���.
      %   fields         �������ݶ�Ӧ��ָ��.
      %   times          �������ݶ�Ӧ��ʱ��.
      %   errorid        �������еĴ���ID.
      %   reqid          �ڶ���ʱΪ����id������ȡ�����ĵ�
    
