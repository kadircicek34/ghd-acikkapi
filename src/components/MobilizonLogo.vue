<template>
  <img
    v-if="instanceLogoUrl"
    alt="GHD Açık Kapı"
    class="max-h-12 w-auto"
    :src="instanceLogoUrl"
  />
  <span v-else class="ghd-logo-lockup" aria-label="GHD Açık Kapı">
    <img
      src="/img/ghd-emblem.png"
      alt=""
      width="48"
      height="48"
      class="ghd-logo-emblem"
    />
    <span class="ghd-logo-type">
      <span class="ghd-logo-ghd">GHD</span>
      <span class="ghd-logo-open">AÇIK KAPI</span>
    </span>
  </span>
</template>

<script lang="ts" setup>
import { useInstanceLogoUrl } from "@/composition/apollo/config";

const { instanceLogoUrl } = useInstanceLogoUrl();

withDefaults(
  defineProps<{
    invert?: boolean;
  }>(),
  { invert: false }
);
</script>
