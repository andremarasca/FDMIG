function Atributos = FDMIG(I, N_Camadas, Rmax)

I = double(I);
I(:, :, 4) = (I(:, :, 1) + I(:, :, 2) + I(:, :, 3))/3;
[M, N, L] = size(I);

LBP_CODIGOS = uint32(LBPRIU2_RGB(I));

N_labels = 4 + 10;

X = zeros(M * N * L, 1);
Y = zeros(M * N * L, 1);
Z = zeros(M * N * L, 1);
Lab = zeros(M * N * L, 1);

u = 1;
for k = 1 : L
    for i = 1 : M
        for j = 1 : N
            X(u, 1) = i - 1;
            Y(u, 1) = j - 1;
            Z(u, 1) = I(i, j, k) / 255.0;
            
            bit_LBP = bitshift(1, LBP_CODIGOS(i, j, k)); % 4 bits
            
            Lab(u, 1) = 0;
            Lab(u, 1) = Lab(u, 1) + bitshift(1, k - 1); % 4
            Lab(u, 1) = Lab(u, 1) + bitshift(bit_LBP, 4); % 10
            u = u + 1;
        end
    end
end

Camadas = N_Camadas;
Z = Z * (Camadas - 1);
Z = Z - min(Z(:));
Camadas = max(Z(:)) + 1;

Atributos = EDT_FRACTAL(double(X), double(Y), double(Z), double(Lab), [M, N, Camadas], Rmax, N_labels);

end
