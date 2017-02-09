%{
 ���ܣ�����ծȯ�ľ�����͹�ȡ�
 ��1��    �����£�sdzhang@wind.com.cn��  2013��7��5��
 �ο����ף�
1. MATLAB2012a��  fixed-incomne Toolbox 
2.�����£����������������̡̳������ÿ�ѧ�����磬2010��8��
3.�����£���MATLAB���ڼ�����������ݴ������������캽�մ�ѧ�����磬2008��3��
%}
clc;clear;
%% ��ȡ��ծƷ������(��ծ���롢��ծ���ơ���Ϣ�ա������ա���ϢƵ�ʡ�ƱϢ�ʣ���ǰ��)���ծ���飨2013��4��2�գ���
strList='010004.IB,010011.IB';
strList='010004.IB,010011.IB,020005.IB,100014.IB,090025.IB,090020.IB,090031.IB,100017.IB,100027.IB,100033.IB'
strField=   'fullname,carrydate,maturitydate,interestfrequency,couponrate2';
BondList=regexp(strList,'[,]','split');
BondList=BondList(:);
w=windmatlab
BondInfo=w.wss(strList,strField);
BondInfo=[BondList,BondInfo];
for i=1:length(BondList)
    w_data=w.wsd(BondInfo{i,1},'close','2013-04-02','2013-04-02');   
    if iscell(w_data)~=1
    BondPrice(i,1)=w_data;
    else
    BondPrice(i,1)=nan;    
    end
end
w.close
%% ����׼��
[m,n]=size(BondInfo)
Settle=repmat(datenum('2013-04-02'),m,1)
for i=1:m
Maturity(i,1)=datenum(BondInfo{i,4}) ;   
Period(i,1)=BondInfo{i,5};   
CouponRate(i,1)=BondInfo{i,6}/100;
Face(i,1)=1000
end
Periods=double(Period);
Instruments = [Settle Maturity BondPrice CouponRate];
%% ����ծȯ�۸���������͹��
[ModDuration, YearDuration] = bnddurp(BondPrice, CouponRate,Settle, Maturity ,3, Periods); 
YearConvexity = bndconvp(BondPrice, CouponRate,Settle, Maturity ,3, Periods);
%% ���
Result=num2cell([YearDuration,ModDuration,YearConvexity])
Result=[BondInfo(:,1:2),Result];
Result=[{'ծȯ����','ծȯ����','����','��������','͹��'};Result]
%% ����ȫ��=����+Ӧ����Ϣ
Yields = bndyield(BondPrice, CouponRate, Settle, Maturity)
[CleanPrice, AccruedInterest] = bndprice(Yields,CouponRate,Settle, Maturity, Periods);
Prices  =  CleanPrice + AccruedInterest;
%% ծȯ����(ÿ��ծȯͶ��1����Ԫ)
BondAmounts = 1000000./Prices
dy = -0.1:0.005:0.05;               % �趨δ�������ʱ仯��Χ
% % D  = datevec(Settle);                % �õ����ڷ���
% % dt = datenum(D(1):2014, D(2), D(3));
% dt=datenum(Settle(1)):datenum(Settle(1))+1000
% �趨���ڱ䶯
dt=repmat(datenum('2013-04-02'),10,1);
[dT, dY]  =  meshgrid(dt, dy); % ����
NumTimes  =  length(dt);       % ���㲽��
NumYields =  length(dy);       % �����ʱ仯��Number of yield changes
NumBonds  =  length(Maturity); % ծȯƷ��
Prices = zeros(NumTimes*NumYields, NumBonds);
%% ���㲻ͬ���������ʲ�ͬ�������µ�ծȯ�۸�
for i = 1:NumBonds
   [CleanPrice, AccruedInterest] = bndprice(Yields(i)+... 
   dY(:), CouponRate(i), dT(:), Maturity(i), Periods(i),...
   [], [], [], [], [], [], Face(i));
   Prices(:,i) = CleanPrice + AccruedInterest;
end
Prices = Prices * BondAmounts;
Prices = reshape(Prices, NumYields, NumTimes);
figure                   % ����һ���´���
surf(dt, dy, Prices)     % ��ͼ
hold on                  % ���ӵ�ǰ��ֵAdd the current value for reference
basemesh = mesh(dt, dy, 100000*ones(NumYields, NumTimes));
set(basemesh, 'facecolor', 'none');
set(basemesh, 'edgecolor', 'm');
set(gca, 'box', 'on');
dateaxis('x', 11);
xlabel('������');
ylabel('���ʱ仯');
zlabel('�����ֵ');
hold off
view(-25,25);