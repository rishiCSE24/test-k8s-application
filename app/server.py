# server.py
from fastapi import FastAPI, Query
from fastapi.responses import PlainTextResponse

app = FastAPI()

@app.get("/greet", response_class=PlainTextResponse)
def greet(name: str = Query(...), age: int = Query(...)): 
    """returns a greet message with name and age 

    Args:
        name (str, optional): name. Defaults to Query(...).
        age (int, optional): age. Defaults to Query(...).

    Returns:
        string: greet mesage
    """
    return f"hello {name}, {age}"


if __name__ == "__main__":
    import uvicorn
    uvicorn.run("server:app", host="0.0.0.0", port=80)
