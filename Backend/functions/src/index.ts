import {setGlobalOptions} from "firebase-functions";
import {defineSecret} from "firebase-functions/params";
import {onCall, HttpsError} from "firebase-functions/https";
import * as logger from "firebase-functions/logger";
import {initializeApp} from "firebase-admin/app";
import {getStorage, getDownloadURL} from "firebase-admin/storage";
import {randomUUID} from "crypto";
import OpenAI from "openai";

initializeApp();
setGlobalOptions({maxInstances: 10});
const openAIKey = defineSecret("OPENAI_API_KEY");

export const generateAvatarImage = onCall(
  {secrets: [openAIKey], timeoutSeconds: 120},
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "Sign in first");
    }
    const uid = request.auth.uid;

    const description = request.data.description;
    if (typeof description !== "string" || description.trim() === "") {
      throw new HttpsError("invalid-argument", "Description is required");
    }

    const openai = new OpenAI({apiKey: openAIKey.value()});

    let base64: string | undefined;
    try {
      const result = await openai.images.generate({
        model: "gpt-image-2.5-flare",
        prompt: `Portrait avatar of a character: ${description}`,
        size: "1024x1024",
      });
      base64 = result.data?.[0]?.b64_json;
    } catch (error) {
      logger.error("OpenAI request failed", error);
      if (error instanceof OpenAI.APIError && error.code === "moderation_blocked") {
        throw new HttpsError(
          "invalid-argument",
          "The image was blocked by the safety system. Try a different description."
        );
      }
      throw new HttpsError("internal", "Image generation failed");
    }

    if (!base64) {
      throw new HttpsError("internal", "OpenAI returned no image");
    }

    const buffer = Buffer.from(base64, "base64");
    const file = getStorage().bucket().file(`avatars/${uid}/${randomUUID()}.png`);
    await file.save(buffer, {contentType: "image/png"});
    const imageURL = await getDownloadURL(file);

    return {imageURL};
  }
);