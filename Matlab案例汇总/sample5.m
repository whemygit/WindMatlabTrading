% ���ܣ���ȡʵʱ�۸񡣵��û���GUI�������Ʊ���룬�����ȷ�����롱��ť���ù�Ʊ��ʵʱ�۸����ʾ�����������ֹͣ�������Ʊֹͣ���¼۸�
w= windmatlab;
[w_data1,w_codes,w_fields,w_times,w_errorid,w_reqid]=w.wsq('000005.SZ,000006.SZ,000007.SZ,000008.SZ','rt_time,rt_last,rt_bid1,rt_ask1,rt_vwap');
% ���У�rt_time,rt_last,rt_bid,rt_ask,rt_vwap�ֱ�Ϊʱ�䡢�ּۡ�����ۡ������ۡ��ɽ����ۡ�
%% ������һ�����ƹ�Ʊ�۸�ʵʱ�ؼ�ͼ��
global h3 data data1 cellFields 
data1=[];
w_reqid=0;
fields='rt_ask5,rt_ask4,rt_ask3,rt_ask2,rt_ask1,rt_last,rt_bid1,rt_bid2,rt_bid3,rt_bid4,rt_bid5';
cellFields=regexp(fields,'[,]','split');
h=figure('menubar','none','numberTitle','off','name','��Ʊʵʱ�۸�','position',[400 400 270 300]);
strpath1='str21=get(h2,''string'');w.cancelRequest(w_reqid);'
strpath2=['[~,~,~,~,~,w_reqid]=w.wsq(str21,'];
strpath3='''rt_ask5,rt_ask4,rt_ask3,rt_ask2,rt_ask1,rt_last,rt_bid1,rt_bid2,rt_bid3,rt_bid4,rt_bid5'',@Sample5_sub1);'
strpath=[strpath1,strpath2,strpath3];
h1=uicontrol('position',[20 260 70 30],'string','ȷ������','callback',strpath,'FontSize',10);
h2=uicontrol('style','edit','position',[95 260 78 30],'horizontal','left','string','600000.SH','FontSize',10);
h3=uicontrol('style','listbox','position',[20 20 220 230],'FontSize',12,'value',1,'string',[{'�÷�˵����'};{'�����Ʊ�����'};{'�����ȷ�����롱��'};{'�����ֹͣ���ж�ʵʱ����'}]); 
h4=uicontrol('position',[180 260 60 30],'string','ֹͣ','FontSize',10,'callback','  w.cancelRequest(w_reqid),clc') ;







