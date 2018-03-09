# Gists

[REST API v3](https://developer.github.com/v3/gists/)

请求地址 `https://api.github.com`

## 认证

[scopes-for-oauth](https://developer.github.com/apps/building-oauth-apps/scopes-for-oauth-apps/)

gists 只需要授权

`gist`: Grants write access to gists.

设置位置: `Settings` -> `Developer settings` -> `Personal access tokens`

```shell
curl -H "Authorization: token OAUTH-TOKEN" https://api.github.com/users/technoweenie -I
```

- `X-OAuth-Scopes` 列出TOKEN授权的范围 authorized.
- `X-Accepted-OAuth-Scopes` 列出操作检查的范围.

## 列出某个用户的 gists

列出指定用户的 public gists:

```shell
GET /users/:username/gists

# /users/yangjinjie/gists
```

示例

```shell
curl https://api.github.com/users/yangjinjie/gists
```

## 获取某个 gist

```shell
GET /gists/:id
```

示例

```shell
curl https://api.github.com/gists/689019b5c033a931096396cb609f5c49
```

## 创建 gist

```shell
POST /gists
```

Input

Name | Type | Description
-----|------|------------
`files` | `object` | Required. Files that make up this gist.
`description` | `string` | A description of the gist.
`public` | `boolean` | Indicates whether the gist is public. Default: `false`

```json
{
  "description": "关于此gist的描述",
  "public": true,
  "files": {
    "file1.txt": {
      "content": "String file contents"
    }
  }
}
```

示例: 使用requests创建

```python
def create_gist(headers):
    # headers = {
    #     "Authorization": "token YOUR-TOKEN"
    # }

    payload = {
      "description": "关于此gist的描述",
      "public": "true",
      "files": {
        "file1.txt": {
          "content": "create gist by requests"
        }
      }
    }

    r = requests.post(url="https://api.github.com/gists", data=json.dumps(payload), headers=headers)
    print(r.text)
```

[raw_url](https://gist.githubusercontent.com/yangjinjie/689019b5c033a931096396cb609f5c49/raw/296565e1b4a790ac3b595f825881ada56a8a743d/file1.txt)

## 编辑 gist

```shell
PATCH /gists/:id
```

示例

```python
def edit_gist(headers):
    # headers = {
    #     "Authorization": "token YOUR-TOKEN"
    # }
    payload = {
      "description": "the description for this gist",
      "files": {
        "new_name1.txt": {
            "content": 'xxx'
        }
      }
    }

    id = '689019b5c033a931096396cb609f5c49'
    r = requests.patch(url="https://api.github.com/gists/{id}".format(id=id), data=json.dumps(payload), headers=headers)
    print(r.text)
```

```json
    // 修改文件名, 修改内容
    "old_name.txt": {
      "filename": "new_name.txt",
      "content": "modified contents"
    },
```

## 其他详见官方开发文档
