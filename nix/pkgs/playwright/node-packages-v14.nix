# This file has been generated by node2nix 1.8.0. Do not edit!

{nodeEnv, fetchurl, fetchgit, globalBuildInputs ? []}:

let
  sources = {
    "@types/node-14.0.13" = {
      name = "_at_types_slash_node";
      packageName = "@types/node";
      version = "14.0.13";
      src = fetchurl {
        url = "https://registry.npmjs.org/@types/node/-/node-14.0.13.tgz";
        sha512 = "rouEWBImiRaSJsVA+ITTFM6ZxibuAlTuNOCyxVbwreu6k6+ujs7DfnU9o+PShFhET78pMBl3eH+AGSI5eOTkPA==";
      };
    };
    "@types/yauzl-2.9.1" = {
      name = "_at_types_slash_yauzl";
      packageName = "@types/yauzl";
      version = "2.9.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/@types/yauzl/-/yauzl-2.9.1.tgz";
        sha512 = "A1b8SU4D10uoPjwb0lnHmmu8wZhR9d+9o2PKBQT2jU5YPTKsxac6M2qGAdY7VcL+dHHhARVUDmeg0rOrcd9EjA==";
      };
    };
    "agent-base-4.3.0" = {
      name = "agent-base";
      packageName = "agent-base";
      version = "4.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/agent-base/-/agent-base-4.3.0.tgz";
        sha512 = "salcGninV0nPrwpGNn4VTXBb1SOuXQBiqbrNXoeizJsHrsL6ERFM2Ne3JUSBWRE6aeNJI2ROP/WEEIDUiDe3cg==";
      };
    };
    "async-limiter-1.0.1" = {
      name = "async-limiter";
      packageName = "async-limiter";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/async-limiter/-/async-limiter-1.0.1.tgz";
        sha512 = "csOlWGAcRFJaI6m+F2WKdnMKr4HhdhFVBk0H/QbJFMCr+uO2kwohwXQPxw/9OCxp05r5ghVBFSyioixx3gfkNQ==";
      };
    };
    "balanced-match-1.0.0" = {
      name = "balanced-match";
      packageName = "balanced-match";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/balanced-match/-/balanced-match-1.0.0.tgz";
        sha1 = "89b4d199ab2bee49de164ea02b89ce462d71b767";
      };
    };
    "brace-expansion-1.1.11" = {
      name = "brace-expansion";
      packageName = "brace-expansion";
      version = "1.1.11";
      src = fetchurl {
        url = "https://registry.npmjs.org/brace-expansion/-/brace-expansion-1.1.11.tgz";
        sha512 = "iCuPHDFgrHX7H2vEI/5xpz07zSHB00TpugqhmYtVmMO6518mCuRMoOYFldEBl0g187ufozdaHgWKcYFb61qGiA==";
      };
    };
    "buffer-crc32-0.2.13" = {
      name = "buffer-crc32";
      packageName = "buffer-crc32";
      version = "0.2.13";
      src = fetchurl {
        url = "https://registry.npmjs.org/buffer-crc32/-/buffer-crc32-0.2.13.tgz";
        sha1 = "0d333e3f00eac50aa1454abd30ef8c2a5d9a7242";
      };
    };
    "concat-map-0.0.1" = {
      name = "concat-map";
      packageName = "concat-map";
      version = "0.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/concat-map/-/concat-map-0.0.1.tgz";
        sha1 = "d8a96bd77fd68df7793a73036a3ba0d5405d477b";
      };
    };
    "debug-3.2.6" = {
      name = "debug";
      packageName = "debug";
      version = "3.2.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/debug/-/debug-3.2.6.tgz";
        sha512 = "mel+jf7nrtEl5Pn1Qx46zARXKDpBbvzezse7p7LqINmdoIk8PYP5SySaxEmYv6TZ0JyEKA1hsCId6DIhgITtWQ==";
      };
    };
    "debug-4.2.0" = {
      name = "debug";
      packageName = "debug";
      version = "4.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/debug/-/debug-4.2.0.tgz";
        sha512 = "IX2ncY78vDTjZMFUdmsvIRFY2Cf4FnD0wRs+nQwJU8Lu99/tPFdb0VybiiMTPe3I6rQmwsqQqRBvxU+bZ/I8sg==";
      };
    };
    "end-of-stream-1.4.4" = {
      name = "end-of-stream";
      packageName = "end-of-stream";
      version = "1.4.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/end-of-stream/-/end-of-stream-1.4.4.tgz";
        sha512 = "+uw1inIHVPQoaVuHzRyXd21icM+cnt4CzD5rW+NC1wjOUSTOs+Te7FOv7AhN7vS9x/oIyhLP5PR1H+phQAHu5Q==";
      };
    };
    "es6-promise-4.2.8" = {
      name = "es6-promise";
      packageName = "es6-promise";
      version = "4.2.8";
      src = fetchurl {
        url = "https://registry.npmjs.org/es6-promise/-/es6-promise-4.2.8.tgz";
        sha512 = "HJDGx5daxeIvxdBxvG2cb9g4tEvwIk3i8+nhX0yGrYmZUzbkdg8QbDevheDB8gd0//uPj4c1EQua8Q+MViT0/w==";
      };
    };
    "es6-promisify-5.0.0" = {
      name = "es6-promisify";
      packageName = "es6-promisify";
      version = "5.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/es6-promisify/-/es6-promisify-5.0.0.tgz";
        sha1 = "5109d62f3e56ea967c4b63505aef08291c8a5203";
      };
    };
    "extract-zip-2.0.1" = {
      name = "extract-zip";
      packageName = "extract-zip";
      version = "2.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/extract-zip/-/extract-zip-2.0.1.tgz";
        sha512 = "GDhU9ntwuKyGXdZBUgTIe+vXnWj0fppUEtMDL0+idd5Sta8TGpHssn/eusA9mrPr9qNDym6SxAYZjNvCn/9RBg==";
      };
    };
    "fd-slicer-1.1.0" = {
      name = "fd-slicer";
      packageName = "fd-slicer";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/fd-slicer/-/fd-slicer-1.1.0.tgz";
        sha1 = "25c7c89cb1f9077f8891bbe61d8f390eae256f1e";
      };
    };
    "fs.realpath-1.0.0" = {
      name = "fs.realpath";
      packageName = "fs.realpath";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/fs.realpath/-/fs.realpath-1.0.0.tgz";
        sha1 = "1504ad2523158caa40db4a2787cb01411994ea4f";
      };
    };
    "get-stream-5.1.0" = {
      name = "get-stream";
      packageName = "get-stream";
      version = "5.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/get-stream/-/get-stream-5.1.0.tgz";
        sha512 = "EXr1FOzrzTfGeL0gQdeFEvOMm2mzMOglyiOXSTpPC+iAjAKftbr3jpCMWynogwYnM+eSj9sHGc6wjIcDvYiygw==";
      };
    };
    "glob-7.1.6" = {
      name = "glob";
      packageName = "glob";
      version = "7.1.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/glob/-/glob-7.1.6.tgz";
        sha512 = "LwaxwyZ72Lk7vZINtNNrywX0ZuLyStrdDtabefZKAY5ZGJhVtgdznluResxNmPitE0SAO+O26sWTHeKSI2wMBA==";
      };
    };
    "https-proxy-agent-3.0.1" = {
      name = "https-proxy-agent";
      packageName = "https-proxy-agent";
      version = "3.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/https-proxy-agent/-/https-proxy-agent-3.0.1.tgz";
        sha512 = "+ML2Rbh6DAuee7d07tYGEKOEi2voWPUGan+ExdPbPW6Z3svq+JCqr0v8WmKPOkz1vOVykPCBSuobe7G8GJUtVg==";
      };
    };
    "inflight-1.0.6" = {
      name = "inflight";
      packageName = "inflight";
      version = "1.0.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/inflight/-/inflight-1.0.6.tgz";
        sha1 = "49bd6331d7d02d0c09bc910a1075ba8165b56df9";
      };
    };
    "inherits-2.0.4" = {
      name = "inherits";
      packageName = "inherits";
      version = "2.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/inherits/-/inherits-2.0.4.tgz";
        sha512 = "k/vGaX4/Yla3WzyMCvTQOXYeIHvqOKtnqBduzTHpzpQZzAskKMhZ2K+EnBiSM9zGSoIFeMpXKxa4dYeZIQqewQ==";
      };
    };
    "jpeg-js-0.3.7" = {
      name = "jpeg-js";
      packageName = "jpeg-js";
      version = "0.3.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/jpeg-js/-/jpeg-js-0.3.7.tgz";
        sha512 = "9IXdWudL61npZjvLuVe/ktHiA41iE8qFyLB+4VDTblEsWBzeg8WQTlktdUK4CdncUqtUgUg0bbOmTE2bKBKaBQ==";
      };
    };
    "mime-2.4.6" = {
      name = "mime";
      packageName = "mime";
      version = "2.4.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/mime/-/mime-2.4.6.tgz";
        sha512 = "RZKhC3EmpBchfTGBVb8fb+RL2cWyw/32lshnsETttkBAyAUXSGHxbEJWWRXc751DrIxG1q04b8QwMbAwkRPpUA==";
      };
    };
    "minimatch-3.0.4" = {
      name = "minimatch";
      packageName = "minimatch";
      version = "3.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/minimatch/-/minimatch-3.0.4.tgz";
        sha512 = "yJHVQEhyqPLUTgt9B83PXu6W3rx4MvvHvSUvToogpwoGDOUQ+yDrR0HRot+yOCdCO7u4hX3pWft6kWBBcqh0UA==";
      };
    };
    "ms-2.1.2" = {
      name = "ms";
      packageName = "ms";
      version = "2.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/ms/-/ms-2.1.2.tgz";
        sha512 = "sGkPx+VjMtmA6MX27oA4FBFELFCZZ4S4XqeGOXCv68tT+jb3vk/RyaKWP0PTKyWtmLSM0b+adUTEvbs1PEaH2w==";
      };
    };
    "once-1.4.0" = {
      name = "once";
      packageName = "once";
      version = "1.4.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/once/-/once-1.4.0.tgz";
        sha1 = "583b1aa775961d4b113ac17d9c50baef9dd76bd1";
      };
    };
    "path-is-absolute-1.0.1" = {
      name = "path-is-absolute";
      packageName = "path-is-absolute";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/path-is-absolute/-/path-is-absolute-1.0.1.tgz";
        sha1 = "174b9268735534ffbc7ace6bf53a5a9e1b5c5f5f";
      };
    };
    "pend-1.2.0" = {
      name = "pend";
      packageName = "pend";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/pend/-/pend-1.2.0.tgz";
        sha1 = "7a57eb550a6783f9115331fcf4663d5c8e007a50";
      };
    };
    "pngjs-5.0.0" = {
      name = "pngjs";
      packageName = "pngjs";
      version = "5.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/pngjs/-/pngjs-5.0.0.tgz";
        sha512 = "40QW5YalBNfQo5yRYmiw7Yz6TKKVr3h6970B2YE+3fQpsWcrbj1PzJgxeJ19DRQjhMbKPIuMY8rFaXc8moolVw==";
      };
    };
    "progress-2.0.3" = {
      name = "progress";
      packageName = "progress";
      version = "2.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/progress/-/progress-2.0.3.tgz";
        sha512 = "7PiHtLll5LdnKIMw100I+8xJXR5gW2QwWYkT6iJva0bXitZKa/XMrSbdmg3r2Xnaidz9Qumd0VPaMrZlF9V9sA==";
      };
    };
    "proxy-from-env-1.1.0" = {
      name = "proxy-from-env";
      packageName = "proxy-from-env";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/proxy-from-env/-/proxy-from-env-1.1.0.tgz";
        sha512 = "D+zkORCbA9f1tdWRK0RaCR3GPv50cMxcrz4X8k5LTSUD1Dkw47mKJEZQNunItRTkWwgtaUSo1RVFRIG9ZXiFYg==";
      };
    };
    "pump-3.0.0" = {
      name = "pump";
      packageName = "pump";
      version = "3.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/pump/-/pump-3.0.0.tgz";
        sha512 = "LwZy+p3SFs1Pytd/jYct4wpv49HiYCqd9Rlc5ZVdk0V+8Yzv6jR5Blk3TRmPL1ft69TxP0IMZGJ+WPFU2BFhww==";
      };
    };
    "rimraf-3.0.2" = {
      name = "rimraf";
      packageName = "rimraf";
      version = "3.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/rimraf/-/rimraf-3.0.2.tgz";
        sha512 = "JZkJMZkAGFFPP2YqXZXPbMlMBgsxzE8ILs4lMIX/2o0L9UBw9O/Y3o6wFw/i9YLapcUJWwqbi3kdxIPdC62TIA==";
      };
    };
    "wrappy-1.0.2" = {
      name = "wrappy";
      packageName = "wrappy";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/wrappy/-/wrappy-1.0.2.tgz";
        sha1 = "b5243d8f3ec1aa35f1364605bc0d1036e30ab69f";
      };
    };
    "ws-6.2.1" = {
      name = "ws";
      packageName = "ws";
      version = "6.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/ws/-/ws-6.2.1.tgz";
        sha512 = "GIyAXC2cB7LjvpgMt9EKS2ldqr0MTrORaleiOno6TweZ6r3TKtoFQWay/2PceJ3RuBasOHzXNn5Lrw1X0bEjqA==";
      };
    };
    "yauzl-2.10.0" = {
      name = "yauzl";
      packageName = "yauzl";
      version = "2.10.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/yauzl/-/yauzl-2.10.0.tgz";
        sha1 = "c7eb17c93e112cb1086fa6d8e51fb0667b79a5f9";
      };
    };
  };
in
{
  playwright = nodeEnv.buildNodePackage {
    name = "playwright";
    packageName = "playwright";
    version = "1.1.1";
    src = fetchurl {
      url = "https://registry.npmjs.org/playwright/-/playwright-1.1.1.tgz";
      sha512 = "abAB/gFdMQueapllosYyEzeKyEu6x/83JykqxmUwSu2foGnLT7E4jPUvbJdOSEpzpDGxN01KmonyskcfXxfcpA==";
    };
    dependencies = [
      sources."@types/node-14.0.13"
      sources."@types/yauzl-2.9.1"
      sources."agent-base-4.3.0"
      sources."async-limiter-1.0.1"
      sources."balanced-match-1.0.0"
      sources."brace-expansion-1.1.11"
      sources."buffer-crc32-0.2.13"
      sources."concat-map-0.0.1"
      sources."debug-4.2.0"
      sources."end-of-stream-1.4.4"
      sources."es6-promise-4.2.8"
      sources."es6-promisify-5.0.0"
      sources."extract-zip-2.0.1"
      sources."fd-slicer-1.1.0"
      sources."fs.realpath-1.0.0"
      sources."get-stream-5.1.0"
      sources."glob-7.1.6"
      (sources."https-proxy-agent-3.0.1" // {
        dependencies = [
          sources."debug-3.2.6"
        ];
      })
      sources."inflight-1.0.6"
      sources."inherits-2.0.4"
      sources."jpeg-js-0.3.7"
      sources."mime-2.4.6"
      sources."minimatch-3.0.4"
      sources."ms-2.1.2"
      sources."once-1.4.0"
      sources."path-is-absolute-1.0.1"
      sources."pend-1.2.0"
      sources."pngjs-5.0.0"
      sources."progress-2.0.3"
      sources."proxy-from-env-1.1.0"
      sources."pump-3.0.0"
      sources."rimraf-3.0.2"
      sources."wrappy-1.0.2"
      sources."ws-6.2.1"
      sources."yauzl-2.10.0"
    ];
    buildInputs = globalBuildInputs;
    meta = {
      description = "A high-level API to automate web browsers";
      homepage = https://playwright.dev/;
      license = "Apache-2.0";
    };
    production = true;
    bypassCache = true;
    reconstructLock = true;
  };
}