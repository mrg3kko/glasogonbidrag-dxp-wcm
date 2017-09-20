<#setting locale = locale>

<#-- Define services -->
<#assign expandoValueLocalService = serviceLocator.findService("com.liferay.expando.kernel.service.ExpandoValueLocalService") />
<#assign layoutLocalService = serviceLocator.findService("com.liferay.portal.kernel.service.LayoutLocalService") />

<#-- Define some variables -->
<#assign scopeGroupId = getterUtil.getLong(request['theme-display']['scope-group-id']) />
<#assign scopePlid = getterUtil.getLong(request['theme-display']['plid']) />
<#assign isPrivateLayout = false />

<#assign scopeLayout = "" />

<#if scopePlid ? has_content>
	<#assign scopeLayout = layoutLocalService.getLayout(scopePlid)! />
	<#assign isPrivateLayout = scopeLayout.isPrivateLayout() />
</#if>

<#if navigationItems.siblings?size gt 0>
	<nav class="block-navigation">
    <ul>
  		<#list navigationItems.siblings as navigationItem>

        <#assign linkUrl = navigationItem.externalLink.data />
        <#assign linkText = navigationItem.externalLink.linkText.data />
        <#assign iconClass = "" />
        <#if navigationItem.externalLink.iconClass.data?has_content>
          <#assign iconClass = navigationItem.externalLink.iconClass.data />
        </#if>

        <#if linkUrl == "">
          <#if navigationItem.data ? has_content>
            <#assign linkUrl = navigationItem.getFriendlyUrl() />
            <#assign linkText = navigationItem.getName() />
            <#assign iconClass = "" />

						<#assign linkLayout = getLayout(navigationItem isPrivateLayout scopeGroupId) />

						<#if linkLayout ? has_content>
							<#assign linkText = linkLayout.getName(locale) />
							<#-- Below is not working. Fetch with expandoValueLocalService instead -->
							<#--
							<#assign expBridge = linkLayout.getExpandoBridge()! />
							<#if expBridge ? has_content>
								<#assign iconClass = expBridge.getAttribute("gb-icon-class")?string />
							</#if>
							-->
						</#if>

            <#-- Still bug with getting plid from link-to-page waiting for fix -->
          </#if>
        </#if>

        <#assign linkTarget = "" />
        <#if navigationItem.linkTarget.data == "_BLANK">
          <#assign linkTarget = "_BLANK" />
        </#if>

        <#--
		    <#assign hotkey = getMainNavHotkey(navigationItem) />
				<#if hotkey?has_content>
					<#assign linkText = linkText + " (" + hotkey + ")" />
				</#if>
        -->

        <li class="${iconClass}">
          <a href="${linkUrl}" target="${linkTarget}">
            <div>${linkText}</div>
          </a>
        </li>

      </#list>
    </ul>
	</nav>
</#if>

<#function getLayout linkToPage isPrivateLayout scopeGroupId>

	<#local layout = layoutLocalService.getLayout(scopeGroupId, isPrivateLayout, getterUtil.getLong(linkToPage.data))! />


	<#return layout />

</#function>

<#--
<#function getMainNavHotkey linkToPage>

	<#local hotkey = "" />

	<#if linkToPage.data?has_content>
		<#local linkData = linkToPage.data?split("@") />

		<#local linkLayoutId =  getterUtil.getLong(linkData[0]) />

		<#local linkLayoutIsPrivate =  false />
  	<#if linkData[1] == "private-group">
  		<#local linkLayoutIsPrivate = true />
  	</#if>

		<#local linkLayoutGroupId = getterUtil.getLong(linkData[2]) />

		<#local linkLayout = layoutLocalService.getLayout(linkLayoutGroupId, linkLayoutIsPrivate, linkLayoutId) />

		<#local hotkeyExpando  = expandoValueLocalService.getValue(companyId, "com.liferay.portal.model.Layout", "CUSTOM_FIELDS", "hotkey", linkLayout.getPlid())! />a

		<#if hotkeyExpando?has_content>
			<#local hotkey = hotkeyExpando.getData() />
		</#if>

	</#if>

	<#return hotkey />
</#function>
-->
