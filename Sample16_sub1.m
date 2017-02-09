function Sample16_sub1(reqid,isfinished,errorid,datas,secCode,fields,times,parTrade)
    % 输入参数：
          % 请求ID（reqid）,
          %   % isfinished？？？？？？？
          % 函数运行的错误ID（errorid）
          %   % datas 猜测wsq函数输出的w_wsq_data，即接收的最新现价？？？？？？
          % 合约代码secCode
          % 数据对应的指标fields
          % 数据对应的时间times
          % 交易参数parTrade
          
%{
策略回调函数分为4个部分
A：接收参数
B：策略部分
C：委托查询
D：成交回报
第1版  张树德编写     （sdzhang@wind.com.cn）   2013年9月5日
%}
       %% 1. 接收参数
        global discQuery  Sign RequestID 
        signLong  =  parTrade. signLong;   % 初始值为1
        signShort =  parTrade.signShort;   % 初始值为0
        pause     =  parTrade.    pause;   % 初始值为5
        w         =  parTrade.        w;   % windmatlab对象
        Data      =  parTrade.     Data;   % 8行6列的空的单元数组Data
        Data1     =  parTrade.Data1(:,1); % 传回登录号 
        Timer     =  parTrade.     Timer; % 交易时间
        LineDivision  = parTrade.LineDivision;
       %% 2. 策略部分         
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%修改策略部分，三分钟线的MA5大于MA20买入，小于MA20卖出
        MA_minte5     =  w.wsi(secCode,'EXPMA',now-3/24/60,now,'EXPMA_N=1');     % MA_minte5，长度为3的向量，从现在起向前数3分钟每分钟周期为1的EXPMA。
        % 指数平均数指标，EXPMA=[当日或当期收盘价*2+上日或上期EXPMA*(N-1)]/(N+1)，首次计算时上期EXPMA值为昨天的EXPMA值，用昨收盘价代替，默认周期为日，默认周期数为12。
        % EXPMA_N=1表示计算EXPMA的计算周期为1分钟
        MA_minte5     =  MA_minte5(end);  
        if datas>MA_minte5 && Sign.Buy==1
           
       %% 2.1 买入1手
        [RequestID]   = w.torder(secCode, 'Buy', datas+10, 1, 'OrderType=LMT;HedgeType=SPEC','LogonID',Data1{1}) ;
        % RequestID,1行10列的单元数组，委托序号，wind代码，交易方向，委托价格，委托数量，委托类型（限价委托），投机套保，登录号，错误类型，错误信息。
        % 其中，登录号，可以写成'LogonID=1'，但是当其值为变量时，则分开写，不然引号内内容不识别。
        % 如： [20]    'IF1702.CFE'    'BUY'    '3370'    '1'    'SPEC'    'LMT'    '1'    [0]    'Sending ...'
        Sign.Buy      = 0;
        Sign.Sell     = 0;
        discQuery.t1  = now;        % ？？？？？？？
        elseif datas<MA_minte5 && Sign.Sell==1
       %% 2.2 卖出1手
        [RequestID]   = w.torder(secCode, 'Sell', datas-10, 1, 'OrderType=LMT;HedgeType=SPEC','LogonID',Data1{1})  ;
        Sign.Buy      = 0;
        Sign.Sell     = 0;                    
        discQuery.t1  = now ;                  
        else
        end             
       %% 3. 查询委托与成交
       %%%%%%%%%%%%%%%%添加当RequestID为空的情况下的处理方法
        if   Sign.Buy==0&&Sign.Sell==0 && now-discQuery.t1>5*1/24/60/60      
            [Data4, we]=w.tquery('Order','LogonID',Data1{1},'RequestID',RequestID{1});          %？？？？？？？？？？？？
            % tquery，输入：【查询类型】order，当日委托查询；【登录号】LogonID，Data{1}；【请求ID】RequestID，RequestID{1}。
            % tquery，输出：【委托状态】OrderStatus；【登录号】LogonID，1；【请求ID】RequestID，20；【错误代码】ErrorCode；【错误信息】。。
            % Data4如：'Invalid'    [1]    '20'    [0]    '400委托失败:建仓失败！可用保证金不足!'
            % we为Data4的各变量名称。
            [Data14,we]=w.tquery('Trade','LogonID',Data1{1},'RequestID',RequestID{1},'OrderNumber',Data4(1)) ;  % 【委托号】OrderNumber，'Invalid'。
            % Data14，1行3列的单元数组，如：    [0]    [-40530606]    'Not found.'
            if       strcmpi(Data14{3},'Normal')==1      &&  strcmpi(Data14{6},'Buy')==1 && Data14{11}==1  
            Sign.Sell=1;
            elseif   strcmpi(Data14{3},'Normal')==1      &&  strcmpi(Data14{6},'Sell')==1  && Data14{11}==1
            Sign.Buy=1;
            else 
           %% 如果不能正常撤单，股票交易被锁死。需要关掉监控界面，然后重新运行程序，目的是避免光大事件。        
            [Data5,Fields,ErrorCode]=w.tcancel(Data4{1}, 'LogonID',RequestID{1});  
            end           
        end    
       %% 5. 统计成交(5秒钟查询一次)   
        if  now-discQuery.t1>5*1/24/60/60 
        % 成交序号 Wind代码 交易方向  成交价格 成交数量
        Data6=w.tquery('order', 'LogonId',Data1{1})  ;
        % Data6,请求次数行，21列的单元数组
        % 各列名称：(1)OrderNumber;(2)OrderStatus;(3)SecurityCode;(4)SecurityName;(5)TradeSide;(6)OrderPrice;(7)OrderVolume;(8)OrderTime ...
        % (9)TradedPrice;(10)TradedVolume;(11)CancelVolume;(12)LastPrice;(13)PreMargin;(14)TotalFrozenCosts;(15)HedgeType;(16)Remark;(17)LogonID...
        % (18)QryPostStr;(19)OrderDate;(21)ErrorCode;(21)ErrorMsg'
        
        N=find(datenum(Data6(:,8))>Timer);     % 最近一次运行过程中的委托成交情况，即时间点大于Trade.Timer的交易
        Data9=Data6(:,8);                      % Data9取Data6的第8列
        for i=1:size(Data6,1)    
        Data6{i,9}= sprintf('%6.2f\n',Data6{i,9}) ;   % 将Data6的第九列变为字符串
        Data9{i,1}= Data6{i,8}(12:end);     %  取字符串时间的12位以后的值，即只取分钟，如'2017/2/8 22:16:26'取后几位变为':16:26'。                         
        end        
        Data7 = Data6(N,[3 4 5 9 7 8]);     % 本次运行过程中成交记录，指标分别为‘代码’，‘名称’，‘买卖方向’，‘成交价格’，‘成交数量’，‘时间’
        Data7(:,end)=Data9(N,:) ;           % Data7最后一列即时间列，取Data9第N行对应的值，只取到分钟         
        if length(N)>=8
            % 多于8行的时候，Data7直接倒着取数
        Data7 = Data7(end:-1:1,:) ;         % Data7按行从后向前取，及新的Data7的第一行是原来Data7的最后一行，第二行是原来的倒数第二行
        else
            % 少于8行的时候，Data7倒着取，其余部分由Data填充
        numLength=length(N);
        Data7=[Data7(end:-1:1,:);Data(3:8-numLength,:)] ;      %%% 为啥是3？？？？？？？？结果为6行6列的空单元数组
        end
        set(LineDivision,'data',Data7);
        discQuery.t2=now;
        end








