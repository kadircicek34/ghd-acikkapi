<template>
  <div class="ghd-shell">
    <section class="container mx-auto px-4 pb-10 pt-12 sm:pt-20">
      <div class="grid items-center gap-10 lg:grid-cols-[1.15fr,0.85fr]">
        <div>
          <p class="ghd-kicker">Global Hukukçular Derneği · Açık Kapı</p>
          <h1
            class="ghd-display mt-4 max-w-3xl text-5xl font-bold leading-[0.98] tracking-tight text-ghd-navy sm:text-6xl lg:text-7xl"
          >
            Hukuk dünyasına
            <span class="italic text-ghd-bronze">yarım günlük</span>
            bir kapı aralayın.
          </h1>
          <p class="mt-6 max-w-2xl text-lg leading-relaxed text-ghd-muted">
            Hukuk öğrencileri ve yeni mezunlar; bir hukuk bürosunda veya
            şirketin hukuk ekibinde yarım günlük misafirliğe başvurabilir.
            İlanı inceleyin, kısa motivasyon notunuzu yazın, e-posta adresinizi
            doğrulayın. Başvurunuz dernek tarafından tek tek değerlendirilir.
          </p>
          <div class="mt-8 flex flex-wrap items-center gap-3">
            <router-link class="ghd-btn ghd-btn-primary" :to="GHD_EVENT_PATH">
              Başvur
              <span aria-hidden="true">→</span>
            </router-link>
            <a class="ghd-btn ghd-btn-outline" href="#surec"
              >Nasıl işliyor?</a
            >
          </div>
          <div class="mt-8 flex flex-wrap gap-2">
            <span class="ghd-tag">3 kişilik kontenjan</span>
            <span class="ghd-tag">E-posta doğrulama</span>
            <span class="ghd-tag">Manuel değerlendirme</span>
            <span class="ghd-tag">Hesap açmadan başvuru</span>
          </div>
        </div>

        <div class="relative mx-auto w-full max-w-md">
          <div
            class="absolute -inset-4 rounded-full bg-ghd-gold/10 blur-2xl"
            aria-hidden="true"
          ></div>
          <div class="ghd-card relative rounded-sm p-6 sm:p-8">
            <div class="flex items-start justify-between gap-4">
              <div>
                <p class="ghd-kicker">Açık Kapı · Misafirlik</p>
                <h2 class="mt-2 text-3xl font-bold leading-tight text-ghd-navy">
                  {{ event?.title || "Yarım Günlük Hukuk Misafirliği" }}
                </h2>
              </div>
              <img
                src="/img/ghd-emblem.png"
                alt=""
                width="76"
                height="76"
                class="h-16 w-16 rounded-full object-cover ring-1 ring-ghd-gold/50 sm:h-20 sm:w-20"
              />
            </div>

            <div class="mt-5 space-y-3 text-sm text-ghd-muted">
              <p class="flex items-start gap-2">
                <span class="mt-1 text-ghd-bronze" aria-hidden="true">◆</span>
                <span v-if="event">
                  {{ formattedDate }}
                  <template v-if="event.physicalAddress?.locality">
                    · {{ event.physicalAddress.locality }}
                  </template>
                </span>
                <span v-else>Yarım gün · Yüz yüze misafirlik</span>
              </p>
              <p class="flex items-start gap-2">
                <span class="mt-1 text-ghd-bronze" aria-hidden="true">◆</span>
                <span
                  >Hukuk öğrencileri ve yeni mezunlar için
                  <template v-if="event">
                    {{ event.options.maximumAttendeeCapacity }} kişilik
                    kontenjan</template
                  ></span
                >
              </p>
              <p class="flex items-start gap-2">
                <span class="mt-1 text-ghd-bronze" aria-hidden="true">◆</span>
                <span
                  >Kısa motivasyon notu ve e-posta doğrulaması ile
                  başvuru</span
                >
              </p>
            </div>

            <div class="mt-6 border-t border-ghd-line pt-4">
              <div
                v-if="event"
                class="mb-4 flex items-center justify-between text-xs font-semibold uppercase tracking-wider text-ghd-muted"
              >
                <span>Kontenjan</span>
                <span class="text-ghd-navy"
                  >{{ event.participantStats.participant }} /
                  {{ event.options.maximumAttendeeCapacity || "—" }}</span
                >
              </div>
              <router-link
                class="ghd-btn ghd-btn-gold w-full"
                :to="GHD_EVENT_PATH"
                >İlanı incele ve başvur</router-link
              >
              <p class="mt-3 text-center text-xs text-ghd-muted">
                Başvuru için hesap açmanız gerekmez.
              </p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <div class="ghd-rule"></div>

    <section class="container mx-auto px-4 py-14">
      <div class="grid gap-8 md:grid-cols-3">
        <div>
          <p class="ghd-kicker">Açık Kapı nedir?</p>
          <h2 class="mt-2 text-3xl font-bold text-ghd-navy">
            Kısa bir misafirlik, kalıcı bir bakış açısı.
          </h2>
        </div>
        <div class="md:col-span-2">
          <p class="text-base leading-relaxed text-ghd-muted">
            Açık Kapı, hukuk öğrencileri ve yeni mezunların meslek hayatını
            yakından tanıması için tasarlanmış yarım günlük bir misafirlik
            programıdır. Katılımcılar bir hukuk bürosunun veya şirketin hukuk
            ekibinin günlük işleyişini yerinde gözlemler; dosya akışı, ekip
            çalışması ve meslek pratiği hakkında ilk elden fikir edinir.
          </p>
          <p class="mt-4 text-base leading-relaxed text-ghd-muted">
            Program kontenjanla sınırlıdır. Başvurular e-posta ile doğrulanır
            ve dernek tarafından manuel olarak değerlendirilir. Onaylanan
            katılımcılara misafirlik gününe ilişkin bilgiler e-posta ile
            iletilir.
          </p>
        </div>
      </div>
    </section>

    <section id="ilan" class="bg-ghd-navy py-14 text-ghd-cream">
      <div class="container mx-auto px-4">
        <div class="flex flex-wrap items-end justify-between gap-6">
          <div>
            <p class="text-xs font-bold uppercase tracking-[0.2em] text-ghd-gold">
              Güncel ilan
            </p>
            <h2 class="mt-2 text-4xl font-bold text-ghd-cream">
              {{ event?.title || "Yarım Günlük Hukuk Misafirliği" }}
            </h2>
          </div>
          <span class="ghd-tag !border-ghd-gold/50 !bg-ghd-gold/10 !text-ghd-cream"
            >Kontenjan: {{ event?.options.maximumAttendeeCapacity || 3 }}</span
          >
        </div>

        <div class="mt-8 grid gap-8 lg:grid-cols-[1.4fr,0.6fr]">
          <div class="rounded-sm border border-white/10 bg-white/[0.04] p-6 sm:p-8">
            <div
              class="prose prose-invert max-w-none text-base leading-relaxed text-ghd-cream/85"
              v-html="eventDescription"
            ></div>
            <div class="mt-6 grid gap-4 sm:grid-cols-2">
              <div class="border-l border-ghd-gold/40 pl-4">
                <p class="text-xs uppercase tracking-wider text-ghd-gold">
                  Tarih
                </p>
                <p class="mt-1 font-semibold text-ghd-cream">
                  {{ formattedDate }}
                </p>
              </div>
              <div class="border-l border-ghd-gold/40 pl-4">
                <p class="text-xs uppercase tracking-wider text-ghd-gold">
                  Yer
                </p>
                <p class="mt-1 font-semibold text-ghd-cream">
                  {{ eventLocation }}
                </p>
              </div>
            </div>
            <div class="mt-8">
              <router-link
                class="ghd-btn ghd-btn-gold"
                :to="GHD_EVENT_PATH"
                >Başvur</router-link
              >
            </div>
          </div>

          <aside class="space-y-4">
            <div class="border border-white/10 p-5">
              <p class="text-xs uppercase tracking-wider text-ghd-gold">
                Süreç
              </p>
              <ol class="mt-3 space-y-3 text-sm text-ghd-cream/80">
                <li>1 · İlanı inceleyin</li>
                <li>2 · Kısa motivasyon notunuzu yazın</li>
                <li>3 · E-posta adresinizi doğrulayın</li>
                <li>4 · Dernek değerlendirmesini bekleyin</li>
              </ol>
            </div>
            <div class="border border-ghd-gold/30 bg-ghd-gold/10 p-5">
              <p class="text-sm leading-relaxed text-ghd-cream/90">
                Başvurunuzun kesinleşmesi için e-posta doğrulaması ve dernek
                onayı gerekir. Kontenjan dolduğunda yeni başvuru kabul
                edilmez.
              </p>
            </div>
          </aside>
        </div>
      </div>
    </section>

    <section id="surec" class="container mx-auto px-4 py-16">
      <div class="max-w-2xl">
        <p class="ghd-kicker">Başvuru süreci</p>
        <h2 class="mt-2 text-4xl font-bold text-ghd-navy">
          Dört adımda Açık Kapı.
        </h2>
        <p class="mt-4 text-ghd-muted">
          Hesap açmadan başvurabilirsiniz. Tek ihtiyacınız geçerli bir e-posta
          adresi ve kısa bir motivasyon notu.
        </p>
      </div>
      <div class="mt-10 grid gap-5 md:grid-cols-2 lg:grid-cols-4">
        <div
          v-for="(step, index) in steps"
          :key="step.title"
          class="ghd-card rounded-sm p-6"
        >
          <span
            class="inline-flex h-9 w-9 items-center justify-center rounded-full bg-ghd-navy text-sm font-bold text-ghd-gold"
            >{{ index + 1 }}</span
          >
          <h3 class="mt-4 text-xl font-bold text-ghd-navy">{{ step.title }}</h3>
          <p class="mt-2 text-sm leading-relaxed text-ghd-muted">
            {{ step.body }}
          </p>
        </div>
      </div>
    </section>

    <section class="bg-ghd-paper py-16">
      <div class="container mx-auto grid gap-10 px-4 lg:grid-cols-2">
        <div>
          <p class="ghd-kicker">Kimler başvurabilir?</p>
          <h2 class="mt-2 text-4xl font-bold text-ghd-navy">
            Hukukun ilk adımlarında olanlar.
          </h2>
          <ul class="mt-6 space-y-4 text-ghd-muted">
            <li class="flex gap-3">
              <span class="mt-1 text-ghd-bronze">◆</span>
              <span>Hukuk fakültesi öğrencileri</span>
            </li>
            <li class="flex gap-3">
              <span class="mt-1 text-ghd-bronze">◆</span>
              <span>Yeni mezun hukukçular</span>
            </li>
            <li class="flex gap-3">
              <span class="mt-1 text-ghd-bronze">◆</span>
              <span
                >Meslek pratiğini yerinde görmek isteyen, öğrenmeye açık
                katılımcılar</span
              >
            </li>
          </ul>
        </div>
        <div class="ghd-card rounded-sm p-6 sm:p-8">
          <p class="ghd-kicker">GHD üyeliği</p>
          <h2 class="mt-2 text-3xl font-bold text-ghd-navy">
            Dernek üyeliği başvurusu
          </h2>
          <p class="mt-3 text-sm leading-relaxed text-ghd-muted">
            Global Hukukçular Derneği üyeliği için de e-posta doğrulaması ve
            yönetici onayı gerekir. Üyelik başvurunuzu oluşturduktan sonra
            e-postanızdaki bağlantıyı doğrulayın; dernek yönetimi başvurunuzu
            değerlendirir.
          </p>
          <router-link
            class="ghd-btn ghd-btn-outline mt-6"
            :to="{ name: RouteName.REGISTER }"
            >Üyelik başvurusu</router-link
          >
          <p class="mt-3 text-xs text-ghd-muted">
            Etkinlik başvurusu için üyelik zorunlu değildir.
          </p>
        </div>
      </div>
    </section>

    <section class="container mx-auto px-4 py-16">
      <div class="grid gap-10 lg:grid-cols-[0.8fr,1.2fr]">
        <div>
          <p class="ghd-kicker">Sık sorulanlar</p>
          <h2 class="mt-2 text-4xl font-bold text-ghd-navy">
            Aklınızdaki sorular.
          </h2>
          <p class="mt-4 text-sm leading-relaxed text-ghd-muted">
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
        <div class="divide-y divide-ghd-line border-y border-ghd-line">
          <details v-for="faq in faqs" :key="faq.q" class="group py-4">
            <summary
              class="flex cursor-pointer list-none items-center justify-between gap-4 font-semibold text-ghd-navy"
            >
              {{ faq.q }}
              <span class="text-ghd-bronze transition group-open:rotate-45">+</span>
            </summary>
            <p class="mt-3 text-sm leading-relaxed text-ghd-muted">
              {{ faq.a }}
            </p>
          </details>
        </div>
      </div>
    </section>

    <section class="bg-ghd-navy py-14 text-center text-ghd-cream">
      <div class="container mx-auto px-4">
        <p class="text-xs font-bold uppercase tracking-[0.2em] text-ghd-gold">
          GHD Açık Kapı
        </p>
        <h2 class="mx-auto mt-3 max-w-3xl text-4xl font-bold text-ghd-cream">
          Hukuk pratiğini yerinde görmek için ilk adımı atın.
        </h2>
        <p class="mx-auto mt-4 max-w-xl text-sm text-ghd-cream/75">
          Başvuru hesap açmadan alınır; e-posta doğrulaması ve dernek onayı ile
          kesinleşir.
        </p>
        <router-link
          class="ghd-btn ghd-btn-gold mt-7"
          :to="GHD_EVENT_PATH"
          >Başvur</router-link
        >
      </div>
    </section>
  </div>
</template>

<script lang="ts" setup>
import { computed } from "vue";
import { useI18n } from "vue-i18n";
import { useHead } from "@/utils/head";
import { useFetchEvent } from "@/composition/apollo/event";
import { formatDateString } from "@/filters/datetime";
import RouteName from "@/router/name";
import {
  GHD_EVENT_PATH,
  GHD_EVENT_UUID,
  GHD_MAIN_SITE_URL,
} from "@/ghd/constants";

const { t } = useI18n({ useScope: "global" });
const { event } = useFetchEvent(GHD_EVENT_UUID);

useHead({
  title: computed(() => t("GHD Açık Kapı")),
});

const eventDescription = computed(
  () =>
    event.value?.description ||
    "<p>Bir hukuk bürosunda veya şirketin hukuk ekibinde yarım günlük misafirlik. Başvurunuzu kısa motivasyon notunuzla birlikte gönderin.</p>"
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
  return (
    [address.description, address.locality, address.region]
      .filter(Boolean)
      .join(", ") || "Yer ilanla birlikte duyurulur"
  );
});

const steps = [
  {
    title: "İlanı inceleyin",
    body: "Misafirliğin yapılacağı büro veya hukuk ekibi, tarih ve kontenjan bilgilerini ilan sayfasında bulun.",
  },
  {
    title: "Motivasyon notunuzu yazın",
    body: "Hesap açmadan; adınız, hukuk statünüz ve kısa motivasyon notunuzla başvurunuzu gönderin.",
  },
  {
    title: "E-postanızı doğrulayın",
    body: "Başvuru sonrası gelen kutunuza gelen bağlantıya tıklayın. Bu adım, başvurunuzun gerçek bir kişiden geldiğini doğrular.",
  },
  {
    title: "Değerlendirmeyi bekleyin",
    body: "Dernek başvuruyu inceler. Kabul veya ret kararı e-posta ile bildirilir; kontenjan sınırı uygulanır.",
  },
];

const faqs = [
  {
    q: "Başvuru için hesap açmam gerekiyor mu?",
    a: "Hayır. Açık Kapı başvuruları hesap açmadan, e-posta doğrulaması ve kısa motivasyon notu ile alınır.",
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
