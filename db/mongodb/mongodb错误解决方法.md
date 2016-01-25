# Mongodb错误解决方法

## soft rlimits too low

WARNING: soft rlimits too low. rlimits set to 15664 processes, 65535 files. Number of processes should be at least 32767.5 : 0.5 times number of files.

[参考地址](http://www.2cto.com/database/201505/398290.html)

## 数据库挂掉了

日志排查发现的问题

涉及到下面两个的语句, 执行时间较长, `SORT_KEY_GENERATOR`执行时间超长

- `COLLSCAN`
- `SORT_KEY_GENERATOR`

解决: 索引

[https://stackoverflow.com/questions/38380544/mongodb-query-faster-lte-than-gte](https://stackoverflow.com/questions/38380544/mongodb-query-faster-lte-than-gte)

There are some issues with what you are trying to do:

1. `$or queries use indexes differently`

For $or queries to be able to use an index, all terms of the $or query must have an index. Otherwise, the query will be a collection scan. This is described in [https://docs.mongodb.com/manual/reference/operator/query/or/#or-clauses-and-indexes](https://docs.mongodb.com/manual/reference/operator/query/or/#or-clauses-and-indexes)

2. `Too many indexes in the collection`

Having too many indexes in a collection affects performance in more than one way, e.g., insert performance will suffer since you are turning one insert operation into many (i.e. one insert for the collection, and one additional insert for each indexes in your collection). Too many similar-looking indexes is also detrimental to the query planner, since it needs to choose one index out of many similar ones with minimal information on which index will be more performant.

3. `Check the explain() output in mongo shell`

The explain() output in the mongo shell is the best tool to discover which index will be used by a query. Generally, you want to avoid any `COLLSCAN` stage (which means a collection scan) and `SORT_KEY_GENERATOR` stage (which means that MongoDB is using an in-memory sort that is limited to 32MB, see [https://docs.mongodb.com/manual/tutorial/sort-results-with-indexes/](https://docs.mongodb.com/manual/tutorial/sort-results-with-indexes/)). Please see Explain Results for more details.
