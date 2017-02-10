%{
功能：根据股价三分钟线MA5大于MA20买入，小于MA20分钟线卖出。
策略放在Minte3_MA5_MA20.m中。当价格变化时就会调用Minte3_MA5_MA20.m，给出买卖信号。
用户只能在指定期货品种开盘时运行此程序。
主函数分为下面4个部分：
A：准备工作
B：登录模拟账户，选定交易品种
C：设立监控流水模板
D：设定传入策略参数
策略回调函数分为4个部分
A：接收参数
B：策略部分
C：委托查询
D：成交回报进入流水模板
%% 如果不能正常成交则撤单，交易被锁死。点击成交监控中的“退出”按钮，结束整个交易。
%}
%% 1 前期准备工作
% 清理窗口等
clear all;
clc;
clear global;
% 设置工作路径
cd F:\git\WindMatlabTrading
% 创建windmatlab对象
w=windmatlab;

%% 2 登录wind模拟账户，选择合约（目前暂定只能选择上期所合约,SHF）
% 登录wind账户
% 如果万得用户号是W84394005，那么用户号后面加02（W8439400502）就是期货模拟账号。
WindID = inputdlg({'输入Wind账号'},'',1,{''});        % wind登录号
if length(WindID)==0;error('请重新输入账号');end
WindPWD = inputdlg({'输入Wind资金账号登录密码'},'',1,{''});  % 资金账号密码
if length(WindPWD)==0;error('密码错误');end
[Data1]= w.tlogon('0000','0',[WindID{1},'02'],WindPWD, 'SHF');     % 登录，tlogon
                                                                   % 输入变量：经纪商,营业部,拟资金账号,资金密码,账号类型
                                                                   % 输出变量：'LogonID','LogonAccount','AccountType','ErrorCode'（0表示正常）,'ErrorMsg'.
                                                                   % 如[1]    'W8439400502'    'SHF'    [0]    ''
if Data1{1}<0;errordlg('资金账号错误,请确认是否开通连接外网权限。');assert('');end   % 查看登录号Data1{1}，如果小于0表示资金帐号错误。

% 选择合约
windcode={'CU1702.SHF','CU1703.SHF','CU1704.SHF','CU1705.SHF','CU1706.SHF'};     % 可选的wind代码，后续添加其他
[s,v] = listdlg('PromptString','请选择要交易的期货品种:','SelectionMode','single',...
                      'ListString',windcode);                                    % 列表对话框选择可交易的品种代码
secCode=windcode(s);                                                             % 选定的交易品种代码
%判断代码是否有效
choice = questdlg(strcat('请先确认代码中secCode:',secCode,' 是否是当前有效的股指期货合约，如果不是，请修改后再运行！'),'运行提示','继续运行','不运行','继续运行')
if strcmpi(choice,'不运行')==1,return;end

%% 3 建立监控模板
RTMontor= figure('position',[300 500 810 250],...
  'Name','股指期货模拟账户成交监控',...
  'NumberTitle','off', ...
  'Menubar','none',...
  'Toolbar','none');
ColumnName={'代码','名称','买卖方向','成交价格','成交数量','时间'};
Data      ={'','','','','',''};
Data=repmat(Data,8,1);
foregroundColor = [1 1 1];
backgroundColor = [.4 .1 .1; .1 .1 .4];
LineDivision=uitable('Parent',RTMontor,...
  'Position', [25 40 800 200],...
  'ColumnName',ColumnName,...
  'ColumnWidth',{180 100 100 100 100 100},...
  'FontSize',12,...
  'ForegroundColor', foregroundColor,...
  'BackgroundColor', backgroundColor,...
  'Data',Data);
set(LineDivision,'ColumnWidth',{180 100 100 140 140});
uicontrol('Parent',RTMontor,'style','pushbutton','position',[330 10  80 20],'FontSize',12,'value',1,...
    'string','退出','HorizontalAlignment','center','callback','w.cancelRequest(0);close(gcf)'); 

%% 4 传入策略函数参数
global discQuery Sign RequestID;
discQuery.t1       = 0;
discQuery.t2       = 0;
Sign.Buy           = 1;    % 【买入信号】初始值为1 ？？？？？？？？？？
Sign.Sell          = 1;    % 【卖出信号】初始值为1
parTrade.signLong  = 1;
parTrade.signShort = 0;
parTrade.pause     = 5;
parTrade.w         = w;
parTrade.Data      =  Data; 
parTrade.LineDivision  = LineDivision;
parTrade.Data1         = Data1(:,1);  % 自动生成的登录号，单元数组，如[1]
parTrade.Timer         = now;
w.wsq(secCode,'rt_last',@Minte3_MA5_MA20,parTrade); % 用wsq函数订阅secCode的实时行情数据，当触发Minte3_MA5_MA20函数的信号时执行wsq,提取现价【rt_last】指标

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
