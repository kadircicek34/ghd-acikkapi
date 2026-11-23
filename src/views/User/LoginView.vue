<template>
  <section
    class="ghd-auth px-5 py-10 sm:px-8 sm:py-16"
    v-if="!currentUser?.isLoggedIn"
  >
    <div
      class="mx-auto grid w-full max-w-6xl items-stretch gap-6 lg:grid-cols-[1.02fr_0.98fr]"
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

          <div class="mt-14">
            <p class="ghd-eyebrow !text-ghd-gold">Üye girişi</p>
            <h1
              class="mt-4 font-['Sora'] text-4xl font-bold leading-[0.98] tracking-[-0.055em] text-white sm:text-5xl"
            >
              Kapıyı<br />aralayın.
            </h1>
            <p class="mt-5 max-w-md text-base leading-relaxed text-white/60">
              Hesabınıza giriş yapın; ilana başvurun, başvurunuzun durumunu
              takip edin ve dernek duyurularından haberdar olun.
            </p>
          </div>

          <ul class="mt-10 space-y-3 text-sm text-white/60">
            <li class="flex items-start gap-3">
              <span
                class="mt-0.5 flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-ghd-gold/10 text-ghd-gold"
                aria-hidden="true"
              >
                <svg
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="2.4"
                  class="h-3 w-3"
                >
                  <path d="m5 12 4 4L19 6" />
                </svg>
              </span>
              E-posta doğrulamalı, yönetici onaylı üyelik
            </li>
            <li class="flex items-start gap-3">
              <span
                class="mt-0.5 flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-ghd-gold/10 text-ghd-gold"
                aria-hidden="true"
              >
                <svg
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="2.4"
                  class="h-3 w-3"
                >
                  <path d="m5 12 4 4L19 6" />
                </svg>
              </span>
              Üç kişilik kontenjan, manuel değerlendirme
            </li>
            <li class="flex items-start gap-3">
              <span
                class="mt-0.5 flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-ghd-gold/10 text-ghd-gold"
                aria-hidden="true"
              >
                <svg
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="2.4"
                  class="h-3 w-3"
                >
                  <path d="m5 12 4 4L19 6" />
                </svg>
              </span>
              Başvuru ve kabul sürecini tek yerden takip
            </li>
          </ul>

          <p class="mt-auto pt-10 text-xs leading-relaxed text-white/30">
            GHD Açık Kapı, Global Hukukçular Derneği'nin hukuk öğrencileri ve
            yeni mezunlar için yürüttüğü misafirlik programıdır.
          </p>
        </div>
      </aside>

      <div class="ghd-auth-card order-1 p-6 sm:p-9 lg:order-2 lg:p-10">
        <p class="ghd-eyebrow">Hesabınıza giriş</p>
        <h2
          class="mt-3 font-['Sora'] text-3xl font-bold tracking-[-0.045em] text-ghd-navy"
        >
          Tekrar hoş geldiniz.
        </h2>
        <p class="mt-3 text-sm leading-relaxed text-ghd-muted">
          Açık Kapı ilanına başvurmak için e-posta doğrulamalı ve yönetici
          onaylı üyelik hesabı gerekir.
        </p>

        <o-notification
          v-if="errorCode === LoginErrorCode.NEED_TO_LOGIN"
          title="Bilgi"
          variant="info"
          :aria-close-label="t('Close')"
          >{{ t("You need to login.") }}</o-notification
        >
        <o-notification
          v-else-if="errorCode === LoginError.LOGIN_PROVIDER_ERROR"
          variant="danger"
          :aria-close-label="t('Close')"
          >{{
            t("Error while login with {provider}. Retry or login another way.", {
              provider: currentProvider,
            })
          }}</o-notification
        >
        <o-notification
          v-else-if="errorCode === LoginError.LOGIN_PROVIDER_NOT_FOUND"
          variant="danger"
          :aria-close-label="t('Close')"
          >{{
            t(
              "Error while login with {provider}. This login provider doesn't exist.",
              {
                provider: currentProvider,
              }
            )
          }}</o-notification
        >
        <o-notification
          :title="t('Error')"
          variant="danger"
          v-for="error in errors"
          :key="error"
        >
          {{ error }}
        </o-notification>

        <form class="ghd-form mt-7" @submit="loginAction" v-if="config?.auth?.databaseLogin">
          <o-field
            :label="t('Email')"
            label-for="email"
            :message="caseWarningText"
            :type="caseWarningType"
          >
            <o-input
              aria-required="true"
              required
              expanded
              id="email"
              type="email"
              autocomplete="email"
              v-model="credentials.email"
            />
          </o-field>

          <o-field :label="t('Password')" label-for="password">
            <o-input
              aria-required="true"
              id="password"
              required
              expanded
              type="password"
              autocomplete="current-password"
              password-reveal
              v-model="credentials.password"
            />
          </o-field>

          <button
            class="ghd-btn ghd-btn-primary ghd-btn-lg mt-2 w-full"
            type="submit"
            :disabled="submitted"
          >
            {{ t("Login") }}
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
                name: RouteName.SEND_PASSWORD_RESET,
                params: { email: credentials.email },
              }"
              >{{ t("Reset your password") }}</router-link
            >
            <router-link
              class="ghd-link"
              :to="{
                name: RouteName.RESEND_CONFIRMATION,
                params: { email: credentials.email },
              }"
              >{{ t("Didn't receive the instructions?") }}</router-link
            >
          </div>

          <p v-if="canRegister" class="mt-6 text-center text-sm text-ghd-muted">
            Henüz üyeliğiniz yok mu?
            <router-link
              class="font-extrabold text-ghd-navy underline decoration-ghd-gold/60 underline-offset-4"
              :to="{
                name: RouteName.REGISTER,
                query: {
                  default_email: credentials.email,
                  default_password: credentials.password,
                },
              }"
              >Üyelik başvurusu yapın</router-link
            >
          </p>
        </form>

        <div v-if="config && config?.auth?.oauthProviders?.length > 0" class="mt-6">
          <auth-providers :oauthProviders="config.auth.oauthProviders" />
        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import { LOGIN } from "@/graphql/auth";
import { CONFIG } from "@/graphql/config";
import { LOGGED_USER_LOCATION } from "@/graphql/user";
import { UPDATE_CURRENT_USER_CLIENT } from "@/graphql/user";
import { IConfig } from "@/types/config.model";
import { IUser } from "@/types/current-user.model";
import { saveUserData, SELECTED_PROVIDERS } from "@/utils/auth";
import { storeUserLocationAndRadiusFromUserSettings } from "@/utils/location";
import {
  useMutation,
  useLazyQuery,
  useQuery,
  useApolloClient,
} from "@vue/apollo-composable";
import { computed, reactive, ref, onMounted } from "vue";
import { useI18n } from "vue-i18n";
import { useRoute, useRouter } from "vue-router";
import AuthProviders from "@/components/User/AuthProviders.vue";
import RouteName from "@/router/name";
import { LoginError, LoginErrorCode } from "@/types/enums";
import { useCurrentUserClient } from "@/composition/apollo/user";
import { useHead } from "@/utils/head";
import { enumTransformer, useRouteQuery } from "vue-use-route-query";
import { useCurrentUserIdentities } from "@/composition/apollo/actor";

const { t } = useI18n({ useScope: "global" });
const router = useRouter();
const route = useRoute();

const { currentUser } = useCurrentUserClient();
const { identities } = useCurrentUserIdentities();

const apollo = useApolloClient();

const configQuery = useQuery<{
  config: Pick<
    IConfig,
    | "auth"
    | "registrationsOpen"
    | "registrationsModeration"
    | "registrationsAllowlist"
  >;
}>(CONFIG);

const config = computed(() => configQuery.result.value?.config);

const canRegister = computed(() => {
  return (
    (config.value?.registrationsOpen || config.value?.registrationsAllowlist) &&
    config.value?.auth?.databaseLogin
  );
});

const errors = ref<string[]>([]);
const submitted = ref(false);

const credentials = reactive({
  email: typeof route.query.email === "string" ? route.query.email : "",
  password:
    typeof route.query.password === "string" ? route.query.password : "",
});

const redirect = useRouteQuery("redirect", "");
const errorCode = useRouteQuery("code", null, enumTransformer(LoginErrorCode));

// Login
const loginMutation = useMutation(LOGIN);
// Update user in cache
const currentUserMutation = useMutation(UPDATE_CURRENT_USER_CLIENT);
// Retrieve preferred location
const loggedUserLocationQuery = useLazyQuery<{
  loggedUser: IUser;
}>(LOGGED_USER_LOCATION);

// form submit action
const loginAction = async (e: Event) => {
  e.preventDefault();
  if (submitted.value) {
    return;
  }
  submitted.value = true;
  errors.value = [];

  try {
    // Step 0: Call resetStore to ensure that queries which identify the user via HTTP headers
    // (instead of GraphQL variables) are properly refetched.
    // https://www.apollographql.com/docs/react/networking/authentication#reset-store-on-logout
    apollo.client.resetStore();

    // Step 1: login the user
    const { data: loginData } = await loginMutation.mutate({
      email: credentials.email,
      password: credentials.password,
    });
    submitted.value = false;
    if (loginData == null) {
      throw new Error("Login: user's data is undefined");
    }

    // Login saved to local storage
    saveUserData(loginData.login);

    // Step 2: save login in apollo cache
    await currentUserMutation.mutate({
      id: loginData.login.user.id,
      email: credentials.email,
      isLoggedIn: true,
      role: loginData.login.user.role,
    });

    // Step 3: Retrieving user location
    const loggedUserLocationPromise = loggedUserLocationQuery.load();

    const loggedUserLocationResult = await loggedUserLocationPromise;
    storeUserLocationAndRadiusFromUserSettings(
      loggedUserLocationResult?.loggedUser?.settings?.location
    );

    // Step 4: Redirection
    if (identities.value && identities.value.length < 1) {
      console.debug(
        "no identities, a redirection to CREATE_IDENTITY has already been done by App.vue"
      );
      return;
    }

    if (redirect.value) {
      console.debug("We have a redirect", redirect.value);
      router.push(redirect.value);
      return;
    }
    console.debug("No redirect, going to homepage");
    if (window.localStorage) {
      console.debug("Has localstorage, setting welcome back");
      window.localStorage.setItem("welcome-back", "yes");
    }
    router.replace({ name: RouteName.HOME });
  } catch (err: any) {
    console.error(err);
    submitted.value = false;
    if (err.graphQLErrors) {
      err.graphQLErrors.forEach(({ message }: { message: string }) => {
        errors.value.push(message);
      });
    } else if (err.networkError) {
      errors.value.push(err.networkError.message);
    }
  }
};

const hasCaseWarning = computed<boolean>(() => {
  return credentials.email !== credentials.email.toLowerCase();
});

const caseWarningText = computed<string | undefined>(() => {
  if (hasCaseWarning.value) {
    return t(
      "Emails usually don't contain capitals, make sure you haven't made a typo."
    ) as string;
  }
  return undefined;
});

const caseWarningType = computed<string | undefined>(() => {
  if (hasCaseWarning.value) {
    return "warning";
  }
  return undefined;
});

const currentProvider = computed(() => {
  const queryProvider = route?.query.provider as string | undefined;
  if (queryProvider) {
    return SELECTED_PROVIDERS[queryProvider];
  }
  return "unknown provider";
});

onMounted(() => {
  // Already-logged-in and accessing /login
  if (currentUser.value?.isLoggedIn) {
    console.debug(
      "Current user is already logged-in, redirecting to Homepage",
      currentUser.value
    );
    router.push("/");
  }
});

useHead({
  title: computed(() => t("Login")),
});
</script>
