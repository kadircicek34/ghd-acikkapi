<template>
  <footer class="ghd-footer" ref="footer">
    <div class="container mx-auto px-4 py-12">
      <div class="grid gap-10 md:grid-cols-[1.3fr,0.7fr,0.7fr,0.7fr]">
        <div>
          <div class="flex items-center gap-3">
            <img
              src="/img/ghd-emblem.png"
              alt=""
              width="58"
              height="58"
              class="h-14 w-14 rounded-full object-cover ring-1 ring-ghd-gold/50"
            />
            <div>
              <p class="ghd-display text-2xl font-bold text-white">
                GHD Açık Kapı
              </p>
              <p class="text-[0.62rem] font-semibold uppercase tracking-[0.22em] text-ghd-gold">
                Global Hukukçular Derneği
              </p>
            </div>
          </div>
          <p class="mt-4 max-w-sm text-sm leading-relaxed text-white/65">
            Hukuk öğrencileri ve yeni mezunlar için yarım günlük misafirlik
            programı. Başvurular e-posta doğrulaması ve manuel değerlendirme
            ile alınır.
          </p>
        </div>

        <div>
          <p class="ghd-footer-title">Platform</p>
          <ul class="mt-3 space-y-2">
            <li>
              <router-link class="ghd-footer-link" :to="{ name: RouteName.HOME }"
                >Açık Kapı</router-link
              >
            </li>
            <li>
              <router-link
                class="ghd-footer-link"
                :to="{ name: RouteName.HOME, hash: '#ilan' }"
                >İlan</router-link
              >
            </li>
            <li>
              <router-link
                class="ghd-footer-link"
                :to="{ name: RouteName.REGISTER }"
                >Üyelik başvurusu</router-link
              >
            </li>
            <li>
              <router-link class="ghd-footer-link" :to="{ name: RouteName.LOGIN }"
                >Giriş</router-link
              >
            </li>
          </ul>
        </div>

        <div>
          <p class="ghd-footer-title">Kurumsal</p>
          <ul class="mt-3 space-y-2">
            <li>
              <a
                class="ghd-footer-link"
                :href="GHD_MAIN_SITE_URL"
                rel="noopener"
                target="_blank"
                >globalhukukcular.com</a
              >
            </li>
            <li>
              <router-link class="ghd-footer-link" :to="{ name: RouteName.ABOUT }"
                >Hakkında</router-link
              >
            </li>
            <li>
              <router-link class="ghd-footer-link" :to="{ name: RouteName.TERMS }"
                >Kullanım koşulları</router-link
              >
            </li>
            <li>
              <router-link class="ghd-footer-link" :to="{ name: RouteName.PRIVACY }"
                >KVKK ve gizlilik</router-link
              >
            </li>
          </ul>
        </div>

        <div>
          <p class="ghd-footer-title">Kaynak</p>
          <ul class="mt-3 space-y-2">
            <li>
              <a
                class="ghd-footer-link"
                :href="GHD_SOURCE_URL"
                rel="noopener"
                target="_blank"
                >Özelleştirilmiş kaynak kod</a
              >
            </li>
            <li>
              <a
                class="ghd-footer-link"
                :href="`${GHD_SOURCE_URL}/blob/main/LICENSE`"
                rel="noopener"
                target="_blank"
                >Lisans · AGPL-3.0</a
              >
            </li>
            <li>
              <a class="ghd-footer-link" href="#navbar">Sayfa başına dön</a>
            </li>
          </ul>
        </div>
      </div>

      <div
        class="mt-10 flex flex-col gap-2 border-t border-white/10 pt-5 text-xs text-white/45 sm:flex-row sm:items-center sm:justify-between"
      >
        <p>© {{ new Date().getFullYear() }} Global Hukukçular Derneği</p>
        <p>GHD Açık Kapı · Hukuk öğrencileri ve yeni mezunlar için.</p>
      </div>
    </div>
  </footer>
</template>

<script setup lang="ts">
import RouteName from "@/router/name";
import { GHD_MAIN_SITE_URL, GHD_SOURCE_URL } from "@/ghd/constants";
</script>

<style scoped>
.ghd-footer {
  background:
    radial-gradient(circle at 15% 20%, rgba(201, 162, 39, 0.1), transparent 24rem),
    #0b1526;
  color: #f7f2e7;
}
.ghd-footer-title {
  font-size: 0.68rem;
  font-weight: 700;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  color: #c9a227;
}
.ghd-footer-link {
  font-size: 0.875rem;
  color: rgba(255, 255, 255, 0.68);
  text-decoration: none;
}
.ghd-footer-link:hover {
  color: #ffffff;
  text-decoration: underline;
  text-underline-offset: 0.2em;
}
</style>
