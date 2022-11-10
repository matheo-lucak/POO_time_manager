import { defineStore } from 'pinia'
import type { Workingtime, WorkingtimeStore } from '../interfaces/workingtime.interface';
import WorkingtimesServices from '@/core/api/workingtimes.services';
import type { AxiosError } from 'axios';
import { useUserStore } from './user.store';

export const useWorkingtimesStore = defineStore('workingtimes', {
    state: (): WorkingtimeStore => ({ 
        workingtimes: [],
    }),
    getters: {
        getWorkingtimes(state)  {
            return this.workingtimes;
        }
    },
    actions: {
        fetchWorkingtimes(userId: number) {
            let workingtimeService = new WorkingtimesServices();
            workingtimeService.getAllWorkingtime(userId).then((response: any) => {
                this.workingtimes = response.data.data;
            })
            .catch((e: any) => {
                if(e.response.status == 401) {
                    const { logoutUser } = useUserStore();
                    logoutUser();
                }
            })
        
        },
        getWorkingtime(userId: string, id: string) {
            let workingtimeService = new WorkingtimesServices();
            return workingtimeService.getWorkingtime(userId, id);
        },
        async updateWorkingtime(id: string, start: Date, end: Date) {
            let body = {
                working_time: {
                    start: start.toISOString(),
                    end:  end.toISOString()
                } 
            }
            let workingtimeService = new WorkingtimesServices();
            let response: any = await workingtimeService.putWorkingtime(id, body);

            if(!response || !response.data.data) {
                return;
            }

            //Find and replace updated workingtime in store
            let newWorkingtime = response.data.data;
            let newWorkingtimes = this.workingtimes.filter(workingtime => workingtime.id !== newWorkingtime.id);
            newWorkingtimes.push(newWorkingtime);
            this.workingtimes = newWorkingtimes;

            return newWorkingtime;
        },
        async postWorkingtime(userId: string, start: Date, end: Date) {
            let body = {
                working_time: {
                    start: start.toISOString(),
                    end:  end.toISOString()
                } 
            }
            let workingtimeService = new WorkingtimesServices();
            let response: any = await workingtimeService.postWorkingtime(userId, body);

            if(!response) {
                return;
            }

            this.workingtimes.push(response.data.data);
            return response.data.data;

        }
    },
})
