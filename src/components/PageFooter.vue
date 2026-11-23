<template>
  <footer class="ghd-footer" ref="footer">
    <div class="mx-auto w-full max-w-7xl px-5 py-14 sm:px-8 sm:py-20">
      <div class="grid gap-12 lg:grid-cols-[1.4fr_0.6fr_0.6fr] lg:gap-16">
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
              <p class="font-['Sora'] text-2xl font-bold tracking-[-0.045em] text-white">
                GHD Açık Kapı
              </p>
              <p class="text-[0.58rem] font-extrabold uppercase tracking-[0.22em] text-ghd-gold">
                Global Hukukçular Derneği
              </p>
            </div>
          </div>
          <p class="mt-5 max-w-sm text-sm leading-relaxed text-white/50">
            Hukuk öğrencileri ve yeni mezunlar için yarım günlük misafirlik
            programı. Başvurular e-posta doğrulaması ve manuel değerlendirme
            ile alınır.
          </p>
          <a
            class="ghd-btn ghd-btn-ghost mt-7 !px-4 !py-2.5 text-sm"
            :href="GHD_MAIN_SITE_URL"
            rel="noopener"
            target="_blank"
            >globalhukukcular.com
            <svg
              aria-hidden="true"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="1.8"
              class="h-4 w-4"
            >
              <path d="M7 17 17 7M9 7h8v8" />
            </svg>
          </a>
        </div>

        <div>
          <p class="ghd-footer-title">Platform</p>
          <ul class="mt-4 space-y-2.5">
            <li>
              <router-link class="ghd-footer-link" :to="{ name: RouteName.HOME }"
                >Açık Kapı</router-link
              >
            </li>
            <li>
              <router-link
                class="ghd-footer-link"
                :to="{ name: RouteName.HOME, hash: '#program' }"
                >Program</router-link
              >
            </li>
            <li>
              <router-link
                class="ghd-footer-link"
                :to="{ name: RouteName.HOME, hash: '#ilan' }"
                >Güncel ilan</router-link
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
          <ul class="mt-4 space-y-2.5">
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
            <li>
              <router-link class="ghd-footer-link" :to="{ name: RouteName.RULES }"
                >Platform kuralları</router-link
              >
            </li>
          </ul>
        </div>
      </div>

      <div
        class="mt-12 flex flex-col gap-3 border-t border-white/10 pt-6 text-xs text-white/40 sm:flex-row sm:items-center sm:justify-between"
      >
        <p>© {{ new Date().getFullYear() }} Global Hukukçular Derneği</p>
        <div class="flex items-center gap-4">
          <p>GHD Açık Kapı · Hukuk öğrencileri ve yeni mezunlar için.</p>
          <a class="text-white/50 transition hover:text-white" href="#navbar"
            >Yukarı çık ↑</a
          >
        </div>
      </div>
    </div>
  </footer>
</template>

<script setup lang="ts">
import RouteName from "@/router/name";
import { GHD_MAIN_SITE_URL } from "@/ghd/constants";
</script>
