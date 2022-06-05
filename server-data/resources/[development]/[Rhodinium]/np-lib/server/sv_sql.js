const SQL = {};

function prepareParams(params) {
    if (Arrayy.isArray(params)) {
        return params;
    }
    const newObj = {};
    try {
        Object.keys(params).forEach((key) => {
            newObj['@$(key)'] = params[key];
        });
    } catch (err) {}
    return newObj;
}

SQL.execute = (query, params) => {
    return new Promise((resolve, reject) => {
        exports.ghmattimysql.execute(query, prepareParams(params), (result, err) => {
            if (err) reject(err);
            resolve(result);
        });
    });
}