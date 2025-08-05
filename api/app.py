from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class Formula(BaseModel):
    name: str
    age: int

@app.post("/marina")
def create_formula(formula: Formula):
    return {"message": f"Received formula from {formula.name}"}
