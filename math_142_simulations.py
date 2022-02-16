import numpy as np
import pandas as pd

covidData = pd.read_csv("germanyCases.csv")
covidData.head()
# Population of the country with data
germanyPop = 83214427
# Function for finding model parameters
def tuningParams(i, r, d, re, P):
    # Using definitions from the paper
    rho = 0.9
    e = 100000000000000000
    betaStar = 0
    gammaStar = 0
    nuStar = 0
    omegaStar = 0
    alphaStar = 0
    muStar = 0
    omega = np.arange(11) / 10
    alpha = np.arange(1, 101)
    for o in omega:
        for a in alpha:
            S = ((o / a) * P) - i - r - d - re
            delta = np.empty((1, 0))
            phi = np.empty((0, 4))
            for t in np.arange(100, 550):
                delta = np.append(
                    delta,
                    np.array(
                        [
                            i[t + 1] - i[t],
                            r[t + 1] - r[t],
                            d[t + 1] - d[t],
                            re[t + 1] - re[t],
                        ]
                    ),
                )
                phi = np.append(
                    phi,
                    np.array(
                        [
                            [(S[t] * i[t]) / (S[t] + i[t]), -1 * i[t], -1 * i[t], r[t]],
                            [0, i[t], 0, -1 * r[t]],
                            [0, 0, (1 / a) * i[t], 0],
                            [0, 0, 0, r[t]],
                        ]
                    ),
                    axis=0,
                )
            # Moore penrose inverse
            invPhi = np.linalg.pinv(phi)
            params = np.matmul(invPhi, delta)
            error = delta - np.matmul(phi, params)
            errorNorm = np.linalg.norm(error)
            # print(f'error = {errorNorm}, e  = {e}')
            if errorNorm < e:
                e = errorNorm
                betaStar = params[0]
                gammaStar = params[1]
                nuStar = params[2]
                muStar = params[3]
                omegaStar = o
                alphaStar = a
            # print(delta, phi)
    paramEstimates = np.array([betaStar, gammaStar, nuStar, muStar])
    return paramEstimates


tuningParams(
    covidData["confirmed"],
    covidData["recovered"],
    covidData["deaths"],
    covidData["reinfection"],
    germanyPop,
)
