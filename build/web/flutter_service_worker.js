'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "66b681cb5c7993f2243c5e02ae4af4ae",
"favicon.ico": "befcd573e767bc93beb20768b8a54536",
"index.html": "3264be9f77cecf1869ecf1938d88541d",
"/": "3264be9f77cecf1869ecf1938d88541d",
"main.dart.js": "6d2b1aca42e02c1d73d0948306a4d915",
"flutter.js": "7d69e653079438abfbb24b82a655b0a4",
"icons/android-chrome-192x192.png": "f0d4b6c06c2a7847d84d338c73a556de",
"icons/apple-touch-icon.png": "117a18fe1f09d8f37216c45272fd0ae2",
"icons/android-chrome-512x512.png": "1ac84b126f3104dc47a2a01f52b7e63a",
"manifest.json": "5653911849daee846a2edfd00f2fe7f1",
"assets/AssetManifest.json": "d0214552d744c5669c5e66111a18b791",
"assets/NOTICES": "679271c97b23adf277d8d06c8f4c880d",
"assets/FontManifest.json": "4c421cc30d1605ca01138fe533b2b9e9",
"assets/AssetManifest.bin.json": "d755d9f83ca2d6cba3debf8a150decf8",
"assets/packages/awesome_snackbar_content/assets/types/warning.svg": "cfcc5fcb570129febe890f2e117615e0",
"assets/packages/awesome_snackbar_content/assets/types/failure.svg": "cb9e759ee55687836e9c1f20480dd9c8",
"assets/packages/awesome_snackbar_content/assets/types/success.svg": "6e273a8f41cd45839b2e3a36747189ac",
"assets/packages/awesome_snackbar_content/assets/types/help.svg": "7fb350b5c30bde7deeb3160f591461ff",
"assets/packages/awesome_snackbar_content/assets/back.svg": "ba1c3aebba280f23f5509bd42dab958d",
"assets/packages/awesome_snackbar_content/assets/bubbles.svg": "1df6817bf509ee4e615fe821bc6dabd9",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/packages/google_places_flutter/images/location.json": "afa33acf2c340246c901718f4efdfccf",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"assets/lib/assets/images/inflow_blue_top.png": "f7da8535833d93921c243814687acd17",
"assets/lib/assets/images/logout_logo.jpg": "23567202a766b6e6a08f181d199cb107",
"assets/lib/assets/images/resizeToDesktop.png": "c8b51c05099516a0333f39e0b5af9993",
"assets/lib/assets/images/urbantransit_logo.jpg": "b17be4fab0a798171cf22deae006d9cc",
"assets/lib/assets/images/driver_logo.jpg": "e5cfa66cb8c1c2c782124ba952aea098",
"assets/lib/assets/images/nile_uni_logo.png": "31db8dd55406e51725901c981b2f2720",
"assets/lib/assets/images/nile_uni_logo.jpg": "b7b535eadc94f1758203d74a8e9f2fb4",
"assets/lib/assets/images/user3.png": "2c575f5f8ce854fa4360d9a8a382e3f1",
"assets/lib/assets/images/user2.png": "1643e66ae4726273f1cc8a5c1b66d4fe",
"assets/lib/assets/images/inflow_orange_base.png": "35be7a586c5941a46aadf6a6daca0a64",
"assets/lib/assets/images/user1.png": "e6153f527cb8ae10a1fea41a99bf9e11",
"assets/lib/assets/images/notifications_logo.jpg": "f6167c860747fdd5f9bfd2df0b0490e5",
"assets/lib/assets/images/default_user.png": "681c706a96806e506622a367c2568010",
"assets/lib/assets/images/inflow_green_base.png": "a3fbef19baca6f89a2386c9e335ec1c0",
"assets/lib/assets/images/inflow_logo.jpg": "452f82b5797b3f2ac7c84ff0b1e34519",
"assets/lib/assets/images/inflow_orange_top.png": "908581db91cd34d43a4316461a1ed3e6",
"assets/lib/assets/images/shimmerMap.png": "233f6af6d20e693323d6332c55e2bf93",
"assets/lib/assets/images/dashboard_logo.jpg": "2f598753643b13dc32272a4e1d6efe47",
"assets/lib/assets/images/inflow_blue_base.png": "6a8495c288af963cd96c7cca27e76b63",
"assets/lib/assets/images/inflow_green_top.png": "08ff12e96b556e39b81af58cf15add64",
"assets/lib/assets/images/temp_logo.png": "732958ab7d9fa8b0fd4180b04323e53e",
"assets/lib/assets/icons/driver.svg": "c3739a4152a3318972ad200f3144ea32",
"assets/lib/assets/icons/logout.svg": "ee3d243c31d1d6dc26cbd053730511aa",
"assets/lib/assets/icons/greyBus.svg": "502fea7e61c9bdfe693a09309c264eeb",
"assets/lib/assets/icons/dashboard.svg": "32b5218f5812bab2aa157f168ea27671",
"assets/lib/assets/icons/yellowBus.svg": "9425c80b56593a6d4d02cdba280f4fce",
"assets/lib/assets/icons/nile_logo.svg": "0d3b2a36f383f83bfa2269adab488842",
"assets/lib/assets/icons/greenBus.svg": "b8add7417ff4ac4bbfc1261cb7b60659",
"assets/lib/assets/icons/notifications.svg": "6cfe5113a5b6878b1cf055d1e30721c2",
"assets/lib/assets/icons/upload.svg": "5a6d0e864bb6ad835eea31de756ae948",
"assets/lib/assets/icons/filterIcon.svg": "157243bdfe3867b32cbf3ef037e5e9d0",
"assets/lib/assets/icons/inflow.svg": "2981dbb9fda563d27dc6545f349428e5",
"assets/AssetManifest.bin": "1e42e77e6e1e304915584e03adcaced9",
"assets/fonts/Inter-Medium.ttf": "ed533866b5c83114c7dddbcbc2288b19",
"assets/fonts/Inter-Light.ttf": "d55f45d07cfe01e8797bd1566561f718",
"assets/fonts/Inter-Regular.ttf": "079af0e2936ccb99b391ddc0bbb73dcb",
"assets/fonts/MaterialIcons-Regular.otf": "e886a0c7a745540656b0172dcb94a51d",
"assets/fonts/Inter-SemiBold.ttf": "07a48beb92b401297a76ff9f6aedd0ed",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "2fc47c0a0c3c7af8542b601634fe9674",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "143af6ff368f9cd21c863bfa4274c406",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/canvaskit.wasm": "73584c1a3367e3eaf757647a8f5c5989",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
