% codeset.m
% % 提取商品期货当月连续合约的3分钟数据，截止时间最新（now），起始时间前推fwpds天（now-fwpds）；
% 创建windmatlab对象；
w= windmatlab;
% % 设置合约代码，提取价格指标，行情起始时间和截止时间，通过wsi接口提取序列数据
% codes='RB.SHF';               % RB.SHF为螺纹钢主连代码，此处在后续过程中应完善，可选择特定品种的特定合约进行交易
% fields='open,high,low,close';
% fwpds=30;                    % 时间前推30天，后续根据需要可重新设置天数
% begintime=now-fwpds;
% endtime=now
% wdata= w.wsi(codes,fields,begintime,endtime,'BarSize','3');
% % 其中now是matlab内置的日期函数，表示当前时刻。


secCode  =  'RB.SHF';
%判断参数是否有效
choice = questdlg(strcat('请先确认代码中secCode:',secCode,' 是否是当前有效的股指期货合约，如果不是，请修改后再运行！'),'运行提示','继续运行','不运行','继续运行')
if strcmpi(choice,'不运行')==1,return;end