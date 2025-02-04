from airflow import DAG
from airflow.utils.dates import days_ago
from airflow.operators.bash_operator import BashOperator
from airflow.contrib.operators.ssh_operator import SSHOperator
from airflow.operators.python_operator import PythonOperator


my_dag = DAG(
        dag_id = "helloworld",
        schedule_interval = "@daily",
        start_date = days_ago(1)
        )

def my_callable(*args, **kwargs):
    print("Hello from Data & AI Community")

bask_task_1 = BashOperator(
    task_id = "t_3",
    bash_command = "/usr/local/bin/submit_spark_on_k8s.sh --name spark-test-app  --driver-memory 1G --driver-cores 1 --executor-memory 1G --executor-cores 1 --num-executors 1 --name spark-test-app --python-input /usr/local/airflow/codes/spark-hello-world.py",
    dag = my_dag
)

python_task = PythonOperator(
        task_id='t_2',
        python_callable=my_callable
    )

bask_task_2 = BashOperator(
    task_id = "t_1",
    bash_command = "echo 'Hello from Data & AI Community'",
    dag = my_dag
)

#task_2 = SSHOperator(
#       task_id="t2",
#       command="your ssh command",
#       ssh_conn_id = 'conn-id',
#       dag = my_dag)



bask_task_2 >> [python_task,bask_task_1]
