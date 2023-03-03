set(0, 'DefaultFigureWindowStyle', 'docked')
set(0, 'defaultaxesfontsize', 20)
set (0, 'defaultaxesfontname', 'Times New Roman')
set(0, 'DefaultLineLineWidth', 2);

nx = 50;
ny = 50;
dx = 1;
V = zeros(nx,ny);
G = sparse (nx*ny);

Inclusion = 0;

material = -4;
material2 = -2;

for i = 1:nx
    for j = 1:ny
        n = j + (i-1) *ny;
        
        if i == 1
            G(n,n) = 1;
        elseif i == nx
              G(n,n) = 1;
        elseif j == 1
              G(n,n) = 1;
        elseif j == ny
            G(n,n) = 1;
        else
            nxm = j + (i-2)*ny;
            nxp = j + i*ny;
            nym = j-1 + (i-1)*ny;
            nyp = j+1 + (i-1)*ny;

            G(n,nxm) = 1;
            G(n,nxp) = 1;
            G(n,nym) = 1;
            G(n,nyp) = 1;

            if (i > 10 && i < 20 && j > 10 && j < 20) 
                G(n,n) = material2;
            else
                G(n,n) = material;
            end

        end

    end
end

figure

figure('name', 'Matrix')
spy(G)

nmodes = 20;
[E,D] = eigs(G, nmodes, 'SM');

figure('name', 'EigenValues')
plot(diag(D), '*')

np = ceil(sqrt(nmodes));

for k = 1:nmodes
    M = E(:,k);
    for i = 1:nx
        for j = 1:ny
            n = i + (j-1) * ny;
            V(i,j) = M(n);
        end
        subplot(np,np, k), surf(V, 'linestyle', 'none')
        title (['EV = ' num2str(D(k,k))])
    end
end