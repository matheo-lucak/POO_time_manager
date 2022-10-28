<template>

    <div class="custom-card app-card-small">

        <div class="card-header">
            <div class="title-border"></div>
            <h2 class="title">{{weekDay}}</h2>
            <div class="title-border right"></div>
        </div>



        <div class="dates flex-col middle">
            <span>
                {{start}}
            </span>
            <span>
                {{end}}
            </span>
        </div>

        <div class="hours-worked flex-row center">
            <span>
                <p>{{hours}} h</p>
            </span>
        </div>

    </div>

</template>

<script lang="ts">
export default {
    data() {
        return {
            weekDay: "Fancy seing you here",
            hours: 17
        }
    },
    props: {
        start: {
            type: String,
            required: true
        },
        end: {
            type: String,
            required: true
        }
    }

}
</script>

<style scoped>
.title {
  color: #3c4462;
  font-size: 14px;
  font-weight: bold;
  font-stretch: normal;
  font-style: normal;
  line-height: normal;
  letter-spacing: 1px;
  text-align: center;
  margin: 0 24px;
  width: fit-content;
  height: 24px;
  flex-shrink: 0;
}

.card-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: 100%;
  margin-bottom: 10px;
}

.title-border {
  height: 1px;
  width: 100%;
  background-color: #dee2f3;
}

.title-border.right {
  width: -moz-calc(100% - 117x);
  width: -webkit-calc(100% - 117px);
  width: -o-calc(100% - 117px);
  width: calc(100% - 117px);
}

button {
  background-color: #fff;
  border: none;
  border-radius: 7px;
}

.dates span {
    padding: 10px;
}

.hours-worked {
    width: 100%;
    color: #00E676;
    font-weight: bold;
    font-size: 24px;
    padding: 1rem;
}
</style>