function w_errorid=getRealtimeWSQ(w,codes)
    %��demo����ʵ��ʵʱ����һЩ��Ʊ�Ľ�����Ϣ�����ĵ���Ϣͨ���ص�����ʵʱ��ʾ����WSQCallback�ص���������
    %��Ҫʹ�ú���wsq���û�����ͨ��w.menu('wsq')����wsq����

    if nargin<2
        %׼����Ҫ��ȡ��Ϣ�Ĺ�Ʊ����
        codes='AUDUSD.FX';%600000.SH,000001.SZ,000002.SZ';
    end

    if nargin<1
        %����Wind����
        global gWindData;
        if ~isa(gWindData,'windmatlab')
            w=windmatlab;
        else
            w=gWindData;
        end
    end
    

    %ȷ��ָ��
    %�û�����ͨ��w.menu('wsq')
    %rt_last �ּۣ�rt_last_vol ����
    %rt_ask1 ��1�ۣ�rt_asize1 ��1��
    %rt_bid1 ��1�ۣ�rt_bsize1 ��1��
    fields='rt_last,rt_last_vol,rt_ask1,rt_asize1,rt_bid1,rt_bsize1';

    [w_data,w_codes,w_fields,w_times,w_errorid,w_reqid] =w.wsq(codes,fields,@WSQCallback);

    %�ȴ��Զ����ûص�����
    fprintf('Waiting for the data. Subscription will be terminated in 60 seconds.\n');
    %fprintf('���ڵȴ��ص����������ã�60����Զ��˳��ȴ�������ֹ����\n');

    endtime = now + 60.0/(3600*24);
    while now < endtime
        pause(1);
        fprintf('.');
    end

    %������ʹ��w.cancelRequest�������ֹͣ����
    w.cancelRequest(w_reqid)

    %fprintf('\n�Ѿ�ֹͣ����\n');
    fprintf('\nSubscription is expired.\n');

    %�������ʹ��wind���������ԶϿ���
    %w.close
end
