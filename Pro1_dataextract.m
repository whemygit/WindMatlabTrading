% Pro1_dataextract.m
% ��ȡ��Ʒ�ڻ�����������Լ��3�������ݣ���ֹʱ�����£�now������ʼʱ��ǰ��fwpds�죨now-fwpds����
% ����windmatlab����
w= windmatlab;
% ���ú�Լ���룬��ȡ�۸�ָ�꣬������ʼʱ��ͽ�ֹʱ�䣬ͨ��wsi�ӿ���ȡ��������
codes='RB.SHF';               % RB.SHFΪ���Ƹ��������룬�˴��ں���������Ӧ���ƣ���ѡ���ض�Ʒ�ֵ��ض���Լ���н���
fields='open,high,low,close';
fwpds=100;                    % ʱ��ǰ��100�죬����������Ҫ��������������
begintime=now-fwpds;
endtime=now
wdata= w.wsi(codes,fields,begintime,endtime,'BarSize','3');
% ����now��matlab���õ����ں�������ʾ��ǰʱ�̡�