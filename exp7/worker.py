from fastapi import FastAPI, Request
import uvicorn

app = FastAPI()


@app.post("/webhook/s3-event")
async def handle_s3_upload(request: Request):

    payload = await request.json()

    print("\n================ EVENT RECEIVED ================")

    if "Records" in payload:

        for record in payload["Records"]:

            event_name = record.get("eventName", "Unknown")

            bucket_name = (
                record.get("s3", {})
                .get("bucket", {})
                .get("name")
            )

            object_key = (
                record.get("s3", {})
                .get("object", {})
                .get("key")
            )

            object_size = (
                record.get("s3", {})
                .get("object", {})
                .get("size")
            )

            etag = (
                record.get("s3", {})
                .get("object", {})
                .get("eTag")
            )

            print(f"Event Type   : {event_name}")
            print(f"Bucket       : {bucket_name}")
            print(f"Object Key   : {object_key}")
            print(f"Object Size  : {object_size} bytes")
            print(f"ETag         : {etag}")

            print("Processing   : Background computation started...")

            # Simulated background processing
            print("Processing   : File metadata extracted successfully.")

    print("================================================\n")

    return {
        "status": "SUCCESS",
        "message": "Event processed successfully"
    }


if __name__ == "__main__":
    uvicorn.run(
        app,
        host="0.0.0.0",
        port=5000
    )