function Asset = Clearing(DB,Asset)
%��ǰK��λ��
I = DB.CurrentK;
if(I == 1)
    % ��ǰ�ֲ�
    Asset.CurrentPosition = Asset.Volume(I);
    Asset.Position(I) = Asset.CurrentPosition;
    % ��ǰ�ֽ�
    Asset.Cash (I) = 0 - Asset.Volume(I)*Asset.Price(I);
else
    % ��ǰ�ֲ�
    Asset.CurrentPosition = Asset.Volume(I) + Asset.Position(I-1);
    Asset.Position(I) = Asset.CurrentPosition;
    % ��ǰ�ֽ�
    Asset.Cash (I) = Asset.Cash(I-1) - Asset.Volume(I)*Asset.Price(I);
end

end