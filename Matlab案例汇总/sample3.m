%��ȡƽ�����У�000001.SZ����������������ݣ�
%����windmatlab����
w= windmatlab;
%������ʼʱ��ͽ�ֹʱ�䣬ͨ��wsi�ӿ���ȡ��������
begintime=datestr(now,'yyyymmdd 09:30:00');
endtime  =datestr(now,'yyyymmdd HH:MM:SS');
codes='000001.SZ'
%last���¼ۣ�amt�ɽ��volume�ɽ���
%bid1 ��1�ۣ�bsize1 ��1��
%ask1 ��1��, asize1 ��1��
fields='last,bid1,ask1';
[wdata,codes,fields,times,errorid,reqid] = w.wst(codes,fields,begintime,endtime);

%% ��ȡ�׶�ͭ������������
[data,~,~,times,~,~]=w.wst('CU1309.SHF','last','2013-03-08 09:00:00','2013-03-08 13:00:00')
% ��matlab�Դ���datestr������ʾ����
datestr(times)



