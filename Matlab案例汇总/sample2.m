% Sample2.m
% ��ȡ�н���IF��ָ�ڻ�����������Լ��3�������ݣ���ֹʱ�����£�now������ʼʱ��ǰ��100�죨now-100����
% ����windmatlab����
w= windmatlab;
%������ʼʱ��ͽ�ֹʱ�䣬ͨ��wsi�ӿ���ȡ��������
codes='IF00.CFE';
fields='open,high,low,close';
begintime=now-100;
endtime=now
wdata= w.wsi(codes,fields,begintime,endtime,'BarSize','3');
% ����now��matlab���õ����ں�������ʾ��ǰʱ�̡�
