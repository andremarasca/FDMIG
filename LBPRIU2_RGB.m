function Saida = LBPRIU2_RGB(I)

load('LBPRIU2TABLE.mat');

[M, N, L] = size(I);

% Viz = [-1 -1; -1 0; -1 1; 0 -1; 0 1; 1 -1; 1 0; 1 1];
Viz = [-1 -1; -1 0; -1 1; 0 1; 1 1; 1 0; 1 -1; 0 -1];

Saida = zeros(M, N, L);

% mapa_andre = [0 0 0 1 1 1 2 2 2 3];

for k = 1 : L
    for i = 1 : M
        for j = 1 : N
            for u = 1 : 8
                if 1 <= (i + Viz(u, 1)) && (i + Viz(u, 1)) <= M
                    if 1 <= (j + Viz(u, 2)) && (j + Viz(u, 2)) <= N
                        if I(i, j, k) <= I(i + Viz(u, 1), j + Viz(u, 2), k)
                            Saida(i, j, k) = Saida(i, j, k) + 2^(u - 1);
                        end
                    else
                        if I(i, j, k) <= I(i + Viz(u, 1), j, k)
                            Saida(i, j, k) = Saida(i, j, k) + 2^(u - 1);
                        end
                    end
                else
                    if 1 <= (j + Viz(u, 2)) && (j + Viz(u, 2)) <= N
                        if I(i, j, k) <= I(i, j + Viz(u, 2), k)
                            Saida(i, j, k) = Saida(i, j, k) + 2^(u - 1);
                        end
                    else
                        Saida(i, j, k) = Saida(i, j, k) + 2^(u - 1);
                    end
                end
            end
            idx = uint32(Saida(i, j, k) + 1);
            Saida(i, j, k) = LBPRIU2(idx);
%             Saida(i, j, k) = mapa_andre(Saida(i, j, k) + 1);
        end
    end
end

end