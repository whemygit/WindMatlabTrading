%  �ļ�����Sample1.m
%  ���ܣ���ȡ���м佻��ծȯ09��Ϣ��ծ��090007.IB���ľ����������ݣ�ʱ���2012-1-1�����¡�
w= windmatlab;%  ���ȴ���windmatlab����
begintime='20120101';%  Ȼ��������ʼʱ��ͽ�ֹʱ�䣬ͨ��wsd�ӿ���ȡ��������
endtime=today;
wdata= w.wsd('090007.IB','close',begintime,endtime,'Priceadj','CP','tradingcalendar','NIB');
w.close
% ����������ȡ000001.SZ�Ŀ��̡���ߡ���������ݣ���ʼʱ��ǰ��100�죨���ں꣩����ֹʱ�����£�ǰ��Ȩ���ݡ�
% ����windmatlab����
w= windmatlab;
begintime='20120101'; % ������ʼʱ��ͽ�ֹʱ�䣬ͨ��wsd�ӿ���ȡ��������
endtime=today;
wdata= w.wsd('000001.SZ','open,high,low,close','-100d',endtime,'Priceadj','F');
% ���У�-100d�����ں꺯������ʾǰ��100�졣
w.close








