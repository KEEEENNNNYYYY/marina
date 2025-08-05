from fastapi import FastAPI
from pydantic import BaseModel as ModelBase

server = FastAPI()

class RequestData(ModelBase):
    name: str
    age: int

@server.post("/marina")
def handle_submission(payload: RequestData):
    return {"message": f"{payload.name} has been successfully handled"}
