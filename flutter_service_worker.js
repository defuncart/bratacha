'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "a06a77044ccc6f8d75ea3b4e807d8518",
"assets/assets/flags/mg.svg": "61c027d18e2c12a149a977de6855bf61",
"assets/assets/flags/sv.svg": "809c809ef52da7486b60b07197211223",
"assets/assets/flags/cy.svg": "c8c9e8d7992c69b72029183b895f1e9d",
"assets/assets/flags/ls.svg": "f3d2be4851752e385fe363017f4022af",
"assets/assets/flags/qa.svg": "0f41621e2f76a771941796825a442a1b",
"assets/assets/flags/cl.svg": "e9972ef7a0e53d50486b82d3eb0c1033",
"assets/assets/flags/cv.svg": "38fc1a76abfc07fe0805efb8e5c43d8c",
"assets/assets/flags/za.svg": "ed8748665f2a26422f905aca2cff3971",
"assets/assets/flags/er.svg": "67749836655647d24bf5f47e8a370474",
"assets/assets/flags/bi.svg": "22c12b5ae0b08fd5b5f2031ea91e174e",
"assets/assets/flags/vc.svg": "95d10af8b33f75258fd1dad1ce490563",
"assets/assets/flags/lb.svg": "42903152d08e43b58d8137c6eb0be559",
"assets/assets/flags/gm.svg": "71793191aba9d31d6c0cfd8e2283548f",
"assets/assets/flags/mn.svg": "1766f13d231d4546c7d01669e27083b4",
"assets/assets/flags/fm.svg": "8430ada9ad2b0350ccbadd9bf46a8892",
"assets/assets/flags/id.svg": "6203798445365fd2f6aca38a31671aa8",
"assets/assets/flags/mh.svg": "7ae66d69a662b7a836f60ccafa248009",
"assets/assets/flags/lk.svg": "e4950f16cc89b893e1550d68942a1cf6",
"assets/assets/flags/om.svg": "c804795d15bfa59cfff2abf80decdd17",
"assets/assets/flags/at.svg": "e6aa1b76183d5adab2f6b12bb7d3ca47",
"assets/assets/flags/cu.svg": "7f0efb57bae73814d36b72fe4a5e5a8e",
"assets/assets/flags/gb.svg": "ca683b00b9e74b6f4e5e2208f4c680e5",
"assets/assets/flags/kg.svg": "f6189c468fd005f7d23d875a3efc7166",
"assets/assets/flags/ml.svg": "84ac86e2ebee38a305dc14f7a1d9b623",
"assets/assets/flags/ss.svg": "374ff353e2f245fe5c49115a042e04b6",
"assets/assets/flags/sd.svg": "dcab590e365a146b8f0d7a3a3a9f269c",
"assets/assets/flags/pg.svg": "9daa38679d2f78b34bcfc45154304772",
"assets/assets/flags/cn.svg": "32667780740d20d079b6f54bb2ac3c6e",
"assets/assets/flags/hr.svg": "61bb31eba12260879cc8188649558834",
"assets/assets/flags/jo.svg": "59e898eb5c9a2033b11541360f53c9a5",
"assets/assets/flags/nr.svg": "b328fae89f09e3009fec057e06e9d4db",
"assets/assets/flags/in.svg": "68e57f17f013fab91125050d73b3ab66",
"assets/assets/flags/jp.svg": "cd1a389d8eb29456f4922cea4192f955",
"assets/assets/flags/sb.svg": "a320c8b39e5bc734b29bac0c73f67e30",
"assets/assets/flags/rs.svg": "d4f9cff9f2c713e19227717d9c3e4232",
"assets/assets/flags/ni.svg": "0f8d29ad9d395708199edd71fd5ab200",
"assets/assets/flags/sl.svg": "27a5a7d4c52fea93a7da29398fa3ae7e",
"assets/assets/flags/bs.svg": "7487e6dd7b5b17d0f237f573c15fb80a",
"assets/assets/flags/ao.svg": "cea4fb36688d01e3ffe37e42bad8c5e9",
"assets/assets/flags/ru.svg": "a0d92b057b857f9cd8181b9a22ddc582",
"assets/assets/flags/tr.svg": "b1921aee311224f97add729c53734a54",
"assets/assets/flags/bd.svg": "fd116ecaf46fcd722026f1c404a40b3e",
"assets/assets/flags/tz.svg": "af15037da39907b10fae58c9a9e7ddf4",
"assets/assets/flags/gn.svg": "8117f5363fbcb9cadca897dd32194607",
"assets/assets/flags/dj.svg": "2b0cbf523344efc09a26abe800747c95",
"assets/assets/flags/lv.svg": "9d3a77dd19258f099397e72b0e0c3015",
"assets/assets/flags/so.svg": "370894230ea4cb7644be4db9c6f56ed8",
"assets/assets/flags/nl.svg": "f9373fa6157f15b54f58870bb8debed8",
"assets/assets/flags/pk.svg": "f3e87423f9f2660436ef8a431df9f3e3",
"assets/assets/flags/il.svg": "a55032f59745ed1841b588a3d367f21a",
"assets/assets/flags/kp.svg": "47a69e7b12e6ee8f72313349376b926a",
"assets/assets/flags/hu.svg": "3b76ec1e3c2ea757f0da4680c8565430",
"assets/assets/flags/ma.svg": "f469818794caeea4ffd4e4fbdef6ef83",
"assets/assets/flags/am.svg": "8ea979f5d7cf69280537a6979cfde8f0",
"assets/assets/flags/sm.svg": "6fa5c284ea375a18938003f4cf054881",
"assets/assets/flags/kh.svg": "67e37fcdd5bb92ad78b117edc865d75c",
"assets/assets/flags/al.svg": "db3d069219bccd2d3a2aea5167b80b85",
"assets/assets/flags/cm.svg": "ae758a2d40b07152b50e8a9df9925e5c",
"assets/assets/flags/sg.svg": "fe0d91a436615fac9ea106164ac8c69a",
"assets/assets/flags/lu.svg": "5f7dc0f8baba5f82914ee4223a28183e",
"assets/assets/flags/iq.svg": "11bc6dd293414834474d865050330bc6",
"assets/assets/flags/na.svg": "35d7d0b6ab6d7b5f10505ed4e902f2d3",
"assets/assets/flags/pl.svg": "95ac75133b1ff09dd206bc8bb8b2da93",
"assets/assets/flags/sy.svg": "aaae9a50a68cc6e7f0b362beb0131922",
"assets/assets/flags/fr.svg": "5dc9481bb80428f68678fc1f60812e7e",
"assets/assets/flags/me.svg": "24f49632bea1090703c0a8e00f2807a9",
"assets/assets/flags/dk.svg": "b2d6a3b4062cced64a6116c2b29c8c08",
"assets/assets/flags/bt.svg": "ac8f99cdbaed8bbf9f6b54867c5ce78e",
"assets/assets/flags/lr.svg": "215029cad6675ab79363d0d6a5317e52",
"assets/assets/flags/mw.svg": "cf67d8d1bdea3a92196c5cd0e27652b8",
"assets/assets/flags/mc.svg": "42303781b1be40383e3c8a7e1a087cce",
"assets/assets/flags/si.svg": "f5fe6f3cf4c5bf706d85b8db87074ca4",
"assets/assets/flags/tj.svg": "13cc94643caec9ea116a1fc9533bfbdb",
"assets/assets/flags/de.svg": "ecef78fd916612f8cd8acfba52e65919",
"assets/assets/flags/ci.svg": "390b8ae226a9b767dd8e1a57c79b4bf7",
"assets/assets/flags/ua.svg": "4a2da0e87d22f601a9e87eb2378a8550",
"assets/assets/flags/ge.svg": "004250f249884f554d5b776d94288680",
"assets/assets/flags/ga.svg": "58c02268865d926b8d8b0f651e57e92b",
"assets/assets/flags/kw.svg": "ca3f4c59f9751ead4d806a72ae3740cc",
"assets/assets/flags/cd.svg": "584b596fafb5cacdab89560aab142048",
"assets/assets/flags/ly.svg": "f1bf8b3a4c06909193cb2a9b4fdb8000",
"assets/assets/flags/ch.svg": "d838559389daf5dcd882e3a43886212f",
"assets/assets/flags/sc.svg": "eaa67a098477e14cf9ac2897c148a722",
"assets/assets/flags/bn.svg": "d7bbe99f94e1d7390fd28eda03e41412",
"assets/assets/flags/co.svg": "5c502787dfd59ead8e8b3fb889541e58",
"assets/assets/flags/ne.svg": "44619a97c73cba165262ac9976a5881a",
"assets/assets/flags/kz.svg": "fa6361c796dd9b46a2dae42aa1a7709c",
"assets/assets/flags/sr.svg": "8df5896175e45aa42b3aac12d98914bd",
"assets/assets/flags/us.svg": "da51d8c7e7defc29ad4a18760d25f07e",
"assets/assets/flags/ug.svg": "f8a14ecc46d52321d80cd7c8acc8216e",
"assets/assets/flags/vu.svg": "a5cebac41aff8ad7641c02072ec7854c",
"assets/assets/flags/az.svg": "be2ad8d3517babc868b6c297f834d595",
"assets/assets/flags/ng.svg": "6c340f83bf92134ff6a8f6cd27150a26",
"assets/assets/flags/ba.svg": "e0d3b6a3049b364e1702f9f241354b46",
"assets/assets/flags/gr.svg": "1abff2288033e36d22ca7ffa6eeff14b",
"assets/assets/flags/dm.svg": "e6f27889849166dc3e932c22cdfb4c85",
"assets/assets/flags/is.svg": "2e587e15a4479b02b80a4355edbba28a",
"assets/assets/flags/do.svg": "8ecb460e0f9aec1afd58f1b1359bf7f5",
"assets/assets/flags/br.svg": "ba862f82f5af3399848b6a776942f5ea",
"assets/assets/flags/ki.svg": "dd60354d5980ce303ae5a3a41f937089",
"assets/assets/flags/st.svg": "10e3c9bc93776ace3545a19c8df6644a",
"assets/assets/flags/bz.svg": "de3576608601150f043c064a6aaac59e",
"assets/assets/flags/gw.svg": "fade2c897596ad317df52485ebe279dd",
"assets/assets/flags/lt.svg": "a262a4312aecdc0d0183bee55d30cb90",
"assets/assets/flags/sn.svg": "df816a64379b1dc57eb2d360cfc70452",
"assets/assets/flags/km.svg": "d19e5dafb6b744edd946c3ce24d7d90c",
"assets/assets/flags/kn.svg": "89e16aee4748af84818e85c4ea928658",
"assets/assets/flags/sa.svg": "346ae8d5f23091071e332ee951229976",
"assets/assets/flags/fi.svg": "cecb71a78cd528bbdbc85a910e61324e",
"assets/assets/flags/ph.svg": "f51ffdc422191a5f3ebaf3a20c73a2ab",
"assets/assets/flags/fj.svg": "a8c5520eca9e6d9e5206390d2fb71b4a",
"assets/assets/flags/tv.svg": "b233b34722a43a7ed0ab5cf12af2ef06",
"assets/assets/flags/mu.svg": "cc9177816696a3fc99f1fa1bbc4e1ce2",
"assets/assets/flags/pt.svg": "beec0c04ac6c082045968bc30bbfe18f",
"assets/assets/flags/dz.svg": "311e9156ceb6616dd4717aedf15017be",
"assets/assets/flags/nz.svg": "5d966a1263b33afaf3244c74b0878e3e",
"assets/assets/flags/gt.svg": "55acb897c46e44744b0301eed8a64613",
"assets/assets/flags/ws.svg": "3118cd21a3aab3fd3c93931aa20627aa",
"assets/assets/flags/bh.svg": "105529685db630aac3bcf2dbe86521ce",
"assets/assets/flags/be.svg": "b4092de8115cc6f82a0958b386c38b79",
"assets/assets/flags/gy.svg": "b7e183da8e498304733ef8cd65286226",
"assets/assets/flags/np.svg": "b3814b79089b7d2b87ab709bb7e97b0b",
"assets/assets/flags/pe.svg": "6c3577c7e0fd3b8ec37ec6a255a2e9b2",
"assets/assets/flags/to.svg": "5f0f637c42d0b0c31dd8ce049422c836",
"assets/assets/flags/au.svg": "c1ddbf910a57ff3878c6f25fb8770be0",
"assets/assets/flags/ke.svg": "6933bbe049dd956a355674472764cda7",
"assets/assets/flags/th.svg": "6001090cb627cdc721414a87704ade53",
"assets/assets/flags/hn.svg": "7abbb17d627966eac82b69b69a303752",
"assets/assets/flags/by.svg": "7ff1ec07c6f0fd1d144f0de5bfd291d1",
"assets/assets/flags/ht.svg": "8169d9413d8591d004699753c0548438",
"assets/assets/flags/mt.svg": "0a06a1eef7e4590ac9f0d38cb50c7536",
"assets/assets/flags/bf.svg": "9385467b49a805108296681cea57aff8",
"assets/assets/flags/tg.svg": "c8ec6a14f4059371a8e396c2daff5eef",
"assets/assets/flags/tm.svg": "470020cf20ee450dc0c1581694c8e8c9",
"assets/assets/flags/li.svg": "8b26f179add97c9d5bc8159e0707f639",
"assets/assets/flags/jm.svg": "d7b25bb2bb08315c5ab8d00b051da61b",
"assets/assets/flags/mr.svg": "84ca8329fc3c2a6b5366094bbb0ca668",
"assets/assets/flags/bg.svg": "2758f7dda793393c901c39b243be786e",
"assets/assets/flags/sk.svg": "8b96cfeb8e8518ad4f5344914eed8cea",
"assets/assets/flags/ir.svg": "7e5763d29fd8103548b14dd7d50232f4",
"assets/assets/flags/gq.svg": "50838abb298b6fcb60f571171ede0eeb",
"assets/assets/flags/no.svg": "60cd05cbba666fc9dd69b71235b05ca5",
"assets/assets/flags/gh.svg": "8d6ab9696ce3e64eb5f05d6e3e3da836",
"assets/assets/flags/my.svg": "d900c32589d7e47a621285674d51622e",
"assets/assets/flags/uy.svg": "e5f7dc5ff3282d5ef1188bbabcb31223",
"assets/assets/flags/vn.svg": "5a8ab48b2dbe5f3e8bbd5469a5749ea2",
"assets/assets/flags/ec.svg": "f7e81cae44867c29e04a42ce9aeb272d",
"assets/assets/flags/tl.svg": "a3bc7e9773d69be54af5a8017c9bf1c3",
"assets/assets/flags/tt.svg": "53fe943fae490a9243a05ac451d0d374",
"assets/assets/flags/cz.svg": "664c65faff216055213aafd8993de311",
"assets/assets/flags/tn.svg": "be5b1d0c0cc80db171ba92d257747370",
"assets/assets/flags/bo.svg": "314c3ff8a80bfbfb27d6ec941d7dc023",
"assets/assets/flags/es.svg": "73971af94039075b460cd9e00ff445e7",
"assets/assets/flags/ae.svg": "25e3521f84c880f13e5dd5f9faff3846",
"assets/assets/flags/sz.svg": "d9cbd88514b0a0d9455501fe22a1d2b6",
"assets/assets/flags/kr.svg": "4ba7fa9b8a69ccd5041d254ed7eb1d19",
"assets/assets/flags/bj.svg": "68e8998f27077b3998c0981b531cb3ab",
"assets/assets/flags/gd.svg": "914b85c1c60f58d3e8c8dc3eff3b129a",
"assets/assets/flags/uz.svg": "8ceae758da31cd4e19e3fb5ce567422d",
"assets/assets/flags/cf.svg": "54aa0e3612763f0356f4be3cc65ac0e0",
"assets/assets/flags/mm.svg": "8fa97244c7d0a2bd9b1cbf0f223f5551",
"assets/assets/flags/ca.svg": "f5a69c97d10c88f335b8aa14a29326b6",
"assets/assets/flags/lc.svg": "b5f6f4503a1d591c15037f40b31b81c8",
"assets/assets/flags/bw.svg": "0a25933b8d5c045c57159ebcdb38491f",
"assets/assets/flags/ag.svg": "78d52dfa8bba13202ae45c57b9a9c564",
"assets/assets/flags/pw.svg": "bebae68986bb30b4097155ca9760c3e5",
"assets/assets/flags/cg.svg": "2186628ecdf90da74286913d4b09a0dd",
"assets/assets/flags/la.svg": "e0abd54e5f63f70531ee1b28b28f3ef8",
"assets/assets/flags/ad.svg": "0ddbf3e4caf5ac1038d3a10bd1740d7b",
"assets/assets/flags/zw.svg": "aeb1ff087e7937b9ce0c0527afa669a0",
"assets/assets/flags/it.svg": "ad14683e773e1915913e381bd6e33cc2",
"assets/assets/flags/ie.svg": "67f36d592a8b228087f58f9d8c5a4dbc",
"assets/assets/flags/mz.svg": "0dc26ba10d8efa256ce03bc8c447fdf5",
"assets/assets/flags/mk.svg": "959a092cc9cce118b1249069023c6998",
"assets/assets/flags/mv.svg": "24e29c9f85e9df9a6541752d9c2bfeef",
"assets/assets/flags/rw.svg": "3c7fe654cc88806ba1ed54590c7955c9",
"assets/assets/flags/cr.svg": "0f2f19985b315c1f2cbe053b71a6af5d",
"assets/assets/flags/mx.svg": "33dbd738cf2d1af67e76e0d3adbb2c98",
"assets/assets/flags/td.svg": "f296fe927cc7c01afe19db7361ed7f9e",
"assets/assets/flags/zm.svg": "05d12ec832c0d5ddcba69a11c1bf72bc",
"assets/assets/flags/pa.svg": "8b830c8b0b914d63dbb8d0256dc700df",
"assets/assets/flags/ve.svg": "8355575cc70207f45b8976fdbf8d3f8e",
"assets/assets/flags/se.svg": "db2a9d7de101a6582d52f42fe999b0b1",
"assets/assets/flags/py.svg": "81676ea39f37f8483d0d5ecd1325fa10",
"assets/assets/flags/eg.svg": "3116eb05f888c5cb05e8d634a3f60f20",
"assets/assets/flags/bb.svg": "95b3237488574644c191061c9f9640d5",
"assets/assets/flags/ro.svg": "caa1ec1e57590dabeda60d04aa0b3e26",
"assets/assets/flags/et.svg": "75ba70e27d234eff3a385c6f5e3abf0a",
"assets/assets/flags/ye.svg": "3f8de2d4110060e723f303517481ae01",
"assets/assets/flags/ee.svg": "f677960a1d9ee4ab377273a5fededbb2",
"assets/assets/flags/ar.svg": "733032d80c359e5a6cdb98d2836eab67",
"assets/assets/flags/af.svg": "dd875c29cff9cb02934e8fb00bf0ca7e",
"assets/assets/flags/md.svg": "159ad719079d4682ceb72efda6bd0a9b",
"assets/assets/languages/cy.svg": "6bb23e6f560e78b52532e20e758ebc9b",
"assets/assets/languages/ga.svg": "67f36d592a8b228087f58f9d8c5a4dbc",
"assets/assets/languages/en.svg": "ca683b00b9e74b6f4e5e2208f4c680e5",
"assets/assets/languages/be.svg": "7ff1ec07c6f0fd1d144f0de5bfd291d1",
"assets/assets/settings/app_icon.png": "fa70e34902d2ef1f030d29679f60462d",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"assets/AssetManifest.json": "cfdaa5f6b3da7366bbea79ce57cadcdf",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/NOTICES": "b3fc9bfed8411a15556acc3b439da674",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"main.dart.js": "feee359e3c533709e1e464594e96245f",
"favicon.png": "5eacee62474154676a454937d477eed0",
"index.html": "2ac0993b51e2d4cb472b661dd46ee5b6",
"/": "2ac0993b51e2d4cb472b661dd46ee5b6",
"manifest.json": "414df30e5903633b1e47e0929c6775bd",
"icons/Icon-512.png": "0da76c9b771d172683c21790447dfb63",
"icons/Icon-192.png": "bb7b56447ba3584c5418834006b62221"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value + '?revision=' + RESOURCES[value], {'cache': 'reload'})));
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
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
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
  for (var resourceKey in Object.keys(RESOURCES)) {
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
