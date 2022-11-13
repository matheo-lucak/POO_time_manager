import { defineStore } from 'pinia'
import type { Clock } from "@/core/interfaces/clock.interface";
import ClocksServices from "@/core/api/clocks.service"
import { useUserStore } from "@/core/stores/user.store";
import type { User } from "@/core/interfaces/user.interface"

type ClockStore =
    {
        clock: Clock;
        clockServices: ClocksServices;
    }

export const useClockStore = defineStore('clock', {
    state: (): ClockStore => <ClockStore>({
        clock: {
            time: "",
            status: false,
        },
        clockServices: new ClocksServices()

    }),
    getters: {
        getClock: (state) => state.clock,

    },
    actions: {

        fetchClock(userID: number) {
            this.clockServices.getClock(userID).then((response: Clock) => {
                this.clock = response;
            })
            .catch((e: any) => {
                if(e.response.status == 401) {
                    const { logoutUser } = useUserStore();
                    logoutUser();
                }
            })
        },

        submitClock(userID: number) {
            this.clockServices.postClock(userID).then((response: Clock) => {
                this.clock = response;
            })
            .catch((e: any) => {
                if(e.response.status == 401) {
                    const { logoutUser } = useUserStore();
                    logoutUser();
                }
            })

        },

        refreshClock(userID: number) {
            this.clockServices.postClock(userID).then(() => {
                this.clock.status = false;
            })
            .catch((e: any) => {
                if(e.response.status == 401) {
                    const { logoutUser } = useUserStore();
                    logoutUser();
                }
            })

        }
    }
})
