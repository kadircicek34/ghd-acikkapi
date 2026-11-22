<template>
  <div>
    <section class="container mx-auto">
      <div class="flex flex-wrap gap-4">
        <aside class="w-64 mt-6">
          <div
            class="overflow-y-auto py-4 px-3 bg-gray-50 rounded dark:bg-gray-800"
          >
            <p>
              <router-link
                class="flex items-center p-2 text-base font-normal text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700"
                :to="{ name: RouteName.ABOUT_INSTANCE }"
                >Platform hakkında</router-link
              >
            </p>
            <p class="menu-label has-text-grey-dark">
              {{ t("Legal") }}
            </p>
            <ul>
              <li>
                <router-link
                  class="flex items-center p-2 text-base font-normal text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700"
                  :to="{ name: RouteName.TERMS }"
                  >{{ t("Terms of service") }}</router-link
                >
              </li>
              <li>
                <router-link
                  class="flex items-center p-2 text-base font-normal text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700"
                  :to="{ name: RouteName.PRIVACY }"
                  >{{ t("Privacy policy") }}</router-link
                >
              </li>
              <li>
                <router-link
                  class="flex items-center p-2 text-base font-normal text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700"
                  :to="{ name: RouteName.RULES }"
                  >{{ t("Instance rules") }}</router-link
                >
              </li>
            </ul>
          </div>
        </aside>
        <div class="container mx-auto flex-1 bg-white dark:bg-gray-700">
          <router-view />
        </div>
      </div>
    </section>
    <div class="bg-ghd-navy p-6 text-ghd-cream">
      <div class="container mx-auto">
        <p class="ghd-kicker !text-ghd-gold">GHD Açık Kapı</p>
        <h1 class="mt-2 text-4xl font-bold text-ghd-cream">
          Hukuk pratiğine açılan yarım günlük kapı.
        </h1>
        <p class="mt-3 max-w-2xl text-ghd-cream/75">
          Hukuk öğrencileri ve yeni mezunlar için yarım günlük misafirlik
          programı. Başvurular e-posta doğrulaması ve dernek değerlendirmesi ile
          alınır.
        </p>
        <div class="mt-5 flex flex-wrap gap-3">
          <router-link class="ghd-btn ghd-btn-gold" :to="GHD_EVENT_PATH"
            >Başvur</router-link
          >
          <a
            class="ghd-btn ghd-btn-outline !border-ghd-cream/40 !text-ghd-cream"
            :href="GHD_MAIN_SITE_URL"
            rel="noopener"
            target="_blank"
            >globalhukukcular.com</a
          >
        </div>
      </div>
    </div>
    <div v-if="!currentUser || !currentUser.id" class="bg-purple-2 pb-3">
      <div class="container mx-auto text-center py-10 px-6">
        <div class="flex flex-wrap">
          <div class="flex-1" v-if="config && config.registrationsOpen">
            <h2 class="text-3xl text-ghd-navy font-bold">
              GHD üyeliği
            </h2>
            <p class="mb-3 text-sm text-ghd-muted">
              E-posta doğrulaması ve yönetici onayı ile üyelik başvurusu.
            </p>
            <router-link
              class="ghd-btn ghd-btn-primary"
              :to="{ name: RouteName.REGISTER }"
              >Üyelik başvurusu</router-link
            >
          </div>
          <div class="flex-1">
            <h2 class="text-3xl text-ghd-navy font-bold">Açık Kapı ilanı</h2>
            <p class="mb-3 text-sm text-ghd-muted">
              Hesap açmadan yarım günlük misafirliğe başvurun.
            </p>
            <router-link class="ghd-btn ghd-btn-outline" :to="GHD_EVENT_PATH"
              >İlanı incele</router-link
            >
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { CONFIG } from "@/graphql/config";
import { IConfig } from "@/types/config.model";
import RouteName from "../router/name";
import { useQuery } from "@vue/apollo-composable";
import { computed } from "vue";
import { useCurrentUserClient } from "@/composition/apollo/user";
import { useI18n } from "vue-i18n";
import { useHead } from "@/utils/head";
import { GHD_EVENT_PATH, GHD_MAIN_SITE_URL } from "@/ghd/constants";

const { currentUser } = useCurrentUserClient();

const { result: configResult } = useQuery<{ config: IConfig }>(CONFIG);

const config = computed(() => configResult.value?.config);

const { t } = useI18n({ useScope: "global" });

useHead({
  title: computed(() =>
    t("About {instance}", { instance: config.value?.name })
  ),
});

// metaInfo() {
//   return {
//     title: this.t("About {instance}", {
//       // eslint-disable-next-line @typescript-eslint/ban-ts-comment
//       // @ts-ignore
//       instance: this?.config?.name,
//     }) as string,
//   };
// },
</script>
