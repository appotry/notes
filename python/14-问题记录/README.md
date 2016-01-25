# 问题记录

## Django

### django.core.exceptions.ImproperlyConfigured: Requested setting DEFAULT_INDEX_TABLESPACE

```python
import sys
import django
# 将项目目录添加到path路径, 如此设置环境才能找到项目
BASE_DIR = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
sys.path.append(BASE_DIR)
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "project_name.settings")# project_name 项目名称
django.setup()
```
