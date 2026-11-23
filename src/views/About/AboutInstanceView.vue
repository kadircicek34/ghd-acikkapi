<template>
  <div>
    <p class="ghd-eyebrow">Program hakkında</p>
    <h1
      class="mt-4 font-['Sora'] text-3xl font-bold leading-[1.03] tracking-[-0.05em] text-ghd-navy sm:text-4xl"
    >
      Hukuk pratiğine<br />
      <span class="text-ghd-bronze">ilk elden bakış.</span>
    </h1>

    <div class="mt-6 space-y-4 text-sm leading-relaxed text-ghd-muted">
      <p>
        Açık Kapı, hukuk öğrencileri ve yeni mezunların bir hukuk bürosunun
        veya şirketin hukuk ekibinin günlük işleyişini yerinde görmesi için
        tasarlanmış yarım günlük bir misafirlik programıdır.
      </p>
      <p>
        Katılımcılar dosya akışını, ekip çalışmasını ve meslek pratiğinin
        görünmeyen taraflarını gözlemler. Program yüz yüze ve tek oturumluktur;
        kontenjan üç kişiyle sınırlıdır.
      </p>
    </div>

    <div class="mt-8 grid gap-3 sm:grid-cols-3">
      <div class="rounded-2xl border border-ghd-navy/10 bg-[#fbf7ee] p-4">
        <p class="font-['Sora'] text-lg font-bold tracking-[-0.03em] text-ghd-navy">
          Yarım gün
        </p>
        <p class="mt-1 text-xs leading-relaxed text-ghd-muted">
          Yaklaşık dört saatlik tek bir büro ziyareti.
        </p>
      </div>
      <div class="rounded-2xl border border-ghd-navy/10 bg-[#fbf7ee] p-4">
        <p class="font-['Sora'] text-lg font-bold tracking-[-0.03em] text-ghd-navy">
          Gerçek ortam
        </p>
        <p class="mt-1 text-xs leading-relaxed text-ghd-muted">
          Dosya akışı, ekip kültürü ve günlük işleyiş.
        </p>
      </div>
      <div class="rounded-2xl border border-ghd-navy/10 bg-[#fbf7ee] p-4">
        <p class="font-['Sora'] text-lg font-bold tracking-[-0.03em] text-ghd-navy">
          Manuel seçim
        </p>
        <p class="mt-1 text-xs leading-relaxed text-ghd-muted">
          Başvurular dernek yönetimi tarafından tek tek değerlendirilir.
        </p>
      </div>
    </div>

    <div class="mt-8 rounded-2xl border border-ghd-gold/30 bg-ghd-gold/10 p-5">
      <p class="text-sm leading-relaxed text-ghd-navy/80">
        Açık Kapı bir işe alım veya hukuki danışmanlık programı değildir.
        Amacı, hukuk pratiğini tanımak isteyen öğrenci ve yeni mezunlara kısa
        ama gerçek bir gözlem imkânı sunmaktır.
      </p>
    </div>

    <h2
      class="mt-10 font-['Sora'] text-xl font-bold tracking-[-0.03em] text-ghd-navy"
    >
      Başvuru nasıl işliyor?
    </h2>
    <ol class="mt-5 space-y-4">
      <li class="flex gap-3">
        <span
          class="flex h-7 w-7 shrink-0 items-center justify-center rounded-full bg-ghd-navy text-[0.62rem] font-extrabold text-ghd-gold"
          >01</span
        >
        <div>
          <p class="text-sm font-bold text-ghd-navy">Üyelik başvurusu</p>
          <p class="mt-0.5 text-xs leading-relaxed text-ghd-muted">
            E-posta, hukuk statüsü ve kısa motivasyon notuyla üyelik başvurusu
            oluşturun.
          </p>
        </div>
      </li>
      <li class="flex gap-3">
        <span
          class="flex h-7 w-7 shrink-0 items-center justify-center rounded-full bg-ghd-navy text-[0.62rem] font-extrabold text-ghd-gold"
          >02</span
        >
        <div>
          <p class="text-sm font-bold text-ghd-navy">Doğrulama ve onay</p>
          <p class="mt-0.5 text-xs leading-relaxed text-ghd-muted">
            E-postanızı doğrulayın; başvurunuz dernek yönetiminin onayına
            sunulur.
          </p>
        </div>
      </li>
      <li class="flex gap-3">
        <span
          class="flex h-7 w-7 shrink-0 items-center justify-center rounded-full bg-ghd-navy text-[0.62rem] font-extrabold text-ghd-gold"
          >03</span
        >
        <div>
          <p class="text-sm font-bold text-ghd-navy">İlana başvuru</p>
          <p class="mt-0.5 text-xs leading-relaxed text-ghd-muted">
            Onaylı üyelikle giriş yapın, profilinizi oluşturun ve ilana
            başvurun.
          </p>
        </div>
      </li>
      <li class="flex gap-3">
        <span
          class="flex h-7 w-7 shrink-0 items-center justify-center rounded-full bg-ghd-navy text-[0.62rem] font-extrabold text-ghd-gold"
          >04</span
        >
        <div>
          <p class="text-sm font-bold text-ghd-navy">Değerlendirme</p>
          <p class="mt-0.5 text-xs leading-relaxed text-ghd-muted">
            Dernek başvuruyu değerlendirir; kabul veya ret kararı e-posta ile
            bildirilir.
          </p>
        </div>
      </li>
    </ol>

    <div class="mt-10 flex flex-wrap gap-3">
      <router-link class="ghd-btn ghd-btn-primary" :to="GHD_EVENT_PATH"
        >İlanı incele</router-link
      >
      <router-link
        class="ghd-btn ghd-btn-outline"
        :to="{ name: RouteName.REGISTER }"
        >Üyelik başvurusu</router-link
      >
    </div>
  </div>
</template>

<script lang="ts" setup>
import RouteName from "@/router/name";
import { useHead } from "@/utils/head";
import { GHD_EVENT_PATH } from "@/ghd/constants";

useHead({
  title: "Hakkında",
});
</script>
