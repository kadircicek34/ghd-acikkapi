<template>
  <div class="ghd-home">
    <section class="ghd-hero">
      <div
        class="ghd-hero-inner mx-auto grid w-full max-w-7xl items-center gap-14 px-5 py-16 sm:px-8 lg:grid-cols-[1.05fr_0.95fr] lg:gap-20 lg:py-24"
      >
        <div class="ghd-fade-up">
          <div class="ghd-eyebrow">
            <span class="ghd-eyebrow-dot" aria-hidden="true"></span>
            Global Hukukçular Derneği
            <span class="rounded-full border border-white/10 px-2 py-1 text-[0.58rem] text-white/50"
              >2026</span
            >
          </div>

          <h1 class="ghd-hero-title mt-7">
            Hukuk dünyasına<br />
            <span class="ghd-gold-text">yarım günlük</span><br />
            bir kapı.
          </h1>

          <p class="ghd-hero-copy mt-7 max-w-xl text-base leading-relaxed sm:text-lg">
            Hukuk öğrencileri ve yeni mezunlar için yarım günlük bir misafirlik
            programı. Başvurular yalnızca e-posta doğrulamalı ve yönetici
            onaylı üyelik hesabıyla alınır.
          </p>

          <div class="mt-9 flex flex-wrap items-center gap-3">
            <router-link
              class="ghd-btn ghd-btn-gold ghd-btn-lg"
              :to="primaryCta.to"
            >
              {{ primaryCta.label }}
              <svg
                aria-hidden="true"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                class="h-4 w-4"
              >
                <path d="M5 12h14M13 6l6 6-6 6" />
              </svg>
            </router-link>
            <a class="ghd-btn ghd-btn-ghost ghd-btn-lg" href="#program"
              >Programı keşfet</a
            >
          </div>

          <div class="mt-11 grid max-w-lg grid-cols-3 gap-5">
            <div class="ghd-stat">
              <p class="ghd-stat-value">3</p>
              <p class="ghd-stat-label">kişilik kontenjan</p>
            </div>
            <div class="ghd-stat">
              <p class="ghd-stat-value">4 saat</p>
              <p class="ghd-stat-label">yarım gün</p>
            </div>
            <div class="ghd-stat">
              <p class="ghd-stat-value">100%</p>
              <p class="ghd-stat-label">manuel</p>
            </div>
          </div>
        </div>

        <div class="relative mx-auto w-full max-w-md lg:max-w-none">
          <div
            class="absolute -inset-8 rounded-[3rem] bg-ghd-gold/10 blur-3xl"
            aria-hidden="true"
          ></div>

          <div class="ghd-event-card ghd-fade-up ghd-fade-up-delay p-6 sm:p-8">
            <div class="flex items-center justify-between gap-4">
              <p class="ghd-eyebrow !text-ghd-bronze">Güncel ilan</p>
              <span
                class="ghd-status"
                :class="{ 'ghd-status-full': availablePlaces === 0 }"
                >{{
                  availablePlaces === 0 ? "Kontenjan dolu" : "Başvuruya açık"
                }}</span
              >
            </div>

            <h2
              class="mt-5 font-['Sora'] text-3xl font-bold leading-tight tracking-[-0.045em] text-ghd-navy sm:text-4xl"
            >
              {{ event?.title || "Yarım Günlük Hukuk Misafirliği" }}
            </h2>

            <div class="mt-6 space-y-4 text-sm">
              <div class="flex items-start gap-3">
                <span class="mt-0.5 text-ghd-bronze" aria-hidden="true">
                  <svg
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.7"
                    class="h-5 w-5"
                  >
                    <rect x="3" y="5" width="18" height="16" rx="3" />
                    <path d="M8 3v4M16 3v4M3 10h18" />
                  </svg>
                </span>
                <div>
                  <p class="text-[0.64rem] font-extrabold uppercase tracking-[0.14em] text-ghd-muted">
                    Tarih
                  </p>
                  <p class="mt-0.5 font-semibold text-ghd-navy">
                    {{ formattedDate }}
                  </p>
                </div>
              </div>

              <div class="flex items-start gap-3">
                <span class="mt-0.5 text-ghd-bronze" aria-hidden="true">
                  <svg
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.7"
                    class="h-5 w-5"
                  >
                    <path d="M20 10c0 5-8 11-8 11S4 15 4 10a8 8 0 1 1 16 0Z" />
                    <circle cx="12" cy="10" r="2.5" />
                  </svg>
                </span>
                <div>
                  <p class="text-[0.64rem] font-extrabold uppercase tracking-[0.14em] text-ghd-muted">
                    Yer
                  </p>
                  <p class="mt-0.5 font-semibold text-ghd-navy">
                    {{ eventLocation }}
                  </p>
                </div>
              </div>

              <div class="flex items-start gap-3">
                <span class="mt-0.5 text-ghd-bronze" aria-hidden="true">
                  <svg
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.7"
                    class="h-5 w-5"
                  >
                    <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2" />
                    <circle cx="9" cy="7" r="4" />
                    <path d="M22 21v-2a4 4 0 0 0-3-3.87M16 3.13a4 4 0 0 1 0 7.75" />
                  </svg>
                </span>
                <div>
                  <p class="text-[0.64rem] font-extrabold uppercase tracking-[0.14em] text-ghd-muted">
                    Kimler için
                  </p>
                  <p class="mt-0.5 font-semibold text-ghd-navy">
                    Hukuk öğrencileri ve yeni mezunlar
                  </p>
                </div>
              </div>
            </div>

            <div class="mt-7 rounded-2xl bg-[#f1ebde] p-4">
              <div
                class="flex items-center justify-between text-[0.66rem] font-extrabold uppercase tracking-[0.12em] text-ghd-muted"
              >
                <span>Kontenjan</span>
                <span class="text-ghd-navy"
                  >{{ participantCount }} / {{ capacity }}</span
                >
              </div>
              <div class="ghd-progress mt-2.5">
                <div
                  class="ghd-progress-bar"
                  :style="{ width: `${capacityPercent}%` }"
                ></div>
              </div>
              <p class="mt-2 text-xs font-medium text-ghd-muted">
                {{ availablePlaces }} yer kaldı · onaylı üyeler başvurabilir
              </p>
            </div>

            <router-link
              class="ghd-btn ghd-btn-primary mt-5 w-full"
              :to="eventCta.to"
            >
              {{ eventCta.label }}
              <svg
                aria-hidden="true"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                class="h-4 w-4"
              >
                <path d="M5 12h14M13 6l6 6-6 6" />
              </svg>
            </router-link>
            <p class="mt-3 text-center text-[0.68rem] leading-relaxed text-ghd-muted">
              E-posta doğrulama ve yönetici onayı gerekir.
            </p>
          </div>

          <div class="ghd-float-chip">
            <span class="mr-2 text-ghd-gold">●</span>
            GHD Hukuk Bürosu · Ankara
          </div>
        </div>
      </div>
    </section>

    <div class="ghd-marquee" aria-hidden="true">
      <div class="ghd-marquee-track">
        <span
          v-for="item in marqueeItems"
          :key="item"
          class="ghd-marquee-item"
          >{{ item }}</span
        >
        <span
          v-for="item in marqueeItems"
          :key="`${item}-repeat`"
          class="ghd-marquee-item"
          >{{ item }}</span
        >
      </div>
    </div>

    <section id="program" class="ghd-section">
      <div class="mx-auto w-full max-w-7xl px-5 sm:px-8">
        <div class="grid gap-10 lg:grid-cols-[0.9fr_1.1fr] lg:gap-20">
          <div>
            <p class="ghd-label">01 / Program</p>
            <h2
              class="mt-5 font-['Sora'] text-4xl font-bold leading-[1.03] tracking-[-0.055em] text-ghd-navy sm:text-6xl"
            >
              Kısa bir misafirlik,<br />
              <span class="text-ghd-bronze">kalıcı bir bakış açısı.</span>
            </h2>
          </div>
          <div class="lg:pt-8">
            <p class="text-lg leading-relaxed text-ghd-muted">
              Açık Kapı, hukuk öğrencileri ve yeni mezunların meslek hayatını
              yakından tanıması için tasarlanmış yarım günlük bir misafirlik
              programıdır. Katılımcılar bir hukuk bürosunun veya şirketin hukuk
              ekibinin günlük işleyişini yerinde gözlemler.
            </p>
            <p class="mt-4 text-base leading-relaxed text-ghd-muted">
              Program kontenjanla sınırlıdır. Üyelik başvuruları e-posta ile
              doğrulanır ve dernek tarafından manuel olarak değerlendirilir.
              Onaylanan üyeler ilana başvurabilir; kabul edilen katılımcılara
              misafirlik gününe ilişkin bilgiler e-posta ile iletilir.
            </p>

            <div class="mt-8 grid gap-3 sm:grid-cols-3">
              <div
                v-for="feature in features"
                :key="feature.title"
                class="ghd-feature"
              >
                <span class="ghd-feature-icon" aria-hidden="true">
                  <svg
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.8"
                    class="h-5 w-5"
                  >
                    <path :d="feature.icon" />
                  </svg>
                </span>
                <h3
                  class="mt-4 font-['Sora'] text-base font-bold tracking-[-0.025em] text-ghd-navy"
                >
                  {{ feature.title }}
                </h3>
                <p class="mt-2 text-sm leading-relaxed text-ghd-muted">
                  {{ feature.body }}
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section id="ilan" class="ghd-section ghd-section-dark">
      <div class="mx-auto w-full max-w-7xl px-5 sm:px-8">
        <div class="grid gap-12 lg:grid-cols-[1.25fr_0.75fr] lg:gap-16">
          <div>
            <p class="ghd-label !text-ghd-gold">02 / Güncel ilan</p>
            <h2
              class="mt-5 font-['Sora'] text-4xl font-bold leading-[1.02] tracking-[-0.055em] text-white sm:text-6xl"
            >
              {{ event?.title || "Yarım Günlük Hukuk Misafirliği" }}
            </h2>

            <div class="mt-6 flex flex-wrap gap-2">
              <span
                class="ghd-tag !border-white/10 !bg-white/[0.06] !text-white/75"
                >{{ formattedDate }}</span
              >
              <span
                class="ghd-tag !border-white/10 !bg-white/[0.06] !text-white/75"
                >{{ eventLocation }}</span
              >
              <span
                class="ghd-tag !border-ghd-gold/30 !bg-ghd-gold/10 !text-ghd-gold"
                >{{ capacity }} kişilik kontenjan</span
              >
            </div>

            <div
              class="prose prose-invert mt-8 max-w-3xl text-base leading-relaxed text-white/70"
              v-html="eventDescription"
            ></div>

            <router-link
              class="ghd-btn ghd-btn-gold ghd-btn-lg mt-8"
              :to="eventCta.to"
            >
              {{ eventCta.label }}
              <svg
                aria-hidden="true"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                class="h-4 w-4"
              >
                <path d="M5 12h14M13 6l6 6-6 6" />
              </svg>
            </router-link>
          </div>

          <aside class="space-y-4">
            <div
              class="rounded-[1.5rem] border border-white/10 bg-white/[0.045] p-6 backdrop-blur"
            >
              <p class="ghd-eyebrow !text-ghd-gold">Başvuru durumu</p>
              <div class="mt-4 flex items-end justify-between gap-4">
                <span
                  class="font-['Sora'] text-4xl font-bold tracking-[-0.06em] text-white"
                  >{{ participantCount }}<span class="text-white/30">/</span
                  >{{ capacity }}</span
                >
                <span
                  class="pb-1 text-[0.62rem] font-extrabold uppercase tracking-[0.14em] text-white/40"
                  >kontenjan</span
                >
              </div>
              <div class="ghd-progress mt-3 !bg-white/10">
                <div
                  class="ghd-progress-bar"
                  :style="{ width: `${capacityPercent}%` }"
                ></div>
              </div>
              <p class="mt-3 text-sm leading-relaxed text-white/50">
                {{ availablePlaces }} yer kaldı. Başvurular e-posta doğrulaması
                ve dernek onayı ile kesinleşir.
              </p>

              <div class="mt-6 space-y-3 border-t border-white/10 pt-5">
                <div
                  v-for="(step, index) in steps"
                  :key="step.title"
                  class="flex gap-3"
                >
                  <span
                    class="flex h-7 w-7 shrink-0 items-center justify-center rounded-full border border-ghd-gold/30 bg-ghd-gold/10 text-[0.62rem] font-extrabold text-ghd-gold"
                    >0{{ index + 1 }}</span
                  >
                  <div>
                    <p class="text-sm font-bold text-white/90">
                      {{ step.title }}
                    </p>
                    <p class="mt-0.5 text-xs leading-relaxed text-white/40">
                      {{ step.short }}
                    </p>
                  </div>
                </div>
              </div>
            </div>

            <div
              class="rounded-[1.5rem] border border-ghd-gold/25 bg-ghd-gold/10 p-5 text-sm leading-relaxed text-white/70"
            >
              Kontenjan dolduğunda yeni başvuru kabul edilmez. Dernek
              değerlendirmesi sonrası kabul veya ret kararı e-posta ile
              bildirilir.
            </div>
          </aside>
        </div>
      </div>
    </section>

    <section id="surec" class="ghd-section">
      <div class="mx-auto w-full max-w-7xl px-5 sm:px-8">
        <div class="max-w-2xl">
          <p class="ghd-label">03 / Süreç</p>
          <h2
            class="mt-5 font-['Sora'] text-4xl font-bold leading-[1.03] tracking-[-0.055em] text-ghd-navy sm:text-6xl"
          >
            Dört adım.<br />
            <span class="text-ghd-bronze">Tek bir kapı.</span>
          </h2>
          <p class="mt-5 text-base leading-relaxed text-ghd-muted">
            Önce e-posta doğrulamalı üyelik başvurunuzu oluşturun. Yönetici
            onayından sonra giriş yaparak ilana başvurabilirsiniz.
          </p>
        </div>

        <div class="mt-10 grid gap-4 sm:grid-cols-2 xl:grid-cols-4">
          <div
            v-for="(step, index) in steps"
            :key="step.title"
            class="ghd-process-card"
          >
            <span class="ghd-process-num">0{{ index + 1 }}</span>
            <span
              class="inline-flex h-9 items-center rounded-full border border-ghd-gold/30 bg-ghd-gold/10 px-3 text-[0.62rem] font-extrabold uppercase tracking-[0.14em] text-ghd-bronze"
              >Adım 0{{ index + 1 }}</span
            >
            <h3
              class="mt-8 font-['Sora'] text-xl font-bold leading-tight tracking-[-0.035em] text-ghd-navy"
            >
              {{ step.title }}
            </h3>
            <p class="mt-3 text-sm leading-relaxed text-ghd-muted">
              {{ step.body }}
            </p>
          </div>
        </div>
      </div>
    </section>

    <section class="ghd-section bg-[#efe8d9]">
      <div class="mx-auto w-full max-w-7xl px-5 sm:px-8">
        <div class="grid gap-8 lg:grid-cols-[1.05fr_0.95fr] lg:gap-16">
          <div>
            <p class="ghd-label">04 / Kimler için</p>
            <h2
              class="mt-5 font-['Sora'] text-4xl font-bold leading-[1.03] tracking-[-0.055em] text-ghd-navy sm:text-5xl"
            >
              Hukukun ilk adımlarında<br />
              <span class="text-ghd-bronze">olanlar için.</span>
            </h2>

            <div class="mt-8 space-y-3">
              <div
                v-for="item in audience"
                :key="item.title"
                class="flex items-start gap-4 rounded-2xl border border-ghd-navy/10 bg-white/60 p-4"
              >
                <span
                  class="mt-0.5 flex h-7 w-7 shrink-0 items-center justify-center rounded-full bg-ghd-navy text-ghd-gold"
                  aria-hidden="true"
                >
                  <svg
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2.4"
                    class="h-3.5 w-3.5"
                  >
                    <path d="m5 12 4 4L19 6" />
                  </svg>
                </span>
                <div>
                  <p class="font-['Sora'] text-base font-bold tracking-[-0.02em] text-ghd-navy">
                    {{ item.title }}
                  </p>
                  <p class="mt-1 text-sm leading-relaxed text-ghd-muted">
                    {{ item.body }}
                  </p>
                </div>
              </div>
            </div>
          </div>

          <div class="flex flex-col justify-between rounded-[1.8rem] border border-ghd-gold/25 bg-[#fbf8f0] p-6 shadow-[0_26px_70px_rgba(8,23,43,0.08)] sm:p-8">
            <div>
              <p class="ghd-eyebrow">GHD üyeliği</p>
              <h3
                class="mt-4 font-['Sora'] text-3xl font-bold leading-tight tracking-[-0.045em] text-ghd-navy"
              >
                Dernek üyeliği başvurusu
              </h3>
              <p class="mt-4 text-sm leading-relaxed text-ghd-muted">
                Etkinlik başvurusu için onaylı üyelik zorunludur. Üyelik
                başvurunuzu oluşturun, e-postanızdaki bağlantıyı doğrulayın;
                dernek yönetimi başvurunuzu değerlendirir. Onaylandığında giriş
                yapın, ilk girişte profil oluşturun ve ilana başvurun.
              </p>
            </div>

            <div class="mt-8">
              <router-link
                class="ghd-btn ghd-btn-primary w-full"
                :to="{ name: RouteName.REGISTER }"
                >Üyelik başvurusu
                <svg
                  aria-hidden="true"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="2"
                  class="h-4 w-4"
                >
                  <path d="M5 12h14M13 6l6 6-6 6" />
                </svg>
              </router-link>
              <p class="mt-3 text-center text-[0.68rem] text-ghd-muted">
                Etkinlik başvurusu için onaylı üyelik zorunludur.
              </p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section id="sss" class="ghd-section">
      <div class="mx-auto w-full max-w-7xl px-5 sm:px-8">
        <div class="grid gap-10 lg:grid-cols-[0.72fr_1.28fr] lg:gap-16">
          <div>
            <p class="ghd-label">05 / SSS</p>
            <h2
              class="mt-5 font-['Sora'] text-4xl font-bold leading-[1.03] tracking-[-0.055em] text-ghd-navy sm:text-5xl"
            >
              Aklınızdaki<br />
              <span class="text-ghd-bronze">sorular.</span>
            </h2>
            <p class="mt-5 max-w-sm text-sm leading-relaxed text-ghd-muted">
              Başka bir sorunuz varsa
              <a
                class="ghd-link"
                :href="GHD_MAIN_SITE_URL"
                rel="noopener"
                target="_blank"
                >globalhukukcular.com</a
              >
              üzerinden derneğe ulaşabilirsiniz.
            </p>
          </div>

          <div class="space-y-3">
            <details
              v-for="faq in faqs"
              :key="faq.q"
              class="ghd-faq-item group"
            >
              <summary
                class="flex cursor-pointer list-none items-center justify-between gap-4 py-4 font-['Sora'] text-sm font-bold tracking-[-0.02em] text-ghd-navy"
              >
                {{ faq.q }}
                <span
                  class="text-xl font-light text-ghd-bronze transition group-open:rotate-45"
                  >+</span
                >
              </summary>
              <p class="pb-4 text-sm leading-relaxed text-ghd-muted">
                {{ faq.a }}
              </p>
            </details>
          </div>
        </div>
      </div>
    </section>

    <section class="pb-16 sm:pb-24">
      <div class="mx-auto w-full max-w-7xl px-5 sm:px-8">
        <div class="ghd-final-panel px-6 py-14 text-center sm:px-12 sm:py-20">
          <div class="relative z-10">
            <p class="ghd-eyebrow !text-ghd-gold">GHD Açık Kapı</p>
            <h2
              class="mx-auto mt-5 max-w-3xl font-['Sora'] text-4xl font-bold leading-[1.03] tracking-[-0.055em] text-white sm:text-6xl"
            >
              Hukuk pratiğini yerinde görmek için ilk adımı atın.
            </h2>
            <p class="mx-auto mt-5 max-w-xl text-sm leading-relaxed text-white/60 sm:text-base">
              Başvurular yalnızca e-posta doğrulamalı ve yönetici onaylı üyelik
              hesabıyla alınır.
            </p>
            <router-link
              class="ghd-btn ghd-btn-gold ghd-btn-lg mt-8"
              :to="primaryCta.to"
            >
              {{ primaryCta.label }}
              <svg
                aria-hidden="true"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                class="h-4 w-4"
              >
                <path d="M5 12h14M13 6l6 6-6 6" />
              </svg>
            </router-link>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script lang="ts" setup>
import { computed } from "vue";
import { useHead } from "@/utils/head";
import { useFetchEvent } from "@/composition/apollo/event";
import { useCurrentUserClient } from "@/composition/apollo/user";
import { formatDateString } from "@/filters/datetime";
import RouteName from "@/router/name";
import {
  GHD_EVENT_PATH,
  GHD_EVENT_UUID,
  GHD_MAIN_SITE_URL,
} from "@/ghd/constants";

const { event } = useFetchEvent(GHD_EVENT_UUID);
const { currentUser } = useCurrentUserClient();

useHead({
  title: computed(() => "Hukuk Öğrencileri ve Yeni Mezunlar İçin Misafirlik"),
});

const participantCount = computed(
  () => event.value?.participantStats.participant ?? 0
);
const capacity = computed(
  () => event.value?.options.maximumAttendeeCapacity ?? 3
);
const availablePlaces = computed(() =>
  Math.max(capacity.value - participantCount.value, 0)
);
const capacityPercent = computed(() => {
  if (!capacity.value) return 0;
  return Math.min(Math.round((participantCount.value / capacity.value) * 100), 100);
});

const primaryCta = computed(() =>
  currentUser.value?.isLoggedIn
    ? { to: GHD_EVENT_PATH, label: "İlana başvur" }
    : { to: { name: RouteName.REGISTER }, label: "Üyelik başvurusu" }
);

const eventCta = computed(() =>
  currentUser.value?.isLoggedIn
    ? { to: GHD_EVENT_PATH, label: "İlanı incele ve başvur" }
    : { to: { name: RouteName.REGISTER }, label: "Önce üyelik oluştur" }
);

const eventDescription = computed(
  () =>
    event.value?.description ||
    "<p>Bir hukuk bürosunda veya şirketin hukuk ekibinde yarım günlük misafirlik. Başvurular yalnızca onaylı üyeler tarafından yapılır.</p>"
);

const formattedDate = computed(() => {
  if (!event.value?.beginsOn) return "Tarih ilanla birlikte duyurulur";
  return formatDateString(
    event.value.beginsOn.toString(),
    event.value.options?.timezone ?? undefined
  );
});

const eventLocation = computed(() => {
  const address = event.value?.physicalAddress;
  if (!address) return "Yer ilanla birlikte duyurulur";
  const parts = [address.description, address.locality, address.region]
    .filter(Boolean)
    .map((part) => part?.trim())
    .filter(Boolean) as string[];
  return [...new Set(parts)].join(", ") || "Yer ilanla birlikte duyurulur";
});

const marqueeItems = [
  "E-posta doğrulama",
  "Yönetici onayı",
  "3 kişilik kontenjan",
  "Yarım gün",
  "Ankara",
  "Manuel değerlendirme",
];

const features = [
  {
    title: "Gerçek büro deneyimi",
    body: "Bir hukuk bürosunun veya şirket hukuk ekibinin günlük işleyişini yerinde görün.",
    icon: "M3 21h18M5 21V7l7-4 7 4v14M9 21v-4h6v4",
  },
  {
    title: "Dosya akışı",
    body: "Dosyaların nasıl açıldığını, takip edildiğini ve ekip içinde nasıl paylaşıldığını gözlemleyin.",
    icon: "M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8zM14 2v6h6M8 13h8M8 17h6",
  },
  {
    title: "Meslek kültürü",
    body: "Ekip çalışması, mesleki iletişim ve hukuk pratiğinin görünmeyen taraflarını tanıyın.",
    icon: "M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2M9 11a4 4 0 1 0 0-8 4 4 0 0 0 0 8ZM23 21v-2a4 4 0 0 0-3-3.87M16 3.13a4 4 0 0 1 0 7.75",
  },
];

const audience = [
  {
    title: "Hukuk fakültesi öğrencileri",
    body: "Okulda öğrendiklerini gerçek bir büro ortamında görmek isteyenler.",
  },
  {
    title: "Yeni mezun hukukçular",
    body: "Mesleğe geçişte günlük işleyişi ve ekip kültürünü tanımak isteyenler.",
  },
  {
    title: "Öğrenmeye açık katılımcılar",
    body: "Soru sormaktan, gözlem yapmaktan ve meslek pratiğine yaklaşmaktan çekinmeyenler.",
  },
];

const steps = [
  {
    title: "Üyelik başvurusu",
    short: "E-posta, hukuk statüsü ve motivasyon notu.",
    body: "E-posta adresiniz, hukuk statünüz ve kısa motivasyonunuzla GHD Açık Kapı üyelik başvurusu oluşturun.",
  },
  {
    title: "E-postanızı doğrulayın",
    short: "Gelen kutunuzdaki bağlantıya tıklayın.",
    body: "Üyelik başvurunuz sonrası gelen kutunuza gelen bağlantıya tıklayın. Bu adım, başvurunuzun gerçek bir kişiden geldiğini doğrular.",
  },
  {
    title: "Yönetici onayını bekleyin",
    short: "Dernek yönetimi başvurunuzu inceler.",
    body: "Dernek yönetimi üyelik başvurunuzu inceler. Onaylandığında giriş yapabilir ve ilana başvurabilirsiniz.",
  },
  {
    title: "İlana başvurun",
    short: "Profil oluşturun, motivasyon notunuzu gönderin.",
    body: "Onaydan sonra giriş yapın; ilk girişte profil oluşturun ve ilana başvurun. Kısa motivasyon notunuz dernek tarafından değerlendirilir; kontenjan sınırı uygulanır.",
  },
];

const faqs = [
  {
    q: "Başvuru için hesap açmam gerekiyor mu?",
    a: "Evet. Başvurular yalnızca e-posta doğrulamalı ve yönetici onaylı üyelik hesabıyla alınır. Hesap açmadan başvuru kabul edilmez.",
  },
  {
    q: "Kimler başvurabilir?",
    a: "Hukuk fakültesi öğrencileri ve yeni mezun hukukçular başvurabilir. İlanda belirtilen ek koşullar varsa başvuru sırasında dikkate alınır.",
  },
  {
    q: "Kontenjan nasıl işliyor?",
    a: "İlan üç kişiliktir. Kabul edilen katılımcı sayısı üçe ulaştığında yeni başvurular kabul edilmez; değerlendirme sırasında kontenjan sınırı korunur.",
  },
  {
    q: "E-posta adresim kimlerle paylaşılır?",
    a: "E-posta adresiniz yalnızca başvurunun doğrulanması ve süreç bilgilendirmesi için kullanılır. Başvuru notunuz ve adınız değerlendirme için dernekle paylaşılır.",
  },
  {
    q: "Başvurum ne zaman kesinleşir?",
    a: "Önce e-posta adresinizi doğrularsınız, ardından dernek başvurunuzu manuel olarak değerlendirir. Kabul e-postası gelmeden başvurunuz kesinleşmez.",
  },
];
</script>
