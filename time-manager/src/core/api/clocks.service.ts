import AxiosServices from "@/core/api/axios.services";
import type {AxiosResponse} from "axios";
import type {Clock} from "@/core/interfaces/clock.interface";

export default class ClocksServices extends AxiosServices
{
    public async getClock(userID: number) : Promise<Clock>
    {
        let response = await this.get(`/clocks/${userID}`, {params: {}});
        return response.data.data
    }

    public async postClock(userID: number) : Promise<Clock>
    {
        let response = await this.post(`/clocks/${userID}`, null,{params: {}});
        return response.data.data
    }

    public async resetClock(userID: number) : Promise<Clock>
    {
        let response = await this.post(`/clocks/reset/${userID}`, null, {params: {}});
        return response.data.data
    }
}
