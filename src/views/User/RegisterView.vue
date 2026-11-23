<template>
  <div class="ghd-auth px-5 py-10 sm:px-8 sm:py-16">
    <div
      class="mx-auto grid w-full max-w-7xl items-stretch gap-6 lg:grid-cols-[0.82fr_1.18fr]"
    >
      <aside class="ghd-auth-panel order-2 p-7 sm:p-10 lg:order-1 lg:p-12">
        <div class="relative z-10 flex h-full flex-col">
          <div class="flex items-center gap-3">
            <img
              src="/img/ghd-emblem.png"
              alt=""
              width="52"
              height="52"
              class="h-12 w-12 rounded-full object-cover ring-1 ring-white/20"
            />
            <div>
              <p
                class="font-['Sora'] text-lg font-bold tracking-[-0.04em] text-white"
              >
                GHD Açık Kapı
              </p>
              <p
                class="text-[0.56rem] font-extrabold uppercase tracking-[0.22em] text-ghd-gold"
              >
                Global Hukukçular Derneği
              </p>
            </div>
          </div>

          <div class="mt-12">
            <p class="ghd-eyebrow !text-ghd-gold">Üyelik başvurusu</p>
            <h1
              class="mt-4 font-['Sora'] text-4xl font-bold leading-[0.98] tracking-[-0.055em] text-white sm:text-5xl"
            >
              Üyelik, tek bir<br />kapıdan başlar.
            </h1>
            <p class="mt-5 max-w-md text-base leading-relaxed text-white/60">
              Hukuk öğrencileri ve yeni mezunlar için tasarlanan Açık Kapı
              programına katılmak üzere üyelik başvurunuzu oluşturun.
            </p>
          </div>

          <ol class="mt-9 space-y-4">
            <li class="flex gap-3">
              <span
                class="flex h-6 w-6 shrink-0 items-center justify-center rounded-full border border-ghd-gold/30 bg-ghd-gold/10 text-[0.6rem] font-extrabold text-ghd-gold"
                >01</span
              >
              <div>
                <p class="text-sm font-bold text-white/90">Başvurunuzu gönderin</p>
                <p class="mt-0.5 text-xs leading-relaxed text-white/40">
                  E-posta, hukuk statüsü ve kısa motivasyon notu yeterlidir.
                </p>
              </div>
            </li>
            <li class="flex gap-3">
              <span
                class="flex h-6 w-6 shrink-0 items-center justify-center rounded-full border border-ghd-gold/30 bg-ghd-gold/10 text-[0.6rem] font-extrabold text-ghd-gold"
                >02</span
              >
              <div>
                <p class="text-sm font-bold text-white/90">E-postanızı doğrulayın</p>
                <p class="mt-0.5 text-xs leading-relaxed text-white/40">
                  Gelen kutunuza gelen bağlantı hesabınızı etkinleştirir.
                </p>
              </div>
            </li>
            <li class="flex gap-3">
              <span
                class="flex h-6 w-6 shrink-0 items-center justify-center rounded-full border border-ghd-gold/30 bg-ghd-gold/10 text-[0.6rem] font-extrabold text-ghd-gold"
                >03</span
              >
              <div>
                <p class="text-sm font-bold text-white/90">Yönetici onayını bekleyin</p>
                <p class="mt-0.5 text-xs leading-relaxed text-white/40">
                  Dernek yönetimi başvurunuzu değerlendirir; onay sonrası ilana
                  başvurabilirsiniz.
                </p>
              </div>
            </li>
          </ol>

          <div
            class="mt-auto rounded-2xl border border-white/10 bg-white/[0.04] p-4 text-xs leading-relaxed text-white/50"
          >
            Onay e-postası gelmeden hesabınız aktif olmaz. Başvurunuzun
            durumunu yönetici onayından sonra giriş yaparak takip edebilirsiniz.
          </div>
        </div>
      </aside>

      <div class="ghd-auth-card order-1 p-6 sm:p-9 lg:order-2 lg:p-10">
        <div v-if="!validationSent">
          <p class="ghd-eyebrow">Yeni üyelik</p>
          <h2
            class="mt-3 font-['Sora'] text-3xl font-bold tracking-[-0.045em] text-ghd-navy"
          >
            Başvurunuzu oluşturun.
          </h2>
          <p class="mt-3 text-sm leading-relaxed text-ghd-muted">
            Başvurunuz önce e-posta ile doğrulanır, ardından dernek yönetimi
            tarafından değerlendirilir. Açık Kapı ilanına başvurmak için onaylı
            üyelik zorunludur.
          </p>

          <o-notification
            variant="warning"
            v-if="config?.registrationsAllowlist"
            :closable="false"
          >
            {{ t("Registrations are restricted by allowlisting.") }}
          </o-notification>
          <o-field :variant="errorOtherType" :message="errorOtherMessage" />

          <form class="ghd-form mt-7" @submit.prevent="submit">
            <div class="grid gap-x-4 sm:grid-cols-2">
              <o-field
                :label="t('Email')"
                :variant="errorEmailType"
                :message="errorEmailMessage"
                label-for="email"
              >
                <o-input
                  aria-required="true"
                  required
                  id="email"
                  type="email"
                  autocomplete="email"
                  v-model="credentials.email"
                  expanded
                />
              </o-field>

              <o-field
                :label="t('Password')"
                :variant="errorPasswordType"
                :message="errorPasswordMessage"
                label-for="password"
              >
                <o-input
                  aria-required="true"
                  required
                  id="password"
                  type="password"
                  autocomplete="new-password"
                  password-reveal
                  minlength="6"
                  v-model="credentials.password"
                  expanded
                />
              </o-field>
            </div>

            <o-field label="Hukuk statünüz" label-for="law-status">
              <o-select id="law-status" v-model="lawStatus" required>
                <option value="student">Hukuk Fakültesi Öğrencisi</option>
                <option value="graduate">Hukuk Fakültesi Mezunu</option>
              </o-select>
            </o-field>

            <o-field
              v-if="config?.registrationsModeration"
              label="Kısa motivasyon notunuz"
              :variant="errorModerationType"
              :message="errorModerationMessage"
              label-for="moderation"
            >
              <o-input
                aria-required="true"
                required
                :autosize="false"
                id="moderation"
                type="textarea"
                v-model="credentials.moderation"
                placeholder="Neden GHD Açık Kapı üyeliğine başvuruyorsunuz? Kısaca anlatın."
                expanded
              />
            </o-field>

            <div class="mb-6 mt-2 flex items-start gap-3">
              <input
                type="checkbox"
                id="accept_rules_terms"
                class="mt-1 h-4 w-4 rounded border-ghd-navy/20 accent-ghd-gold"
                required
              />
              <label
                for="accept_rules_terms"
                class="text-xs leading-relaxed text-ghd-muted"
              >
                Platform
                <router-link class="ghd-link" :to="{ name: RouteName.RULES }"
                  >kurallarını</router-link
                >
                ve
                <router-link class="ghd-link" :to="{ name: RouteName.TERMS }"
                  >kullanım koşullarını</router-link
                >
                kabul ediyorum.
              </label>
            </div>

            <button
              class="ghd-btn ghd-btn-primary ghd-btn-lg w-full"
              type="submit"
              :disabled="sendingForm"
            >
              Üyelik başvurusu yap
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
            </button>

            <div
              class="mt-5 flex flex-col gap-2 text-sm font-semibold sm:flex-row sm:items-center sm:justify-between"
            >
              <router-link
                class="ghd-link"
                :to="{
                  name: RouteName.RESEND_CONFIRMATION,
                  params: { email: credentials.email },
                }"
                >{{ t("Didn't receive the instructions?") }}</router-link
              >
              <router-link
                class="ghd-link"
                :to="{
                  name: RouteName.LOGIN,
                  query: {
                    email: credentials.email,
                    password: credentials.password,
                    moderation: credentials.moderation,
                  },
                }"
                >{{ t("Login") }}</router-link
              >
            </div>

            <div
              class="mt-6 border-t border-ghd-navy/10 pt-5"
              v-if="config && config.auth.oauthProviders.length > 0"
            >
              <auth-providers :oauthProviders="config.auth.oauthProviders" />
            </div>
          </form>
        </div>

        <div v-else class="py-8 text-center">
          <span
            class="mx-auto flex h-16 w-16 items-center justify-center rounded-full bg-ghd-gold/10 text-ghd-bronze"
          >
            <svg
              aria-hidden="true"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2.2"
              class="h-7 w-7"
            >
              <path d="m5 12 4 4L19 6" />
            </svg>
          </span>
          <h2
            class="mt-6 font-['Sora'] text-3xl font-bold tracking-[-0.045em] text-ghd-navy"
          >
            Başvurunuz alındı.
          </h2>
          <p class="mt-4 text-sm leading-relaxed text-ghd-muted">
            <span class="font-semibold text-ghd-navy">{{
              credentials.email
            }}</span>
            adresine bir doğrulama e-postası gönderdik.
          </p>
          <p class="mt-2 text-sm leading-relaxed text-ghd-muted">
            Hesabınızı etkinleştirmek için e-postadaki bağlantıya tıklayın.
            Doğrulama sonrası başvurunuz dernek yönetiminin onayına sunulur.
          </p>
          <router-link
            class="ghd-btn ghd-btn-primary mt-7"
            :to="{ name: RouteName.HOME }"
            >Ana sayfaya dön</router-link
          >
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { CREATE_USER } from "@/graphql/user";
import RouteName from "@/router/name";
import { IConfig } from "@/types/config.model";
import { CONFIG } from "@/graphql/config";
import AuthProviders from "@/components/User/AuthProviders.vue";
import { computed, reactive, ref, watch } from "vue";
import { useMutation, useQuery } from "@vue/apollo-composable";
import { useI18n } from "vue-i18n";
import { useRoute } from "vue-router";
import { useHead } from "@/utils/head";
import { AbsintheGraphQLErrors } from "@/types/errors.model";

type errorType = "danger" | "warning";
type errorMessage = { type: errorType; message: string };
type credentialsType = {
  email: string;
  password: string;
  moderation: string;
  locale: string;
};

const { t, locale } = useI18n({ useScope: "global" });
const route = useRoute();
const validationSent = ref(false);

const { result: configResult } = useQuery<{ config: IConfig }>(CONFIG);

const config = computed(() => configResult.value?.config);

const lawStatus = ref<"student" | "graduate">("student");

const credentials = reactive<credentialsType>({
  email: typeof route.query.email === "string" ? route.query.email : "",
  password:
    typeof route.query.password === "string" ? route.query.password : "",
  moderation:
    typeof route.query.moderation === "string" ? route.query.moderation : "",
  locale: "tr",
});

const otherErrors = ref<errorMessage[]>([]);
const emailErrors = ref<errorMessage[]>([]);
const passwordErrors = ref<errorMessage[]>([]);
const moderationError = ref<errorMessage[]>([]);

const sendingForm = ref(false);

const title = computed((): string => {
  if (config.value) {
    return t("Register an account on {instanceName}!", {
      instanceName: config.value?.name,
    });
  }
  return "";
});

useHead({
  title: () => title.value,
});

const { onDone, onError, mutate } = useMutation(CREATE_USER);

onDone(() => {
  validationSent.value = true;
});

onError((error) => {
  (error.graphQLErrors as AbsintheGraphQLErrors).forEach(
    ({ field, message }) => {
      let message_txt;
      if (Array.isArray(message)) {
        message_txt = message[0] as string;
      } else {
        message_txt = message as string;
      }
      switch (field) {
        case "email":
          emailErrors.value.push({
            type: "danger" as errorType,
            message: message_txt,
          });
          break;
        case "password":
          passwordErrors.value.push({
            type: "danger" as errorType,
            message: message_txt,
          });
          break;
        case "moderation":
          moderationError.value.push({
            type: "danger" as errorType,
            message: message_txt,
          });
          break;
        default:
          otherErrors.value.push({
            type: "danger" as errorType,
            message: message_txt,
          });
      }
    }
  );
  sendingForm.value = false;
});

const submit = async (): Promise<void> => {
  sendingForm.value = true;
  credentials.locale = locale as unknown as string;
  try {
    emailErrors.value = [];
    passwordErrors.value = [];
    moderationError.value = [];

    const lawStatusLabel =
      lawStatus.value === "student"
        ? "Hukuk Fakültesi Öğrencisi"
        : "Hukuk Fakültesi Mezunu";

    mutate({
      ...credentials,
      moderation: `Hukuk statüsü: ${lawStatusLabel}\n\n${credentials.moderation}`,
    });
  } catch (error: any) {
    console.error(error);

    sendingForm.value = false;
  }
};

watch(credentials, () => {
  if (credentials.email !== credentials.email.toLowerCase()) {
    const error = {
      type: "warning" as errorType,
      message: t(
        "Emails usually don't contain capitals, make sure you haven't made a typo."
      ),
    };
    emailErrors.value = [error];
  }
});

const maxErrorType = (errors: errorMessage[]): errorType | undefined => {
  if (!errors || errors.length === 0) return undefined;
  return errors.reduce<errorType>((acc, error) => {
    if (error.type === "danger" || acc === "danger") return "danger";
    return "warning";
  }, "warning");
};

const errorOtherType = computed((): errorType | undefined => {
  return maxErrorType(otherErrors.value);
});

const errorEmailType = computed((): errorType | undefined => {
  return maxErrorType(emailErrors.value);
});
const errorPasswordType = computed((): errorType | undefined => {
  return maxErrorType(passwordErrors.value);
});

const errorModerationType = computed((): errorType | undefined => {
  return maxErrorType(moderationError.value);
});

const errorOtherMessage = computed((): string => {
  return otherErrors.value.map(({ message }) => message).join(" ");
});

const errorEmailMessage = computed((): string => {
  return emailErrors.value.map(({ message }) => message).join(" ");
});

const errorPasswordMessage = computed((): string => {
  return passwordErrors.value?.map(({ message }) => message).join(" ");
});

const errorModerationMessage = computed((): string => {
  return moderationError.value?.map(({ message }) => message).join(" ");
});
</script>
