% Minte3_MA5_MA20函数
function Minte3_MA5_MA20(reqid,isfinished,errorid,datas,secCode,fields,times,parTrade)
% reqid 推送过来的行情对应的wsq订阅函数的requestID
% isfinished 状态字段，使用时无需处理
% errorid 错误码，如果为0表示运行正常
% datas 推送回来的行情数据
% codes 行情数据对应的code
% fields 行情数据对应的fields
% times 行情对应的本地时间，注意这个时间不是行情的时间，想知道向前对应的时间，请订阅rt_time指标
%{
策略回调函数功能：用于处理实时推送回来的行情数据
分为4个部分
A：接收参数
B：策略部分
C：委托查询
D：成交回报
%}
       %% 1. 接收参数
        global discQuery  Sign RequestID 
        signLong  =  parTrade. signLong;
        signShort =  parTrade.signShort;
        pause     =  parTrade.    pause;
        w         =  parTrade.        w;
        Data      =  parTrade.     Data;
        Data
        Data1     =  parTrade.Data1(:,1); % 传回登录号 
        Timer     =  parTrade.     Timer;
        LineDivision  = parTrade.LineDivision;
        datas
        Timer
        datestr(Timer)
       %% 2. 策略部分
        [MA5_minte3]=w.wsi('CU1706.SHF','MA',now-3/24/60,now,'MA_N=5;BarSize=3');                   % 提取三分钟线的MA5
        [MA20_minte3]=w.wsi('CU1706.SHF','MA',now-3/24/60,now,'MA_N=20;BarSize=3');                 % 提取三分钟线的MA20
        MA5_minte3
        MA20_minte3
        if MA5_minte3>MA20_minte3 && Sign.Buy==1                                                    %%%%%%%%%%%%%%%%%%% 信号的变化部分
           
       %% 2.1 买入1手
        [RequestID]   = w.torder(secCode, 'Buy', datas(1)+10, 1, 'OrderType=LMT;HedgeType=SPEC','LogonID',Data1{1}) ;
        Sign.Buy      = 0;
        Sign.Sell     = 0;
        discQuery.t1  = now;
        elseif MA5_minte3<MA20_minte3 && Sign.Sell==1
       %% 2.2 卖出1手
       datas
        [RequestID]   = w.torder(secCode, 'Sell', datas(1)-10, 1, 'OrderType=LMT;HedgeType=SPEC','LogonID',Data1{1})  ;
        Sign.Buy      = 0;
        Sign.Sell     = 0;                    
        discQuery.t1  = now ;                  
        else
        end
        RequestID
        discQuery.t1
        datestr(discQuery.t1)
       %% 3. 查询委托与成交????????程序不运行
        if   Sign.Buy==0&&Sign.Sell==0 && now-discQuery.t1>5*1/24/60/60      
            [Data4, we]=w.tquery('Order','LogonID',Data1{1},'RequestID',RequestID{1}) ;
            Data4
            we
            [Data14,we]=w.tquery('Trade','LogonID',Data1{1},'RequestID',RequestID{1},'OrderNumber',Data4(1)) ;
            Data14
            we
            if       strcmpi(Data14{3},'Normal')==1      &&  strcmpi(Data14{6},'Buy')==1 && Data14{11}==1  
            Sign.Sell=1;
            elseif   strcmpi(Data14{3},'Normal')==1      &&  strcmpi(Data14{6},'Sell')==1  && Data14{11}==1
            Sign.Buy=1;
            else 
           %% 如果不能正常撤单，股票交易被锁死。需要关掉监控界面，然后重新运行程序，目的是避免光大事件。        
            [Data5,Fields,ErrorCode]=w.tcancel(Data4{1}, 'LogonID',Data1{1});  
            Data5
            Fields
            end           
        end
        Data4
        Data14
        we
        Data5
       %% 5. 统计成交(5秒钟查询一次)   
        if  now-discQuery.t1>5*1/24/60/60 
        % 成交序号 Wind代码 交易方向  成交价格 成交数量
        [Data6,fields]=w.tquery('order', 'LogonId',Data1{1})  ;
        Data6
        fields
        N=find(datenum(Data6(:,8))>Timer);
        N
        Data9=Data6(:,8);
        Data9
        for i=1:size(Data6,1)    
        Data6{i,9}= sprintf('%6.2f\n',Data6{i,9}) ;
        Data9{i,1}= Data6{i,8}(12:end);
        end
        Data6
        Data6{1,9}
        Data9
        Data9{1,1}
        
        Data7 = Data6(N,[3 4 5 9 7 8]);
        Data7(:,end)=Data9(N,:) ;
        Data7
        if length(N)>=8
        Data7 = Data7(end:-1:1,:) ;
        Data7
        else
        numLength=length(N);
        Data7=[Data7(end:-1:1,:);Data(3:8-numLength,:)] ;
        Data7
        end
        set(LineDivision,'data',Data7);
        discQuery.t2=now;
        discQuery.t2
        datestr(discQuery.t2)
        end




