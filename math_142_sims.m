syms m n g b s

% Jacobian of SIRRe model, b = beta * s
J(g, b, n, m) = [0, -b+g, 0, 0, 0;
                 0, b-g-n, m, 0, 0;
                 0, g, -m, 0, 0;
                 0, n, 0, 0, 0;
                 0, 0, m, 0, 0;];

b0 = 1.64886340e-02 * 83214427;
g0 = 4.17627477e-03;
n0 = 1.16559725e-05;
m0 = 2.79609530e-04;

[V, D] = eig(J(g0, b0, n0, m0))