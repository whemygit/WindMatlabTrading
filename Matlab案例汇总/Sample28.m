%{ 
��1��    �����£�sdzhang@wind.com.cn��  2013��7��5��
���ܣ���Ʒ�ڻ���Ƶ���ƽ��ײ��ԡ����Ϊ�󶹡����͡����ɡ����ף� ����ǿ������Ʒ�֣���ʱ����ͬ����������ǵ�Ʒ�֣�
������2013��4��12�յ�1�������̼ۣ���������Ǽ���4����Ʒ�е�ǰ�۾���������ͼ��Ƿ�����3�ļ����������������2����˵������Ʒ�ִ��ڲ��ǻ��ᣬ
���������Ʒ�֣��Ƿ�����3ʱ��������������ǰƽ�֣����Բ�ȡ����������
%}
clc
clear
w=windmatlab
% ѡȡ        ��һ��     ���͡�     ����      ������Ϊ��ġ�
strStockList='A1309.DCE,Y1309.DCE,M1309.DCE,C1309.DCE'
cellStockList=regexp(strStockList,'[,]','split');
%% ��ȡ��ʷ���׷��Ӽ۸�
Close=[];
for i=1:length(cellStockList)
[Close_Daily,~,~,DateTime]=w.wsi(cellStockList{i},'close','2013-04-12 00:00:00','2013-04-12  15:30:00 ','barsize','1');
Close=[Close,Close_Daily];
end
minBar=Close(1,:);
HighBar=Close(1,:);
[m,n]=size(Close);
%% ���ý���״̬��ֵ
position=[0 0 0 0] ;                            % ��¼����λ�ã� 1��ʾ���룬-1��ʾ������0��ʾ�ֲ֡�
position_Buy =logical([1 1 1 1]);               % ��¼����״̬�� 1��ʾ�������룬0��ʾ��������
position_Sell=logical([0 0 0 0]);               % ��¼����״̬�� 1��ʾ����������0��ʾ��������
position_Price=[0 0 0 0];                       % ��¼����۸�
for i=2:m
%% ��������
minBar=min([minBar;Close(i,:)]);               
maxbar=max([minBar;Close(i,:)]);
sign_Buy=Close(i,:)-minBar>3;                  
conBuy_1=(sum(sign_Buy)>=2)*[1 1 1 1];         % ����1���Ƿ�����3����Ʒ�������ڵ���2.
conBuy_2=Close(i,:)-minBar<=5 ;                % ����2���Ƿ�С��3Ʒ����ѡ
conBuy_3=position_Buy ;                        % ����3����ǰ���ڿ���״̬,1�������룬0��ʾ�������롣
common=logical(conBuy_1.*conBuy_2.*conBuy_3);  % ��������������1��ʾ���������㣬0��ʾ������������������
position_Buy (common)=logical(0) ;             % �޸Ŀ���״̬��1��ʾ�������룬0��ʾ�������롣
position_Sell(common)=logical(1) ;             % �޸Ŀ���״̬��1��ʾ����������0��ʾ����������
position(i,:)=1*common  ;                      % ��¼����λ�ã�1��ʾ���룬-1��ʾ������0���䡣
position_Price(common)=Close(i,common) ;       % �޸�����۸�
%% ��������
conSell_1=logical((Close(i,:)-position_Price>3).*(Close(i,:)-position_Price<1000)) ;% ����1���������3ʱ����
conSell_2=position_Sell   ;                                                         % ����2����ǰ���ڿ���״̬
common=logical(conSell_1.*conSell_2);                                               % ������������ 
position_Buy (common)=logical(1) ;            % �޸Ŀ���״̬��1��ʾ�������룬0��ʾ�������롣
position_Sell(common)=logical(0) ;            % �޸Ŀ���״̬��1��ʾ����������0��ʾ����������
position(i,:)=position(i,:)+(-1)*common;      % ��¼����λ�ã�1��ʾ���룬-1��ʾ������0���䡣
position_Price(common)=0  ;                   % �������۸�
minBar(common)=Close(i,common) ;              % �����ͼ�
maxbar(common)=Close(i,common) ;              % �����߼�
end
%% ������������ɶԣ�������һ�ν���ֻ�����룬�����̼�ƽ�֡�
sign_pair=sum(position)==1;
sign_pair=sign_pair.*position(end,:)==1;
position(end,logical(sign_pair))=0;
sign_pair=sum(position)==1;
position(end,logical(sign_pair))=-1;
%% ��������
Return=nansum(Close.*position)
% % Return =% 
%      5    32   -25   -14
































