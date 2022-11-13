import { defineStore } from 'pinia'
import type { WorkingtimeStore } from '../interfaces/workingtime.interface';
import WorkingtimesServices from '@/core/api/workingtimes.services';
import { useUserStore } from './user.store';

export const useChartStore = defineStore('charts', {
    state: (): WorkingtimeStore => ({ 
        workingtimes: [],
    }),
    getters: {
        getWorkingtimes: (state) => state.workingtimes,
    },
    actions: {

        fetchWorkingtimesByDate(userId: number, start: string, end: string) {
            let workingtimeService = new WorkingtimesServices();
            workingtimeService.getAllWorkingtimesByDate(userId, start, end).then((response: any) => {
                this.workingtimes = response.data.data;
                console.log(this.workingtimes)
            })
            .catch((e: any) => {
                if(e.response.status == 401) {
                    const { logoutUser } = useUserStore();
                    logoutUser();
                }
            });
        },
    },
})
