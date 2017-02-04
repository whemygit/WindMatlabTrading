% Pro1_dataextract.m
% 提取商品期货当月连续合约的3分钟数据，截止时间最新（now），起始时间前推fwpds天（now-fwpds）；
% 创建windmatlab对象；
w= windmatlab;
% 设置合约代码，提取价格指标，行情起始时间和截止时间，通过wsi接口提取序列数据
codes='RB.SHF';               % RB.SHF为螺纹钢主连代码，此处在后续过程中应完善，可选择特定品种的特定合约进行交易
fields='open,high,low,close';
fwpds=100;                    % 时间前推100天，后续根据需要可重新设置天数
begintime=now-fwpds;
endtime=now
wdata= w.wsi(codes,fields,begintime,endtime,'BarSize','3');
% 其中now是matlab内置的日期函数，表示当前时刻。