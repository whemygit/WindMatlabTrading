% codeset.m
% % ��ȡ��Ʒ�ڻ�����������Լ��3�������ݣ���ֹʱ�����£�now������ʼʱ��ǰ��fwpds�죨now-fwpds����
% ����windmatlab����
w= windmatlab;


secCode  =  'RB.SHF';
%�жϲ����Ƿ���Ч
choice = questdlg(strcat('����ȷ�ϴ�����secCode:',secCode,' �Ƿ��ǵ�ǰ��Ч�Ĺ�ָ�ڻ���Լ��������ǣ����޸ĺ������У�'),'������ʾ','��������','������','��������')
if strcmpi(choice,'������')==1,return;end