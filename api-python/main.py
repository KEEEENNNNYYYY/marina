from fastapi import FastAPI, Request
import httpx

app = FastAPI()
MARINA_URL = "https://marina-yourname.onrender.com"


@app.get("/")
async def root():
    return {"message": "API Python proxy de Marina fonctionne 🎉"}

@app.api_route("/{path:path}", methods=["GET"])
async def proxy(request: Request, path: str):
    async with httpx.AsyncClient() as client:
        method = request.method.lower()
        body = await request.body()
        headers = dict(request.headers)
        url = f"{MARINA_URL}/{path}"
        response = await client.request(method, url, data=body, headers=headers)
    return response.json()
