import { defineStore } from 'pinia'
import type { Workingtime, WorkingtimeStore } from '../interfaces/workingtime.interface';
import WorkingtimesServices from '@/core/api/workingtimes.services';
import type { AxiosError } from 'axios';

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
            .catch((error: AxiosError) => console.log(error));
        
        },
        getWorkingtime(userId: string, id: string) {
            let workingtimeService = new WorkingtimesServices();
            return workingtimeService.getWorkingtime(userId, id);
        },
        updateWorkingtimes(workingtimes: Workingtime[]) {
            this.workingtimes = workingtimes;
        },
        async postWorkingtime(userId: number, start: Date, end: Date) {
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
