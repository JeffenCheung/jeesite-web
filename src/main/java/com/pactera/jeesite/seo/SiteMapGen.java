/**
 * Copyright &copy; 2014-2016 <a href="https://pactera.com">Pactera-JeeSite</a> All rights reserved.
 */
package com.pactera.jeesite.seo;

import java.io.File;
import java.net.MalformedURLException;
import java.util.Date;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.redfin.sitemapgenerator.ChangeFreq;
import com.redfin.sitemapgenerator.WebSitemapGenerator;
import com.redfin.sitemapgenerator.WebSitemapUrl;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.utils.StringUtil;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.Menu;
import com.thinkgem.jeesite.modules.sys.service.SystemService;

/**
 * Java Code To Generate Sitemap
 * 
 * @author Jeffen
 * @since 1.2.11
 * @date 2016/4/21
 * 
 */
@Controller
@RequestMapping(value = "${adminPath}/seo")
public class SiteMapGen extends BaseController {

	private static final String URL = Global.getConfig("cas.project.url");
	private static final String URL_XML = URL + "/sitemap/sitemap.xml";
	private static final String SITEMAP_PATH = Global.getConfig("projectPath")
			+ "\\src\\main\\webapp\\sitemap";

	@Autowired
	private SystemService systemService;

	private WebSitemapGenerator sitemapGenerator;
	private WebSitemapUrl sitemapUrl;

	public SiteMapGen() {
	}

	@RequiresPermissions("sys:menu:edit")
	@RequestMapping(value = "sitemap")
	public String sitemap(RedirectAttributes redirectAttributes)
			throws MalformedURLException {

		// If you need gzipped output
		sitemapGenerator = WebSitemapGenerator
				.builder(URL, new File(SITEMAP_PATH)).gzip(false).build();
		// this will configure the URL with lastmod=now, priority=1.0,
		// changefreq=hourly
		sitemapUrl = new WebSitemapUrl.Options(URL).lastMod(new Date())
				.priority(1.0).changeFreq(ChangeFreq.HOURLY).build();
		// You can add any number of urls here
		sitemapGenerator.addUrl(sitemapUrl);
		sitemapGenerator.addUrl(URL + adminPath);
		sitemapGenerator.addUrl(URL + frontPath);

		// loop menu to site map
		for (Menu m : systemService.findAllMenu()) {
			if ("1".equals(m.getIsShow()) && StringUtil.isNotEmpty(m.getHref())) {
				sitemapGenerator.addUrl(URL + adminPath + m.getHref());
			}
		}

		sitemapGenerator.write();
		addMessage(redirectAttributes, "网站地图更新成功！</br>网站地图服务器存储地址："
				+ SITEMAP_PATH + "</br>网站地图：<a target='_blank' href='"
				+ URL_XML + "'>" + URL_XML + "</a>");
		return "redirect:" + adminPath + "/sys/menu/";
	}
}