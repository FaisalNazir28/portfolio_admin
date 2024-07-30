'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "c72b0f80be65d776c8f7df880cc0b491",
".git/config": "b41775c9312cbb94fbe3f4d50e5cbe14",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/FETCH_HEAD": "7aaea513ac2af861e12bf929d4aa2baa",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "a57a71d7c27367b6cc9289ffc76f7f37",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "0537ad92f67a80ecdc81c457ab8a5c03",
".git/logs/refs/heads/main": "15ab721099247e032e46e7248b3a2eb5",
".git/logs/refs/remotes/origin/main": "f8bf5b87224ba49669cf26ed15cbdd37",
".git/logs/refs/remotes/origin/master": "c8f933993b75df6768e9a53c5f9ffd63",
".git/objects/00/83debe03db0465effb6d76b2c2349168342a26": "c73b622af08783753e3e3316c3376224",
".git/objects/04/c25ed9a3fb3d33f24b4d957a5dadd2f3f55c75": "8f368ff7a5d8bc22c5227d9491d27ba3",
".git/objects/09/6b090dd5f3e0ea0ccc5937c888183c32dc8f83": "3ce8450a3d177b9705a34508bac07514",
".git/objects/0f/c344c7e8b9e32ea1ad91f30ded22556352d7bf": "a8a30f28869f7378465338066f34d80d",
".git/objects/10/8f42085c193eca2b2e9e8732a8bcb5dbde4247": "92a0efb4c1fbd849bf030116a7f58bec",
".git/objects/18/eb401097242a0ec205d5f8abd29a4c5e09c5a3": "4e08af90d04a082aab5eee741258a1dc",
".git/objects/1f/a32c3e5c6b984537d6294423266d9033af67dc": "cd5c6068d9d35d198bc523af084ab83e",
".git/objects/20/1afe538261bd7f9a38bed0524669398070d046": "82a4d6c731c1d8cdc48bce3ab3c11172",
".git/objects/20/cb2f80169bf29d673844d2bb6a73bc04f3bfb8": "b807949265987310dc442dc3f9f492a2",
".git/objects/22/3573e719b7c4e3c308c15b7547779f63b3d493": "01ae467c73df8f62a6df2e9f96c6e44d",
".git/objects/24/6d34dbd0686aef8d912350c32884951b4cc57a": "d3b357aa336628eb99b4c681bca262e3",
".git/objects/25/0fc4b7c0644100d7745943c703ae8463ce2a4d": "c3a23aea3566d7e693924310253abb7d",
".git/objects/26/08a5757151f999bd492a24341d3f7e24be7c02": "848fa0f0cdec1bece20b10fa11ed8f49",
".git/objects/2e/d2413d0450c04af23744c93dfdf086a89624be": "92515fb4eebf826e73e1210a474a621d",
".git/objects/31/067b233bfe8231c0dee826ba23eecb22b9ab49": "6415e902ad38873ca74d0be9ed01e265",
".git/objects/32/18f8dcc4d0f9700cc3578d300a106b2fa65bf8": "0f20cf4d282b35e7138379e6ce344262",
".git/objects/36/e007fa3fea5efb7e9113bd468db92561666f75": "c1ef95a2473d42d8857bb8d3a8b8b547",
".git/objects/44/9ed350fb7a290b50deb2c53970139d4269c995": "df282e4cd2face6e053c5d5103ea4846",
".git/objects/49/adebdb511c8c293b28db3f6792e5bac28cdc32": "ba6a3971e7f06834fd6ec3844372ce17",
".git/objects/4d/480c1f5691ccb4ad78df17f82f39194c002d35": "6f3bc064f178d2ec749b08095f06cdb0",
".git/objects/4f/71bb3ae54c5a90c5782b061fbff92df9c47a60": "efcc86fc9295c7cd7acaa8b492e7f95f",
".git/objects/51/ac2ed45adf3cb7f599906f97bbe2b9066f435a": "cdd723250bc64d4148ef816266af9d71",
".git/objects/53/ea3bb85447e8f9c550fa1a3152860ac2ccbfca": "1dee4fd51c6df5bba51609dc4ad4855a",
".git/objects/58/356635d1dc89f2ed71c73cf27d5eaf97d956cd": "f61f92e39b9805320d2895056208c1b7",
".git/objects/58/b007afeab6938f7283db26299ce2de9475d842": "6c6cbea527763bb3cdff2cecfee91721",
".git/objects/5b/3be1b70f6188168a55419ddc00e35e9dc0f302": "e4a9027d62c5f0b0b9ac0a44a10bfaf7",
".git/objects/62/c89ee094658c7a9465824fdb42793a64ea557b": "133cd5da638f245b079d9e9cdc29ae38",
".git/objects/63/c6900a0af868bd705350f9e8e5372d110ad09d": "7e55a9901fddf337ee0ed02ab14a72af",
".git/objects/6a/ac02bcf0934a3751c45faffb4ecbb5efc74b43": "f07fd68b8b6bfe5f90d34c67cc829aad",
".git/objects/6c/01c3e88a46a1e5319ed7547d5077812293628f": "dfff45ad14f0397a328bb8da2ce78fb7",
".git/objects/70/ebf183d51dd6bb5dd3d97c5bbcf1bfaa79afce": "a585f6f9d94d52d443a6101dfb63f1df",
".git/objects/71/3f932c591e8f661aa4a8e54c32c196262fd574": "66c6c54fbdf71902cb7321617d5fa33c",
".git/objects/72/2583053bae6e822b5b3399946aa213c2c3fed2": "34c857cf01b2407b67118acfad8165d5",
".git/objects/77/05350f25b631372bc46dfedea9899fc16d8a96": "518c1b95dc84f9d8bc2ec211adf56d20",
".git/objects/77/5b27c7a6c138d47ac91104533e1775cc5df3f1": "021b5c79363f0ecfcf3547b4dc668daf",
".git/objects/7a/8e32ff81974002ef0258be2c0b389eb7a16959": "894d622dd58509d02daa69d77e9931a2",
".git/objects/7c/d749f85fd6228800bdf60a5882fcf7661ffdff": "c82d3d66f10e53085ac2162f10366f81",
".git/objects/7f/ace25699ff91c76d462bda5096a8920937e71b": "4246183043e43e9e9617508235bc35ec",
".git/objects/85/bd3820697e81da7661f7957ee69c744759dca5": "7a9b5ebd79731e145ca4b1c8285b91c9",
".git/objects/87/a514062462fa49afe39eeab2ea6ee4c609f83c": "8bed0687d535b9cb3634bce549bae7a5",
".git/objects/88/8d9aa49f8c8a936bfe81cfa9ed86203f93b168": "394ebe702c49383fcbd68ec1c3440659",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/93/d6eaaff43211eacb03d62985a6df2e0bc3f2c9": "3211edb4b25b395769e0e146f9751a04",
".git/objects/94/f7d06e926d627b554eb130e3c3522a941d670a": "77a772baf4c39f0a3a9e45f3e4b285bb",
".git/objects/95/c97820a795b342158419612a16106c11a07c62": "420dd7efad541d2ef69f9dc2e1c2b0a4",
".git/objects/95/d440a2cd2ece7abeb6abaa735200ce303af648": "dc32cfdc751954db35aa7fd21cd8e9bb",
".git/objects/99/7824b02b98d670ac7283a45ae19a787e5993b0": "0a5deef02da7002ad03f5dbfb8d81327",
".git/objects/a6/49654bbae2a6ff85371fef5797d43aac959075": "b98db4b91030eee44b787f39480fdf6b",
".git/objects/a7/9c93ecb610dee8d91a6c61d3ab1e9b07516497": "7de52c1c874a9f4218e70fb718b8bc91",
".git/objects/ad/050ebc63373b9450066b86ac2a95e93907b0f3": "f32ca024646c912857193939078b33ee",
".git/objects/b0/59c7acb2aa7480362c31ba21a3a0b7295961bc": "861177224b60ca2ab6d4913ce4421308",
".git/objects/b3/ebbd38f666d4ffa1a394c5de15582f9d7ca6c0": "23010709b2d5951ca2b3be3dd49f09df",
".git/objects/b5/e000dfa2646858d3df8af242adaa3eaa674b04": "af29b746e07d972d9c25c043949352d6",
".git/objects/b7/2d4c42822e07f5198971acf4ee01fd8f0beb6e": "be62101b8cbe2389dcc546709a07b155",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/be/7ba19691be894365f8fbad53ff8265ed74ac79": "bfc2c280ad2cc1a9b952f8200090b684",
".git/objects/be/e54b785456d505bae71c926ea25bb585b460c4": "8ff8b3a496e386d9c904390b478f000c",
".git/objects/bf/f474f151a2bac40c0afda821e96b321c73a4d2": "dede80d420a7945bd44a2427a4bcd192",
".git/objects/c4/79d6daf51ee08c332f4569f3dd03dd218da0d8": "b26b562af9e4b97899bb99ae297b04c0",
".git/objects/c9/bf8af1b92c723b589cc9afadff1013fa0a0213": "632f11e7fee6909d99ecfd9eeab30973",
".git/objects/d1/098e7588881061719e47766c43f49be0c3e38e": "f17e6af17b09b0874aa518914cfe9d8c",
".git/objects/d2/da82904e19b6e5353285dcdfa0e7840c70bdd7": "332f075bfb9e0ed0d1ebf214ba9c8cee",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d5/05abdbaeca0ad5e2b095273afd52fb4c6e551a": "1a6678f01d66c82a4cf747293f1f7faa",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/d8/7c021c5aebf48832e938beb3a485dda0305ab6": "973b9dd587943556e230f39ef1270e10",
".git/objects/d8/c1b00d18821c8c00796b925f50f87b79eba6fd": "9ca34b07e88f2a2420b805978f37c86b",
".git/objects/d9/d3190f536621a018fcd8f475efee1e5c6a53ba": "96ba9df9a4e2118ed10be6ff59858f9d",
".git/objects/d9/fbff1a1963ed7947c32d6c39382b943a806fbf": "a3bb73f0d4c38173182f7beefbd87c8d",
".git/objects/db/f748904c26cdc6eec14d5cf104a8cc665a0d86": "36caef474872c34f3d2fda8b6ecad43f",
".git/objects/e0/1d88d9eaef3c143c6a395129e06abf26a645d0": "5aaf885dea2b3016c7b577dff88ddb33",
".git/objects/e4/57c85d2324d21f2161982f9234c3706c6756f2": "c21e82c9103defb946f19207d0fef239",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/ed/592eb51a552e9d1521401787fcdcf62c09b333": "4b6a623e15dbd230c5d5c3d62258fb63",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f6/8d81dd71ba46128ad7d5989a11c9ce78c8977f": "ccad65ceb83311f6d4dba7ed279147ce",
".git/objects/f8/13d55ce1baacec97c290c3f9cfbfec127463f2": "98a05c6404e41b7354de7f3f3e2f830c",
".git/objects/fa/aacce4fed2d654d3e3438722861aa1d294c821": "b9dddc8625e4509b77125d0f703d27fc",
".git/objects/fd/3d7caf696dd84867dff77cd4c0e56ac2c32f06": "f1d52100841f2bce081c6528c6133588",
".git/objects/ff/6eeb28462c41abd5443693928349b721b7f1ab": "0da696720b48adb37646cfec2d7f9591",
".git/objects/pack/pack-c64f89d1117bcbfcc00847049ef43581bdc3bc3c.idx": "83ae474e15eb29611d67d935e5d0e551",
".git/objects/pack/pack-c64f89d1117bcbfcc00847049ef43581bdc3bc3c.pack": "00775f258d87fe1614a1d5f5b0d4c101",
".git/objects/pack/pack-c64f89d1117bcbfcc00847049ef43581bdc3bc3c.rev": "75614e07cc3e71cf5b426c29d29402c4",
".git/ORIG_HEAD": "22c3e135d9de2ccd7a1109a924aaeedf",
".git/refs/heads/main": "4754915ccee0659bd90d0491168fa233",
".git/refs/remotes/origin/main": "4754915ccee0659bd90d0491168fa233",
".git/refs/remotes/origin/master": "fac5ca6bba8e8272cd94202e1e6ac3cb",
"assets/AssetManifest.bin": "1169e3682558a92a4a5aefb27f50d0e3",
"assets/AssetManifest.bin.json": "6d512697ead41425b4f130ffc1636f91",
"assets/AssetManifest.json": "936236750adb6e318cd7892a6f3e710f",
"assets/assets/backgrounds/bg1.jpg": "aa9abe4601cffa958cb667a53266e55a",
"assets/assets/backgrounds/bg2.jpg": "f86c471c90d537b96b839d3a01342bb0",
"assets/assets/backgrounds/login_background.jpg": "70a458da84f9f538f36222b9f8015b51",
"assets/assets/logo/404.png": "596f521a8677c1d0ba6334e230501105",
"assets/assets/profiles/faisal.png": "097a7c3e3388e166b857a004227479f9",
"assets/FontManifest.json": "66b71d2bcd2b436ab06cceee43157084",
"assets/fonts/MaterialIcons-Regular.otf": "c81393dbba2daab15c8f875446e39ba8",
"assets/NOTICES": "00c3b49402f5942c218ce37112977367",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "16ddffe0be869c393c3d21bd56a05263",
"assets/packages/ionicons/assets/fonts/Ionicons.ttf": "757f33cf07178f986e73b03f8c195bd6",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"flutter_bootstrap.js": "ee4f58508d8910dddac5007098b66982",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "be160030836ae48f6d2674e42b3ff8ac",
"/": "be160030836ae48f6d2674e42b3ff8ac",
"main.dart.js": "38effc2633eb123585e013bbec75e385",
"manifest.json": "813e043ec04670a686a793c3ad0e036b",
"version.json": "c8c10f1f25aa64ced37e7028f8e4fb9e"};
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
