{*
* 2007-2016 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author    PrestaShop SA <contact@prestashop.com>
*  @copyright 2007-2016 PrestaShop SA
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}
 

{if $head_msg|escape:'htmlall':'UTF-8' <> ''}
    <div class="module_confirmation conf confirm">
    <img src="{$path_confirmation|escape:'htmlall':'UTF-8'}" alt="" title="" />{$head_msg|escape:'htmlall':'UTF-8'}</div>
{/if}

{if $error_msg|escape:'htmlall':'UTF-8' <> ''}
    <div class="module_error alert error">
	<img src="{$path_error|escape:'htmlall':'UTF-8'}" alt="" title="" />{$error_msg|escape:'htmlall':'UTF-8'}
	<ul>
	{foreach from=$errors item=error_label name=errors}
	    <li>{$error_label|escape:'htmlall':'UTF-8'}</li>
	{/foreach}
	</ul>
    </div>
{/if}

<fieldset>
	<legend><img src="{$image_path|escape:'htmlall':'UTF-8'}"/>{l s='FIA-NET - Certissim' mod='fianetfraud'}</legend>
		{l s='FIA-NET, le leader français de la lutte contre la fraude à  la carte bancaire sur internet !' mod='fianetfraud'}
	<br />
	<br />
	{l s='Avec son réseau mutualisé de plus de 1 700 sites marchands, et sa base de données de 14 millions de cyber-acheteurs, Certissim vous offre une protection complète et unique contre le risque dimpayé.' mod='fianetfraud'}
	<br /><br />
	{l s='Le logiciel expert score vos transactions en quasi temps réel à  partir de plus de 200 critères pour valider plus de 92% de vos transactions.' mod='fianetfraud'}
	<br />
	{l s='Le contrôle humain, prenant en charge les transactions les plus risquées, associé à  l\'assurance FIA-NET vous permet de valider et garantir jusqu\'à  100% de vos transactions.' mod='fianetfraud'}
	<br />
	<br />
	{l s='Ne restez pas isolé face à  l\'explosion des réseaux de fraudeurs !' mod='fianetfraud'}
	<p>
	{l s='To sign in, check out: ' mod='fianetfraud'} <u><a href="http://www.fia-net-group.com/formulaire-de-contact-prestashop" target="_blank">{l s='Fia-net Website' mod='fianetfraud'}</a></u>
</p>
</fieldset>

<br />

<form action="" method="post">
	<fieldset>
		<legend><img src="{$logo_account_path|escape:'htmlall':'UTF-8'}" />{l s='Account settings' mod='fianetfraud'}</legend>
		<label>{l s='Login' mod='fianetfraud'}</label>
		<div class="margin-form">
			<input type="text" name="certissim_login" value="{$certissim_login|escape:'htmlall':'UTF-8'}"/>
		</div>
		<label>{l s='Password' mod='fianetfraud'}</label>
		<div class="margin-form">
			<input type="text" name="certissim_password" value="{$certissim_password|escape:'htmlall':'UTF-8'}"/>
		</div>
		<label>{l s='Site ID' mod='fianetfraud'}</label>
		<div class="margin-form">
			<input type="text" name="certissim_siteid" value="{$certissim_siteid|escape:'htmlall':'UTF-8'}"/>
		</div>
		<br/>
		<label>{l s='Enable Copilot' mod='fianetfraud'}</label>
		<div class="margin-form">
			<input name="certissim_copilot_status" type="checkbox" value="1" {if $certissim_copilot_status eq '1'}Checked{/if} />
		</div>
		<label>{l s='Authkey' mod='fianetfraud'}</label>
		<div class="margin-form">
			<input type="text" name="certissim_authkey" value="{$certissim_authkey|escape:'htmlall':'UTF-8'}"/>
		</div>
		<br/>
		<label>{l s='Enable Franfinance' mod='fianetfraud'}</label>
		<div class="margin-form">
			<input name="certissim_franfinance_status" type="checkbox" value="1" {if $certissim_franfinance_status eq '1'}Checked{/if} /> 
		</div>
		<label>{l s='Franfinance Site ID' mod='fianetfraud'}</label>
		<div class="margin-form">
			<input type="text" name="certissim_franfinance_siteid" value="{$certissim_franfinance_siteid|escape:'htmlall':'UTF-8'}"/>
		</div>
		<br/>
		<label>{l s='Production mode' mod='fianetfraud'}</label>
		<div class="margin-form">
			<select name="certissim_status">
				{foreach from=$certissim_statuses item=certissim_status_name name=certissim_status}
					<option value="{$certissim_status_name|escape:'htmlall':'UTF-8'}" {if $certissim_status_name eq $certissim_status}Selected{/if}>{l s=$certissim_status_name mod='fianetfraud'}</option>
				{/foreach}
			</select>
		</div>
	</fieldset>

	<br />

	<fieldset>
		<legend><img src="{$logo_categories_path|escape:'htmlall':'UTF-8'}"/>{l s='Category settings' mod='fianetfraud'}</legend>
		<label>{l s='Default Product Type' mod='fianetfraud'}</label>
		<div class="margin-form">
			<select name="certissim_default_product_type">
				<option value="0">-- {l s='Choose' mod='fianetfraud'} --</option>
				{foreach from=$certissim_product_types item=product_type key=id_product_type name=product_types}
					<option value="{$id_product_type|intval}" {if $certissim_default_product_type eq $id_product_type}Selected{/if}>{$product_type|strval}</option>
				{/foreach}
			</select>
		</div>

		<div class="margin-form">
			<table class="table">
				<thead>
					<tr><th>{l s='Shop category' mod='fianetfraud'}</th><th>{l s='Certissim category' mod='fianetfraud'}</th></tr>
				</thead>
				<tbody>
					{foreach from=$shop_categories key=id item=shop_category name=shop_categories}
						<tr>
							<td>{$shop_category.name|strval|escape:'htmlall':'UTF-8'}</td>
							<td>
								<select name="certissim_{$id|intval}_product_type">
									<option value="0">-- {l s='Choose' mod='fianetfraud'} --</option>
									{foreach from=$certissim_product_types item=product_type key=id_product_type name=product_types}
										<option value="{$id_product_type|intval|escape:'htmlall':'UTF-8'}" {if $shop_category.certissim_type|escape:'htmlall':'UTF-8' eq $id_product_type|escape:'htmlall':'UTF-8'}Selected{/if}>{$product_type|strval|escape:'htmlall':'UTF-8'}</option>
									{/foreach}
								</select>
							</td>
						</tr>
					{/foreach}
				</tbody>
			</table>
		</div>
	</fieldset>

	<br />

	<fieldset>
		<legend><img src="{$logo_carriers_path|escape:'htmlall':'UTF-8'}"/>{l s='Carrier settings' mod='fianetfraud'}</legend>
		<label>{l s='Default Carrier Type' mod='fianetfraud'}</label>
		<div class="margin-form">
			<select name="certissim_default_carrier_type">
				<option value="0">-- {l s='Choose' mod='fianetfraud'} --</option>
				{foreach from=$certissim_carrier_types key=id_carrier_type item=certissim_carrier_type name=certissim_carrier_types}
					<option value="{$id_carrier_type|intval}" {if $certissim_default_carrier_type eq $id_carrier_type}Selected{/if}>{$certissim_carrier_type|strval|escape:'htmlall':'UTF-8'}</option>
				{/foreach}
			</select>
			<select name="certissim_default_carrier_speed">
				{foreach from=$certissim_carrier_speeds key=id_carrier_speed item=certissim_carrier_speed name=certissim_carrier_speeds}
					<option value="{$id_carrier_speed|intval}" {if $certissim_default_carrier_speed eq $id_carrier_speed}Selected{/if}>{$certissim_carrier_speed|escape:'htmlall':'UTF-8'}</option>
				{/foreach}
			</select>
		</div>

		<div class="margin-form">
			<table cellspacing="0" cellpadding="0" class="table">
				<thead><tr><th>{l s='Carrier' mod='fianetfraud'}</th><th>{l s='Carrier Type' mod='fianetfraud'}</th><th>{l s='Carrier Speed' mod='fianetfraud'}</th></tr></thead>
				<tbody>
					{foreach from=$shop_carriers key=id_shop_carrier item=shop_carrier name=shop_carriers}
						<tr>
							<td>{$shop_carrier.name|strval|escape:'htmlall':'UTF-8'}</td>
							<td>
								<select name="certissim_{$id_shop_carrier|intval}_carrier_type">
									<option value="0">-- {l s='Choose' mod='fianetfraud'} --</option>
									{foreach from=$certissim_carrier_types key=id_carrier_type item=certissim_carrier_type name=certissim_carrier_types}
										<option value="{$id_carrier_type|intval}" {if $shop_carrier.certissim_type eq $id_carrier_type}Selected{/if}>{$certissim_carrier_type|escape:'htmlall':'UTF-8'}</option>
									{/foreach}
								</select>
							</td>
							<td>
								<select name="certissim_{$id_shop_carrier|intval}_carrier_speed">
									{foreach from=$certissim_carrier_speeds key=id_carrier_speed item=certissim_carrier_speed name=certissim_carrier_speeds}
										<option value="{$id_carrier_speed|intval}" {if $shop_carrier.certissim_speed eq $id_carrier_speed}Selected{/if}>{$certissim_carrier_speed|escape:'htmlall':'UTF-8'}</option>
									{/foreach}
								</select>
							</td>
						</tr>
					{/foreach}
				</tbody>
			</table>
		</div>
		<br /><img src="{$logo_warning|escape:'htmlall':'UTF-8'}"/>{l s='To use the withdrawal store, you must enter the address of your store.' mod='fianetfraud'} <a href="{$link_shop_setting|escape:'htmlall':'UTF-8'}" target="_blank">{l s='Check the details of the shop here' mod='fianetfraud'}</a>.
	</fieldset>

	<br />

	<fieldset>
		<legend><img src="{$logo_payments_path|escape:'htmlall':'UTF-8'}" />{l s='Payment modules settings' mod='fianetfraud'}</legend>
		<div class="margin-form">
			<table cellspacing="0" cellpadding="0" class="table">
				<thead>
					<tr>
						<th>{l s='Payment module' mod='fianetfraud'}</th>
						<th>{l s='Payment Type' mod='fianetfraud'}</th>
						<th>{l s='Enable Certissim for this payment method' mod='fianetfraud'}</th>
					</tr>
				</thead>
				<tbody>
					{foreach from=$payment_modules key=id_payment_module item=payment_module name=payment_modules}
						<tr>
							<td>{$payment_module.name|strval|escape:'htmlall':'UTF-8'}</td>
							<td>
								<select name="certissim_{$id_payment_module|intval}_payment_type">
									{foreach from=$certissim_payment_types key=id_certissim_payment_type item=certissim_payment_type name=certissim_payment_types}
										<option value="{$id_certissim_payment_type|intval}" {if $payment_module.certissim_type eq $id_certissim_payment_type}Selected{/if}>{$certissim_payment_type|escape:'htmlall':'UTF-8'}</option>
									{/foreach}
								</select>
							</td>
							<td>
								<input type="checkbox" name="certissim_{$id_payment_module|escape:'htmlall':'UTF-8'}_payment_enabled" value="1" {if $payment_module.enabled|escape:'htmlall':'UTF-8' eq '1'}Checked{/if}/>
							</td>
						</tr>
					{/foreach}
				</tbody>
			</table>
		</div>
	</fieldset>
				
	<br/>
				
	<fieldset>
		<legend><img src="{$logo_payments_path|escape:'htmlall':'UTF-8'}" />{l s='Authentification level settings' mod='fianetfraud'}</legend>
		<p>{l s='For each level of authentication, please choose available payments' mod='fianetfraud'}</p>
		<div class=""><br/>
			{foreach from=$certissim_level key=id_certissim_level item=level name=certissim_level}
			    <strong>{l s='Level' mod='fianetfraud'} {$level|escape:'htmlall':'UTF-8'} : </strong><br/><br/>
			    {foreach from=$payment_modules key=id_payment_module item=payment_module name=payment_modules}
				<input name="{$level|escape:'htmlall':'UTF-8'}_{$id_payment_module|escape:'htmlall':'UTF-8'}" type="checkbox" value="1" {if {$payment_module.copilot_status.$level|escape:'htmlall':'UTF-8'} eq '1'}Checked{/if} />&nbsp;&nbsp;{$payment_module.name|strval|escape:'htmlall':'UTF-8'}&nbsp;&nbsp;
			    {/foreach}
			    <br/><br/><br/>
			{/foreach}
		</div>
	</fieldset>

	<br />

	<fieldset>
		<legend>{l s='Log file' mod='fianetfraud'}</legend>
		<p>{l s='The log file is a file that contains an history of what happened technically inside the module.' mod='fianetfraud'}</p>
		<p>{l s='We advise you to join the content of the log file each time you contact the Fia-Net support team.' mod='fianetfraud'}</p>
		<p><a href="{$url_log|escape:'htmlall':'UTF-8'}">{l s='Display log.' mod='fianetfraud'}</a></p>
	</fieldset>

	<br />

	<fieldset>
		<legend>{l s='Automated tasks' mod='fianetfraud'}</legend>
		<p>{l s='You can use automated tasks to recover FIA-NET evaluation and reevaluation.' mod='fianetfraud'}</p>
		<p>{l s='You can run the following two scripts through cron tasks:' mod='fianetfraud'}</p>
		<ul>
			<li>{l s='Evaluation :' mod='fianetfraud'} {if $certissim_login == '' || $certissim_password == ''} {l s='you must enter the account settings to see the link' mod='fianetfraud'} {else} <a target="_blank" href="{$link_cron_eval|escape:'htmlall':'UTF-8'}">{$link_cron_eval|escape:'htmlall':'UTF-8'}</a></li>{/if}
			<li>{l s='Reevaluation :' mod='fianetfraud'} {if $certissim_login == '' || $certissim_password == ''} {l s='you must enter the account settings to see the link' mod='fianetfraud'} {else}<a target="_blank" href="{$link_cron_reeval|escape:'htmlall':'UTF-8'}">{$link_cron_reeval|escape:'htmlall':'UTF-8'}</a></li>{/if}
		</ul>
		
		<p>{l s='We recommend that you call the script evaluation every 10 minutes and the script revaluation 2 times a day (12:00 pm and 12:00 am for example).' mod='fianetfraud'}</p>

	</fieldset>

	<br />

	<center><input type="submit" name="submitSettings" value="{l s='Save' mod='fianetfraud'}" class="button" /></center>

</form>