import torch
from torch.autograd.functional import jacobian

if __name__ == '__main__':
    A = torch.tensor([[2.0, 0.0], [0.0, 0.5]])
    x = torch.tensor([1.0, 2.0])

    matmul_A = lambda x: torch.matmul(A, x)

    y = matmul_A(x)
    J = jacobian(matmul_A, x)

    print(A, x, y)
    print(J)