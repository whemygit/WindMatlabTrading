% �������Ƿ��ǹ�ָ�ڻ����� 
%{
ʹ��˵�����������ǹ�ָ�ڻ����߲�����Ϸ�����û�����֮�ã��ڹ�ָ�ڻ������ڼ�ʹ�á�
         �����ǹ�ָ�ڻ��������ߣ������ȵ��������ָ����,Ҳ���Ե��������ָ������
         ����������ӯ��ͳ��ͼ��������������ǧ������˸������ǡ�
��1��  �����±�д     ��sdzhang@wind.com.cn��   2013��10��31��

%}

function Sample30
%% ������һ�����ƹ�Ʊ�۸�ʵʱ�ؼ�ͼ��
clear global h11 h12 h22 Rtprice  Profit Profit1 M Buy
global h11 h12 h22 Rtprice  Profit Profit1 M Buy

M.m1=0;M.m2=0;M.m3=0;M.m4=0;
Profit=0;Profit1=0;
Rtprice=nan(50,2);
w=windmatlab;
w.cancelRequest(0);
h=figure('menubar','none','numberTitle','off','name','��ָ�ڻ���Ϸ','position',[300 300 800 600],'Resize', 'off');
h1 = axes('Parent',h,'position',[0.1  0.55 0.8 0.35]);
h11=plot(h1,Rtprice(:,1),'LineWidth',3);
title('��������','FontSize',20,  'FontWeight','bold');
set(gca,'XTickLabel','');
hold on
h12=plot(h1,Rtprice(:,2),'--o','MarkerSize',15);
set(gca,'XTickLabel','');
h2  = uicontrol('position', [115  255 150 50],'string','����ָ��','FontSize',20,'callback','global M;M.m1= 1;M.m3=1;','BackgroundColor', [0.1 0.8 0.8]);
h3  = uicontrol('position', [315  255 150 50],'string','����ָ��','FontSize',20,'callback','global M;M.m2=-1;M.m3=2;','BackgroundColor', [0.1 0.8 0.8]) ;
h33 = uicontrol('position', [515  255 150 50],'string','�˳���Ϸ','FontSize',20,'callback','w=windmatlab;w.cancelRequest(0);clc;close(gcf)','BackgroundColor', [0.9 0.8 0.8]);
h4 = axes('Parent',h,'position',[0.1  0.05 0.8 0.3]);
h22=plot(h4,Profit,'LineWidth',1.5);
set(gca,'XTickLabel','');
title('ӯ������','FontSize',20,  'FontWeight','bold');
w.wsq('IF1312.CFE','rt_latest',@STplay_sub1);
function STplay_sub1(reqid,isfinished,errorid,datas,codes,fields,times)
%��������������ʾ�û��Զ���ص���������׫д��ʽ
datas
global h11 h12 h22 Rtprice  Profit Profit1 M Buy
if M.m1==1||M.m2==-1
Rtprice=[Rtprice;[datas,datas]]  ; 
if M.m1*M.m2==0&&M.m4==0
Buy=datas;
M.m4=1;
end
else
Rtprice=[Rtprice;[datas,nan]];
end
if  M.m1==1&&M.m2==-1
    if M.m3==1
       Profit=[Profit,(-1)*datas+Buy];
       M.m1=0;M.m2=0;M.m3=0;M.m4=0;Buy=nan;
    elseif M.m3==2
       Profit=[Profit,datas+(-1)*Buy]; 
       M.m1=0;M.m2=0;M.m3=0;M.m4=0;Buy=nan;
    else  
    end    
end
Profit1=[Profit1,nansum(Profit)];
set(h11, 'XData',[1:50]', 'YData',Rtprice(end-49:end,1)) ;
set(h12, 'XData',[1:50]', 'YData',Rtprice(end-49:end,2)) ;     
set(h22, 'XData',[1:length(Profit1)]','YData',Profit1)   ;     


    


















