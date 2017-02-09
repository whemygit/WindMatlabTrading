% ��򵥵�˫���߲���
function Signal = Strategy(DB)
Signal.Action = 'NULL';
MA5 = MovAvg(DB.Close,DB.CurrentK,5);  %���� 5�վ���
MA20 = MovAvg(DB.Close,DB.CurrentK,20); %���� 20�վ���
if(MA5 > MA20) %5�վ����ϴ�20�վ��� ��
    Signal.Action = 'BUY';
elseif (MA5 < MA20) %5�վ����´�20�վ��� ��
    Signal.Action = 'SELL';
end

end
