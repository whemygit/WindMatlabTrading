%{
���ܣ��޷��������µ��ʲ���ϡ��ص���ѧ��Matlab����ϵ�Portfolio���ʹ�÷�����
��1��    �����£�sdzhang@wind.com.cn��  2013��7��5��
   
�ο����ף�
1. MATLAB2012a��  financial Toolbox 
2.�����£����������������̡̳������ÿ�ѧ�����磬2010��8��
3.�����£���MATLAB���ڼ�����������ݴ������������캽�մ�ѧ�����磬2008��3��
%}
%% ����׼��
clc;clear;
w=windmatlab
RealEstimateList='000002.SZ,000048.SH,600185.SH'; % ��Ĺ�Ʊ����
Field='sec_name'; 
StockList=regexp(RealEstimateList,'[,]','split');
StockList=StockList(:);
for i=1:length(StockList)
     StockList(i,2)=w.wsd(StockList{i},'sec_name','2012-12-31','2012-12-31'); % ��ȡ������
     Price(:,i)    =w.wsd(StockList{i},'close','2012-08-22','2012-12-31');    % ��ȡ�۸�
end
%% ��ȡ��ָ֤����000001.SH����������
MarkerIndex=w.wsd('000001.SH','close','2012-08-22','2012-12-31');
%% ��ȡһ����SHIBOR���ʣ�SHIBOR1Y.IR������
CashRet=w.wsd('SHIBOR1Y.IR','close','2012-08-22','2012-12-31');
w.close
%% ���������ʾ�ֵ��Э���� 
AssetList=StockList(:,2);
AssetList=AssetList;
RetSeries=price2ret(Price);
[AssetMean,AssetCovar]=ewstats(RetSeries);
RetSeries=price2ret(MarkerIndex);
[MarketMean,MarketVar]=ewstats(RetSeries);
[CashMean,CashVar]=ewstats(CashRet/100/225);
mret = MarketMean;      % �г�ƽ������
mrsk = sqrt(MarketVar); % �г������ʵı�׼��
cret = CashMean;        % �޷��������ʾ�ֵ
crsk = sqrt(CashVar);   % �޷��������ʵı�׼��
crsk=0;
%% �����ʲ���϶���
p = Portfolio('AssetList', AssetList, 'RiskFreeRate', CashMean);
p = p.setAssetMoments(AssetMean, AssetCovar);
p = p.setInitPort(1/p.NumAssets);
[ersk, eret] = p.estimatePortMoments(p.InitPort);  % ������ϵķ�����������
%% ����ʲ������������
p = p.setDefaultConstraints;
pwgt = p.estimateFrontier(20);   % �����Чǰ���ϵĵ����ϡ�
[prsk, pret] = p.estimatePortMoments(pwgt);% ��Чǰ���ϵķ�����������
%% ����ʲ����ǰ�ص�����
q = p.setBudget(0, 1);
qwgt = q.estimateFrontier(20);
[qrsk, qret] = q.estimatePortMoments(qwgt);
figure;
portfolioexamples_plot('�����޷������ʵ��ʲ������Чǰ��', ...
 {'line', prsk, pret}, ...
 {'line', qrsk, qret, [], [], 1}, ...
 {'scatter', [mrsk, crsk, ersk], [mret, cret, eret], {'����', '�޷�������', '��Ʊƽ������'}}, ...
 {'scatter', sqrt(diag(p.AssetCovar)), p.AssetMean, p.AssetList, '.r'});
xlabel('����')
ylabel('����')