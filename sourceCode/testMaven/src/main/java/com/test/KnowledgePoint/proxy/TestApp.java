package com.test.KnowledgePoint.proxy;

import org.junit.Test;

public class TestApp {
	@Test
	public  void testProxy() {
		//Ŀ�����
        Target target = new Target();

        //�������
        Target proxy = (Target)new proxyFactory(target).getProxyInstance();

        //ִ�д������ķ���
        proxy.test1("test1");
        proxy.test2("test2");
        proxy.test3("test3");
	}

}
