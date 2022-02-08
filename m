Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCB4C43219
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 11:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357485AbiBHLW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 06:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355495AbiBHJoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:44:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77789C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 01:44:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23DCBB81986
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 09:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA5CC004E1;
        Tue,  8 Feb 2022 09:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644313460;
        bh=lUoNb62Lq9FASwuSu15eW59Kx2+UCvqdXJF+KIBTrEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lPbub3oGEMtLKMEte6nnKtTe5kKYEGC2Sw+7JRCCJkQv8qHT3QJKL85VtWlQhs45l
         Wz6+zXZ8oWnxhCz0L5oJlsZONy8M1Wx1DARBFvCoHirO3eRA3FoMXUdipMSm8QJpwf
         iMvccnnrHs5UASFRHd6PEIQKPRx9WH1GI6IERktU=
Date:   Tue, 8 Feb 2022 10:44:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Leonardo Araujo <leonardo.aa88@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] Staging: r8188eu: core: Concatenated strings should use
 spaces between elements
Message-ID: <YgI7cZ+YhZccXq8g@kroah.com>
References: <20220207235643.29768-1-leonardo.aa88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207235643.29768-1-leonardo.aa88@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 08:56:43PM -0300, Leonardo Araujo wrote:
> This patch fixes the following checkpatch.pl warning:
> 
> CHECK: Concatenated strings should use spaces between elements
> 
> Signed-off-by: Leonardo Araujo <leonardo.aa88@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_ap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
> index c7803144355a..30f5ad4e7ca7 100644
> --- a/drivers/staging/r8188eu/core/rtw_ap.c
> +++ b/drivers/staging/r8188eu/core/rtw_ap.c
> @@ -1093,7 +1093,7 @@ int rtw_sta_flush(struct adapter *padapter)
>  	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
>  	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
>  
> -	DBG_88E(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(padapter->pnetdev));
> +	DBG_88E(FUNC_NDEV_FMT "\n", FUNC_NDEV_ARG(padapter->pnetdev));
>  
>  	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
>  		return ret;
> -- 
> 2.29.0
> 
> 

This too does not apply, sorry.

greg k-h
