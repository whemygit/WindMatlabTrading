%{
 ���ܣ������������޽ṹ��
 ��1��    �����£�sdzhang@wind.com.cn��   2013��7��5��
 �ο����ף�
1. MATLAB2012a��  fixed-incomne Toolbox 
2.�����£����������������̡̳������ÿ�ѧ�����磬2010��8��
3.�����£���MATLAB���ڼ�����������ݴ������������캽�մ�ѧ�����磬2008��3��
%}
%% ��ȡ���м��ծƷ��(��ծ���롢��ծ���ơ���Ϣ�ա������ա���ϢƵ�ʡ�ƱϢ�ʣ���ǰ��)�Լ������̼ۣ�2013��4��2�գ�
clc;clear;
strList='010004.IB,010011.IB,020005.IB,100014.IB,090025.IB,090020.IB,090031.IB,100017.IB,100027.IB,100033.IB';
BondList=regexp(strList,'[,]','split');
BondList=BondList(:);
w=windmatlab
strField=   'fullname,carrydate,maturitydate,interestfrequency,couponrate2';
BondInfo=w.wss(strList,strField);
BondInfo=[BondList,BondInfo];
%% 2 ��ȡծȯ���̼ۣ�2013��4��2�գ�
for i=1:length(BondInfo)
    [w_data,w_codes,w_fields,w_times,w_errorid,w_reqid]=w.wsd(BondInfo{i,1},'close','2013-04-02','2013-04-02');   
    if iscell(w_data)~=1
    BondPrice(i,1)=w_data;
    else
    BondPrice(i,1)=nan;    
    end
end
w.close
% �޳�û�гɽ�ծȯƷ��
nanPosition=isnan(BondPrice)
BondInfo=BondInfo(~nanPosition,:)
BondPrice=BondPrice(~nanPosition,:)

%% ����׼��
[m,n]=size(BondInfo)
Settle=repmat(datenum('2013-04-02'),m,1)
for i=1:m
Maturity(i,1)=datenum(BondInfo{i,4}) ;   
Period(i,1)=BondInfo{i,5};   
CouponRate(i,1)=BondInfo{i,6}/100;
end
Period=double(Period);
Instruments = [Settle Maturity BondPrice CouponRate];
% �޳��쳣����
abnormDays=find(Maturity<Settle(1))

%% ����NelsonSiegelģ��
%% ����fitSvenssonģ��
OptOptions = optimset('lsqnonlin');
OptOptions = optimset(OptOptions,'MaxFunEvals',1000);
% �趨Svenssonģ���в����ĳ�ֵ�������Ͻ����½�
fIRFitOptions = IRFitOptions([7.82 -2.55 -.87 0.45 ],'FitType','durationweightedprice','OptOptions',OptOptions,...
    'LowerBound',[3 -Inf -Inf -Inf ],'UpperBound',[Inf Inf Inf Inf ]);

NSModel = IRFunctionCurve.fitNelsonSiegel('Zero',Settle(1),Instruments,'IRFitOptions',fIRFitOptions,'InstrumentPeriod',Period,'instrumentbasis',3);
NSModel = IRFunctionCurve.fitNelsonSiegel('Zero',Settle(1),Instruments,'InstrumentPeriod',Period,'instrumentbasis',3);


%% ����fitSvenssonģ��
OptOptions = optimset('lsqnonlin');
OptOptions = optimset(OptOptions,'MaxFunEvals',1000);
% �趨Svenssonģ���в����ĳ�ֵ�������Ͻ����½�
fIRFitOptions = IRFitOptions([5.82 -2.55 -.87 0.45 3.9 0.44],'FitType','durationweightedprice','OptOptions',OptOptions,...
    'LowerBound',[0 -Inf -Inf -Inf 0 0],'UpperBound',[Inf Inf Inf Inf Inf Inf]);
SvenssonModel = IRFunctionCurve.fitSvensson('Zero',Settle(1),Instruments,'IRFitOptions',fIRFitOptions,...
    'InstrumentPeriod',Period,'instrumentbasis',3);

%% �����������޽ṹ
PlottingPoints= Settle(1):2000:max(Maturity);
TimeToMaturity = yearfrac(Settle(1),PlottingPoints);
figure 
plot(TimeToMaturity,NSModel.getParYields(PlottingPoints),'-.r')
hold on
plot(TimeToMaturity,SvenssonModel.getParYields(PlottingPoints),'g')
legend({'Nelson Siegelģ��','Svenssonģ��'})
title('�������޽ṹ')
xlabel('�����ڣ��꣩')

