<template>
  <header class="ghd-header">
    <div class="ghd-topline">
      <div class="container mx-auto flex flex-wrap items-center justify-between gap-2 px-3 py-1.5">
        <span>GLOBAL HUKUKÇULAR DERNEĞİ · AÇIK KAPI</span>
        <a :href="GHD_MAIN_SITE_URL" rel="noopener" target="_blank"
          >globalhukukcular.com</a
        >
      </div>
    </div>
    <nav class="ghd-navbar" id="navbar">
      <div
        class="container mx-auto flex flex-wrap items-center justify-between gap-3 px-3 py-3"
      >
        <router-link
          :to="{ name: RouteName.HOME }"
          :aria-label="t('Back to homepage')"
          class="flex shrink-0 items-center"
        >
          <MobilizonLogo />
        </router-link>

        <div class="hidden items-center gap-7 md:flex">
          <router-link class="ghd-nav-link" :to="{ name: RouteName.HOME }"
            >Açık Kapı</router-link
          >
          <router-link
            class="ghd-nav-link"
            :to="{ name: RouteName.HOME, hash: '#ilan' }"
            >İlan</router-link
          >
          <router-link
            class="ghd-nav-link"
            :to="{ name: RouteName.HOME, hash: '#surec' }"
            >Nasıl işliyor?</router-link
          >
          <router-link class="ghd-nav-link" :to="{ name: RouteName.ABOUT }"
            >Hakkında</router-link
          >
          <router-link
            v-if="canRegister"
            class="ghd-nav-link"
            :to="{ name: RouteName.REGISTER }"
            >Üyelik</router-link
          >
        </div>

        <div class="flex items-center gap-2 sm:gap-3">
          <router-link
            v-if="!currentUser?.isLoggedIn"
            class="hidden text-sm font-semibold text-ghd-navy sm:inline-flex"
            :to="{ name: RouteName.LOGIN }"
            >{{ t("Login") }}</router-link
          >
          <router-link
            class="ghd-btn ghd-btn-gold !px-4 !py-2 text-sm"
            :to="GHD_EVENT_PATH"
            >Başvur</router-link
          >
          <div class="flex gap-2" v-if="currentUser?.isLoggedIn">
            <router-link
              :to="{ name: RouteName.CONVERSATION_LIST }"
              class="relative flex text-sm"
              id="conversations-menu-button"
              aria-expanded="false"
            >
              <span class="sr-only">{{ t("Open conversations") }}</span>
              <Inbox :size="28" />
              <span
                v-show="unreadConversationsCount > 0"
                class="absolute bottom-0.5 -left-2 bg-primary rounded-full inline-block h-3 w-3 mx-2"
              >
              </span>
            </router-link>
            <o-dropdown position="bottom-right">
              <template #trigger>
                <button
                  type="button"
                  class="flex rounded-full text-sm focus:ring-4 focus:ring-gray-300 dark:focus:ring-gray-600"
                  id="user-menu-button"
                  aria-expanded="false"
                >
                  <span class="sr-only">{{ t("Open user menu") }}</span>
                  <figure class="h-8 w-8" v-if="currentActor?.avatar">
                    <img
                      class="rounded-full w-full h-full object-cover"
                      alt=""
                      :src="currentActor?.avatar.url"
                      width="32"
                      height="32"
                      loading="lazy"
                    />
                  </figure>
                  <AccountCircle v-else :size="32" />
                </button>
              </template>

              <div
                class="z-50 text-base list-none bg-white rounded divide-y divide-gray-100 dark:bg-zinc-700 dark:divide-gray-600 max-w-xs"
                position="bottom-left"
              >
                <o-dropdown-item aria-role="listitem">
                  <div class="px-4">
                    <span class="block text-sm text-zinc-900 dark:text-white">{{
                      displayName(currentActor) || currentUser.email
                    }}</span>
                    <span
                      class="block text-sm font-medium text-zinc-500 truncate dark:text-zinc-400"
                      v-if="currentUser?.role === ICurrentUserRole.ADMINISTRATOR"
                      >{{ t("Administrator") }}</span
                    >
                    <span
                      class="block text-sm font-medium text-zinc-500 truncate dark:text-zinc-400"
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
                  <div class="flex gap-1 items-center w-full">
                    <div class="flex-none">
                      <figure class="h-8 w-8" v-if="identity.avatar">
                        <img
                          class="rounded-full object-cover h-full"
                          loading="lazy"
                          :src="identity.avatar.url"
                          alt=""
                          height="32"
                          width="32"
                        />
                      </figure>
                      <AccountCircle v-else :size="32" />
                    </div>

                    <div
                      class="text-base text-zinc-700 dark:text-zinc-100 flex flex-col flex-auto overflow-hidden items-start w-full"
                    >
                      <p class="truncate w-full">{{ displayName(identity) }}</p>
                      <p
                        class="truncate text-sm w-full"
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
                  <span
                    class="block py-2 px-4 text-sm text-zinc-700 dark:text-zinc-200 dark:hover:text-white"
                    >{{ t("My account") }}</span
                  >
                </o-dropdown-item>
                <o-dropdown-item
                  aria-role="listitem"
                  v-if="currentUser?.role === ICurrentUserRole.ADMINISTRATOR"
                  tag="router-link"
                  :to="{ name: RouteName.ADMIN_DASHBOARD }"
                >
                  <span
                    class="block py-2 px-4 text-sm text-zinc-700 dark:text-zinc-200 dark:hover:text-white"
                    >{{ t("Administration") }}</span
                  >
                </o-dropdown-item>
                <o-dropdown-item
                  aria-role="listitem"
                  @click="performLogout"
                  @keyup.enter="performLogout"
                >
                  <span
                    class="block py-2 px-4 text-sm text-zinc-700 dark:text-zinc-200 dark:hover:text-white"
                    >{{ t("Log out") }}</span
                  >
                </o-dropdown-item>
              </div>
            </o-dropdown>
          </div>
          <button
            @click="showMobileMenu = !showMobileMenu"
            type="button"
            class="inline-flex items-center justify-end rounded p-2 text-ghd-navy md:hidden"
            aria-controls="mobile-menu-ghd"
            :aria-expanded="showMobileMenu"
            :aria-label="t('Open main menu')"
          >
            <svg
              class="h-6 w-6"
              aria-hidden="true"
              fill="currentColor"
              viewBox="0 0 20 20"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                fill-rule="evenodd"
                d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 15a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z"
                clip-rule="evenodd"
              ></path>
            </svg>
          </button>
        </div>
      </div>
      <div
        id="mobile-menu-ghd"
        class="border-t border-ghd-line bg-ghd-cream/95 px-3 pb-4 md:hidden"
        v-show="showMobileMenu"
      >
        <ul class="flex flex-col gap-1 pt-2">
          <li>
            <router-link class="ghd-mobile-link" :to="{ name: RouteName.HOME }"
              >Açık Kapı</router-link
            >
          </li>
          <li>
            <router-link
              class="ghd-mobile-link"
              :to="{ name: RouteName.HOME, hash: '#ilan' }"
              >İlan</router-link
            >
          </li>
          <li>
            <router-link
              class="ghd-mobile-link"
              :to="{ name: RouteName.HOME, hash: '#surec' }"
              >Nasıl işliyor?</router-link
            >
          </li>
          <li>
            <router-link class="ghd-mobile-link" :to="{ name: RouteName.ABOUT }"
              >Hakkında</router-link
            >
          </li>
          <li v-if="canRegister">
            <router-link class="ghd-mobile-link" :to="{ name: RouteName.REGISTER }"
              >Üyelik</router-link
            >
          </li>
          <li v-if="!currentUser?.isLoggedIn">
            <router-link class="ghd-mobile-link" :to="{ name: RouteName.LOGIN }"
              >{{ t("Login") }}</router-link
            >
          </li>
        </ul>
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
import { GHD_EVENT_PATH, GHD_MAIN_SITE_URL } from "@/ghd/constants";
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
