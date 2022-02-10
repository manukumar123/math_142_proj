syms m n g b s

% Jacobian of SIRRe model, b = beta * s
J(g, b, n, m) = [0, -b+g, 0, 0, 0;
                 0, -b-g-n, m, 0, 0;
                 0, g, -m, 0, 0;
                 0, n, 0, 0, 0;
                 0, 0, m, 0, 0;];
[V, D] = eig(J);


% stability analysis of bs_0 < 4m
m_func(b, s) = (b*s) / 4;
b_prac = 0:0.01:1;
s_prac = b_prac;
m_prac = m_func(b_prac, s_prac);
plot3(b_prac, s_prac, m_prac);

