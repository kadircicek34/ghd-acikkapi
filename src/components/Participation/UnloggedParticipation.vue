<template>
  <section class="container mx-auto max-w-3xl px-4 py-10">
    <p class="ghd-kicker">GHD Açık Kapı</p>
    <h1 class="mt-2 text-4xl font-bold text-ghd-navy">
      Başvuru yönteminizi seçin
    </h1>
    <p class="mt-3 text-sm leading-relaxed text-ghd-muted">
      Açık Kapı başvuruları için hesap açmanız gerekmez. E-posta adresinizle
      doğrulama yaparak ya da mevcut profilinizle başvurabilirsiniz.
    </p>
    <EventListViewCard v-if="event" :event="event" class="mt-6" />
    <div class="mt-6 grid gap-4 sm:grid-cols-2">
      <div class="ghd-card rounded-sm p-6">
        <h2 class="text-2xl font-bold text-ghd-navy">Hesap açmadan</h2>
        <p class="mt-2 text-sm leading-relaxed text-ghd-muted">
          Adınız, hukuk statünüz ve kısa motivasyon notunuzla başvurun.
          Başvurunuz e-posta ile doğrulanır.
        </p>
        <router-link
          class="ghd-btn ghd-btn-gold mt-5 w-full"
          :to="{
            name: RouteName.EVENT_PARTICIPATE_WITHOUT_ACCOUNT,
            params: { uuid: event?.uuid },
          }"
          >Hesap açmadan başvur</router-link
        >
      </div>
      <div class="ghd-card rounded-sm p-6">
        <h2 class="text-2xl font-bold text-ghd-navy">Hesabımla</h2>
        <p class="mt-2 text-sm leading-relaxed text-ghd-muted">
          GHD Açık Kapı hesabınız veya başka bir uyumlu hesap ile başvurmak
          için giriş yapın.
        </p>
        <router-link
          class="ghd-btn ghd-btn-outline mt-5 w-full"
          :to="{
            name: RouteName.EVENT_PARTICIPATE_WITH_ACCOUNT,
            params: { uuid: event?.uuid },
          }"
          >Hesabımla başvur</router-link
        >
      </div>
    </div>
    <div class="mt-6">
      <router-link
        class="ghd-link text-sm"
        :to="{ name: RouteName.EVENT, params: { uuid: event?.uuid } }"
        >İlana dön</router-link
      >
    </div>
  </section>
</template>
<script lang="ts" setup>
import EventListViewCard from "@/components/Event/EventListViewCard.vue";
import RouteName from "@/router/name";
import { useFetchEvent } from "@/composition/apollo/event";
import { computed } from "vue";
import { useHead } from "@/utils/head";

const props = defineProps<{ uuid: string }>();

const { event } = useFetchEvent(computed(() => props.uuid));

useHead({
  title: computed(() => "Başvuru yöntemi"),
  meta: [{ name: "robots", content: "noindex" }],
});
</script>
