% ��ѯ
% ��1��  �����±�д     ��sdzhang@wind.com.cn��   2013��9��5��
%% ��ѯ����ͨ����¼�Ž��еġ�
%% 1. �ʽ��ѯ
[Data6,Fields,ErrorCode]=w.tquery('Capital', 'LogonId=1')
%% 2. ��¼�ţ�LogonID����ѯ
[Data7,Fields,ErrorCode]=w.tquery('LogonID', 'LogonId=3')
%% 3. ί�в�ѯ
% �û���ѯLogonID=3��Request=17��ί�м��ɽ������
[Data8,Fields,ErrorCode]=w.tquery('Order', 'LogonId',3,'RequestID',Data4{2})
% �û���ѯLogonID=3��Request=17,19��ί�м��ɽ������
[Data9,Fields,ErrorCode]=w.tquery('Order', 'LogonId=3','RequestID',[18 19])
%% 4.�ɽ���ѯ
%% ע��ɽ�Ŀǰ��֧�ֵ�¼�ţ�LogonID����ѯ
[Data10,Fields,ErrorCode]=w.tquery('Trade', 'LogonId=3');
%% 5. �ֲֲ�ѯ
[Data11,Fields,ErrorCode]=w.tquery('Position', 'LogonId=3');
%% 6. �˺�
[Data12,Fields,ErrorCode]=w.tquery('Account', 'LogonId=3');