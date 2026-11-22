<template>
  <section class="container mx-auto max-w-3xl px-4 py-8">
    <div v-if="event">
      <div class="mb-6">
        <p class="ghd-kicker">GHD Açık Kapı · Başvuru</p>
        <h1 class="mt-2 text-4xl font-bold text-ghd-navy">
          Hesap açmadan başvuru
        </h1>
        <p class="mt-3 max-w-2xl text-sm leading-relaxed text-ghd-muted">
          {{ event.title }} için başvurunuzu aşağıdan gönderin. Başvurunuz önce
          e-posta ile doğrulanacak, ardından dernek tarafından manuel olarak
          değerlendirilecektir.
        </p>
      </div>

      <form
        @submit.prevent="joinEvent"
        v-if="!formSent"
        class="ghd-card rounded-sm p-6 sm:p-8"
      >
        <div class="mb-5 flex flex-wrap items-center gap-2">
          <span class="ghd-tag">Kontenjan: 3 kişi</span>
          <span class="ghd-tag">E-posta doğrulamalı</span>
          <span class="ghd-tag">Manuel değerlendirme</span>
        </div>

        <o-notification variant="info" :closable="false">
          E-posta adresiniz yalnızca başvurunuzu doğrulamak ve süreçle ilgili
          bilgilendirme yapmak için kullanılır. Başvuru notunuz ve adınız ilan
          sahibiyle paylaşılır.
        </o-notification>

        <o-notification variant="danger" v-if="error">{{
          error
        }}</o-notification>

        <div class="grid gap-4 sm:grid-cols-2">
          <o-field label="Ad Soyad" label-for="applicantName">
            <o-input
              id="applicantName"
              v-model="anonymousParticipation.name"
              placeholder="Adınız ve soyadınız"
              minlength="3"
              maxlength="120"
              required
            />
          </o-field>

          <o-field label="E-posta adresi" label-for="anonymousParticipationEmail">
            <o-input
              type="email"
              id="anonymousParticipationEmail"
              v-model="anonymousParticipation.email"
              placeholder="ornek@eposta.com"
              required
            />
          </o-field>
        </div>

        <o-field label="Hukuk statünüz" label-for="applicantLawStatus">
          <o-select
            id="applicantLawStatus"
            v-model="anonymousParticipation.lawStatus"
            required
          >
            <option value="student">Hukuk Fakültesi Öğrencisi</option>
            <option value="graduate">Hukuk Fakültesi Mezunu</option>
          </o-select>
        </o-field>

        <o-field
          label="Kısa motivasyon notu"
          label-for="anonymousParticipationMessage"
        >
          <o-input
            id="anonymousParticipationMessage"
            type="textarea"
            v-model="anonymousParticipation.message"
            minlength="10"
            maxlength="600"
            placeholder="Neden bu misafirliğe katılmak istiyorsunuz? Kısaca anlatın."
            required
          />
        </o-field>

        <div class="mt-4 space-y-3 rounded-sm border border-ghd-line bg-ghd-paper/60 p-4">
          <o-checkbox v-model="anonymousParticipation.kvkkAccepted" required>
            <span class="text-sm text-ghd-navy">
              <router-link
                class="ghd-link"
                :to="{ name: RouteName.PRIVACY }"
                target="_blank"
                >KVKK aydınlatma metnini</router-link
              >
              okudum; başvurumun değerlendirilmesi için adımın, hukuk statümün
              ve motivasyon notumun ilan sahibiyle paylaşılmasına onay
              veriyorum.
            </span>
          </o-checkbox>

          <o-checkbox v-model="anonymousParticipation.saveParticipation">
            <span class="text-sm text-ghd-navy">
              Başvurumu bu tarayıcıda hatırla
            </span>
            <p class="mt-1 text-xs leading-relaxed text-ghd-muted">
              Başvuru durumunuzu bu cihazda görmek istiyorsanız işaretli
              bırakın. Ortak kullanılan bir cihazda işareti kaldırın.
            </p>
          </o-checkbox>
        </div>

        <div class="mt-6 flex flex-wrap items-center gap-3">
          <o-button
            :disabled="sendingForm"
            variant="primary"
            size="large"
            type="submit"
            >{{ sendingForm ? "Gönderiliyor…" : "Başvuruyu gönder" }}</o-button
          >
          <router-link
            class="ghd-btn ghd-btn-outline"
            :to="{ name: RouteName.EVENT, params: { uuid: event.uuid } }"
            >İlana dön</router-link
          >
        </div>
      </form>

      <div v-else class="ghd-card rounded-sm p-6 sm:p-8">
        <p class="ghd-kicker">Başvuru alındı</p>
        <h2 class="mt-2 text-3xl font-bold text-ghd-navy">
          Doğrulama e-postası gönderildi
        </h2>
        <p class="mt-3 text-sm leading-relaxed text-ghd-muted">
          {{ anonymousParticipation.email }} adresine bir doğrulama bağlantısı
          gönderdik. Gelen kutunuzu ve spam klasörünüzü kontrol edin.
        </p>
        <div class="mt-5 rounded-sm border border-ghd-gold/30 bg-ghd-gold/10 p-4 text-sm leading-relaxed text-ghd-navy">
          <p>
            <strong>Sonraki adım:</strong> E-postadaki bağlantıya tıklayın.
            Başvurunuz doğrulandıktan sonra dernek değerlendirmesine alınır.
          </p>
          <p class="mt-2">
            Değerlendirme sonucu e-posta ile bildirilir. Başvurunuz, kabul
            e-postası gelmeden kesinleşmez.
          </p>
        </div>
        <p class="mt-5 text-sm text-ghd-muted">
          Bu pencereyi kapatabilir veya
          <router-link
            class="ghd-link"
            :to="{ name: RouteName.EVENT, params: { uuid: event.uuid } }"
            >ilana dönebilirsiniz</router-link
          >.
        </p>
      </div>
    </div>

    <o-notification variant="danger" v-else-if="!loading">
      İlan yüklenemedi. Lütfen sayfayı yenileyip tekrar deneyin.
      <details>
        <pre>{{ error }}</pre>
      </details>
    </o-notification>
  </section>
</template>

<script lang="ts" setup>
import { IEvent } from "@/types/event.model";
import { FETCH_EVENT_BASIC, JOIN_EVENT } from "@/graphql/event";
import { addLocalUnconfirmedAnonymousParticipation } from "@/services/AnonymousParticipationStorage";
import { ParticipantRole } from "@/types/enums";
import RouteName from "@/router/name";
import { IParticipant } from "@/types/participant.model";
import { ApolloCache, FetchResult } from "@apollo/client/core";
import { useFetchEventBasic } from "@/composition/apollo/event";
import { useAnonymousActorId } from "@/composition/apollo/config";
import { computed, reactive, ref } from "vue";
import { useI18n } from "vue-i18n";
import { useHead } from "@/utils/head";
import { useMutation } from "@vue/apollo-composable";

const error = ref<boolean | string>(false);
const { anonymousActorId } = useAnonymousActorId();

const props = defineProps<{
  uuid: string;
}>();
const { event, loading } = useFetchEventBasic(computed(() => props.uuid));

const { t, locale } = useI18n({ useScope: "global" });

useHead({
  title: computed(() => t("Hesap açmadan başvuru")),
  meta: [{ name: "robots", content: "noindex" }],
});

const anonymousParticipation = reactive<{
  name: string;
  email: string;
  lawStatus: string;
  message: string;
  kvkkAccepted: boolean;
  saveParticipation: boolean;
}>({
  name: "",
  email: "",
  lawStatus: "student",
  message: "",
  kvkkAccepted: false,
  saveParticipation: true,
});

const formSent = ref(false);
const sendingForm = ref(false);

const {
  mutate: joinEventMutation,
  onDone: joinEventDone,
  onError: joinEventError,
} = useMutation<{
  joinEvent: IParticipant;
}>(JOIN_EVENT, () => ({
  update: (
    store: ApolloCache<{ joinEvent: IParticipant }>,
    { data: updateData }: FetchResult
  ) => {
    if (updateData == null) return;

    const cachedData = store.readQuery<{ event: IEvent }>({
      query: FETCH_EVENT_BASIC,
      variables: { uuid: event.value?.uuid },
    });
    if (cachedData == null) return;
    const participantStats = { ...cachedData.event.participantStats };

    if (updateData.joinEvent.role === ParticipantRole.NOT_CONFIRMED) {
      participantStats.notConfirmed += 1;
    } else {
      participantStats.going += 1;
      participantStats.participant += 1;
    }

    store.writeQuery({
      query: FETCH_EVENT_BASIC,
      variables: { uuid: event.value?.uuid },
      data: {
        event: {
          ...cachedData.event,
          participantStats,
        },
      },
    });
  },
}));

joinEventDone(async ({ data }) => {
  sendingForm.value = false;
  formSent.value = true;
  if (
    data?.joinEvent.metadata.cancellationToken &&
    anonymousParticipation.saveParticipation &&
    event.value
  ) {
    try {
      await addLocalUnconfirmedAnonymousParticipation(
        event.value,
        data.joinEvent.metadata.cancellationToken
      );
    } catch (e: any) {
      if (
        ["TextEncoder is not defined", "crypto.subtle is undefined"].includes(
          e.message
        )
      ) {
        error.value = t("Unable to save your participation in this browser.");
      }
    }
  }
});

joinEventError((e) => {
  sendingForm.value = false;
  if (e.graphQLErrors && e.graphQLErrors.length > 0) {
    error.value = e.graphQLErrors[0].message;
  } else if (e.networkError) {
    error.value = e.networkError.message;
  }
});

const joinEvent = async (): Promise<void> => {
  error.value = false;
  sendingForm.value = true;
  joinEventMutation({
    eventId: event.value?.id,
    actorId: anonymousActorId.value,
    email: anonymousParticipation.email,
    message: anonymousParticipation.message,
    name: anonymousParticipation.name,
    lawStatus: anonymousParticipation.lawStatus,
    kvkkAccepted: anonymousParticipation.kvkkAccepted,
    locale: locale.value,
    timezone: Intl.DateTimeFormat().resolvedOptions().timeZone,
  });
};
</script>
