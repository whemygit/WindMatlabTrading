%%  登录股指期货模拟账户
% % 创建windmatlab对象；
% w= windmatlab;
% 如果万得用户号是W84394005，那么用户号后面加02（W8439400502）就是期货模拟账号。
%                 经纪商  营业部  拟资金账号 资金密码  账号类型 
WindID = inputdlg({'输入Wind账号'},'',1,{''});
if length(WindID)==0;error('请重新输入账号');end
WindPWD = inputdlg({'输入Wind账号登录密码'},'',1,{''});
[Data1]= w.tlogon('0000','0',[WindID{1},'02'],WindPWD, 'SHF');
if length(WindPWD)==0;error('密码错误');end