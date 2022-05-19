import numpy as np
import pandas as pd
from typing import Union


class Car:
    def init(self, h, w):
        self.h = h
        self.w = w


def run(car: Car):
    pass


def func(a: pd.DataFrame, b: np.ndarray):
    return a


def sum_a_b(a: Union[int, float], b: int) -> int:
    """
    суммирование аргументов
    :param a:
    :param b:
    :return:
    """
    x = a + b
    return x


def hello():
    print('Hello!')


if __name__ == "__main__":
    sum_a_b(2., 3)
