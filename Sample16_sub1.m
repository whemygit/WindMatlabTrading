function Sample16_sub1(reqid,isfinished,errorid,datas,secCode,fields,times,parTrade)
%{
���Իص�������Ϊ4������
A�����ղ���
B�����Բ���
C��ί�в�ѯ
D���ɽ��ر�
��1��  �����±�д     ��sdzhang@wind.com.cn��   2013��9��5��
%}
       %% 1. ���ղ���
        global discQuery  Sign RequestID 
        signLong  =  parTrade. signLong;
        signShort =  parTrade.signShort;
        pause     =  parTrade.    pause;
        w         =  parTrade.        w;
        Data      =  parTrade.     Data;
        Data1     =  parTrade.Data1(:,1); % ���ص�¼�� 
        Timer     =  parTrade.     Timer;
        LineDivision  = parTrade.LineDivision;
       %% 2. ���Բ���          
        MA_minte5     =  w.wsi(secCode,'EXPMA',now-3/24/60,now,'EXPMA_N=1');
        MA_minte5     =  MA_minte5(end);  
        if datas>MA_minte5 && Sign.Buy==1
           
       %% 2.1 ����1��
        [RequestID]   = w.torder(secCode, 'Buy', datas+10, 1, 'OrderType=LMT;HedgeType=SPEC','LogonID',Data1{1}) ;
        Sign.Buy      = 0;
        Sign.Sell     = 0;
        discQuery.t1  = now;
        elseif datas<MA_minte5 && Sign.Sell==1
       %% 2.2 ����1��
        [RequestID]   = w.torder(secCode, 'Sell', datas-10, 1, 'OrderType=LMT;HedgeType=SPEC','LogonID',Data1{1})  ;
        Sign.Buy      = 0;
        Sign.Sell     = 0;                    
        discQuery.t1  = now ;                  
        else
        end             
       %% 3. ��ѯί����ɽ�
        if   Sign.Buy==0&&Sign.Sell==0 && now-discQuery.t1>5*1/24/60/60      
            [Data4, we]=w.tquery('Order','LogonID',Data1{1},'RequestID',RequestID{1}) ;
            [Data14,we]=w.tquery('Trade','LogonID',Data1{1},'RequestID',RequestID{1},'OrderNumber',Data4(1)) ;
            if       strcmpi(Data14{3},'Normal')==1      &&  strcmpi(Data14{6},'Buy')==1 && Data14{11}==1  
            Sign.Sell=1;
            elseif   strcmpi(Data14{3},'Normal')==1      &&  strcmpi(Data14{6},'Sell')==1  && Data14{11}==1
            Sign.Buy=1;
            else 
           %% �������������������Ʊ���ױ���������Ҫ�ص���ؽ��棬Ȼ���������г���Ŀ���Ǳ������¼���        
            [Data5,Fields,ErrorCode]=w.tcancel(Data4{1}, 'LogonID',RequestID{1});  
            end           
        end    
       %% 5. ͳ�Ƴɽ�(5���Ӳ�ѯһ��)   
        if  now-discQuery.t1>5*1/24/60/60 
        % �ɽ���� Wind���� ���׷���  �ɽ��۸� �ɽ�����
        Data6=w.tquery('order', 'LogonId',Data1{1})  ;
        N=find(datenum(Data6(:,8))>Timer);
        Data9=Data6(:,8);
        for i=1:size(Data6,1)    
        Data6{i,9}= sprintf('%6.2f\n',Data6{i,9}) ;
        Data9{i,1}= Data6{i,8}(12:end);
        end        
        Data7 = Data6(N,[3 4 5 9 7 8]);
        Data7(:,end)=Data9(N,:) ;          
        if length(N)>=8
        Data7 = Data7(end:-1:1,:) ;
        else
        numLength=length(N);
        Data7=[Data7(end:-1:1,:);Data(3:8-numLength,:)] ;
        end
        set(LineDivision,'data',Data7);
        discQuery.t2=now;
        end








