<template>
    <footer>
        
        <div class="footer-content">

          <div class="flex-row space-evenly">
            <div class="copyrights">
                Beep Boop I'm not a bot
            </div>
            <div>
              <RouterLink to="/contact">Contact</RouterLink>
            </div>
            <div>
              <RouterLink to="/rgpd">RGPD</RouterLink>
            </div>
            <div>
              <RouterLink to="/howaboutda">About Us</RouterLink>
            </div>
          </div>
            
        </div>
        
    </footer>
</template>

<script lang="ts">
export default {
    data() {
        return {

        }
    }
}
</script>

<style scoped>
.footer-content {
  max-width: 1440px;
  padding: 8px;
  margin: 0 auto;
}

.footer-content div:first-child {
  width: 100%;
}

.footer-content div:first-child div {
  width: fit-content;
}

.footer-content a {
    color: #fff;
    text-decoration: none;
}

.copyrights {
  font-size: 15px;
  color: #fff;
}
.footer-options {
  font-size: 12px;
  cursor: pointer;
}

</style>