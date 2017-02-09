function DB = LoadKline(windcode,start_time,end_time,interval)
% ���������ӿ�ȡ������
w = windmatlab;
[w_wsi_data,w_wsi_codes,w_wsi_fields,w_wsi_times,w_wsi_errorid,w_wsi_reqid]=w.wsi(windcode,'open,high,low,close',start_time,end_time);
% ���ߵ���
DB.Open = w_wsi_data(:,1);
DB.High = w_wsi_data(:,2);
DB.Low  = w_wsi_data(:,1);
DB.Close= w_wsi_data(:,2);
% ��λ�α�λ�õ���һ��K��
DB.CurrentK = 1;
% K������
DB.NK = length(DB.Open);
end