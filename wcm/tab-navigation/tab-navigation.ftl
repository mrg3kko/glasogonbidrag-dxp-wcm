<#setting locale = locale>

<#-- Define services -->
<#assign layoutLocalService = serviceLocator.findService("com.liferay.portal.kernel.service.LayoutLocalService") />

<#-- Define some variables -->

<#if navigationItems.siblings?size gt 0>
	<nav class="gb-tabs">
    <ul class="tabs-list">
  		<#list navigationItems.siblings as navigationItem>

				<#assign linkUrl = "" />
				<#assign linkText = "" />
				<#assign isCurrentLayout = false />

				<#if navigationItem.data ? has_content>
					<#assign linkUrl = navigationItem.getFriendlyUrl() />
					<#assign linkText = navigationItem.getName() />
				</#if>

				<#if navigationItem.linkText.data != "">
					<#assign linkText = navigationItem.linkText.data />
				</#if>

				<#assign linkLayout = getLayout(navigationItem) />
				<#if linkLayout ? has_content>
					<#-- linkText should be avaiable through navigationItem.getName() but this seems not to be working -->
					<#assign linkText = linkLayout.getName(locale) />

					<#assign scopePlid =  getterUtil.getLong((request["theme-display"]["plid"])!) />
					<#assign isCurrentLayout = (linkLayout.plid == scopePlid) />
				</#if>

				<#if isCurrentLayout>
					<li class="active">
						<span class="tab">
							${linkText}
						</span>
					</li>
				<#else>
					<li>
						<a class="tab" href="${linkUrl}">
	            ${linkText}
	          </a>
					</li>
				</#if>

      </#list>
    </ul>
	</nav>
</#if>


<#function getLayout linkToPage>

	<#local linkInfo = [] />
	<#local layout = "" />

	<#if linkToPage.data?has_content>
		<#local linkData = linkToPage.data?split("@") />
		<#local linkLayoutId =  getterUtil.getLong(linkData[0]) />

		<#local linkLayoutIsPrivate =  false />
		<#if linkData[1] == "private-group">
  		<#local linkLayoutIsPrivate = true />
  	</#if>

		<#local linkLayoutGroupId = getterUtil.getLong(linkData[2]) />

		<#local layout = layoutLocalService.getLayout(linkLayoutGroupId, linkLayoutIsPrivate, linkLayoutId) />

	</#if>

	<#return layout />

</#function>
