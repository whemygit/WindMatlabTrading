% �µ�
% ��1��  �����±�д     ��sdzhang@wind.com.cn��   2013��9��5��
%% 1. ���˺��µ�
% ��¼ʱ���ɵĵ�¼��Ϊ1 ����Ҫ�˳���¼��1.
[Data3]=w.torder('600276.SH', 'Buy',32, 100, 'OrderType=LMT;HedgeType=SPEC','LogonID',1)
%% 2. ���ʲ����˻��µ�
% ��¼����2�����ֱ�Ϊ2��3��
[Data4]=w.torder({'600276.SH';'600267.SH'}, {'sell';'Buy'},[32,19], 100, 'OrderType=LMT;HedgeType=SPEC','LogonID',[2 3])
% ��¼����2�����ֱ�Ϊ2��3��
[Data4]=w.torder({'600276.SH';'600267.SH'}, {'sell';'Buy'},[32,19], 100, 'OrderType=LMT;HedgeType=SPEC','LogonID',{3})
