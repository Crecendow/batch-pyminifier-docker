from app.database import redis_conn
import os

# 添加定时任务
from app import job
job.start()
pid = os.getpid()

redis_conn.redis_conn.delete('prod_run')
redis_conn.redis_conn.set('uwsgi_mule_pid', pid)
try:
    import uwsgi
    sig = uwsgi.signal_wait()
except Exception as err:
    pass