%{
���ܣ������µ�GUI�����˻��µ����˻�֧�ֶ��֤ȯ��˾���ڻ���˾���ס����Զ�β�ѯ��ע���µ�ǰ�޸ļ۸����¼���Ƿ����
�������̣���1�����û���¼�Լ����˻�����Ʊ�˻����ڻ��˻��������ɵ�¼�ţ�logonID�����ɲ��������еĵ�¼������
         ��2�������б�������дGUI���еĵ�¼�ţ�LogonID������Ʊ���롢��������ί�м۸��ί��������
ע�⣬��¼���뽻��Ʒ��ƥ�䣬���Ʊ�����¼�ŵ��г�����Ϊ�Ϻ������ڹ�Ʊ�������������ڻ���¼���е��г�����Ϊ�ڽ������н���Ʒ��Ϊ�ڻ���
      �µ���ɹ��󣬽����ѯ״̬��ί�����ݲ����޸ġ�
      ������˶Ե�¼���Ƿ�����������˶�ί�е������Ƿ����,ί�������Ƿ�������û��Լ���ϸ��ˡ�
      ���򷵻ء��ѳɽ������Ǿ����̹�̨��ί�кŲ�ѯ�����
��1��  �����±�д     ��sdzhang@wind.com.cn��   2013��10��31��
%}
function Sample17
clc
%% ȫ�ֻ�����
clear global  GUI1 GUI2 Data OrderQuery Data4 N w
global GUI1 GUI2 Data OrderQuery Data4 N w
OrderQuery.Num=1;
w=windmatlab;
%
% �����ܽ���
        hTabFig = figure('Position', [100 200 760 400 ],...
            'Units', 'pixels',...
            'Toolbar', 'none',...
            'NumberTitle', 'off',...
            'Color', [0.3 0.7 0.3],...
            'Name', '���˻��µ�GUI',...
            'MenuBar', 'none',...
            'Resize', 'off',...
            'DockControls', 'off');
% �ֶ�        1                  2               3            4           5                 6            7            8                     9            10 
FieldName={'Wind LogonID',     '��Ʊ����',      '��������',  'ί�м۸�',     'ί������',     '�ѳɽ�����' ,'ӯ��' ,  '������Ϣ',          '�����',    'ί�к�'   ;};
Data={      '2',         '600276.SH',     'Buy ',      '31',       '100',         ''         ,''    ,  ' '       ,          NaN  ,       NaN      ;...
            '2',         '600267.SH',     'Buy',      '16',       '200',         ''         ,''    ,  ' '       ,          NaN  ,       NaN      ;...
           '2',         '600267.SH',     'Buy',       '16',       '200',         ''         ,''    ,  ' '       ,          NaN  ,       NaN      ;...
};
Data(4:20,1:end)={''};
%% �趨�µ��б�����
GUI1=uitable('Position', [5 150 750 250 ],...
            'Parent', hTabFig, ...
            'ColumnEditable', [true true true true true false],...
            'BackgroundColor', [0.9 0.7 0.7],...
            'ColumnName',FieldName(:,1:6),...
            'ColumnFormat', {'numeric', 'char','char', 'numeric', 'numeric','numeric'},...
            'Data',Data(:,1:6),...
            'RearrangeableColumns','on',...
            'ColumnWidth',{90 ,200 ,100 ,110, 100,100 },...
            'FontSize', 14);
%% �趨��ȷ���µ�����ť����
GUI2=uicontrol('Parent', hTabFig, ...
            'Position', [100 20 200 100], ...
            'String', 'ȷ���µ�', ...
            'callback', @Sample17_sub1,...
            'Style', 'pushbutton',...
            'HorizontalAlignment', 'center',...
            'BackgroundColor', [0.5 0.8 0.8],...
            'FontWeight', 'bold',...
            'FontSize', 15);       
%% �趨���˳�����ť����
GUI3=uicontrol('Parent', hTabFig, ...
            'Position', [370 20 200 100], ...
            'String', '�˳�', ...
            'callback', 'clear global  GUI1 GUI2 Data OrderQuery Data4 N;close(gcf)',...
            'Style', 'pushbutton',...
            'HorizontalAlignment', 'center',...
            'BackgroundColor', [0.5 0.8 0.8],...
            'FontWeight', 'bold',...
            'FontSize', 15);     

function Sample17_sub1(varargin)
%{
���ܣ����˻��µ����˻�֧�ֶ��֤ȯ��˾���ڻ���˾���ס�
�������̣���1�����û���¼�Լ����˻�����Ʊ�˻����ڻ��˻��������ɵ�¼�ţ�logonID�����ɲ��������еĵ�¼������
         ��2�������б�����
%}
global GUI1 GUI2 OrderQuery Data Data4 N w
set(GUI2,'BackgroundColor',[0.5 0.5 0.5]);
set(GUI2,'String','������');
if OrderQuery.Num==1    
       Data=get(GUI1,'Data');
       for i=1:size(Data,1);            
            if strcmp(Data{i,1},'')==1
            N(i)=logical(0); 
            else
            N(i)=logical(1);    
            end
        end        
        N=logical(N);
        % ����¼���Ƿ���ȷ        
        [dataLogID]=w.tquery('LogonID','LogonID',Data(N,1));
        for i =1:size(dataLogID,1)
        if double(dataLogID{i})<=0;errordlg('����½���Ƿ���ȷ','��½����');set(GUI2,'String', 'ȷ���µ�','BackgroundColor', [0.5 0.8 0.8]);return;end    
        end      
        Data4=w.torder(Data(N,2),Data(N,3),Data(N,4),Data(N,5), 'OrderType=LMT;HedgeType=SPEC','LogonID',Data(N,1));        
        if Data4{1}==-40530101;errordlg(Data4{end},'�µ�ʧ��');set(GUI2,'String', 'ȷ���µ�','BackgroundColor', [0.5 0.8 0.8]);;return;end    
        OrderQuery.Num=OrderQuery.Num+1;        
end
set(GUI1,'ColumnEditable', [false false false false  false]); 
[Data5,s1]=w.tquery('order','logonID',Data(N,1),'requestID',Data4(N,1));% ��ѯί�к�
[Data6,e]=w.tquery('Trade','logonID',Data(N,1),'OrderNumber',Data5(:,1));
t=1;
for i=1:size(Data,1);
if N(i)==1
    Data{i,6}=Data6{t,12};
    t=t+1;
end
end
set(GUI1,'Data',Data);
set(GUI2,'String','��ѯ�ɽ�');
set(GUI2,'BackgroundColor',[0.5 0.8 0.8]);














