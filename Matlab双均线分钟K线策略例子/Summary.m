function Asset = Summary(DB,Asset)
asset = Asset.Position.*DB.Close + Asset.Cash;
plot(asset);
title('���ʲ����ߣ���ʼΪ0��')