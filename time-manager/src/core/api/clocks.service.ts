import AxiosServices from "@/core/api/axios.services";
import type {AxiosResponse} from "axios";
import type {Clock} from "@/core/interfaces/clock.interface";

export default class ClocksServices extends AxiosServices
{
    public async getClock(userID: number) : Promise<Clock>
    {
        return await this.get(`/${userID}`, null);
    }

    public async postClock(userID: number) : Promise<Clock>
    {
        return await this.post(`/${userID}`, null,null);
    }
}
