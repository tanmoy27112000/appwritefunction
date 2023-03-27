# Wipe appwrite collection

A Dart Cloud Function for wiping all documents in a collection.

* Make sure to set the `APPWRITE_FUNCTION_ENDPOINT` and `APPWRITE_FUNCTION_PROJECT_ID` environment variables in your function settings.

_Example input 1:_

```json
{"databaseId":"6414d8143114e42c1926","collectionId":"6414d81dabc278ef9147"}
```

_Example output 1:_

```json
{
  "success": true,
}
```

_Example input 2:_

```json
{"databaseId":"stage","collectionId":""}
```

_Example output 2:_

```json
{
  "success": false,
  "message": "Collection not found."
}
```

## 📝 Environment Variables

List of environment variables used by this cloud function:

* **APPWRITE_FUNCTION_ENDPOINT** - Your Appwrite Endpoint
* **APPWRITE_FUNCTION_PROJECT_ID** - Your Appwrite Project ID

## 🚀 Deployment

1. Clone this repository, and enter this function folder:

```shell
git clone https://github.com/open-runtimes/examples.git && cd examples
cd dart/wipe_appwrite_collection
```

2. Enter this function folder and build the code:

```shell
docker run -e INTERNAL_RUNTIME_ENTRYPOINT=lib/main.dart --rm --interactive --tty --volume $PWD:/usr/code openruntimes/dart:v2-2.17 sh /usr/local/src/build.sh
```

As a result, a `code.tar.gz` file will be generated.

3. Start the Open Runtime:

```shell
docker run -p 3000:3000 -e INTERNAL_RUNTIME_KEY=secret-key --rm --interactive --tty --volume $PWD/code.tar.gz:/tmp/code.tar.gz:ro openruntimes/dart:v2-2.17 sh /usr/local/src/start.sh
```

Your function is now listening on port `3000`, and you can execute it by sending `POST` request with appropriate
authorization headers. To learn more about runtime, you can visit Dart
runtime [README](https://github.com/open-runtimes/open-runtimes/tree/main/runtimes/dart-2.17).

4. Execute function:

```shell
curl http://localhost:3000/ -d '{"variables":{"APPWRITE_FUNCTION_ENDPOINT":"YOUR_APPWRITE_FUNCTION_ENDPOINT","APPWRITE_FUNCTION_PROJECT_ID":"YOUR_APPWRITE_FUNCTION_PROJECT_ID"},"payload":{"databaseId":"stage","collectionId":"profiles"}}' -H "X-Internal-Challenge: secret-key" -H "Content-Type: application/json"
```

## 📝 Notes

* This function is designed for use with Appwrite Cloud Functions. You can learn more about it
  in [Appwrite docs](https://appwrite.io/docs/functions).
* This example is compatible with Dart 2.17. Other versions may work but are not guaranteed to work as they haven't been
  tested. Versions below Dart 2.14 will not work, because Apwrite SDK requires Dart 2.14,
