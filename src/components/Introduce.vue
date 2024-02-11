<template>
  <div class="introduce-container" v-show="visible">
<!--    <Typed :options="optionsHeader">-->
<!--      <span class="typing"></span>-->
<!--    </Typed>-->
    <div id="sayHeader"></div>
<!--    <div class="content">-->
<!--      <Typed :options="optionsContent" v-show="optionsContent.strings.length">-->
<!--        <span class="typing"></span>-->
<!--      </Typed>-->
<!--    </div>-->
    <div class="content"></div>
    <div class="letter-author"></div>
  </div>
</template>

<script setup>
import {defineEmits, nextTick,ref, onMounted,defineProps, watch} from 'vue';
import Typed from 'typed.js';
// import { Typed } from "@duskmoon/vue3-typed-js";
const props = defineProps({
  visible: {
    type: Boolean,
    required: true,
  }
})
const emit = defineEmits(['onCompleteType']);
// const optionsHeader = ref({
//   strings: [],
//   typeSpeed: 100,
// });
// const optionsContent = ref({
//   strings: [],
//   typeSpeed: 100,
// });

watch(() => props.visible, (value) => {
  if (!value) return;
  const typed = new Typed('#sayHeader', {
    strings: ['你好啊，稻荷小姐:'],
    typeSpeed: 200,
    startDelay: 1500,
    showCursor: false
  });
  new Typed('.content', {
    // strings: [`&nbsp;&nbsp;&nbsp;&nbsp;见字如晤！一日不见，如三秋兮。今夕何夕,见此良人。岁月如梭，念已周年。吾之所愿，喜乐连绵。礼赠余爱，纪以永年！`],
    strings: ["&nbsp;&nbsp;&nbsp;&nbsp;言语是贫乏的,但关怀是真挚的;在新年到来时,送上我最真挚的祝福,愿稻荷小姐新年如意,万事顺利!我们要活得比世界更久一点\n~(￣▽￣)~*"],
    typeSpeed: 200,
    startDelay: 3100,
    showCursor: false,
  });
  new Typed('.letter-author', {
    strings: ['-- 来自你的朋友白生也。'],
    typeSpeed: 200,
    startDelay: 18500,
    showCursor: false,
    onComplete: (self) => {
      console.log('完成了，哈哈', self)
      emit('onCompleteType');
    }
  })
  // contentType.onComplete
  console.log('显示---', typed);
  // optionsHeader.value.strings.push("亲爱的张乐明女士：")
  // // optionsContent.value.strings = [`&nbsp;&nbsp;&nbsp;&nbsp;见字如晤`];
  // optionsContent.value = {
  //   strings: [`&nbsp;&nbsp;&nbsp;&nbsp;见字如晤`],
  //   typeSpeed: 100,
  // }
})
onMounted(() => {

})
</script>

<style scoped lang="scss">
.introduce-container {
  padding: px2rem(6px) px2rem(6px);
  font-size: px2rem(16px);
  #sayHeader {
    margin-top: 6px;
  }
  .content {
    //margin-top: 6px;
  }
  .letter-author {
    margin-left: px2rem(100px);
  }
}
</style>
