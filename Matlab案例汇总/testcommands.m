%��demo������������WSD,WSS,WSI,WST,WSQ ������
%��Ҫʹ�ú���wss���û�����ͨ��w.menu('wss')����wss����

%����Wind����
answer=who('w');
if(isempty(answer) || ~isa(w,'windmatlab'))
    w= windmatlab;
end

codes='600000.SH';
% fields='low';
% 
 data=w.wsd(codes,'low','20120908','20120918')
 data=w.wss(codes,'comp_name,low')
% 
 data=w.wsi(codes,'low',now-1,now)
% 
 begintime=datestr(now,'yyyymmdd 09:30:00');
 endtime  =datestr(now,'yyyymmdd 9:40:00');
 data=w.wst(codes,'low',begintime,endtime)


data=w.wsq(codes,'rt_last,rt_last_vol,rt_ask1')

%w.close
%clear w;