Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EABC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jun 2022 14:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344927AbiFEOOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jun 2022 10:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242532AbiFEOOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 10:14:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0C627160
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 07:14:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CD7B60FF6
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 14:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6CDC385A5;
        Sun,  5 Jun 2022 14:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654438483;
        bh=DnxN5ambVi3dI6+cdjSLkE5eBkMXsX56J4bxLEa/gCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CtsNbvCnjWY+NytgmtVZi80XbCPc6SLOwZgOy/EMSsv9k3e6KHKxUrEA2CfKlNlSD
         5JsaI6cN/G0KyQDPXUB7urdRUXspWneWagpsrk39MeyM/oo6B4c9MloxXNfyf27HXs
         tTLB5zb3QXlQ7rKmLhOta0b9+B9D1Y3IHwULUSu4=
Date:   Sun, 5 Jun 2022 16:14:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andrea Paris <aparis@ethz.ch>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixed 3 warnings about missing blank line after
 declaration
Message-ID: <Ypy6UMvCwAH0E50a@kroah.com>
References: <20220605135716.GA11092@student.ethz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220605135716.GA11092@student.ethz.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2022 at 03:57:16PM +0200, Andrea Paris wrote:
> Fixed three checkpatch.pl warnings about missing blank lines after
> declaration
> 
> Signed-off-by: Andrea Paris <aparis@ethz.ch>
> ---
>  drivers/staging/r8188eu/core/rtw_cmd.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> index 06523d91939a..92d5e4534087 100644
> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> @@ -25,6 +25,7 @@ void rtw_free_evt_priv(struct	evt_priv *pevtpriv)
> 
>  	while (!rtw_cbuf_empty(pevtpriv->c2h_queue)) {
>  		void *c2h = rtw_cbuf_pop(pevtpriv->c2h_queue);
> +
>  		if (c2h && c2h != (void *)pevtpriv)
>  			kfree(c2h);
>  	}
> @@ -323,6 +324,7 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
>  	/* prepare ssid list */
>  	if (ssid) {
>  		int i;
> +
>  		for (i = 0; i < ssid_num && i < RTW_SSID_SCAN_AMOUNT; i++) {
>  			if (ssid[i].SsidLength) {
>  				memcpy(&psurveyPara->ssid[i], &ssid[i], sizeof(struct ndis_802_11_ssid));
> @@ -334,6 +336,7 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
>  	/* prepare channel list */
>  	if (ch) {
>  		int i;
> +
>  		for (i = 0; i < ch_num && i < RTW_CHANNEL_SCAN_AMOUNT; i++) {
>  			if (ch[i].hw_value && !(ch[i].flags & RTW_IEEE80211_CHAN_DISABLED)) {
>  				memcpy(&psurveyPara->ch[i], &ch[i], sizeof(struct rtw_ieee80211_channel));
> --
> 2.25.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.


If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
