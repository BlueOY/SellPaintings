package test;

/**
 * 参考资料：http://blog.csdn.net/gebitan505/article/details/44455235/
 */

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.alibaba.fastjson.JSON;
import com.trajectory.pojo.Order;
import com.trajectory.pojo.Painting;
import com.trajectory.service.IShopService;
import com.trajectory.service.ITestService;

@RunWith(SpringJUnit4ClassRunner.class)     //表示继承了SpringJUnit4ClassRunner类
@ContextConfiguration(locations = {"classpath:spring-mybatis.xml"})

public class TestMyBatis {
	
	@Resource
	private ITestService testService;
	@Resource
	private IShopService shopService;
	
	@Test
	public void test() {
		System.out.println("test");
		
		test1();
//		testSelect();
//		testInsert();
		
	}
	
	private void testInsert(){
		Order order = new Order();
		order.setAddress("address");
		shopService.addOrder(order);
		System.out.println(JSON.toJSONString(order));
		String paintings = "1,2,3";
		String[] paintingIds = paintings.split(",");
		List<Map<String, String>> list = new ArrayList<Map<String,String>>();
		for(String paintingId : paintingIds){
			Map<String, String> temp = new HashMap<String, String>();
			temp.put("orderId", order.getId()+"");
			temp.put("paintingId", paintingId);
			list.add(temp);
		}
		shopService.addOrderPaintings(list);
		System.out.println("list="+list);
	}
	
	private void testSelect(){
		Map<String, String> params = new HashMap<String, String>();
		params.put("startIndex", "0");
		params.put("endIndex", "10");
//		params.put("user", "");
		List<Order> list = shopService.getOrders(params);
		System.out.println("test="+JSON.toJSONString(list));
		System.out.println("size="+list.size());
		for(Order order : list){
			System.out.println("order="+JSON.toJSONString(order));
			List<Painting> paintings = order.getPaintings();
			for(Painting painting : paintings){
				System.out.println("painting="+JSON.toJSONString(painting));
			}
			
		}
	}
	
	private void test1(){
		com.trajectory.pojo.Test test = testService.getTestById("1");
		System.out.println("test="+JSON.toJSONString(test));
	}

}
