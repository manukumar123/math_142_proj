%syms a(t) S(t) I(t) R(t) D(t) Re(t) phi(t) t;
syms beta gamma nu;
t0 = 0.5;
a(t) = atan(alpha * (t + t0));

phi(t) = [((S(t) * I(t)) / (S(t) + I(t))), -1 * I(t), -1 * I(t), R(t);
          0, I(t), 0, -R(t);
          0, 0, a(t) * I(t), 0;
          0, 0, 0, R(t);];