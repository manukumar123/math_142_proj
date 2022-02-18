syms m n g b s

% Jacobian of SIRRe model, b = beta * s
J(g, b, n, m) = [0, -b+g, 0, 0, 0;
                 0, b-g-n, m, 0, 0;
                 0, g, -m, 0, 0;
                 0, n, 0, 0, 0;
                 0, 0, m, 0, 0;];
[V, D] = eig(J)