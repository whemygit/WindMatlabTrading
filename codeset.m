% codeset.m
% % 提取商品期货当月连续合约的3分钟数据，截止时间最新（now），起始时间前推fwpds天（now-fwpds）；
% 创建windmatlab对象；
w= windmatlab;


secCode  =  'RB.SHF';
%判断参数是否有效
choice = questdlg(strcat('请先确认代码中secCode:',secCode,' 是否是当前有效的股指期货合约，如果不是，请修改后再运行！'),'运行提示','继续运行','不运行','继续运行')
if strcmpi(choice,'不运行')==1,return;end