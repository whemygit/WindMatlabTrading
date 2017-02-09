%{
%  ���ܣ������ʲ������Чǰ�ء�
%  ���ݣ�
        A����ȡ���а���Ʊ�۸�
        B�������ʲ���ϵ���Чǰ�ء�
        C������Ŀ�������µ�����Ȩ����ϡ�
        D������Լ�������µ�������ϡ�

 ��1��    �����£�sdzhang@wind.com.cn��  2013��7��5��
�ο����ף�
1. MATLAB Financial Toolbox 2012a
2.�����£����������������̡̳������ÿ�ѧ�����磬2010��8��
3.�����£���MATLAB���ڼ�����������ݴ������������캽�մ�ѧ�����磬2008��3��

%}

%% ��Ʊ�б����а�飩���۸���ֹ���� 
strList='002142.SZ,601166.SH,601169.SH,601288.SH,601328.SH,601398.SH,601818.SH,601939.SH,601988.SH,601998.SH';
StockList=regexp(strList,'[,]','split');
StockList=StockList(:);
BeginTime='2013-01-01';
EndTime='2013-04-01';

%% ��ȡ��Ʊ�۸��б�
w=windmatlab;
t=1;
for i=1:length(StockList)    
    [wdata,wcodes,wfields,wtimes,werrorid,wreqid]=w.wsd(StockList{i},'close',BeginTime,EndTime);    
    if werrorid==107;error('�����������');end
     matPrice(:,i)=wdata;
end
    matTime=datenum(wtimes);
    matPrice=[matTime,matPrice];
    w.close;
%% ����۸����е���������
RetSeries=price2ret(matPrice(:,2:end));
%% �����ʲ������Чǰ��ͼ
[ExpReturn,ExpCovariance]=ewstats(RetSeries);
frontcon(ExpReturn*225,ExpCovariance, 20);
title('�ʲ������Чǰ��');
xlabel('���գ���׼�');
ylabel('����');
%% ��ȡ����Ŀ�������ʣ�5%/�꣩�����
% ���Ҫ��Ŀ��
retTarget=0.05;
[PortRisk, PortReturn, PortWts] =frontcon(ExpReturn*225,ExpCovariance,[],retTarget);
% PortWts =[0 0 0 0 0 0 0.1430 0 0.5813 0.2757];
cellWeight=num2cell(PortWts');
cellWeight_1=[StockList,cellWeight];
cellWeight_2=[{'��Ʊ����','Ȩ��'};cellWeight_1];
disp('Ŀ��������Ϊ0.05/������Ȩ��');
disp(cellWeight_2)











