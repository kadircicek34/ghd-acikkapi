<template>
  <header class="ghd-header" id="navbar">
    <nav class="ghd-navbar">
      <div
        class="mx-auto flex h-[74px] w-full max-w-7xl items-center justify-between gap-4 px-5 sm:px-8"
      >
        <router-link
          :to="{ name: RouteName.HOME }"
          :aria-label="t('Back to homepage')"
          class="flex shrink-0 items-center"
        >
          <MobilizonLogo class="max-h-10" />
        </router-link>

        <div class="hidden items-center gap-8 lg:flex">
          <router-link class="ghd-nav-link" :to="{ name: RouteName.HOME }"
            >Açık Kapı</router-link
          >
          <router-link
            class="ghd-nav-link"
            :to="{ name: RouteName.HOME, hash: '#program' }"
            >Program</router-link
          >
          <router-link
            class="ghd-nav-link"
            :to="{ name: RouteName.HOME, hash: '#ilan' }"
            >İlan</router-link
          >
          <router-link
            class="ghd-nav-link"
            :to="{ name: RouteName.HOME, hash: '#surec' }"
            >Süreç</router-link
          >
          <router-link
            class="ghd-nav-link"
            :to="{ name: RouteName.HOME, hash: '#sss' }"
            >SSS</router-link
          >
          <router-link class="ghd-nav-link" :to="{ name: RouteName.ABOUT }"
            >Hakkında</router-link
          >
        </div>

        <div class="flex items-center gap-2 sm:gap-3">
          <template v-if="!currentUser?.isLoggedIn">
            <router-link
              class="hidden px-2 py-2 text-sm font-extrabold text-ghd-navy sm:inline-flex"
              :to="{ name: RouteName.LOGIN }"
              >{{ t("Login") }}</router-link
            >
            <router-link
              v-if="canRegister"
              class="ghd-btn ghd-btn-primary !px-5 !py-2.5 text-sm"
              :to="{ name: RouteName.REGISTER }"
              >Üyelik başvurusu</router-link
            >
          </template>

          <template v-else>
            <router-link
              class="ghd-btn ghd-btn-primary !px-5 !py-2.5 text-sm"
              :to="GHD_EVENT_PATH"
              >Başvur</router-link
            >
            <router-link
              :to="{ name: RouteName.CONVERSATION_LIST }"
              class="relative hidden text-sm sm:inline-flex"
              id="conversations-menu-button"
              aria-expanded="false"
            >
              <span class="sr-only">{{ t("Open conversations") }}</span>
              <Inbox :size="24" />
              <span
                v-show="unreadConversationsCount > 0"
                class="absolute -left-1 bottom-0.5 mx-2 inline-block h-2.5 w-2.5 rounded-full bg-primary"
              >
              </span>
            </router-link>
            <o-dropdown position="bottom-right">
              <template #trigger>
                <button
                  type="button"
                  class="ghd-avatar-button"
                  id="user-menu-button"
                  aria-expanded="false"
                >
                  <span class="sr-only">{{ t("Open user menu") }}</span>
                  <figure class="h-7 w-7" v-if="currentActor?.avatar">
                    <img
                      class="h-full w-full rounded-full object-cover"
                      alt=""
                      :src="currentActor?.avatar.url"
                      width="28"
                      height="28"
                      loading="lazy"
                    />
                  </figure>
                  <AccountCircle v-else :size="26" />
                </button>
              </template>

              <div
                class="z-50 w-64 overflow-hidden rounded-2xl border border-ghd-navy/10 bg-[#fffdf8] py-2 shadow-2xl"
              >
                <o-dropdown-item aria-role="listitem">
                  <div class="px-4 py-2">
                    <span class="block truncate text-sm font-extrabold text-ghd-navy">{{
                      displayName(currentActor) || currentUser.email
                    }}</span>
                    <span
                      class="block truncate text-xs font-semibold text-ghd-muted"
                      v-if="currentUser?.role === ICurrentUserRole.ADMINISTRATOR"
                      >{{ t("Administrator") }}</span
                    >
                    <span
                      class="block truncate text-xs font-semibold text-ghd-muted"
                      v-if="currentUser?.role === ICurrentUserRole.MODERATOR"
                      >{{ t("Moderator") }}</span
                    >
                  </div>
                </o-dropdown-item>
                <o-dropdown-item
                  v-for="identity in identities"
                  :active="identity.id === currentActor?.id"
                  :key="identity.id"
                  tabindex="0"
                  @click="changeIdentity(identity)"
                  @keyup.enter="changeIdentity(identity)"
                >
                  <div class="flex w-full items-center gap-2">
                    <div class="flex-none">
                      <figure class="h-7 w-7" v-if="identity.avatar">
                        <img
                          class="h-full w-full rounded-full object-cover"
                          loading="lazy"
                          :src="identity.avatar.url"
                          alt=""
                          height="28"
                          width="28"
                        />
                      </figure>
                      <AccountCircle v-else :size="28" />
                    </div>
                    <div
                      class="flex w-full flex-auto flex-col items-start overflow-hidden text-sm text-ghd-navy"
                    >
                      <p class="w-full truncate font-semibold">
                        {{ displayName(identity) }}
                      </p>
                      <p
                        class="w-full truncate text-xs text-ghd-muted"
                        v-if="identity.preferredUsername"
                      >
                        @{{ identity.preferredUsername }}
                      </p>
                    </div>
                  </div>
                </o-dropdown-item>
                <o-dropdown-item
                  aria-role="listitem"
                  tag="router-link"
                  :to="{ name: RouteName.SETTINGS }"
                >
                  <span class="block px-4 py-2 text-sm text-ghd-navy"
                    >{{ t("My account") }}</span
                  >
                </o-dropdown-item>
                <o-dropdown-item
                  aria-role="listitem"
                  v-if="currentUser?.role === ICurrentUserRole.ADMINISTRATOR"
                  tag="router-link"
                  :to="{ name: RouteName.ADMIN_DASHBOARD }"
                >
                  <span class="block px-4 py-2 text-sm text-ghd-navy"
                    >{{ t("Administration") }}</span
                  >
                </o-dropdown-item>
                <o-dropdown-item
                  aria-role="listitem"
                  @click="performLogout"
                  @keyup.enter="performLogout"
                >
                  <span class="block px-4 py-2 text-sm text-ghd-navy"
                    >{{ t("Log out") }}</span
                  >
                </o-dropdown-item>
              </div>
            </o-dropdown>
          </template>

          <button
            @click="showMobileMenu = !showMobileMenu"
            type="button"
            class="inline-flex items-center justify-center rounded-full border border-ghd-navy/10 bg-white/60 p-2.5 text-ghd-navy lg:hidden"
            aria-controls="mobile-menu-ghd"
            :aria-expanded="showMobileMenu"
            :aria-label="t('Open main menu')"
          >
            <svg
              class="h-5 w-5"
              aria-hidden="true"
              fill="none"
              stroke="currentColor"
              stroke-width="1.8"
              viewBox="0 0 24 24"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path d="M4 7h16M4 12h16M4 17h16" stroke-linecap="round" />
            </svg>
          </button>
        </div>
      </div>

      <div
        id="mobile-menu-ghd"
        class="ghd-mobile-panel lg:hidden"
        v-show="showMobileMenu"
      >
        <div class="mx-auto max-w-7xl px-5 py-4 sm:px-8">
          <router-link class="ghd-mobile-link" :to="{ name: RouteName.HOME }"
            >Açık Kapı</router-link
          >
          <router-link
            class="ghd-mobile-link"
            :to="{ name: RouteName.HOME, hash: '#program' }"
            >Program</router-link
          >
          <router-link
            class="ghd-mobile-link"
            :to="{ name: RouteName.HOME, hash: '#ilan' }"
            >İlan</router-link
          >
          <router-link
            class="ghd-mobile-link"
            :to="{ name: RouteName.HOME, hash: '#surec' }"
            >Süreç</router-link
          >
          <router-link
            class="ghd-mobile-link"
            :to="{ name: RouteName.HOME, hash: '#sss' }"
            >SSS</router-link
          >
          <router-link class="ghd-mobile-link" :to="{ name: RouteName.ABOUT }"
            >Hakkında</router-link
          >

          <div class="mt-5 flex flex-col gap-2 pb-2">
            <template v-if="!currentUser?.isLoggedIn">
              <router-link
                class="ghd-btn ghd-btn-primary w-full"
                :to="{ name: RouteName.LOGIN }"
                >{{ t("Login") }}</router-link
              >
              <router-link
                v-if="canRegister"
                class="ghd-btn ghd-btn-gold w-full"
                :to="{ name: RouteName.REGISTER }"
                >Üyelik başvurusu</router-link
              >
            </template>
            <router-link
              v-else
              class="ghd-btn ghd-btn-gold w-full"
              :to="GHD_EVENT_PATH"
              >İlana başvur</router-link
            >
          </div>
        </div>
      </div>
    </nav>
  </header>

  <div v-if="currentUser?.id && !currentActor?.id" class="p-5">
    <o-notification variant="warning">
      <div class="flex place-content-between items-center">
        <span>
          {{
            t("You have to create and select a profile to fully use Mobilizon.")
          }}
        </span>
        <o-button
          :label="t('Create a new profile')"
          variant="primary"
          size="small"
          @click="createProfile()"
        />
      </div>
    </o-notification>
  </div>
</template>

<script lang="ts" setup>
import MobilizonLogo from "@/components/MobilizonLogo.vue";
import { GHD_EVENT_PATH } from "@/ghd/constants";
import { ICurrentUserRole } from "@/types/enums";
import { logout } from "../utils/auth";
import { displayName, IPerson } from "../types/actor";
import RouteName from "../router/name";
import { computed, onMounted, ref, watch } from "vue";
import { useRoute, useRouter } from "vue-router";
import { useI18n } from "vue-i18n";
import AccountCircle from "vue-material-design-icons/AccountCircle.vue";
import Inbox from "vue-material-design-icons/Inbox.vue";
import { useCurrentUserClient } from "@/composition/apollo/user";
import {
  useCurrentActorClient,
  useCurrentUserIdentities,
} from "@/composition/apollo/actor";
import { useLazyQuery } from "@vue/apollo-composable";
import { changeIdentity } from "@/utils/identity";
import {
  useExternalLinksConfig,
  useRegistrationConfig,
} from "@/composition/apollo/config";
import { useOruga } from "@oruga-ui/oruga-next";
import {
  UNREAD_ACTOR_CONVERSATIONS,
  UNREAD_ACTOR_CONVERSATIONS_SUBSCRIPTION,
} from "@/graphql/user";
import { ICurrentUser } from "@/types/current-user.model";

const { currentUser } = useCurrentUserClient();
const { currentActor } = useCurrentActorClient();
const { identities } = useCurrentUserIdentities();

const router = useRouter();
const route = useRoute();

const { externalLinksConfig } = useExternalLinksConfig();

const enabledExternalLinks = computed(() =>
  externalLinksConfig.value?.filter((link) => link.enabled)
);

const { registrationsOpen, registrationsAllowlist, databaseLogin } =
  useRegistrationConfig();

const canRegister = computed(() => {
  return (
    ((registrationsOpen.value || registrationsAllowlist.value) &&
      databaseLogin.value) ??
    false
  );
});

const { t } = useI18n({ useScope: "global" });

const unreadConversationsCount = computed(
  () =>
    unreadActorConversationsResult.value?.loggedUser.defaultActor
      ?.unreadConversationsCount ?? 0
);

const {
  result: unreadActorConversationsResult,
  load: loadUnreadConversations,
  subscribeToMore,
} = useLazyQuery<{
  loggedUser: Pick<ICurrentUser, "id" | "defaultActor">;
}>(UNREAD_ACTOR_CONVERSATIONS);

watch(currentActor, async (currentActorValue, previousActorValue) => {
  if (
    currentActorValue?.id &&
    currentActorValue.preferredUsername !==
      previousActorValue?.preferredUsername
  ) {
    await loadUnreadConversations();

    subscribeToMore<
      { personId: string },
      { personUnreadConversationsCount: number }
    >({
      document: UNREAD_ACTOR_CONVERSATIONS_SUBSCRIPTION,
      variables: {
        personId: currentActor.value?.id as string,
      },
      updateQuery: (previousResult, { subscriptionData }) => {
        console.debug(
          "Updating actor unread conversations count query after subscribe to more update",
          subscriptionData?.data?.personUnreadConversationsCount
        );
        return {
          ...previousResult,
          loggedUser: {
            id: previousResult.loggedUser.id,
            defaultActor: {
              ...previousResult.loggedUser.defaultActor,
              unreadConversationsCount:
                subscriptionData?.data?.personUnreadConversationsCount ??
                previousResult.loggedUser.defaultActor
                  ?.unreadConversationsCount,
            } as IPerson, // no idea why,
          },
        };
      },
    });
  }
});

onMounted(() => {});

const showMobileMenu = ref(false);

const { notification } = useOruga();

const performLogout = async () => {
  console.debug("Logging out client...");
  await logout();
  notification.open({
    message: t("You have been logged-out"),
    variant: "success",
    position: "bottom-right",
    duration: 5000,
  });

  if (route.meta["requiredAuth"] === true) {
    return router.push({ name: RouteName.HOME });
  }
};

const createProfile = () => {
  router.push({
    name: RouteName.CREATE_IDENTITY,
  });
};
</script>
