% ����
%��1��  �����±�д     ��sdzhang@wind.com.cn��   2013��9��5��
% ��¼��Ʊ�˺�
[Data1]=w.tlogon('0000', '0',   {'W081316502';'W081316501'}, {'123456';'123456'}, {'CFE';'SHSZ'});
pause(10)
%% ����600276.SH��Ʊ100�ɣ��۸�31Ԫ��
[Data2]=w.torder({'600276.SH';'600267.SH'}, {'Buy';'Buy'},[32,15], 100, 'OrderType=LMT;HedgeType=SPEC','LogonID',Data1{2,1});
pause(10)
%% ��ѯί��
[Data3,Fields,ErrorCode]=w.tquery('Order', 'LogonId',Data1{2,1},'RequestID',Data2(:,1));
pause(10)
%% ���� 600267.SHί��
[Data4,Fields,ErrorCode]=w.tcancel(Data3(:,1), 'LogonID',Data1{2,1});
pause(10)
%% ��ѯί���Ƿ񱻳�����
[Data3,Fields,ErrorCode]=w.tquery('Order', 'LogonId',Data1{2,1},'RequestID',Data2(:,1));


