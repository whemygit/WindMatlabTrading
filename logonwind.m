%%  ��¼��ָ�ڻ�ģ���˻�
% % ����windmatlab����
% w= windmatlab;
% �������û�����W84394005����ô�û��ź����02��W8439400502�������ڻ�ģ���˺š�
%                 ������  Ӫҵ��  ���ʽ��˺� �ʽ�����  �˺����� 
WindID = inputdlg({'����Wind�˺�'},'',1,{''});
if length(WindID)==0;error('�����������˺�');end
WindPWD = inputdlg({'����Wind�˺ŵ�¼����'},'',1,{''});
[Data1]= w.tlogon('0000','0',[WindID{1},'02'],WindPWD, 'SHF');
if length(WindPWD)==0;error('�������');end