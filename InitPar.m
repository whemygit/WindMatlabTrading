% InitPar.m
% % ��ʼ����Լ����Ȼ������������

% ����windmatlab����
w= windmatlab;
% �趨Ҫ���н��׵ĺ�Լ���룻
secCode  =  'RB.SHF';
%�жϲ����Ƿ���Ч
choice = questdlg(strcat('����ȷ�ϴ�����secCode:',secCode,' �Ƿ��ǵ�ǰ��Ч�Ĺ�ָ�ڻ���Լ��������ǣ����޸ĺ������У�'),'������ʾ','��������','������','��������')
if strcmpi(choice,'������')==1,return;end