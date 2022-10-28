import { defineStore } from 'pinia'
import type { Workingtime, WorkingtimeStore } from '../interfaces/workingtime.interface';
import WorkingtimesServices from '@/core/api/workingtimes.services';
import type { AxiosError } from 'axios';

export const useWorkingtimesStore = defineStore('workingtimes', {
  state: (): WorkingtimeStore => ({ 
    workingtimes: []
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
        this.workingtimes = response.data;
      })
      .catch((error: AxiosError) => console.log(error));
      
    },
    updateWorkingtimes(workingtimes: Workingtime[]) {
      this.workingtimes = workingtimes;
    },
  },
})
