import 'dart:async';

import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart';

/* Example function payload
 {"databaseId":"stage","collectionId":"profiles"}

Successful function response:
{"success":true}

Error function response:
{"success":false,"message":"Collection not found."}
*/

void returnSuccess(final res, final data) {
  res.json({"success": true});
}

void returnFailure(final res, final String message) {
  res.json({
    'success': false,
    'message': message,
  }, status: 500);
}

Future<void> start(final req, final res) async {
  if (!checkEnvVariables(req, res) || !checkPayload(req.payload, res)) {
    return;
  }
  String databaseId = req.payload['databaseId'];
  String collectionId = req.payload['collectionId'];
  String endpoint = req.variables['APPWRITE_FUNCTION_ENDPOINT'];
  String project = req.variables['APPWRITE_FUNCTION_PROJECT_ID'];

  //delete all documents in collection
  try {
    Client client = Client();
    client.setEndpoint(endpoint).setProject(project).setSelfSigned();
    Databases databases = Databases(client);
    DocumentList documents = await databases.listDocuments(
      databaseId: databaseId,
      collectionId: collectionId,
    );

    for (Document document in documents.documents) {
      await databases.deleteDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: document.$id,
      );
    }
  } catch (e) {
    returnFailure(res, "error: $e");
  }
}

bool checkEnvVariables(final req, final res) {
  if (req.variables['APPWRITE_FUNCTION_PROJECT_ID'] == null) {
    returnFailure(res, "APPWRITE_FUNCTION_PROJECT_ID is empty");
    return false;
  } else if (req.variables['APPWRITE_FUNCTION_ENDPOINT'] == null) {
    returnFailure(res, "APPWRITE_FUNCTION_ENDPOINT is empty");
    return false;
  }
  return true;
}

bool checkPayload(Map<String, dynamic> payload, final res) {
  if (payload['databaseId'] == null) {
    returnFailure(res, "Payload has incorrect data, databaseId is empty");
    return false;
  } else if (payload['collectionId'] == null) {
    returnFailure(res, "Payload has incorrect data, collectionId is empty");
    return false;
  }
  return true;
}
