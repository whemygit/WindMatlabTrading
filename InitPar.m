% InitPar.m
% % 初始化合约代码等基础输入参数；

% 创建windmatlab对象；
w= windmatlab;
% 设定要进行交易的合约代码；
secCode  =  'RB.SHF';
%判断参数是否有效
choice = questdlg(strcat('请先确认代码中secCode:',secCode,' 是否是当前有效的股指期货合约，如果不是，请修改后再运行！'),'运行提示','继续运行','不运行','继续运行')
if strcmpi(choice,'不运行')==1,return;end