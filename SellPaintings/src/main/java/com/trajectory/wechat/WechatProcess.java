package com.trajectory.wechat;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * 微信xml消息处理流程逻辑类
 * 
 * @author pamchen-1
 * 
 */

public class WechatProcess {

	/**
	 * 解析处理xml、获取智能回复结果（通过图灵机器人api接口）
	 * 
	 * @param xml
	 *            接收到的微信数据
	 * @return 最终的解析结果（xml格式数据）
	 */
	public String processWechatMag(HttpServletRequest request) {
		/** 解析xml数据 */
		Map<String, String> map = FormatXmlProcess.xmlToMap(request);
		System.out.println("map="+map);
		// 发送方帐号（一个OpenID）
        String fromUserName = map.get("FromUserName");
        // 开发者微信号
        String toUserName = map.get("ToUserName");
        // 消息类型
        String msgType = map.get("MsgType");
        // 消息内容
        String msgContent = map.get("Content");

		/** 以文本消息为例，调用图灵机器人api接口，获取回复内容 */
		String result = "success";	// 默认回复一个"success"
		if ("text".endsWith(msgType)) {
			result = new TulingApiProcess().getTulingResult(msgContent);
		}

		/**
		 * 此时，如果用户输入的是“你好”，在经过上面的过程之后，result为“你也好”类似的内容
		 * 因为最终回复给微信的也是xml格式的数据，所有需要将其封装为文本类型返回消息
		 * */
		result = FormatXmlProcess.formatXmlAnswer(
				fromUserName, toUserName, result);

		return result;
	}

}
