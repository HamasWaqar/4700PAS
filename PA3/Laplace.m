
i = 1;

nx = 100 + i;
ny = 100 + i;

ni = 5000;

V = zeros(nx,ny);

SidesToZero = 0;

filterSwitch = 0;

movie = 1;

Boundary1Val = 1;
Boundary2Val = 1;
Boundary3Val = 0;
Boundary4Val = 0;

Bound = [Boundary1Val Boundary2Val Boundary3Val Boundary4Val];

for k = 1:ni
    for i = 1:nx
        for j = 1:ny

            if i == 1
                V(1,j) = Boundary1Val;
            elseif i == nx
                V(nx,j) = Boundary2Val;
            elseif j == 1
                V(i,1) = Boundary3Val;
            elseif j == ny
                V(i,ny) = Boundary4Val;
            else
                if filterSwitch == 0
                    V(i,j) = ( V(i-1,j) + V(i+1,j) + V(i,j-1) + V(i, j+1))/4;
                end
            end
        end
    end

    if filterSwitch == 1
        V = imboxfilt(V,3);
    end

    if mod(k, 50) == 0
        surf(V');
        zlim([min(Bound) max(Bound)]);

        if movie == 1
            pause(0.05);
        end
    end

end

[Ex,Ey] = gradient(V);

figure
quiver(-Ey',-Ex', 1)