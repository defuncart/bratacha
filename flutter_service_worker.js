'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"icons/Icon-512.png": "33809c0b2b13eed95cc1df9c3eb6db16",
"icons/Icon-maskable-512.png": "33809c0b2b13eed95cc1df9c3eb6db16",
"icons/Icon-192.png": "8643af6ae794d90cc40fafaff4d5c096",
"icons/Icon-maskable-192.png": "8643af6ae794d90cc40fafaff4d5c096",
"manifest.json": "fe72d22ceefe095ccc31521a57788b0f",
"index.html": "cc061536d1504bba221ca8cb8dcdc166",
"/": "cc061536d1504bba221ca8cb8dcdc166",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "ec7f50123688e13167e3e90c6bdb540a",
"assets/assets/languages/be.svg": "253fa4ffae9dedc93afe4f3a07c40094",
"assets/assets/languages/ga.svg": "110efbf8a9a95ec3384b8b45dc5bc607",
"assets/assets/languages/en.svg": "5c231c8fb3adf7a11c96381b875231b7",
"assets/assets/languages/cy.svg": "c488ecae68ddf5574c36b7e5782f6954",
"assets/assets/flags/pk.svg": "f0eea2745a73fcad663607f58bcc86a7",
"assets/assets/flags/mn.svg": "1453fd3afa77a86cd8e4ae7999902ddc",
"assets/assets/flags/lb.svg": "371ccb6104dda922a01dc472e5afd766",
"assets/assets/flags/th.svg": "18046547363916c7bdfe4556f7cd6989",
"assets/assets/flags/mg.svg": "b23fb375f4dc2242ad3e9df8c9d1e2fc",
"assets/assets/flags/mu.svg": "b111c44ad076945213b75dc8ec0b9ee4",
"assets/assets/flags/mc.svg": "585834807536af77d01bb714e142528a",
"assets/assets/flags/eg.svg": "e4add16bd50e02c145a400ce364b64fb",
"assets/assets/flags/st.svg": "7a4c09c4c8243454a8d049871ad0a30a",
"assets/assets/flags/ye.svg": "7d9f64e2c1379366c1f3ae61234f4b77",
"assets/assets/flags/dk.svg": "079b834714bed8a2a943d5985cd8140c",
"assets/assets/flags/cl.svg": "7ecdf25d613d4749ec22e3c955028154",
"assets/assets/flags/ml.svg": "e264a6264f02dd9b1afba338062b2d75",
"assets/assets/flags/kg.svg": "a6432dc58a4fe33de9c702b8c7d41104",
"assets/assets/flags/ar.svg": "9eb0cff108724a6e0b3b5281069c428e",
"assets/assets/flags/jo.svg": "df05ffe05025fcf2f9abbb3cb4b9fe7b",
"assets/assets/flags/es.svg": "5e33621fe2508b8a20230cf350b1fa8f",
"assets/assets/flags/cr.svg": "a7d3b3129756d3ff6d8d9e0e5fc07c7c",
"assets/assets/flags/tg.svg": "945c4ba6c9db4520ad1e2b5127c97bc9",
"assets/assets/flags/kr.svg": "5602ba0bad1e235c6cfdbd090affe59a",
"assets/assets/flags/la.svg": "1a47b431554ef34afcbba92404cf6c62",
"assets/assets/flags/ve.svg": "3810d5851842b8c714d7d32f41f805e8",
"assets/assets/flags/id.svg": "b966e5565c7ca5538622eafdcc091c45",
"assets/assets/flags/cu.svg": "1d121afbf676c3567c2d15dbd95372d0",
"assets/assets/flags/mh.svg": "91d72a8fd1e93543191d9628749e28c7",
"assets/assets/flags/bo.svg": "a7e737f7948ad5e0823786316df90d64",
"assets/assets/flags/tl.svg": "7b14f1d7d33c6d21b9543c5fb14a2407",
"assets/assets/flags/jp.svg": "b246edf04ee2ba6fa967722cdab72860",
"assets/assets/flags/gy.svg": "c14a87b8ad0c71d9d82120b4699a29d7",
"assets/assets/flags/mm.svg": "558c0aff00891dfe4b5249f8ae1ccfae",
"assets/assets/flags/gt.svg": "a6ffbd293be3d09f73610506a7e78efd",
"assets/assets/flags/ae.svg": "e07b35d07ee5ef0f3f2b6aefe103d17d",
"assets/assets/flags/si.svg": "1126b6a8b927bc396158c436a23d8bc5",
"assets/assets/flags/ao.svg": "53e3b152c1d239fc9c10420ae213dc8e",
"assets/assets/flags/ci.svg": "4914b40504850ce7fa40aa544f981d3e",
"assets/assets/flags/am.svg": "8a063b9e5908a3f0dd57b5aa4deeb852",
"assets/assets/flags/gw.svg": "e8c8d32ea529b326e80fd05aa33f0364",
"assets/assets/flags/vn.svg": "f36729772a1f3e23e0076bc0da0b399d",
"assets/assets/flags/rw.svg": "1e372dfa76bdd20d0b3b3662cef11256",
"assets/assets/flags/tt.svg": "911f9e9e9d79c518da9bae23d0cd3687",
"assets/assets/flags/sz.svg": "a1425bf53f17a3d9c260ed0f59ebf14f",
"assets/assets/flags/ag.svg": "272679259da03e76cf20c93c3d96534f",
"assets/assets/flags/bs.svg": "988026a242f4bcdb79fa827a69d0c654",
"assets/assets/flags/ee.svg": "0c07b4c1ce4791a450a59182a8aff72a",
"assets/assets/flags/bf.svg": "7194e2401226188f053b48d5d41ba00d",
"assets/assets/flags/to.svg": "ed0e1091a188b0c14c20a47d943cd29c",
"assets/assets/flags/fr.svg": "770376a19bf07e9e33726baabac4647c",
"assets/assets/flags/sc.svg": "29da75118abb5d8283e743f70df21469",
"assets/assets/flags/do.svg": "a801db1ee096d44d0b6177288e24389a",
"assets/assets/flags/rs.svg": "262bf3138ff7e970f8057936e874f1b7",
"assets/assets/flags/so.svg": "0702ef60b183c11827787d18d2da1963",
"assets/assets/flags/bt.svg": "35894501838edc452ad27ede50a0ee12",
"assets/assets/flags/ru.svg": "71400f6107cbe7a4c07a3160e6c2a985",
"assets/assets/flags/py.svg": "03453a7d65eb5d2e02bb0864d578cc17",
"assets/assets/flags/be.svg": "5f46a468ef29754430c958a719f197f5",
"assets/assets/flags/fm.svg": "3f4f42d4ae3f23b35a84b89da04a4ab6",
"assets/assets/flags/vu.svg": "2728f0be6f113e9950882ac3fc75b473",
"assets/assets/flags/ma.svg": "7fe34c1e160dc851310c1a6469a8379a",
"assets/assets/flags/sr.svg": "5bd4f0200ffd168102aa2e4b9a16ab83",
"assets/assets/flags/se.svg": "478ae8846b330ff8c010a1b28a74e43f",
"assets/assets/flags/by.svg": "253fa4ffae9dedc93afe4f3a07c40094",
"assets/assets/flags/cg.svg": "a3ffdcc522c984dd2c086de3f82d1d1d",
"assets/assets/flags/au.svg": "bdee5945d74c02a44318ea14bd9039d0",
"assets/assets/flags/mw.svg": "7237249f559f872e19e3c9925c5f3b0c",
"assets/assets/flags/cf.svg": "cbd95957781f73a837a6333aa980a253",
"assets/assets/flags/pa.svg": "53fd74a16500839978fe8d89b8727b1e",
"assets/assets/flags/bb.svg": "e9416451e235926ff5435dfcfda9f23a",
"assets/assets/flags/ng.svg": "b9197e69f00cd0f998a46b0080c23229",
"assets/assets/flags/hu.svg": "ac606833cdcf0da0803709ac75c75036",
"assets/assets/flags/dj.svg": "271749e9807ca793cc6e89e813f2c17f",
"assets/assets/flags/bn.svg": "6a5109e314e90e08e7104650a76b5a6c",
"assets/assets/flags/hr.svg": "3ae76f21460f8331cd2e523b2d6f5379",
"assets/assets/flags/gh.svg": "bf3974229d159627713bc77fa6ddddee",
"assets/assets/flags/br.svg": "88f7033910ab7ec9d16adfed076e59a0",
"assets/assets/flags/ec.svg": "47afca0e578b8a1277564bdef3d41740",
"assets/assets/flags/iq.svg": "b9b5e1d11989c7f5494a1b881de97dd0",
"assets/assets/flags/jm.svg": "34f033141d45145e5d289b92430f0934",
"assets/assets/flags/ht.svg": "1c893134728e2ed651adcc75153fcc34",
"assets/assets/flags/ch.svg": "9f295dfce66ba565655e91d247284005",
"assets/assets/flags/nl.svg": "325ba0f4a9a56f440b68362e8474df98",
"assets/assets/flags/mx.svg": "59aac71a8ead3c5859bdaa7d58fb7422",
"assets/assets/flags/kh.svg": "f293ed3f265d250f73c2678bd321d558",
"assets/assets/flags/ga.svg": "1aa26b2be2f1faf8c75476e95f09c453",
"assets/assets/flags/gd.svg": "d6a401a4d4a484f8c537060ae18d1861",
"assets/assets/flags/fi.svg": "5b3833a61c8740336765c46c89c2a6f6",
"assets/assets/flags/gq.svg": "90f8d8d42b548961b5853de764b67cfd",
"assets/assets/flags/tr.svg": "8d5fa6f464f7ccd92d5fda95ef685511",
"assets/assets/flags/sn.svg": "eed2f85384a1674211601ebf35a9bc72",
"assets/assets/flags/pw.svg": "529d8fc055a559996805e9382a55267b",
"assets/assets/flags/ie.svg": "110efbf8a9a95ec3384b8b45dc5bc607",
"assets/assets/flags/vc.svg": "e7980daea33fa64c3f6ddb0a68a7a3f1",
"assets/assets/flags/kz.svg": "be7c7d5f6630bcc85c004114ddc82818",
"assets/assets/flags/ba.svg": "0aed361f2d655f8abe99a45ad87da614",
"assets/assets/flags/lv.svg": "eeafeb0fec4b2b31672ac508265f1712",
"assets/assets/flags/pt.svg": "b19cce57f4b122b0d8ff42c427396dcf",
"assets/assets/flags/tm.svg": "3bd4270e9e27418b2eccf0e2247712f9",
"assets/assets/flags/tv.svg": "58748d51b2bfc83e9f85688e7f7d7660",
"assets/assets/flags/ge.svg": "2c75c3b0d70e6d766ec1d1300d4f2520",
"assets/assets/flags/dm.svg": "fe187b2111c75f046a3a81eeb7d92c6a",
"assets/assets/flags/kw.svg": "188a4f5b71d4659deef411860977d235",
"assets/assets/flags/lt.svg": "39f9399afe4e99afc7807a3614269ea6",
"assets/assets/flags/bi.svg": "093899b2ae47de3deccb633c4574c0d1",
"assets/assets/flags/sv.svg": "cd0f7708ce1174487b64afc007ddbf33",
"assets/assets/flags/ki.svg": "46f24dc27e67942aa36fede083271b0a",
"assets/assets/flags/ug.svg": "56ef70ea462276ddea7c956aee7e77b7",
"assets/assets/flags/mv.svg": "8ea7a65ef62eec34311194b49971388c",
"assets/assets/flags/uz.svg": "76b3fe1188fe514bd49847d9cadf534c",
"assets/assets/flags/at.svg": "b9ccc08ccd7b199f5f5850f2d815db3b",
"assets/assets/flags/td.svg": "69f44e06b96acc2ba68af163d1545f38",
"assets/assets/flags/cv.svg": "825501fd112391d6910c47b364ecfd71",
"assets/assets/flags/me.svg": "f7b0cbd867ed75f6829c9c68e8d748c7",
"assets/assets/flags/gr.svg": "398239dd784ae5d4687d84ccbd54160e",
"assets/assets/flags/lr.svg": "eb501af34b90f37f6c9fbb02ada61877",
"assets/assets/flags/ro.svg": "18358326c569c5d7584a6000ad4c87bf",
"assets/assets/flags/my.svg": "c93df666419c2279257b7a63ae9fe890",
"assets/assets/flags/tz.svg": "d7cd03ce107a918309a0ba00a68ae600",
"assets/assets/flags/na.svg": "ed1264f65cbd1427c8278c76ea7524fd",
"assets/assets/flags/gb.svg": "5c231c8fb3adf7a11c96381b875231b7",
"assets/assets/flags/uy.svg": "5a27099c830d788e45e12702747ea01e",
"assets/assets/flags/bh.svg": "ee0ac09528486a658d0d2ec5c6d90ba1",
"assets/assets/flags/sl.svg": "7fac599c42ea5816c0bb90036aeffbf6",
"assets/assets/flags/sk.svg": "1d34393730d2ab1cf1fbc290f07b00c2",
"assets/assets/flags/lc.svg": "add759b4c82c49dcf23732d89b85e5da",
"assets/assets/flags/al.svg": "d5153b9d545bf72c61ca64cd66ee4183",
"assets/assets/flags/bj.svg": "9295d49d3017c2de0275446585683bcb",
"assets/assets/flags/om.svg": "7a50700e9ecfb3f961c981574f383564",
"assets/assets/flags/za.svg": "aacb67f74183e59e459718e84e25083f",
"assets/assets/flags/il.svg": "ceec49687e9b72ccf5756544a51a9439",
"assets/assets/flags/dz.svg": "e8688062e43dbd51e6458acefd84d15f",
"assets/assets/flags/co.svg": "2d27993064a890abf252036cf65d3319",
"assets/assets/flags/tj.svg": "8d999f8210a13ea09020d25576f756d9",
"assets/assets/flags/az.svg": "3de3d8b1e3145e175ea62091729c0566",
"assets/assets/flags/cn.svg": "919d001e1dc5c6bec7b89b99e7c99204",
"assets/assets/flags/nz.svg": "9ca78c0ed507c2272deef6de2d751d4a",
"assets/assets/flags/md.svg": "731eb462d16c929f47d811670871f5f7",
"assets/assets/flags/sm.svg": "ff909c3148606635eeb9384ad91d9475",
"assets/assets/flags/hn.svg": "9007c6204972533afaf0270ac89c865a",
"assets/assets/flags/sd.svg": "b5cc2c49b6e350b18df22207063c31b2",
"assets/assets/flags/bg.svg": "e5036532821a419884b5d5f0246cf227",
"assets/assets/flags/np.svg": "c7ee89d39c75d3177ddf4a214f515d7a",
"assets/assets/flags/pg.svg": "b8dd145a2a7b04209eab76aa203b9673",
"assets/assets/flags/tn.svg": "f09f623a19bf799d342efacb204394e9",
"assets/assets/flags/fj.svg": "f5d304617b9617da5dd9f97f057a62af",
"assets/assets/flags/in.svg": "0f1bb937c02d38fdaaa536ab0c9eb672",
"assets/assets/flags/nr.svg": "bed9d473f3d6f0515e1e68806bfa5a6b",
"assets/assets/flags/ua.svg": "4437573c77341db30e92c4d5883944bb",
"assets/assets/flags/ws.svg": "9dcd85be09f67d107265077e58629892",
"assets/assets/flags/qa.svg": "18d1be0cfaec50bbb14025ca3cb2ae74",
"assets/assets/flags/ls.svg": "b13846178d92f01c33f2b1137c8f7dd3",
"assets/assets/flags/bw.svg": "8f8ee94584bf69b36206d7acc2e44631",
"assets/assets/flags/de.svg": "3b979153dc5aba7cd1d27634fd64a097",
"assets/assets/flags/et.svg": "d8a76881fec95e82ba33f316c33a56ca",
"assets/assets/flags/er.svg": "3d5e54ef808e2dd7aff81ec2d7952630",
"assets/assets/flags/bd.svg": "9a6cf43247bf4c3024eabccb5c3e6e30",
"assets/assets/flags/pl.svg": "8dae965602d8036252672fc2f07977eb",
"assets/assets/flags/ir.svg": "3ec6dec62e4444473313a3623a20655c",
"assets/assets/flags/gm.svg": "301e054b9f8d6489cdbfa02c14fdd11b",
"assets/assets/flags/no.svg": "93a89ef2894bcbf6c82115737277da87",
"assets/assets/flags/pe.svg": "c24592822e43b439651ed978e200750f",
"assets/assets/flags/us.svg": "2357e16e08ade6cff5a5ba49b03393aa",
"assets/assets/flags/zm.svg": "25895d14279847a2df4e79baad5cc23f",
"assets/assets/flags/ne.svg": "052dc6649ad238e3437d2bf997edae29",
"assets/assets/flags/ke.svg": "71edb78dca7f0f8f233cea5e89a3daff",
"assets/assets/flags/cm.svg": "ccb1df206ce7c3a509055d1892c0b783",
"assets/assets/flags/it.svg": "5dd499d625a2415aef316563427b867a",
"assets/assets/flags/cd.svg": "b12eeb694cee78e585fd2324b98053f3",
"assets/assets/flags/ss.svg": "b77163c337bb75543e8fab4d5dbd05ab",
"assets/assets/flags/bz.svg": "ff2b6d9816b9c979f0394b22c652c129",
"assets/assets/flags/km.svg": "19941245b93921db679384e8c9f10885",
"assets/assets/flags/lk.svg": "b32c31d5e0a8ab4702d47f41c8c002ee",
"assets/assets/flags/ad.svg": "a7b1fa0a3a6a05c1b6ce87cb4b70085e",
"assets/assets/flags/ly.svg": "b8b33d150a62b56d75b12d91133db73a",
"assets/assets/flags/sg.svg": "cef716653c2dc8095f4dde9023a0a599",
"assets/assets/flags/ca.svg": "4f67be07db374b31b5fea5902e540895",
"assets/assets/flags/gn.svg": "b95b7a545b0fc81827a37a219024900b",
"assets/assets/flags/af.svg": "b3ac9a1d8f4908568cd4e95c4e1d3e01",
"assets/assets/flags/cz.svg": "8ffb243fd5351444af894f75415fbf16",
"assets/assets/flags/li.svg": "7ee8a5622a320cc3e3c4b4bfb2de9a4a",
"assets/assets/flags/mk.svg": "aa4bb76fa561509b29d63cd3edd8a1a9",
"assets/assets/flags/sb.svg": "7d350026e53312393cfc23027b75769e",
"assets/assets/flags/mz.svg": "14d1cfae7f26e5f56c23556a466364e6",
"assets/assets/flags/sy.svg": "e13324f113df129041a4c51919ddadeb",
"assets/assets/flags/lu.svg": "e744a4a1b85051788e6ca530c9182d17",
"assets/assets/flags/kn.svg": "9d06fec1cd1f2dbbd23340b1a44f79c6",
"assets/assets/flags/mt.svg": "79bbdd4f2c7a0747b8503bc52ee07448",
"assets/assets/flags/kp.svg": "669316f7e98ebf489bd5f8bfd6eb7fcc",
"assets/assets/flags/sa.svg": "7520b2f8bc670bd3b6721d67256edb4c",
"assets/assets/flags/mr.svg": "d2f11d8354cbddd85a84a4ff40494ce3",
"assets/assets/flags/is.svg": "f6aedbc9e20e4339647eac8d4fd7c8b1",
"assets/assets/flags/ni.svg": "430dcffb8976f4424ae0a71a18c87cf4",
"assets/assets/flags/ph.svg": "8f080515b1133c2ee1ab4bdd7bc59abd",
"assets/assets/flags/zw.svg": "4222885131ea0cf0b01c4c135996b69b",
"assets/assets/flags/cy.svg": "3bc400e676aba37fdd5dffcbf49b25c9",
"assets/fonts/MaterialIcons-Regular.otf": "cc8aaa8e0520c3112ef38d3bea3f812b",
"assets/NOTICES": "4e98c076264f6be81ed5d6737b2fa896",
"assets/packages/material_design_icons_flutter/lib/fonts/materialdesignicons-webfont.ttf": "3759b2f7a51e83c64a58cfe07b96a8ee",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/FontManifest.json": "23d5e382cedd20ca8083c7dc0ab27c79",
"assets/AssetManifest.bin": "71ae8b579592f844abce7a08b6f1383f",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"favicon.png": "495a2f82b5a25dcc751e9a86e776b1b4",
"flutter_bootstrap.js": "3ed25e11bfa63c81cc26baecb86d7e7c",
"version.json": "1803f801742122fc29e259019a07629f",
"main.dart.js": "a04cbaec42b36634f70dde822ca57db9"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
