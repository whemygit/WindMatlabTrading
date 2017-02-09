function Backtest(StrategyFunc,windcode,start_time,end_time,k_interval)
    % ����K������
    DB = LoadKline(windcode,start_time,end_time,k_interval);    
    % ��ʼ���ʲ���
    Asset = InitAsset(DB);
    
    % ��K��ѭ��
    NK = DB.NK;
    for K = 1:NK
        DB.CurrentK = K; %��ǰK��
        Signal = StrategyFunc(DB); %���в��Ժ��������ɽ����ź�
        if( Asset.CurrentPosition ~= 100 && strcmp(Signal.Action,'BUY') == 0)
            Asset = Buy(DB,Asset,100,NaN,'Close'); % �����̼���
        elseif( Asset.CurrentPosition ~= -100 && strcmp(Signal.Action,'BUY') == 0 )
            Asset = Sell(DB,Asset,100,NaN,'Close');
        end
        
        % ÿ��K�������н���ʱ��Ҫ����
        Asset = Clearing(DB,Asset);
    end
    
    Summary(DB,Asset);
end