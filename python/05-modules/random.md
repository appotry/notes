# random

```python

choice(seq) method of Random instance
    Choose a random element from a non-empty sequence.

randint(a, b) method of Random instance
    Return random integer in range [a, b], including both end points.

random(...) method of Random instance
    random() -> x in the interval [0, 1).

randrange(start, stop=None, step=1, _int=<class 'int'>) method of Random instance
    Choose a random item from range(start, stop[, step]).

    This fixes the problem with randint() which includes the
        endpoint; in Python this is usually not what you want.

sample(population, k) method of Random instance
    Chooses k unique random elements from a population sequence or set.

uniform(a, b) method of Random instance
    Get a random number in the range [a, b) or [a, b] depending on rounding.

shuffle(x, random=None) method of Random instance
    Shuffle list x in place, and return None.

    Optional argument random is a 0-argument function returning a
    random float in [0.0, 1.0); if it is the default None, the
        standard random.random will be used.
```

## random.choice()

```python
>>> random.choice('hello')
'o'
>>> random.choice('hello')
'e'
>>> random.choice([1,2,3])
2
>>> random.choice(['apple','xxx','oa'])
'apple'
>>> random.choice(['apple','xxx','oa'])
'oa'
```

## random.randint()

    >>> random.randint(0,100)
    76

## random.random()

    >>> random.random()
    0.0865458073401395

## random.randrange()

```python
>>> random.randrange(0,3,2)
0
>>> random.randrange(0,3,2)
2
>>> random.randrange(0,3,2)
2
```

## random.sample()

```python
>>> random.sample('hello',2)
['e', 'l']
```

## random.uniform()

```python
>>> random.uniform(1,3)
1.8014312865217799
>>> random.uniform(1,3)
2.137511066847893
```

## random.shuffle()

洗牌

```python
>>> items = [1,2,3,4,5,6,7,8,9]
>>> random.shuffle(items)
>>> items
[8, 5, 4, 7, 2, 9, 1, 6, 3]
```