%{
功能：根据股价大于5分钟线买入，小于5分钟线卖出。
策略放在Sample16_sub1.m中。当价格变化时就会调用Sample16_sub1.m，给出买卖信号。
用户请在股指期货开盘时运行程序。
主函数分为下面2个部分
A：登录模拟账户
B：设立监控流水模板
C：设定传入策略参数
策略回调函数分为4个部分
A：接收参数
B：策略部分
C：委托查询
D：成交回报进入流水模板
%% 如果不能正常成交则撤单，股票交易被锁死。需要关掉监控界面，然后重新运行程序，目的是避免光大事件。 
%% 点击成交监控中的“退出”按钮，结束整个交易。
第1版  张树德编写     （sdzhang@wind.com.cn）   2013年9月5日
%}
clc;clear
clear global
%% 策略初始化参数
w        =  windmatlab;            % 建立windmatlab对象w
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 此部分可修改为对话框输入
secCode  =  'IF1702.CFE';          % 要进行交易的【合约代码】secCode
%判断参数是否有效
choice = questdlg(strcat('请先确认代码中secCode:',secCode,' 是否是当前有效的股指期货合约，如果不是，请修改后再运行！'),'运行提示','继续运行','不运行','继续运行')  %【代码有效性问题对话框】...
%问题对话框标题为‘运行提示’，显示文字为'请先确认代码中secCode:',secCode,'
%是否是当前有效的股指期货合约，如果不是，请修改后再运行！'，两个按钮，'继续运行'和'不运行'，其中'继续运行'默认设置为标识状态。
if strcmpi(choice,'不运行')==1,return;end   % if条件设置合约代码输入错误的情况下返回，程序终止。

% 策略初始化参数，输出w，secCode。

%% 1. 登录股指期货模拟账户        
% 如果万得用户号是W0813165，那么用户号后面加02（W081316502）就是期货模拟账号。
%                 经纪商  营业部  拟资金账号 资金密码  账号类型 
WindID = inputdlg({'输入Wind账号'},'',1,{''});  % 通过输入对话框输入，输出【wind登录账号】WindID，WindID为一个一行一列的单元数组，值为输入的wind登录账号
if length(WindID)==0;error('请重新输入账号');end  % 上一步未输入，则重新输入wind账号
[Data1]= w.tlogon('0000','0',[WindID{1},'02'],'29177624', 'CFE');  % 通过wind自带函数【tlogon】登录wind，输出一个一行五列的单元数组【Data1】，每列值分别为（1）自动生成的...
% 登录号LogonID，如[1],[2];（2）登录账户LogonAccount,即'W8439400502';（3）账户类型AccountType，如CFE;(4)返回的错误号ErrorCode...
% 0表示所有操作都对，其他表示有错;(5)错误消息ErrorMsg，如Invalid arguments。
% tlogon的输入中，登录账号为字符串，WindID{1}为字符串'W84394005'，[WindID{1},'02']为字符串'W8439400502'.
% tlogon函数一般形式[Data,Fields,ErrorCode] = tlogon(w,BrokerID, DepartmentID, LogonAccount, Password, AccountType, varargin)
 % 输入参数
      %  BrokerID        经纪商代码.模拟账号为0000
      %  DepartmentID    营业部代码(期货登录填写0)
      %  LogonAccount    资金账号
      %  Password        账号密码
      %  AccountType     账号类型: 深圳上海A ：11或SH、SZ、SHSZ; 深圳B：12 或 SZB;上海B：13或SHB;郑商所：14或CZC
                        % 上期所：15或SHF;大商所：16或DCE; 中金所：17或CFE
      %  varargin        其他可选输入参数，如@wsqcallback表示委托/成交回报
 % 输出参数
      %  Data            返回的数据内容,为一个cell，最后两列为错误号和错误消息。
      %  Fields          返回的数据内容中对应的解释.
      %  ErrorCode       返回的错误号，0表示所有操作都对，其他表示有错，可以根据Data定位具体错误 .  

if Data1{1}<0;errordlg('资金账号错误,请确认是否开通连接外网权限。');assert('');end   % 查看登录号Data1{1}，如果小于0表示资金帐号错误。
%%
%% 3. 建立监控模板
RTMontor= figure('position',[300 500 810 250],...
  'Name','股指期货模拟账户成交监控',...
  'NumberTitle','off', ...
  'Menubar','none',...
  'Toolbar','none');                  % 创建图形窗口对象RTMontor                  
ColumnName={'代码','名称','买卖方向','成交价格','成交数量','时间'};
Data      ={'','','','','',''};
Data=repmat(Data,8,1);             % 8行6列的空的单元数组Data
foregroundColor = [1 1 1];
backgroundColor = [.4 .1 .1; .1 .1 .4];
LineDivision=uitable('Parent',RTMontor,...
  'Position', [25 40 800 200],...
  'ColumnName',ColumnName,...
  'ColumnWidth',{180 100 100 100 100 100},...
  'FontSize',12,...
  'ForegroundColor', foregroundColor,...
  'BackgroundColor', backgroundColor,...
  'Data',Data);          % 表格对象LineDivision
set(LineDivision,'ColumnWidth',{180 100 100 140 140});
uicontrol('Parent',RTMontor,'style','pushbutton','position',[330 10  80 20],...
    'FontSize',12,'value',1,'string','退出','HorizontalAlignment','center','callback','w.cancelRequest(0);close(gcf)'); 
%% 2. 传入策略函数参数
global discQuery Sign RequestID;
discQuery.t1       = 0;
discQuery.t2       = 0;
Sign.Buy           = 1;    % 【买入信号】初始值为1
%%%%%%%%%%信号初始值的设置，及信号的变化
Sign.Sell          = 0;    % 【卖出信号】初始值为0
parTrade.signLong  = 1;
parTrade.signShort = 0;
parTrade.pause     = 5;
parTrade.w         = w;
parTrade.Data      =  Data; 
parTrade.LineDivision  = LineDivision;
parTrade.Data1         = Data1(:,1);  % 自动生成的登录号，单元数组，如[1]
parTrade.Timer         = now ;
w.wsq(secCode,'rt_last',@Sample16_sub1,parTrade); % 用wsq函数订阅secCode的实时行情数据，提取指标为现价【rt_last】,当实时指标触发时执行Sample16_sub1函数
% wsq函数说明
  %  一次性请求实时行情数据：
  %  [data,codes,fields,times,errorid] = w.wsq(windcodes,windfields)
  %  订阅实时行情数据：
  %  [~,~,~,~,errorid,reqid] = w.wsq(windcodes,windfields,callback,userdata)
  %  其中callback为回调函数，用来指定实时指标触发时执行相应的回调函数.
      %  userdata为传递给回调函数的用户自己的数据  
  %  Description：
      %   w              创建的windmatlab对象；
      %   windcodes      Wind代码，格式为'600000.SH',单个请求支持多品种.
      %   windfields     提取指标，格式为'rt_last_vol,rt_ask1,rt_asize1'.
      %   callback       回调函数,通过回调函数接收不断传递回来的实时数据
     
      %   data         返回的数据结果.
      %   codes          返回数据对应的代码.
      %   fields         返回数据对应的指标.
      %   times          返回数据对应的时间.
      %   errorid        函数运行的错误ID.
      %   reqid          在订阅时为请求id，用来取消订阅的
    
