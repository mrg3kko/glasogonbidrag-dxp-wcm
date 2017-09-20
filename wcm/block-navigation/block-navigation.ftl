<#setting locale = locale>

<#-- Define services -->
<#assign expandoValueLocalService = serviceLocator.findService("com.liferay.expando.kernel.service.ExpandoValueLocalService") />

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
