%{
���ܣ��ص�������ʾʵʱ����5������
��1��    ������  2013��8��5��
%}
clear global data1 cellFields cellList cellData H2
clear
global data1 cellFields cellList cellData H2
strlist='HSI4C22000.HK,600267.SH';
cellList=regexp(strlist,'[,]','split');
cellList=cellList(:);
w= windmatlab;
strFields='rt_ask5,rt_ask4,rt_ask3,rt_ask2,rt_ask1,rt_last,rt_bid1,rt_bid2,rt_bid3,rt_bid4,rt_bid5,rt_asize5,rt_asize4,rt_asize3,rt_asize2,rt_asize1,rt_last_vol,rt_bsize1,rt_bsize2,rt_bsize3,rt_bsize4,rt_bsize5';
cellFields=regexp(strFields,'[,]','split');
cellFields=cellFields(:);
data1=nan(22,2);
RowName={'��5��','��4��','��3��','��2��','��1��','�ּ�','��1��','��2��','��3��','��4��','��5��'};
ColumName={'','600276.SH','�ҵ�','600267.SH','�ҵ�'};
cellData={};
cellData(2:12,1)=RowName(1 :11)';
cellData(2:12,[2 3 4 5])=num2cell(nan(11,4));
cellData(1,:)=ColumName;
[ss,~,~,~,~,w_reqid]=w.wsq(strlist,strFields,@Sample21_sub1);
H1=figure('position',[200 200 880 410],'name','�ص�������ʾ����5������','NumberTitle','off');
H2=uitable('parent',H1,'position',[10 10 870 400],'data',cellData,'fontsize',15,'ColumnWidth',{200  150  150  150  150});
backgroundColor = [1.00 1.00 1.00; .9 .9 .9];
set(H2, 'BackgroundColor', backgroundColor);









