// Web Bot Auth key directory for blr.today, signed per draft-meunier-http-message-signatures-directory-03
const PATH = "/.well-known/http-message-signatures-directory";
const TTL = 300;

const b64url = (buf) =>
  btoa(String.fromCharCode(...new Uint8Array(buf))).replace(/\+/g, "-").replace(/\//g, "_").replace(/=+$/, "");

const b64 = (buf) => btoa(String.fromCharCode(...new Uint8Array(buf)));

function pemToDer(pem) {
  const body = pem.replace(/-----[^-]+-----/g, "").replace(/\s+/g, "");
  return Uint8Array.from(atob(body), (c) => c.charCodeAt(0));
}

async function loadKey(pem) {
  const privateKey = await crypto.subtle.importKey("pkcs8", pemToDer(pem), { name: "Ed25519" }, true, ["sign"]);
  const { x } = await crypto.subtle.exportKey("jwk", privateKey);
  const canonical = JSON.stringify({ crv: "Ed25519", kty: "OKP", x });
  const keyid = b64url(await crypto.subtle.digest("SHA-256", new TextEncoder().encode(canonical)));
  return { privateKey, keyid, jwk: { kty: "OKP", crv: "Ed25519", x } };
}

export default {
  async fetch(request, env) {
    const url = new URL(request.url);
    if (url.pathname !== PATH) {
      return new Response("Not found\n", { status: 404 });
    }
    const { privateKey, keyid, jwk } = await loadKey(env.WEB_BOT_AUTH_KEY);
    const created = Math.floor(Date.now() / 1000);
    const params =
      `("@authority";req);alg="ed25519";keyid="${keyid}";` +
      `tag="http-message-signatures-directory";created=${created};expires=${created + TTL}`;
    const base = `"@authority";req: ${env.AUTHORITY}\n"@signature-params": ${params}`;
    const signature = await crypto.subtle.sign({ name: "Ed25519" }, privateKey, new TextEncoder().encode(base));
    return new Response(JSON.stringify({ keys: [jwk] }), {
      headers: {
        "Content-Type": "application/http-message-signatures-directory+json",
        "Cache-Control": "public, max-age=60",
        "Signature-Input": `sig1=${params}`,
        Signature: `sig1=:${b64(signature)}:`,
      },
    });
  },
};
