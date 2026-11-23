<template>
  <div class="ghd-shell">
    <section class="relative overflow-hidden bg-[#071426] text-ghd-cream">
      <div
        class="pointer-events-none absolute inset-0 bg-[radial-gradient(circle_at_85%_0%,rgba(224,178,74,0.16),transparent_24rem)]"
        aria-hidden="true"
      ></div>
      <div class="relative mx-auto w-full max-w-7xl px-5 py-14 sm:px-8 sm:py-20">
        <p class="ghd-eyebrow !text-ghd-gold">GHD Açık Kapı / Hakkında</p>
        <h1
          class="mt-5 max-w-3xl font-['Sora'] text-4xl font-bold leading-[1.02] tracking-[-0.055em] text-white sm:text-6xl"
        >
          Hukuk pratiğine açılan<br />
          <span class="ghd-gold-text">yarım günlük kapı.</span>
        </h1>
        <p class="mt-5 max-w-2xl text-base leading-relaxed text-white/60">
          Hukuk öğrencileri ve yeni mezunlar için yarım günlük misafirlik
          programı. Başvurular e-posta doğrulaması ve dernek değerlendirmesi
          ile alınır.
        </p>
        <div class="mt-7 flex flex-wrap gap-3">
          <router-link class="ghd-btn ghd-btn-gold" :to="GHD_EVENT_PATH"
            >İlanı incele</router-link
          >
          <a
            class="ghd-btn ghd-btn-ghost"
            :href="GHD_MAIN_SITE_URL"
            rel="noopener"
            target="_blank"
            >globalhukukcular.com</a
          >
        </div>
      </div>
    </section>

    <section class="ghd-section">
      <div
        class="mx-auto grid w-full max-w-7xl gap-8 px-5 sm:px-8 lg:grid-cols-[260px_1fr]"
      >
        <aside class="lg:sticky lg:top-24 lg:self-start">
          <div class="ghd-card overflow-hidden p-2">
            <router-link
              class="ghd-side-link"
              :to="{ name: RouteName.ABOUT_INSTANCE }"
              >Platform hakkında</router-link
            >
            <p class="ghd-side-title">Hukuki metinler</p>
            <router-link class="ghd-side-link" :to="{ name: RouteName.TERMS }"
              >Kullanım koşulları</router-link
            >
            <router-link class="ghd-side-link" :to="{ name: RouteName.PRIVACY }"
              >KVKK ve gizlilik</router-link
            >
            <router-link class="ghd-side-link" :to="{ name: RouteName.RULES }"
              >Platform kuralları</router-link
            >
            <router-link class="ghd-side-link" :to="{ name: RouteName.GLOSSARY }"
              >Sözlük</router-link
            >
          </div>
        </aside>

        <div
          class="ghd-legal min-w-0 rounded-[1.5rem] border border-ghd-navy/10 bg-[#fffdf8] p-5 shadow-[0_24px_70px_rgba(8,23,43,0.06)] sm:p-8 lg:p-10"
        >
          <router-view />
        </div>
      </div>
    </section>
  </div>
</template>

<script lang="ts" setup>
import { CONFIG } from "@/graphql/config";
import { IConfig } from "@/types/config.model";
import RouteName from "../router/name";
import { useQuery } from "@vue/apollo-composable";
import { computed } from "vue";
import { useI18n } from "vue-i18n";
import { useHead } from "@/utils/head";
import { GHD_EVENT_PATH, GHD_MAIN_SITE_URL } from "@/ghd/constants";

const { result: configResult } = useQuery<{ config: IConfig }>(CONFIG);

const config = computed(() => configResult.value?.config);

const { t } = useI18n({ useScope: "global" });

useHead({
  title: computed(() =>
    t("About {instance}", { instance: config.value?.name })
  ),
});
</script>
