%{
���ܣ��Զ���ȡ��ʷ��������
%}
clc;
w= windmatlab;
%��ȡȫ�г���Ʊ����
codes=w.wset('SectorConstituent','date=20131105;sector=ȫ��A��'); 
rowcount=length(codes);
%ȫ�г�����A��2010����2013�꣬�����ȵĲ������ݣ�����ָ�����£�
%EBITDA
%��ȷֺ�
%��Ӫҵ������
%���ڽ��
%���ڽ��
%��ȡ������ʱ�����У�ע��ѡȡ������
w_tdays=w.tdays('2013-01-01','2013-09-30','Days=Alldays;Period=Q'); % �Զ���ȡ��������
colcount = length(w_tdays);
dataresult=zeros(rowcount,5,colcount);
for i=1:colcount
    rptdate=datestr(w_tdays(i),'yyyymmdd');
    year=datestr(w_tdays(i),'yyyy');
    dataresult(:,:,i)=w.wss(codes(:,2),'ebitda2,div_aualaccmdiv,oper_rev,lt_borrow,st_borrow','rptDate',rptdate,'rptType=1','year',year);
    fprintf('\n�Ѿ�����%s�����ڵ�����',rptdate);
end