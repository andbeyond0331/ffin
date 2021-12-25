package com.ffin.web.truck;

import com.ffin.common.Page;
import com.ffin.common.Search;
import com.ffin.service.domain.Truck;
import com.ffin.service.truck.TruckService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Map;

//==> 트럭관리 RestController
@RestController
@RequestMapping("/truck/*")
public class TruckRestController {

    /// Field
    @Autowired
    @Qualifier("truckServiceImpl")
    private TruckService truckService;
    // setter Method 구현않음

    public TruckRestController() {
        System.out.println(this.getClass());
    }

    @Value("#{commonProperties['pageUnit']}")
    int pageUnit;
    @Value("#{commonProperties['pageSize']}")
    int pageSize;

    @RequestMapping(value = "json/getTruck/{truckId}", method = RequestMethod.GET)
    public Truck getTruck(@PathVariable String truckId) throws Exception {

        System.out.println("/truck/json/getTruck : GET");

        // Business Logic
        return truckService.getTruck(truckId);
    }

    @RequestMapping(value = "json/login", method = RequestMethod.POST)
    public Truck login(@RequestBody Truck truck, HttpSession session) throws Exception {

        System.out.println("/truck/json/login : POST");
        // Business Logic
        System.out.println("::" + truck);
        Truck dbTruck = truckService.getTruck(truck.getTruckId());

        if (truck.getTruckPassword().equals(dbTruck.getTruckPassword())) {
            session.setAttribute("truck", dbTruck);
        }

        return dbTruck;
    }

    @RequestMapping(value = "json/updateTruck/{truckId}", method = RequestMethod.GET)
    public Truck updateTruck(@PathVariable String truckId, Model model) throws Exception {

        System.out.println("/truck/updateTruck : GET");

        Truck truck = truckService.getTruck(truckId);

        model.addAttribute("truck", truck);

        // Business Logic
        return truck;
    }

    @RequestMapping(value = "json/updateTruck/{truckId}", method = RequestMethod.POST)
    public Truck updateTruck(@ModelAttribute("truck") Truck truck, Model model, HttpSession session) throws Exception {

        System.out.println("/truck/updateTruck : POST");

        truckService.updateTruck(truck);

        String sessionId = ((Truck) session.getAttribute("truck")).getTruckId();
        if (sessionId.equals(truck.getTruckId())) {
            session.setAttribute("truck", truck);
        }

        return truck;
    }

    @RequestMapping(value = "/json/listTruck", method = RequestMethod.POST)
    public Map listTruck(@ModelAttribute("search") Search search, Truck truck, HttpServletRequest request) throws Exception {

        System.out.println("/truck/listTruck : GET / POST");

        if (search.getCurrentPage() == 0) {
            search.setCurrentPage(1);
        }
        search.setPageSize(pageSize);

        Map<String, Object> map = truckService.getTruckList(search);

        Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);

        System.out.println("resultPage :: " + resultPage);

        //list, totalCount
        return map;

    }

    @RequestMapping(value = "/json/addTruck/{truckId}", method = RequestMethod.POST)
    public Truck addTruck(@RequestBody Truck truck, Search search) throws Exception {

        System.out.println("/truck/addTruck : POST");
        //Business Logic

        truckService.addTruck(truck);

        return truck;
    }

    @RequestMapping(value = "/checkDuId/{truckId}", method = RequestMethod.POST)
    @ResponseBody
    public String checkDuId(@PathVariable String truckId) throws Exception {
        System.out.println("TruckRestController.checkDuId");
        int flag = truckService.checkDuId(truckId);
        String result = "";
        if (flag == 0) {
            result = "y";
        } else {
            result = "n";
        }
        return result;
    }

    @RequestMapping(value = "/checkDuTruckName/{truckName}", method = RequestMethod.POST)
    @ResponseBody
    public String checkDuTruckName(@PathVariable String truckName) throws Exception {
        System.out.println("TruckRestController.checkDuTruckName");
        int flag = truckService.checkDuTruckName(truckName);
        String result = "";
        if (flag == 0) {
            result = "y";
        } else {
            result = "n";
        }
        return result;
    }


}
