Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64974ECAAA3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Aug 2022 08:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343570AbiHZIOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Aug 2022 04:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343586AbiHZINy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:13:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D25D4BDC;
        Fri, 26 Aug 2022 01:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661501633; x=1693037633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ln5K9Rli2euZm+3MbXDIrttR84dXLgSX98y9Y3WQF94=;
  b=VSIFK+ezPjnfSWgoQGiPyBzYvP4MYQjy6v69uGmu5RenfWIf3x1yLSu8
   8TcEHOa+nQ90yNASM2m8RR+GoRxqL7C+1r+FOIjUMwYBnevJeFsEPiL5m
   +38HFSUzXx+YBZp4DotBYKxbN0xl8hKdEky/VafpguWeMmMcCv2zBV3wL
   JE0Z34AXw3Myv1wm5YJFN9O6rEjE8EANT9Ec++emXd/zIJRAg8RVfwfAK
   7GiX8+zHaIwdt/wxPyWAkYaolwiqY8O4HXwIUkv8K2l5eRmkxuBGOQsvK
   v4jCqRlWOf+k54rxG7HrOZ7hgdWnHhK68zepu7an3m9rhUC8sidIR81pj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="356170950"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="356170950"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 01:13:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="752799840"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 26 Aug 2022 01:13:49 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 26 Aug 2022 11:13:48 +0300
Date:   Fri, 26 Aug 2022 11:13:48 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     cgel.zte@gmail.com
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        xupanda <xu.panda@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] usb: typec: tcpm: tcpci: Remove the unneeded
 result variable
Message-ID: <YwiAvHSNr34nyx/b@kuha.fi.intel.com>
References: <20220826074856.253810-1-xu.panda@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826074856.253810-1-xu.panda@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 07:48:57AM +0000, cgel.zte@gmail.com wrote:
> From: xupanda <xu.panda@zte.com.cn>
> 
> Return the value regmap_update_bits() directly instead of
> storing it in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: xupanda <xu.panda@zte.com.cn>
> ---
>  drivers/usb/typec/tcpm/tcpci.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index b2bfcebe218f..4436e9e5e2f7 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -328,11 +328,9 @@ static int tcpci_set_vconn(struct tcpc_dev *tcpc, bool enable)
>  static int tcpci_enable_auto_vbus_discharge(struct tcpc_dev *dev, bool enable)
>  {
>  	struct tcpci *tcpci = tcpc_to_tcpci(dev);
> -	int ret;
>  
> -	ret = regmap_update_bits(tcpci->regmap, TCPC_POWER_CTRL, TCPC_POWER_CTRL_AUTO_DISCHARGE,
> +	return regmap_update_bits(tcpci->regmap, TCPC_POWER_CTRL, TCPC_POWER_CTRL_AUTO_DISCHARGE,
>  				 enable ? TCPC_POWER_CTRL_AUTO_DISCHARGE : 0);
> -	return ret;
>  }
>  
>  static int tcpci_set_auto_vbus_discharge_threshold(struct tcpc_dev *dev, enum typec_pwr_opmode mode,
> @@ -884,5 +882,3 @@ static struct i2c_driver tcpci_i2c_driver = {
>  };
>  module_i2c_driver(tcpci_i2c_driver);
>  
> -MODULE_DESCRIPTION("USB Type-C Port Controller Interface driver");
> -MODULE_LICENSE("GPL");

Why are you removing those lines, and how is that related to the above
change?

thanks,

-- 
heikki
