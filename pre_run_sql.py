import pandas as pd
from sqlalchemy import create_engine


engine = create_engine('mysql+pymysql://root:WECHALE$0398_wess@localhost:3306/loan_1')


def run_queries(query: str) -> pd.DataFrame:
    """Executes the provided SQL query and returns the results as a pandas DataFrame."""
    with engine.connect() as connection:
        result = connection.execute(query)
        df = pd.DataFrame(result.fetchall(), columns=result.keys())
    return df