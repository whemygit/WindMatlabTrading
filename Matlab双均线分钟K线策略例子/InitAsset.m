function Asset = InitAsset(DB)
NT = length(DB.Close);

% ��ǰ�ֲ���
Asset.CurrentPosition = 0;
% �ɽ���
Asset.Volume = zeros(NT,1);
% �ɽ���
Asset.Price = zeros(NT,1);
% �ֲ���
Asset.Position = zeros(NT,1);
% �ʲ�
Asset.Cash = zeros(NT,1);

end

