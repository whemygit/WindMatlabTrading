function Sample16_sub1(reqid,isfinished,errorid,datas,secCode,fields,times,parTrade)
    % ���������
          % ����ID��reqid��,
          %   % isfinished��������������
          % �������еĴ���ID��errorid��
          %   % datas �²�wsq���������w_wsq_data�������յ������ּۣ�����������
          % ��Լ����secCode
          % ���ݶ�Ӧ��ָ��fields
          % ���ݶ�Ӧ��ʱ��times
          % ���ײ���parTrade
          
%{
���Իص�������Ϊ4������
A�����ղ���
B�����Բ���
C��ί�в�ѯ
D���ɽ��ر�
��1��  �����±�д     ��sdzhang@wind.com.cn��   2013��9��5��
%}
       %% 1. ���ղ���
        global discQuery  Sign RequestID 
        signLong  =  parTrade. signLong;   % ��ʼֵΪ1
        signShort =  parTrade.signShort;   % ��ʼֵΪ0
        pause     =  parTrade.    pause;   % ��ʼֵΪ5
        w         =  parTrade.        w;   % windmatlab����
        Data      =  parTrade.     Data;   % 8��6�еĿյĵ�Ԫ����Data
        Data1     =  parTrade.Data1(:,1); % ���ص�¼�� 
        Timer     =  parTrade.     Timer; % ����ʱ��
        LineDivision  = parTrade.LineDivision;
       %% 2. ���Բ���         
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�޸Ĳ��Բ��֣��������ߵ�MA5����MA20���룬С��MA20����
        MA_minte5     =  w.wsi(secCode,'EXPMA',now-3/24/60,now,'EXPMA_N=1');     % MA_minte5������Ϊ3������������������ǰ��3����ÿ��������Ϊ1��EXPMA��
        % ָ��ƽ����ָ�꣬EXPMA=[���ջ������̼�*2+���ջ�����EXPMA*(N-1)]/(N+1)���״μ���ʱ����EXPMAֵΪ�����EXPMAֵ���������̼۴��棬Ĭ������Ϊ�գ�Ĭ��������Ϊ12��
        % EXPMA_N=1��ʾ����EXPMA�ļ�������Ϊ1����
        MA_minte5     =  MA_minte5(end);  
        if datas>MA_minte5 && Sign.Buy==1
           
       %% 2.1 ����1��
        [RequestID]   = w.torder(secCode, 'Buy', datas+10, 1, 'OrderType=LMT;HedgeType=SPEC','LogonID',Data1{1}) ;
        % RequestID,1��10�еĵ�Ԫ���飬ί����ţ�wind���룬���׷���ί�м۸�ί��������ί�����ͣ��޼�ί�У���Ͷ���ױ�����¼�ţ��������ͣ�������Ϣ��
        % ���У���¼�ţ�����д��'LogonID=1'�����ǵ���ֵΪ����ʱ����ֿ�д����Ȼ���������ݲ�ʶ��
        % �磺 [20]    'IF1702.CFE'    'BUY'    '3370'    '1'    'SPEC'    'LMT'    '1'    [0]    'Sending ...'
        Sign.Buy      = 0;
        Sign.Sell     = 0;
        discQuery.t1  = now;        % ��������������
        elseif datas<MA_minte5 && Sign.Sell==1
       %% 2.2 ����1��
        [RequestID]   = w.torder(secCode, 'Sell', datas-10, 1, 'OrderType=LMT;HedgeType=SPEC','LogonID',Data1{1})  ;
        Sign.Buy      = 0;
        Sign.Sell     = 0;                    
        discQuery.t1  = now ;                  
        else
        end             
       %% 3. ��ѯί����ɽ�
       %%%%%%%%%%%%%%%%��ӵ�RequestIDΪ�յ�����µĴ�����
        if   Sign.Buy==0&&Sign.Sell==0 && now-discQuery.t1>5*1/24/60/60      
            [Data4, we]=w.tquery('Order','LogonID',Data1{1},'RequestID',RequestID{1});          %������������������������
            % tquery�����룺����ѯ���͡�order������ί�в�ѯ������¼�š�LogonID��Data{1}��������ID��RequestID��RequestID{1}��
            % tquery���������ί��״̬��OrderStatus������¼�š�LogonID��1��������ID��RequestID��20����������롿ErrorCode����������Ϣ������
            % Data4�磺'Invalid'    [1]    '20'    [0]    '400ί��ʧ��:����ʧ�ܣ����ñ�֤����!'
            % weΪData4�ĸ��������ơ�
            [Data14,we]=w.tquery('Trade','LogonID',Data1{1},'RequestID',RequestID{1},'OrderNumber',Data4(1)) ;  % ��ί�кš�OrderNumber��'Invalid'��
            % Data14��1��3�еĵ�Ԫ���飬�磺    [0]    [-40530606]    'Not found.'
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
        % Data6,��������У�21�еĵ�Ԫ����
        % �������ƣ�(1)OrderNumber;(2)OrderStatus;(3)SecurityCode;(4)SecurityName;(5)TradeSide;(6)OrderPrice;(7)OrderVolume;(8)OrderTime ...
        % (9)TradedPrice;(10)TradedVolume;(11)CancelVolume;(12)LastPrice;(13)PreMargin;(14)TotalFrozenCosts;(15)HedgeType;(16)Remark;(17)LogonID...
        % (18)QryPostStr;(19)OrderDate;(21)ErrorCode;(21)ErrorMsg'
        
        N=find(datenum(Data6(:,8))>Timer);     % ���һ�����й����е�ί�гɽ��������ʱ������Trade.Timer�Ľ���
        Data9=Data6(:,8);                      % Data9ȡData6�ĵ�8��
        for i=1:size(Data6,1)    
        Data6{i,9}= sprintf('%6.2f\n',Data6{i,9}) ;   % ��Data6�ĵھ��б�Ϊ�ַ���
        Data9{i,1}= Data6{i,8}(12:end);     %  ȡ�ַ���ʱ���12λ�Ժ��ֵ����ֻȡ���ӣ���'2017/2/8 22:16:26'ȡ��λ��Ϊ':16:26'��                         
        end        
        Data7 = Data6(N,[3 4 5 9 7 8]);     % �������й����гɽ���¼��ָ��ֱ�Ϊ�����롯�������ơ������������򡯣����ɽ��۸񡯣����ɽ�����������ʱ�䡯
        Data7(:,end)=Data9(N,:) ;           % Data7���һ�м�ʱ���У�ȡData9��N�ж�Ӧ��ֵ��ֻȡ������         
        if length(N)>=8
            % ����8�е�ʱ��Data7ֱ�ӵ���ȡ��
        Data7 = Data7(end:-1:1,:) ;         % Data7���дӺ���ǰȡ�����µ�Data7�ĵ�һ����ԭ��Data7�����һ�У��ڶ�����ԭ���ĵ����ڶ���
        else
            % ����8�е�ʱ��Data7����ȡ�����ಿ����Data���
        numLength=length(N);
        Data7=[Data7(end:-1:1,:);Data(3:8-numLength,:)] ;      %%% Ϊɶ��3�������������������Ϊ6��6�еĿյ�Ԫ����
        end
        set(LineDivision,'data',Data7);
        discQuery.t2=now;
        end








