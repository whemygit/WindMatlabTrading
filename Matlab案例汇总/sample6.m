%{
 ���ܣ���ȡ�������ں���
��ȡ���ڽ��׽ӿڵĺ�����3�����ֱ�Ϊtdays��tdaysoffset��tdayscount��
tdays���������ȡ�����գ�tdaysoffset�����������ƫ�ƣ�tdayscount����ͳ�����佻���ո�����

 Copyright�� 2013-2014�� �Ϻ������Ѷ.   
 �޶�2013��4��3�ա�
 �ο����ף�
1. MATLAB2012a��  fixed-incomne Toolbox 
2.�����£����������������̡̳������ÿ�ѧ�����磬2010��8��
3.�����£���MATLAB���ڼ�����������ݴ������������캽�մ�ѧ�����磬2008��3��
%}


%% ��ȡ�Ϻ��ڻ�������2013��5��3����6��3�յĽ�������
[w_tdays_data,w_tdays_codes,w_tdays_fields,w_tdays_times,w_tdays_errorid,w_tdays_reqid]=w.tdays('2013-05-03','2013-06-03','TradingCalendar=SHFE;')
% ���У�'TradingCalendar=SHFE;'���Ϻ��ڻ����������룬Ĭ�����Ϻ�֤ȯ��������
%% ��ȡ�Ϻ���Ʊ������2013��6��3��ǰ��4�������յ����ڡ�
[w_tdays_data,w_tdays_codes,w_tdays_fields,w_tdays_times,w_tdays_errorid,w_tdays_reqid]=w.tdaysoffset(-4,'2013-06-03')
%% ͳ���Ϻ�֤ȯ��������������ͳ�ơ�
[w_tdays_data,w_tdays_codes,w_tdays_fields,w_tdays_times,w_tdays_errorid,w_tdays_reqid]=w.tdayscount('2013-05-03','2013-06-03')








