function Asset = Buy(DB,Asset,volume,price,flag)
%��ǰK��λ��
I = DB.CurrentK;
%�ɽ����� ����Ϊ��
Asset.Volume(I) = volume;
%�ɽ���
if(strcmp(flag,'CLOSE')==0)
    Asset.Price(I)  = DB.Close(I); %�ɽ��� ��Ϊ��
else
    Asset.Price(I) = price;
end
end