function Sample34
%{
���ƣ���ʱ������ģ�⽻������
���ܣ��������Ǵ���1����K�����룬С��1����K��������
���Է���Sample35_sub1.m�У����۸�仯ʱ�ͻ����Sample35_sub.m�����������źš�
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
secCode  =  'IF1403.CFE';
%% 1. ��¼��ָ�ڻ�ģ���˻�        
% �������û�����W0813165����ô�û��ź����02��W081316502�������ڻ�ģ���˺š�
%                 ������  Ӫҵ��  ���ʽ��˺� �ʽ�����  �˺����� 
WindID = inputdlg({'����Wind�˺�'},'',1,{''});
if length(WindID)==0;error('�����������˺�');end
[Data1]= w.tlogon('0000','0',[WindID{1},'02'],'123456', 'CFE');

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
uicontrol('Parent',RTMontor,'style','pushbutton','position',[330 10  80 20],'FontSize',12,'value',1,'string','�˳�','HorizontalAlignment','center','callback','close(gcf)'); 
%% 2. ������Ժ�������
global discQuery Sign RequestID parTrade Profit;
discQuery.t1       = 0;
discQuery.t2       = 0;
Sign.Buy           = 1;
Sign.Sell          = 0;
parTrade.signLong  = 1;
parTrade.signShort = 0;
parTrade.pause     = 5;
parTrade.Data      =  Data;
parTrade.LineDivision  = LineDivision;
parTrade.Data1         = Data1(:,1); 
parTrade.Timer         = now ;
Profit=0;
%% ���ö�ʱ����ÿ��1��������һ�β���
Timer1=timer('TimerFcn',{@Sample35_sub,secCode,parTrade,w},'period',1,'ExecutionMode','fixedspacing','ErrorFcn',{@Sample35_sub,secCode,parTrade,w});
start(Timer1);% ������ʱ��
function Sample35_sub(object,event,secCode,parTrade,w)
%{
���Իص�������Ϊ4������
A�����ղ���
B�����Բ���
C��ί�в�ѯ
D���ɽ��ر�
��1��  �����±�д     ��sdzhang@wind.com.cn��   2013��9��5��
%}
       %% 1. ���ղ���
        datas=w.wsq(secCode,'rt_last');
        global discQuery  Sign RequestID Profit;
        signLong  =  parTrade. signLong;
        signShort =  parTrade.signShort;
        pause     =  parTrade.    pause;
        Data      =  parTrade.     Data;
        Data1     =  parTrade.Data1(:,1); % ���ص�¼�� 
        Timer     =  parTrade.     Timer;
        t2.w3     =  datas;
        LineDivision  = parTrade.LineDivision;
       %% 2. ���Բ��� 
        MA_minte5     =  w.wsi(secCode,'EXPMA',now-3/24/60,now,'EXPMA_N=1');
        MA_minte5     =  MA_minte5(end); 
        if  datas>MA_minte5 && Sign.Buy==1
       %% 2.1 ����1��       
        [RequestID]   = w.torder(secCode, 'Buy', datas+10, 1, 'OrderType=LMT;HedgeType=SPEC','LogonID',Data1{1}) ;
        Sign.Buy      = 0;
        Sign.Sell     = 0;
        discQuery.t1  = now;
        elseif datas<MA_minte5 && Sign.Sell==1
       %% 2.2 ����1��
        [RequestID]   = w.torder(secCode, 'Sell', datas-10, 1, 'OrderType=LMT;HedgeType=SPEC','LogonID',Data1{1})  ;
        Sign.Buy      = 0;
        Sign.Sell     = 0;                    
        discQuery.t1  = now ;                  
        else
        end     
       %% 3. ��ѯί����ɽ�
        if   Sign.Buy==0&&Sign.Sell==0 && now-discQuery.t1>5*1/24/60/60     
            [Data4, we]=w.tquery('Order','LogonID',Data1{1},'RequestID',RequestID{1}) ;
            [Data14,we]=w.tquery('Trade','LogonID',Data1{1},'RequestID',RequestID{1},'OrderNumber',Data4(1)) ;
            if       strcmpi(Data14{3},'Normal')==1      &&  strcmpi(Data14{6},'Buy')==1 && Data14{11}==1  
            Sign.Sell=1;
            elseif   strcmpi(Data14{3},'Normal')==1      &&  strcmpi(Data14{6},'Sell')==1  && Data14{11}==1
            Sign.Buy=1;
            else 
           %% �������������������Ʊ���ױ���������Ҫ�ص���ؽ��棬Ȼ���������г���Ŀ���Ǳ������¼���     
            [Data5,Fields,ErrorCode]=w.tcancel(Data4{1}, 'LogonID',RequestID{1});  
            end           
        end  
       %% 5. ͳ�Ƴɽ�(5���Ӳ�ѯһ��)
        if  now-discQuery.t1>5*1/24/60/60            
        % �ɽ���� Wind���� ���׷���  �ɽ��۸� �ɽ�����        
        Data6=w.tquery('order', 'LogonId',Data1{1})  ;    
        if size(Data6,2)>=8
            datenum(Data6(:,8));
            N=find(datenum(Data6(:,8))>Timer);
            Data9=Data6(:,8);
            for i=1:size(Data6,1)   
            Data6{i,9}= sprintf('%6.2f\n',Data6{i,9}) ;
            Data9{i,1}= Data6{i,8}(12:end);
            end        
            Data7 = Data6(N,[3 4 5 9 7 8]);
            Data7(:,end)=Data9(N,:) ;          
                if length(N)>=8
                Data7 = Data7(end:-1:1,:) ;
                else
                numLength=length(N);
                Data7=[Data7(end:-1:1,:);Data(3:8-numLength,:)] ;
                end
            set(LineDivision,'data',Data7);    
        end
        discQuery.t2=now;
        end