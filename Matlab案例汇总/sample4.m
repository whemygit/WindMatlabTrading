% ��ȡ�ַ����У�600000.SH�������A��000002.SZ��������A��000009.SZ�����ϲ�A��000012.SZ�������ǿ�����000021.SZ��2012��11��30�ŵĻ��������ֶΣ�
% ������˾���ơ���˾Ӣ�����ơ�IPO���ڡ���ͨ�ɡ��������ʽ�����������Ӧ���ֶ�Ϊcomp_name,comp_name_eng,ipo_date,float_a_shares,mf_amt,mf_vol��
% ����windmatlab��������Ѿ��������������´�����
w= windmatlab;
codes='600000.SH,000002.SZ,000009.SZ,000012.SZ,000021.SZ';
fields='comp_name,comp_name_eng,ipo_date,float_a_shares,mf_amt,mf_vol';
[wdata, codes, fields, times, errorid, reqid] = w.wss(codes,fields,'tradedate','20121130');
% ���У���tradedate����ʾ�������ڡ�
