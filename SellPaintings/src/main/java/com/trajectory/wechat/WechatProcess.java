package com.trajectory.wechat;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * ΢��xml��Ϣ���������߼���
 * 
 * @author pamchen-1
 * 
 */

public class WechatProcess {

	/**
	 * ��������xml����ȡ���ܻظ������ͨ��ͼ�������api�ӿڣ�
	 * 
	 * @param xml
	 *            ���յ���΢������
	 * @return ���յĽ��������xml��ʽ���ݣ�
	 */
	public String processWechatMag(HttpServletRequest request) {
		/** ����xml���� */
		Map<String, String> map = FormatXmlProcess.xmlToMap(request);
		// ���ͷ��ʺţ�һ��OpenID��
        String fromUserName = map.get("FromUserName");
        // ������΢�ź�
        String toUserName = map.get("ToUserName");
        // ��Ϣ����
        String msgType = map.get("MsgType");
        // ��Ϣ����
        String msgContent = map.get("Content");
        
        System.out.println("map="+map);

		/** ���ı���ϢΪ��������ͼ�������api�ӿڣ���ȡ�ظ����� */
		String result = "success";	// Ĭ�ϻظ�һ��"success"
		if ("text".endsWith(msgType)) {
			result = new TulingApiProcess().getTulingResult(msgContent);
		}

		/**
		 * ��ʱ������û�������ǡ���á����ھ�������Ĺ���֮��resultΪ����Ҳ�á����Ƶ�����
		 * ��Ϊ���ջظ���΢�ŵ�Ҳ��xml��ʽ�����ݣ�������Ҫ�����װΪ�ı����ͷ�����Ϣ
		 * */
		result = FormatXmlProcess.formatXmlAnswer(
				fromUserName, toUserName, result);

		return result;
	}

}
