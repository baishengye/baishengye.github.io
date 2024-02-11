<template>
  <div id="app">
    <SvgIcon></SvgIcon>
    <transition name="fadelop">
      <div class="shadow" v-if="showEnvelope" >
        <div class="envelop" :class="{'open': openedEnvelope}">
          <div class="top">
            <div class="invitation">
<!--              稻荷大神-->
              稻荷小姐
            </div>
          </div>
          <div class="front"></div>
          <div class="bottom"></div>
          <div class="btn" @click="openEnvelop"></div>
          <div class="left flower"></div>
          <div class="right flower"></div>
          <introduce :visible="openedEnvelope" @on-complete-type="onCompleteType" />
        </div>
      </div>
    </transition>
    <div class="fire-box">
      <div class="container">
        <div class="stage-container remove">
          <div class="canvas-container">
            <canvas id="trails-canvas">
            </canvas>
            <canvas id="main-canvas">
            </canvas>
          </div>
          <div class="controls" v-show="false">
            <div class="btn pause-btn">
              <svg fill="white" width="24" height="24">
                <use href="#icon-pause" xlink:href="#icon-pause">
                </use>
              </svg>
            </div>
            <div class="btn sound-btn">
              <svg fill="white" width="24" height="24">
                <use href="#icon-sound-off" xlink:href="#icon-sound-off">
                </use>
              </svg>
            </div>
            <div class="btn settings-btn">
              <svg fill="white" width="24" height="24">
                <use href="#icon-settings" xlink:href="#icon-settings">
                </use>
              </svg>
            </div>
          </div>
          <div class="menu hide">
            <div class="menu__inner-wrap">
              <div class="btn btn--bright close-menu-btn">
                <svg fill="white" width="24" height="24">
                  <use href="#icon-close" xlink:href="#icon-close">
                  </use>
                </svg>
              </div>
              <div class="menu__header">
                设置
              </div>
              <div class="menu__subheader">
                若想了解更多信息 请点击任意标签
              </div>
              <form>
                <div class="form-option form-option--select">
                  <label class="shell-type-label">
                    烟花类型
                  </label>
                  <select class="shell-type">
                  </select>
                </div>
                <div class="form-option form-option--select">
                  <label class="shell-size-label">
                    烟花大小
                  </label>
                  <select class="shell-size">
                  </select>
                </div>
                <div class="form-option form-option--select">
                  <label class="quality-ui-label">
                    画质
                  </label>
                  <select class="quality-ui">
                  </select>
                </div>
                <div class="form-option form-option--select">
                  <label class="sky-lighting-label">
                    照亮天空
                  </label>
                  <select class="sky-lighting">
                  </select>
                </div>
                <div class="form-option form-option--select">
                  <label class="scaleFactor-label">
                    缩放
                  </label>
                  <select class="scaleFactor">
                  </select>
                </div>
                <div class="form-option form-option--checkbox">
                  <label class="auto-launch-label">
                    自动放烟花
                  </label>
                  <input class="auto-launch" type="checkbox" />
                </div>
                <div class="form-option form-option--checkbox form-option--finale-mode">
                  <label class="finale-mode-label">
                    同时放更多的烟花
                  </label>
                  <input class="finale-mode" type="checkbox" />
                </div>
                <div class="form-option form-option--checkbox">
                  <label class="hide-controls-label">
                    隐藏控制按钮
                  </label>
                  <input class="hide-controls" type="checkbox" />
                </div>
                <div class="form-option form-option--checkbox form-option--fullscreen">
                  <label class="fullscreen-label">
                    全屏
                  </label>
                  <input class="fullscreen" type="checkbox" />
                </div>
                <div class="form-option form-option--checkbox">
                  <label class="long-exposure-label">
                    保留烟花的火花
                  </label>
                  <input class="long-exposure" type="checkbox" />
                </div>
              </form>
            </div>
          </div>
        </div>
        <div class="help-modal">
          <div class="help-modal__overlay">
          </div>
          <div class="help-modal__dialog">
            <div class="help-modal__header">
            </div>
            <div class="help-modal__body">
            </div>
            <button type="button" class="help-modal__close-btn">
              关闭
            </button>
          </div>
        </div>
      </div>
    </div>
    <audio ref="clickMusic" src="../dist/static/audio/click.mp3" class="clickMusic"></audio>
    <audio ref="bgMusic" src="../dist/static/audio/交换余生.m4a" class="bgMusic"></audio>
  </div>

</template>

<script setup>
import {ref, onMounted} from 'vue';
import '@/utils/fscreen';
import '@/utils/MyMath';
import initAllFire from '@/utils/script';
import initWordFire from '@/utils/word';

import SvgIcon from '@/components/SvgIcon.vue';
import {initAddSayWord, initFire, initLoop} from '@/utils/hooks';
import Introduce from '@/components/Introduce.vue';


const openedEnvelope = ref(false);
const showEnvelope = ref(true);
const clickMusic = ref();
const bgMusic = ref();
const clickTimer = ref(null);
const bgTimer = ref(null);
const letterTimer = ref(null);
const wordFireTimer = ref(null);

onMounted(() => {
  initAllFire()
  // initWordFire()
})

const openEnvelop = () => {
  openedEnvelope.value = true;
  clearTimeout(clickTimer.value);
  clearTimeout(bgTimer.value);
  clickTimer.value = setTimeout(() => {
    clickMusic.value.play();
  }, 100)
  bgTimer.value = setTimeout(() => {
    bgMusic.value.volume = 0.4;
    bgMusic.value.play();
    bgMusic.value.addEventListener('ended', () => {
      bgMusic.value.currentTime = 0;
      bgMusic.value.play();
    })
  }, 1000)
}
const onCompleteType = () => {
  clearTimeout(letterTimer.value);
  letterTimer.value = setTimeout(() => {
    showEnvelope.value = false;
    initFire.value();
    initAddSayWord.value();
    initLoop.value();
  }, 2000);


  // clearTimeout(wordFireTimer.value);
  // wordFireTimer.value = setTimeout(() => {
  // }, 3000)
}

</script>

<style lang="scss">
@import "@/assets/css/font.css";
@import "@/assets/css/fire";

.fade-enter-active,
.fadelop-leave-active {
  transition: all 1s;
}

.fadelop-enter-from,
.fadelop-leave-to {
  opacity: 0;
}

html, body{
  box-sizing: border-box;
  width: 100%;
  height: 100%;
  font-size: 16px;
}
#app{
  //width: 100%;
  //height: 100%;
  //display: flex;
  //justify-content: center;
  //align-items: center;
  //border: 6px solid red;
  //font-size: 16px;
  position: relative;
}
.fire-box {
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
  height: 100vh;
  width: 100%;
}
*, *::before, *::after {
  box-sizing: inherit;
  padding: 0px;
  margin: 0px;
}
//@keyframes Falling {
//  0% {
//    opacity: 1;
//    transform: translateY(-120px);
//    //transform: translateY(px2rem(-120));
//  }
//  100% {
//    opacity: 1;
//    transform: translateY(240px);
//    //transform: translateY(px2rem(240));
//  }
//
//}
//@keyframes centerDown {
//  0% {
//    opacity: 1;
//    transform: translateY(0px);
//  }
//  100% {
//    transform: translateY(80px);
//    opacity: 0;
//  }
//
//}
//@keyframes centerUp {
//  0% {
//    opacity: 0;
//    transform: translateY(80px);
//  }
//  100% {
//    transform: translateY(0px);
//    opacity: 1;
//  }
//
//}
//@keyframes Rotate {
//  0% {
//    opacity: 1;
//    transform: rotate(0)
//  }
//  100% {
//    opacity: 1;
//    transform: rotate(180deg)
//  }
//}
.hide-letter {
  opacity: 0;
}
.shadow{
  position: fixed;
  left: 0px;
  top: 0px;
  width: 100%;
  height: 100%;
  //background:rgba(16, 23, 36, 0.64);
  z-index: 5000;
  //opacity: 1;
  //transition: all 0.5s;
  .envelop{
    //opacity: 1;
    //width: 864px;
    width: px2rem($baseWidth);
    //height: 406px;
    height: px2rem($baseHeight);
    //border: 1px solid red;
    /* background: #212865 url('./assets/envelop-back.png') no-repeat; */
    background: #212865 url('http://img-ys011.didistatic.com/static/dc2img/envelop-back.png') no-repeat center;
    //background-size: 864px 406px;
    //background-size: px2rem(864px) px2rem(406px);
    background-size: 100% 100%;
    position: absolute;
    border-radius: px2rem(4px);
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    //margin-left: -432px;
    //margin-top: -300px;
    z-index: 5001;

    .front{
      position: absolute;
      top: 0px;
      left: 0px;
      //width: 864px;
      width: px2rem($baseWidth);
      //height: 406px;
      height: px2rem($baseHeight);
      /* background: url('./assets/envelop-front.png') no-repeat; */
      background: url('http://img-ys011.didistatic.com/static/dc2img/envelop-front.png') no-repeat;
      //background-size: px2rem(864px) px2rem(406px);
      background-size: 100% 100%;
      //background-size: 864px 406px;

      z-index: 5003;
      border-radius: 0px 0px px2rem(4px) px2rem(4px);
    }
    .top{
      position: absolute;
      top: 0px;
      left: 0px;
      //width: 864px;
      width: px2rem($baseWidth);
      //height: 293px;
      height: px2rem(160px);
      /* background: url('./assets/envelop-top.png') no-repeat; */
      background: url('http://img-ys011.didistatic.com/static/dc2img/envelop-top.png') no-repeat center;
      //background-size: 864px 293px;
      //background-size: px2rem(864px) px2rem(293px);
      background-size: 100% 100%;
      z-index: 5005;
      display: flex;
      //padding-top: px2rem(92px);
      padding-top: px2rem(30px);
      justify-content: center;

      .invitation{
        //width: 94px;
        width: px2rem(130px);
        //height: 28px;
        height: px2rem(28px);
        font-size: px2rem(26px);
        text-align: center;
        //background: url('./assets/invitation.png') no-repeat center;
        //background-size: 100% 100%;
      }
    }
    .bottom{
      position: absolute;
      bottom: 0px;
      left: 0px;
      //width: 864px;
      width: px2rem($baseWidth);
      //height: 249px;
      height: px2rem(130px);
      /* background: url('./assets/envelop-bottom.png') no-repeat; */
      background: url('http://img-ys011.didistatic.com/static/dc2img/envelop-bottom.png') no-repeat center;
      //background-size: 864px 249px;
      background-size: 100% 100%;
      z-index: 5004;
      display: flex;
      //padding-top: 190px;
      padding-top: px2rem(180px);
      justify-content: center;
      border-radius: 0px 0px px2rem(4px) px2rem(4px);

    }
    .btn{
      position: absolute;
      //top: 200px;
      //top: px2rem(100px);
      top: 50%;
      left: 50%;
      //margin-left: -53px;
      transform: translate(-50%, -50%);
      //width: 107px;
      width: px2rem(80px);
      //height: 105px;
      height: px2rem(80px);
      //background: url('./assets/seal.png') no-repeat center;
      background: url('./assets/image/seal-new.jpg') no-repeat center;
      //background-size: 107px 105px;
      background-size: 100% 100%;
      z-index: 5060;
      cursor: pointer;
      //&:hover{
      //  img{
      //    opacity: 100;
      //    transition: opacity 0.5s;
      //  }
      //}
      //img{
      //  opacity: 0;
      //  width:107px;
      //  height: 105px;
      //}
    }
    .flower{
      position: absolute;
      bottom: px2rem(-5px);
      //width: 216px;
      width: px2rem(100px);
      //height: 48px;
      height: px2rem(25px);
      background: url('./assets/silk.png') no-repeat center;
      //background-size: 216px 48px;
      background-size: 100% 100%;
      z-index: 5007;
      &.right{
        right: px2rem(-20px);
      }
      &.left{
        width: px2rem(40px);
        left: px2rem(-40px);
      }

    }
    &.open{
      //margin-top: -100px;
      margin-top: px2rem(-50px);
      transition: margin-top 0.5s ease 0.5s;
      border-radius: 0px 0px px2rem(4px) px2rem(4px);
      .btn{
        top: px2rem(90px);
        opacity: 0;
        z-index: 5001;
        transition: top 0.5s, opacity 0.2s ease 1s, z-index 0.2s ease 1s;
        img{
          opacity: 100;
          transition: opacity 0.5s;
        }
      }
      .bottom{
        //.logo{
        //  opacity: 0;
        //  transition: opacity 0.2s ease 1s;
        //}

        transform-origin: center bottom;
        transform: rotateX(50deg);
        transition: transform 0.3s ease 1.5s;
      }

      .top{
        z-index: 5001;
        .invitation{
          opacity: 0;
          transition: opacity 0.2s ease 1s;
        }
        transform-origin: center top;
        transform: rotateX(180deg);
        transition: transform 0.5s ease 1.3s, z-index 0.1s ease 1.5s;
      }
      .front{
        //height: 197px;
        height: px2rem(100px);
        //top: 210px;
        top: px2rem(130px);
        transition: all 0.5s ease 1.3s;
      }
    }
  }
}
</style>
